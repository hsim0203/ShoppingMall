package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.cart.dao.CartDAO;
import kr.ac.mydog.member.vo.MemberVO;

public class DelCartController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        if (user == null) {
            return "loginForm.do";
        }

        String[] selectedProducts = request.getParameterValues("selectedProducts");
        System.out.println(selectedProducts);
        CartDAO cartDAO = new CartDAO();
        
        System.out.println(cartDAO);
        
        if (selectedProducts != null) {
            for (String productCode : selectedProducts) {
                cartDAO.deleteCartProduct(user.getId(), productCode);
            }
        }

        return "cart.do";
    }
}
