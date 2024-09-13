package kr.ac.mydog.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.cart.dao.CartDAO;
import kr.ac.mydog.cart.vo.CartVO;
import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.order.dao.OrderDAO;
import kr.ac.mydog.order.vo.OrderVO;
import kr.ac.mydog.order.vo.OrderDetailVO;
import kr.ac.mydog.member.vo.MemberVO;

public class OrderController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        
        if (user == null) {
            return "loginForm.do"; // 로그인되어 있지 않으면 로그인 페이지로 리다이렉트
        }

        String userId = user.getId();
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String post = request.getParameter("post");
        String basicAddr = request.getParameter("basicAddr");
        String detailAddr = request.getParameter("detailAddr");
        String orderAddress = basicAddr + " " + detailAddr + " (" + post + ")";
        
        // 총 금액 가져오기
        double totalAmount;
        try {
            totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        } catch (NumberFormatException e) {
            return "orderForm.jsp";
        }

        // 주문번호 생성
        OrderDAO orderDAO = new OrderDAO();
        String orderNo = orderDAO.getNextOrderNo();

        // 주문 데이터 생성
        OrderVO order = new OrderVO();
        order.setOrderNo(orderNo);
        order.setUserId(userId);
        order.setOrderAddress(orderAddress);
        order.setPaymentMethod("카드"); // 임시로 카드 결제로 설정
        order.setTotalAmount(totalAmount);
        order.setStatus("주문완료"); //결제구현 완료시 결제대기로 값 설정

        try {
            orderDAO.insertOrder(order);
        } catch (Exception e) {
            e.printStackTrace();
            return "orderForm.jsp";
        }

        // 장바구니에서 주문 상세 데이터 생성 및 삽입
        List<CartVO> cartList = (List<CartVO>) session.getAttribute("cartList");
        if (cartList == null) {
             //cartList가 null이면 장바구니 페이지로 리다이렉트
            return "cart.do";
        }
/*
        for (CartVO cart : cartList) {
            OrderDetailVO orderDetail = new OrderDetailVO();
            orderDetail.setOrderNo(orderNo); // 생성된 orderNo를 사용
            orderDetail.setProductCode(cart.getProductCode());
            orderDetail.setQuantity(cart.getQuantity());
            orderDetail.setPrice(cart.getCartPrice() * cart.getQuantity());
            
            try {
                orderDAO.insertOrderDetail(orderDetail);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "주문 상세 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
                return "orderForm.jsp";
            }
        }*/
        
        String[] productCodes = request.getParameterValues("productCode");
        String[] quantities = request.getParameterValues("quantity");
        String[] cartPrices = request.getParameterValues("cartPrice");
        
        for (int i = 0; i < productCodes.length; i++) {
            OrderDetailVO orderDetail = new OrderDetailVO();
            orderDetail.setOrderNo(orderNo);
            orderDetail.setProductCode(productCodes[i]);
            orderDetail.setQuantity(Integer.parseInt(quantities[i]));
            orderDetail.setPrice(Double.parseDouble(cartPrices[i]) * Integer.parseInt(quantities[i]));

            try {
                orderDAO.insertOrderDetail(orderDetail);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "주문 상세 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
                return "orderForm.jsp";
            }
        }

        // 주문 정보와 세부 정보 가져오기
        OrderVO savedOrder = orderDAO.getOrderByNo(orderNo);
        List<OrderDetailVO> orderDetails = orderDAO.getOrderDetailsByOrderNo(orderNo);

        // 디버깅 정보 출력
        System.out.println("주문 번호: " + orderNo);
        System.out.println("사용자 ID: " + userId);
        System.out.println("총 금액: " + totalAmount);
        for (OrderDetailVO detail : orderDetails) {
            System.out.println("상품 코드: " + detail.getProductCode() + ", 수량: " + detail.getQuantity() + ", 가격: " + detail.getPrice());
        }

        // 주문 완료 후 장바구니 비우기
        request.removeAttribute("cartList");
        session.removeAttribute("cartList");
        
        CartDAO cartDAO = new CartDAO();
        cartDAO.deleteSelectedCartProducts(userId, cartList.stream().map(CartVO::getProductCode).toArray(String[]::new));

        
        for (OrderDetailVO detail : orderDetails) {
            Map<String, Object> params = new HashMap<>();
            params.put("productCode", detail.getProductCode());
            params.put("quantity", detail.getQuantity());
            orderDAO.updateProductStock(params);
        }

        // 성공 메시지 설정
        request.setAttribute("order", savedOrder);
        request.setAttribute("orderDetails", orderDetails);
        
        
        return "orderSuccess.jsp"; // 성공 페이지로 이동
    }
}
