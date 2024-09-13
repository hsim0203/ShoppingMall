package kr.ac.mydog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.product.dao.ProductDAO;
import kr.ac.mydog.product.vo.ProductVO;
import kr.ac.mydog.review.dao.ReviewDAO;
import kr.ac.mydog.review.vo.ReviewVO;

public class ProductDetailController implements Controller{
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String PCode = request.getParameter("productCode");
		ProductDAO productDao = new ProductDAO();
		ProductVO productDetail = new ProductVO();
		productDetail = productDao.proudctDetail(PCode);
		request.setAttribute("productDetail", productDetail);
				
		ProductVO productDetailImg = new ProductVO();
		productDetailImg = productDao.proudctDetailImg(PCode);
		request.setAttribute("productDetailImg", productDetailImg);
		
        ReviewDAO reviewDao = new ReviewDAO();
        List<ReviewVO> reviews = reviewDao.selectReByPCode(PCode);
        request.setAttribute("reviews", reviews);
		
		return "/single.jsp";
	}
}
