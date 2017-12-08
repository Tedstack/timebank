package com.blockchain.timebank.weixin.servlet;

import com.blockchain.timebank.weixin.util.SignUtil;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/coreServlet")
public class CoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 在服务器配置时，用于token校验
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		String echostr = request.getParameter("echostr");

		PrintWriter out = response.getWriter();
		// 如果校验成功
		if (SignUtil.checkSignature(signature, timestamp, nonce)) {
			out.write(echostr);
		}
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 编码设置
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		// 请求校验
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		PrintWriter out = response.getWriter();
		// 如果校验成功
		if (SignUtil.checkSignature(signature, timestamp, nonce)) {
			// 消息进行处理
			/*String respXML = CoreService.processRequest(request);
			out.write(respXML);*/
		}
		out.close();
	}
}
