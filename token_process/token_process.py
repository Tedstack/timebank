import requests
import json
import threading
import time
from flask import Flask, make_response

app = Flask(__name__)

access_token = ''
js_api_ticket = ''


def get_time():
    return time.strftime("%b %d %Y %H:%M:%S", time.localtime(time.time()))


def get_access_token():
    token_url = 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET'
    js_api_url = 'https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi'

    app_id = 'wxb0f6b07f01978a2a'
    app_secret = '386ef712d87480fa1dc27a93995936eb'

    global access_token, js_api_ticket

    log = open('/home/ubuntu/timebank/token_process/log.txt', 'w')
    log.write('start get access token\n\n')
    while True:
        while True:
            try:
                new_access_token_text = requests.get(token_url.replace('APPID', app_id).replace('APPSECRET', app_secret)).text
                new_access_token_json = json.loads(new_access_token_text)
                log.write(get_time() + new_access_token_text + '\n')
                if new_access_token_json.get('errcode'):
                    log.write(get_time() + ' error: ' + new_access_token_json.get('errmsg') + '\n')
                    time.sleep(10)
                    continue
                new_access_token = new_access_token_json.get('access_token')
                if new_access_token:
                    access_token = new_access_token
                    log.write(get_time() + 'get access token: ' + access_token + '\n')
                    break
                else:
                    log.write(get_time() + 'error: ' + new_access_token_text + '\n')
                    time.sleep(10)
            except Exception as e:
                log.write(get_time() + e + '\n')
                continue

        while True:
            try:
                new_js_api_ticket_text = requests.get(js_api_url.replace('ACCESS_TOKEN', access_token)).text
                new_js_api_ticket_json = json.loads(new_js_api_ticket_text)
                log.write(get_time() + new_js_api_ticket_text + '\n')
                if new_js_api_ticket_json.get('errcode') != 0:
                    log.write(get_time() + 'error: ' + new_js_api_ticket_json.get('errmsg') + '\n')
                    time.sleep(10)
                    continue
                new_js_api_ticket = new_js_api_ticket_json.get('ticket')
                if new_js_api_ticket:
                    js_api_ticket = new_js_api_ticket
                    log.write(get_time() + 'get ticket: ' + js_api_ticket + '\n')
                    break
                else:
                    log.write(get_time() + 'error: ' + new_js_api_ticket_text + '\n')
                    time.sleep(10)
            except Exception as e:
                log.write(get_time() + e + '\n')
                continue

        log.flush()
        last_hour = int(time.time()) // 3600
        while int(time.time()) // 3600 == last_hour:
            time.sleep(60)


@app.route('/access_token', methods=['POST'])
def return_access_token():
    return make_response(access_token)


@app.route('/js_api_ticket', methods=['POST'])
def return_js_api_ticket():
    return make_response(js_api_ticket)


if __name__ == '__main__':
    token_thread = threading.Thread(target=get_access_token)
    token_thread.start()
    app.run(host="0.0.0.0", port=8686, threaded=True)
