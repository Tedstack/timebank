package com.blockchain.timebank.weixin.servlet;

import com.blockchain.timebank.weixin.util.Configs;
import com.blockchain.timebank.weixin.util.TokenThread;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by xu on 2017/7/10.
 */
@WebServlet("/scanAccessTokenServlet")
public class AccessTokenServlet extends HttpServlet {

    public void init() throws ServletException {
        TokenThread.appId = Configs.APPID; //获取servlet初始参数appid和appsecret
        TokenThread.appSecret = Configs.APPSECRET;
//        System.out.println("appid:"+TokenThread.appId);
//        System.out.println("appSecret:"+TokenThread.appSecret);
        new Thread(new TokenThread()).start(); //启动进程
        System.out.println("Accesstoken线程已启动.");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
