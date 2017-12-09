package com.blockchain.timebank.weixin.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import com.blockchain.timebank.weixin.model.Token;
import net.sf.json.JSONObject;


public class CommonUtil {
	/**
	 * 处理https GET/POST请求
	 *
	 * @param requestUrl 请求地址
	 * @param requestMethod 请求方法（GET/POST）
	 * @param outputStr 参数
	 * @return
	 */
	public static String httpsRequest(String requestUrl, String requestMethod, String outputStr) {
		StringBuffer buffer = null;
		try {
			// 创建SSLContext
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			TrustManager[] tm = { new MyX509TrustManager() };
			// 初始化
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 获取SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
			conn.setRequestMethod(requestMethod);
			// 设置当前实例使用的SSLSocketFactory
			conn.setSSLSocketFactory(ssf);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.connect();

			// 往服务器端写内容
			if (null != outputStr) {
				OutputStream os = conn.getOutputStream();
				os.write(outputStr.getBytes("utf-8"));
				os.close();
			}

			// 读取服务器端返回的内容
			InputStream is = conn.getInputStream();
			InputStreamReader isr = new InputStreamReader(is, "utf-8");
			BufferedReader br = new BufferedReader(isr);

			buffer = new StringBuffer();
			String line = null;
			while ((line = br.readLine()) != null) {
				buffer.append(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return buffer.toString();
	}

	/**
	 * 获取access_token的请求地址（GET）
	 */
	public final static String token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

	/**
	 * 获取access_token
	 *
	 * @param appid 公众号的唯一凭证
	 * @param appsecret 密钥
	 * @return
	 */
	public static Token getAccessToken(String appid, String appsecret) {
		Token token = null;
		// 拼接请求地址
		String requestUrl = token_url.replace("APPID", appid).replace("APPSECRET", appsecret);
		// 调用接口
		String jsonString = CommonUtil.httpsRequest(requestUrl, "GET", null);

		try {
			// 将json字符串转换成java对象
			JSONObject jsonObject = JSONObject.fromObject(jsonString);

			String accessToken = jsonObject.getString("access_token");
			int expiresIn = jsonObject.getInt("expires_in");

			token = new Token();
			token.setAccess_token(accessToken);
			token.setExpires_in(expiresIn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return token;
	}

	/**
	 * 对链接地址进行utf-8编码
	 * @param url
	 * @return
	 */
	public static String urlEncodeUTF8(String url) {
		String encodeUrl = url;
		try {
			encodeUrl = java.net.URLEncoder.encode(url, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return encodeUrl;
	}

	public static void main(String []args) {
		System.out.println(urlEncodeUTF8("http://lyq8479.oicp.net/weixin-219/oauthServlet"));
		System.out.println(urlEncodeUTF8("http://www.hlb9978.com/oauthServlet"));
	}
}
