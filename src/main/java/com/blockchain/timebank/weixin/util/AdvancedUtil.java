package com.blockchain.timebank.weixin.util;

import java.util.List;
import java.util.ArrayList;

import com.blockchain.timebank.weixin.model.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * 高级接口的调用
 *
 * @author liufeng
 * @date 2015-08-24
 */
public class AdvancedUtil {

	/**
	 * 获取用户基本信息
	 * @param accessToken 接口访问凭证
	 * @param openId 用户的OPENID
	 * @return
	 */
	public static WeixinUser getUserInfo(String accessToken, String openId) {
		WeixinUser weixinUser = null;
		// 拼接请求地址
		String requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		requestUrl = requestUrl.replace("OPENID", openId);
		// 获取用户基本信息
		String respJSON = CommonUtil.httpsRequest(requestUrl, "GET", null);
		System.out.println(respJSON);
		JSONObject jsonObject = JSONObject.fromObject(respJSON);
		if (null != jsonObject) {
			try {
				weixinUser = new WeixinUser();
				// 关注状态
				weixinUser.setSubscribe(jsonObject.getInt("subscribe"));
				weixinUser.setOpenId(jsonObject.getString("openid"));
				weixinUser.setNickname(jsonObject.getString("nickname"));
				weixinUser.setSex(jsonObject.getInt("sex"));
				weixinUser.setLanguage(jsonObject.getString("language"));
				weixinUser.setCity(jsonObject.getString("city"));
				weixinUser.setProvince(jsonObject.getString("province"));
				weixinUser.setCountry(jsonObject.getString("country"));
				weixinUser.setHeadimgurl(jsonObject.getString("headimgurl"));
				weixinUser.setSubscribeTime(jsonObject.getInt("subscribe_time"));
				// weixinUser.setUnionid(jsonObject.getString("unionid"));
				weixinUser.setRemark(jsonObject.getString("remark"));
				weixinUser.setGroupId(jsonObject.getInt("groupid"));
			} catch (Exception e) {
				if(0 == weixinUser.getSubscribe()) {
					System.out.println("用户 " + weixinUser.getOpenId() + " 已经取消关注公众号！");
				}
				else {
					int errorCode = jsonObject.getInt("errcode");
					String errorMsg = jsonObject.getString("errmsg");
					System.out.println("获取用户基本信息失败 errcode:" + errorCode);
				}
			}
		}
		return weixinUser;
	}

	/**
	 * 通过code换取access_token
	 * @param appID
	 * @param appSecret
	 * @param code 授权码
	 * @return
	 */
	public static WeixinOauth2Token getOAuth2AceessToken(String appID, String appSecret, String code) {
		WeixinOauth2Token wot = null;
		// 拼接请求地址
		String requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
		requestUrl = requestUrl.replace("APPID", appID);
		requestUrl = requestUrl.replace("SECRET", appSecret);
		requestUrl = requestUrl.replace("CODE", code);
		// 接口调用
		String respJSON = CommonUtil.httpsRequest(requestUrl, "GET", null);
		System.out.println(respJSON);
		JSONObject jsonObject = JSONObject.fromObject(respJSON);
		if (null != jsonObject) {
			try {
				wot = new WeixinOauth2Token();
				wot.setAccessToken(jsonObject.getString("access_token"));
				wot.setExpiresIn(jsonObject.getInt("expires_in"));
				wot.setRefreshToken(jsonObject.getString("refresh_token"));
				wot.setOpenId(jsonObject.getString("openid"));
				wot.setScope(jsonObject.getString("scope"));
			} catch (Exception e) {
				wot = null;

				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				System.out.println("通过code换取access_token失败 errcode:" + errorCode);
			}
		}
		return wot;
	}

	/**
	 * 网页授权获取用户信息
	 * @param accessToken
	 * @param openId
	 * @return
	 */
	public static SNSUserInfo getSNSUserInfo(String accessToken, String openId) {
		SNSUserInfo snsUserInfo = null;
		// 拼接请求地址
		String requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		requestUrl = requestUrl.replace("OPENID", openId);
		// 接口调用
		String respJSON = CommonUtil.httpsRequest(requestUrl, "GET", null);
		System.out.println(respJSON);
		JSONObject jsonObject = JSONObject.fromObject(respJSON);
		if (null != jsonObject) {
			try {
				snsUserInfo = new SNSUserInfo();
				snsUserInfo.setOpenId(jsonObject.getString("openid"));
				snsUserInfo.setCity(jsonObject.getString("city"));
				snsUserInfo.setCountry(jsonObject.getString("country"));
				snsUserInfo.setHeadimgurl(jsonObject.getString("headimgurl"));
				snsUserInfo.setNickName(jsonObject.getString("nickname"));
				snsUserInfo.setPrivilege(JSONArray.toList(jsonObject.getJSONArray("privilege"), List.class));
				snsUserInfo.setProvince(jsonObject.getString("province"));
				snsUserInfo.setSex(jsonObject.getInt("sex"));
			} catch (Exception e) {
				snsUserInfo = null;

				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				System.out.println("网页授权获取用户信息失败 errcode:" + errorCode);
			}
		}
		return snsUserInfo;
	}

	/*模板消息发送*/
	public static boolean sendTemplateMessage(Template template) {
		boolean result = false;
		String accessToken = TokenThread.accessToken;
		// 请求地址拼接
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
		if(accessToken != null) {
			System.out.println("通过网页获取的access_token"+accessToken);
			requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
			// 模板消息发送
			String respJSON = CommonUtil.httpsRequest(requestUrl, "POST", template.toJSON());
			System.out.println(respJSON);
			JSONObject jsonObject = JSONObject.fromObject(respJSON);
			if (null != jsonObject) {
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				if (0 == errorCode) {
					result = true;
				} else {
					System.out.println("模板消息发送错误 errcode:" + errorCode);
				}
			}
		}
		else{
			System.out.println("accessToken为空");
		}
		return result;
	}

	/*发送文本消息*/
	public static boolean sendCustomMessage(String jsonMsg) {
		boolean result = false;
		String accessToken = TokenThread.accessToken;
		// 链接
		String requestUrl = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";
		requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
		// 发送消息
		String respJSON = CommonUtil.httpsRequest(requestUrl, "POST", jsonMsg);
		JSONObject jsonObject = JSONObject.fromObject(respJSON);
		if (null != jsonObject) {
			int errorCode = jsonObject.getInt("errcode");
			String errorMsg = jsonObject.getString("errmsg");
			if (0 == errorCode) {
				result = true;
			} else {
				System.out.println("发送成功 errcode:" + errorCode);
			}
		}
		return result;
	}


}
