package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.cart.dao.CartDAO;
import kr.ac.mydog.cart.vo.CartVO;
import kr.ac.mydog.member.vo.MemberVO;

import java.util.HashMap;
import java.util.Map;

public class AddCartController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");
        String userId = (user != null) ? user.getId() : null; // MemberVO 객체에서 ID를 가져옴
        String productCode = request.getParameter("productCode");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int productPrice = Integer.parseInt(request.getParameter("productPrice"));

        System.out.println("AddCartController - userId: " + userId + ", productCode: " + productCode + ", quantity: " + quantity + ", productPrice: " + productPrice); // 디버깅 메시지

        if (userId == null) {
            request.setAttribute("message", "로그인이 필요한 기능입니다. 로그인 페이지로 이동하시겠습니까?");
            return "single.do?productCode=" + productCode;
        }

        if (userId != null && productCode != null) {
            CartDAO cartDAO = new CartDAO();
            Map<String, Object> params = new HashMap<>();
            params.put("userId", userId);
            params.put("productCode", productCode);

            CartVO existingCart = cartDAO.selectCartProduct(params);
            if (existingCart != null) {
                existingCart.setQuantity(existingCart.getQuantity() + quantity);
                existingCart.setCartPrice(existingCart.getQuantity() * productPrice);
                cartDAO.updateCart(existingCart);
            } else {
                CartVO newCart = new CartVO();
                newCart.setUserId(userId);
                newCart.setProductCode(productCode);
                newCart.setQuantity(quantity);
                newCart.setCartPrice(quantity * productPrice);
                cartDAO.insertCart(newCart);
            }
            request.setAttribute("message", "장바구니에 추가되었습니다.");
        } else {
            request.setAttribute("message", "장바구니 추가에 실패했습니다.");
        }

        return "single.do?productCode=" + productCode;
    }
}
