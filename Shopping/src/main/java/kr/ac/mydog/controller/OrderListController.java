package kr.ac.mydog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.vo.MemberVO;
import kr.ac.mydog.order.dao.OrderDAO;
import kr.ac.mydog.order.vo.OrderVO;

public class OrderListController implements Controller{

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute("user");
				
		if (user == null) {
			return "loginForm.do";
		}
		
		OrderDAO orderDAO = new OrderDAO();
		List<OrderVO> orderList = orderDAO.getOrderById(user.getId());
		
		request.setAttribute("orderList", orderList);
		
		return "orderList.jsp";
	}
}
