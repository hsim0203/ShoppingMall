package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.cart.dao.CartDAO;
import kr.ac.mydog.cart.vo.CartVO;
import kr.ac.mydog.member.vo.MemberVO;

import java.util.List;

public class CartController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            return "loginForm.do";
        }

        CartDAO cartDAO = new CartDAO();
        List<CartVO> cartList = cartDAO.selectCartByUserId(user.getId());

        request.setAttribute("cartList", cartList);

        return "/cart.jsp";
    }
}
