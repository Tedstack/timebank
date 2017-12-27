package com.blockchain.timebank.weixin.util;

import java.util.List;

import com.blockchain.timebank.weixin.model.SNSUserInfo;
import com.blockchain.timebank.weixin.model.WeixinOauth2Token;
import com.blockchain.timebank.weixin.model.WeixinUser;
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

	public static void main(String[] args) {
		// 获取access_token
		String accessToekn = CommonUtil.getAccessToken("wx0057906b9b02c814", "bc39d8c8f72aef4394a4ab54729b0e95").getAccess_token();

		// String json = makeTextCustomMessage("oTnKKuHeARMSuDIv7iFr43WyWNKY", "点击查看<a href=\"http://m.blog.csdn.net/blog/lyq8479\">柳峰的博客</a>");
		// sendCustomMessage(accessToekn, json);

		// List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
		// templateParamList.add(new TemplateParam("first", "亲爱的顾客，您好！现为您安排的K房如下", "#173177"));
		// templateParamList.add(new TemplateParam("keyword1", "2015年09月09日 10:20", "#173177"));
		// templateParamList.add(new TemplateParam("keyword2", "天河店", "#173177"));
		// templateParamList.add(new TemplateParam("keyword3", "018房", "#173177"));
		// templateParamList.add(new TemplateParam("keyword4", "自由人", "#173177"));
		// templateParamList.add(new TemplateParam("keyword5", "42元/位", "#173177"));
		// templateParamList.add(new TemplateParam("remark", "祝您欢唱愉快！", "#173177"));
		//
		// Template template = new Template();
		// template.setTemplateId("1uzEiP79vQJEwijdfXcdDwwsXBp4l8OB3pgSQx12lFM");
		// template.setToUser("oAuZ6s_lfFc-OqbrWkZzZsJp6R6M");
		// template.setTopColor("#173177");
		// template.setUrl("");
		// template.setTemplateParamList(templateParamList);

		// {"group":{"id":101,"name":"测试组"}}
		// createGroup(accessToekn, "测试组");

		// List<WeixinGroup> groupList = getGroups(accessToekn);
		// for(WeixinGroup group : groupList) {
		// System.out.println(group.getId() + " - " + group.getName() +"  - " + group.getCount());
		// }

		// int groupId = getMemberGroup(accessToekn, "oAuZ6s_lfFc-OqbrWkZzZsJp6R6M");
		// System.out.println(groupId);

		// updateGroupName(accessToekn, 101, "管理员");

		// updateMemberGroup(accessToekn, "oAuZ6s_lfFc-OqbrWkZzZsJp6R6M", 101);

		// deleteGroup(accessToekn, 101);

		WeixinUser weixinUser = getUserInfo(accessToekn, "oAuZ6s_lfFc-OqbrWkZzZsJp6R6M");
		System.out.println("昵称：" + weixinUser.getNickname());
		System.out.println("OPENID：" + weixinUser.getOpenId());
		System.out.println("头像：" + weixinUser.getHeadimgurl());
		System.out.println("城市：" + weixinUser.getCity());
	}

}
