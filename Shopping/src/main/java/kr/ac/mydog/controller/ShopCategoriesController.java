package kr.ac.mydog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.product.dao.ProductDAO;
import kr.ac.mydog.product.vo.ProductVO;


public class ShopCategoriesController implements Controller {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String CCode = request.getParameter("categoriCode");
		
		ProductDAO productDao = new ProductDAO();
		List<ProductVO> shopCategories = productDao.productCategories(CCode);
		request.setAttribute("shopCategories", shopCategories);
		return "/categories.jsp";
	}
}
