package com.blockchain.timebank.weixin.servlet;


import com.alibaba.fastjson.JSON;
import com.blockchain.timebank.weixin.util.Sign;
import com.blockchain.timebank.weixin.util.TokenThread;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 * Created by xu on 2017/7/12.
 */
@WebServlet("/scanGetConfigServlet")
public class GetConfigServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("GetConfigServlet doPost");
        String url = request.getParameter("url");
       // String jsapi_tickec = TokenThread.jsapiTicket.getJsapiTicket();
        String jsapi_tickec = TokenThread.jsapiTicket;
        Map<String, String> jssdk = Sign.main(jsapi_tickec,url);
        String str = JSON.toJSONString(jssdk);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.write(str);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("get config test success");
    }
}
