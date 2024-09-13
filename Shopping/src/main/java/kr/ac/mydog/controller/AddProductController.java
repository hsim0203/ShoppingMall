package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.product.dao.ProductDAO;
import kr.ac.mydog.product.vo.ProductVO;
import kr.ac.mydog.member.vo.MemberVO;

public class AddProductController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"A".equals(user.getAdmin())) {
            return "loginForm.do";
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            return "/addProduct.jsp";
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            String productCode = request.getParameter("productCode");
            String productName = request.getParameter("productName");
            int productPrice = Integer.parseInt(request.getParameter("productPrice"));
            int productStock = Integer.parseInt(request.getParameter("productStock"));
            String productDetail = request.getParameter("productDetail");
            String categoryCode = request.getParameter("categoryCode");
            String imgLink1 = request.getParameter("imgLink1");
            String imgLink2 = request.getParameter("imgLink2");

            ProductVO product = new ProductVO();
            product.setProductCode(productCode);
            product.setProductName(productName);
            product.setProductPrice(productPrice);
            product.setProductStock(productStock);
            product.setProductDetail(productDetail);
            product.setCategoriCode(categoryCode);

            ProductDAO productDAO = new ProductDAO();
            productDAO.insertProduct(product);

            if (imgLink1 != null && !imgLink1.isEmpty()) {
                product.setImgLink(imgLink1);
                product.setImgType("P");
                productDAO.insertProductImage(product);
            }

            if (imgLink2 != null && !imgLink2.isEmpty()) {
                product.setImgLink(imgLink2);
                product.setImgType("D");
                productDAO.insertProductImage(product);
            }
            return "mydog.do";
        } else {
            return "login.do"; 
        }
    }
}
