package kr.ac.mydog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.vo.MemberVO;
import kr.ac.mydog.order.dao.OrderDAO;
import kr.ac.mydog.order.vo.OrderDetailVO;

public class OrderDetailController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		OrderDAO orderDAO = new OrderDAO();
		
		if(user == null) {
			return "loginForm.do";
		}
		String userId = user.getId();
		String ouserId = request.getParameter("userId");
		String orderNo = request.getParameter("orderNo");
		
		System.out.println(userId);
		System.out.println(ouserId);
		
		if(userId.equals(ouserId)) {
			List<OrderDetailVO> orderDetails = orderDAO.getOrderDetailsByOrderNo(orderNo);
			
			System.out.println(orderDetails);
			
			request.setAttribute("orderDetails", orderDetails);
			
			return "orderListDetail.jsp";
		}else {
			return "loginForm.do";
		}
		
	}
	
}
