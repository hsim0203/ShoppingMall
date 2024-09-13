package kr.ac.mydog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.cart.dao.CartDAO;
import kr.ac.mydog.cart.vo.CartVO;
import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.dao.MemberDAO;
import kr.ac.mydog.member.vo.MemberVO;

public class OrderFormController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");
        
    	CartDAO cartDao = new CartDAO();
    	MemberDAO memberDao = new MemberDAO();
    	

        if (user == null) {
            return "loginForm.do"; // 로그인되어 있지 않으면 로그인 페이지로 리다이렉트
        }
        
        String userId = user.getId();
        
        //사용자 정보 가져오기
		/*
		 * MemberVO memberInfo = memberDao.getMemberById(userId);
		 * System.out.println(memberInfo); request.setAttribute("memberInfo",
		 * memberInfo);
		 */
        
        String[] selectedProducts = request.getParameterValues("selectedProducts");
        if (selectedProducts == null || selectedProducts.length == 0) { 
            return "cart.do"; // 선택된 항목이 없으면 다시 장바구니로.
        }
        
        List<CartVO> cartList = cartDao.getCartProductsByIds(userId, selectedProducts);
        
        session.setAttribute("cartList", cartList);
        request.setAttribute("cartList", cartList);
        
        return "/orderForm.jsp";
    }
}
