package com.blockchain.timebank.weixin.servlet;

import com.blockchain.timebank.weixin.util.Configs;
import com.blockchain.timebank.weixin.util.TokenThread;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

//创建的类名根据需要定义，但一定要实现ServletContextListener接口
public class AccesstokenInit implements ServletContextListener {

    public void contextInitialized(ServletContextEvent arg0) {
        TokenThread.appId = Configs.APPID; //获取servlet初始参数appid和appsecret
        TokenThread.appSecret = Configs.APPSECRET;
        new Thread(new TokenThread()).start(); //启动进程
        System.out.println("Accesstoken线程已启动.");
    }

    public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
    }


}