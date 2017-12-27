package com.blockchain.timebank.weixin.util;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

	/**
	 * 根据身份证的号码算出当前身份证持有者的性别和年龄 18位身份证
	 *
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> getCarInfo(String CardCode)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String year = CardCode.substring(6).substring(0, 4);// 得到年份
		String yue = CardCode.substring(10).substring(0, 2);// 得到月份
		// String day=CardCode.substring(12).substring(0,2);//得到日
		String sex;
		if (Integer.parseInt(CardCode.substring(16).substring(0, 1)) % 2 == 0) {// 判断性别
			sex = "女";
		} else {
			sex = "男";
		}
		Date date = new Date();// 得到当前的系统时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String fyear = format.format(date).substring(0, 4);// 当前年份
		String fyue = format.format(date).substring(5, 7);// 月份
		// String fday=format.format(date).substring(8,10);
		int age = 0;
		if (Integer.parseInt(yue) <= Integer.parseInt(fyue)) { // 当前月份大于用户出身的月份表示已过生
			age = Integer.parseInt(fyear) - Integer.parseInt(year) + 1;
		} else {// 当前用户还没过生
			age = Integer.parseInt(fyear) - Integer.parseInt(year);
		}
		map.put("sex", sex);
		map.put("age", age);
		return map;
	}

	/**
	 * 15位身份证的验证
	 *
	 * @param
	 * @throws Exception
	 */
	public static Map<String, Object> getCarInfo15W(String card)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String uyear = "19" + card.substring(6, 8);// 年份
		String uyue = card.substring(8, 10);// 月份
		// String uday=card.substring(10, 12);//日
		String usex = card.substring(14, 15);// 用户的性别
		String sex;
		if (Integer.parseInt(usex) % 2 == 0) {
			sex = "女";
		} else {
			sex = "男";
		}
		Date date = new Date();// 得到当前的系统时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String fyear = format.format(date).substring(0, 4);// 当前年份
		String fyue = format.format(date).substring(5, 7);// 月份
		// String fday=format.format(date).substring(8,10);
		int age = 0;
		if (Integer.parseInt(uyue) <= Integer.parseInt(fyue)) { // 当前月份大于用户出身的月份表示已过生
			age = Integer.parseInt(fyear) - Integer.parseInt(uyear) + 1;
		} else {// 当前用户还没过生
			age = Integer.parseInt(fyear) - Integer.parseInt(uyear);
		}
		map.put("sex", sex);
		map.put("age", age);
		return map;
	}

	/**
	 * 图片下载到本地服务器
	 */
	public static String getImageByUrl(String imageurl, String savepath, String name) {
		try {
			// 构造URL
			URL url = new URL(imageurl);
			// 打开连接
			URLConnection con = url.openConnection();
			// 输入流
			InputStream is = con.getInputStream();
			// 1K的数据缓冲
			byte[] bs = new byte[1024];
			// 读取到的数据长度
			int len;
			// Map<String, Object> property =
			// getProperties("/gbtags.properties");
			File file = new File(savepath);// (String) property.get("ewmPath"));
			if (!file.exists()) {
				file.mkdirs();
			}
			// 输出的文件流
			OutputStream os = new FileOutputStream(savepath + name);
			// 开始读取
			while ((len = is.read(bs)) != -1) {
				os.write(bs, 0, len);
			}
			// 完毕，关闭所有链接
			os.close();
			is.close();
			return "success";
		} catch (Exception e) {
			return "error";
		}
	}

	public static void main(String []args) {
		System.out.println(urlEncodeUTF8("http://lyq8479.oicp.net/weixin-219/oauthServlet"));
		System.out.println(urlEncodeUTF8("http://www.hlb9978.com/oauthServlet"));

		System.out.println(getImageByUrl("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514351160292&di=eeb0575fdabd1f7ddb3f488c81766960&imgtype=0&src=http%3A%2F%2Fpic39.nipic.com%2F20140328%2F18195484_231359496109_2.jpg", "F:\\毕业设计\\Project\\timebankWeb\\web\\WEB-INF\\img\\userAvatar\\", "123.jpg"));
	}
}
