package kr.ac.mydog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.dao.MemberDAO;
import kr.ac.mydog.member.vo.MemberVO;
import kr.ac.mydog.product.dao.ProductDAO;
import kr.ac.mydog.product.vo.ProductVO;

public class MainShopController implements Controller{

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		HttpSession session = request.getSession();
//		MemberVO user = (MemberVO) session.getAttribute("user");
		ProductDAO productDao = new ProductDAO();
		List<ProductVO> mainRecentAdd =  productDao.mainRecAdd();
		request.setAttribute("mainRecentAdd", mainRecentAdd);	
        
/*        if (user != null) {
        	return "/index.jsp";        	
        }else {
        	String id = request.getParameter("id");
    		
    		if(id==null) {
    			session = request.getSession();
    			MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
    			return "index.jsp";
    		}else {
    			MemberVO memberVO = new MemberVO();
    			memberVO.setId(id);
    			
    			MemberDAO memberDAO = new MemberDAO();	
    			MemberVO member = memberDAO.getMemberById(memberVO.getId());
    			System.out.println(member.getDetailAddr());
    			
    			if(member != null) {				
    			session = request.getSession();
                session.setAttribute("user", member);           
                String currentUrl = request.getRequestURL().toString();
                
    			}
    			return "redirect:mydog.do";
    			
    		}     	
        }	*/	
		
		return "/index.jsp";
	}
}
