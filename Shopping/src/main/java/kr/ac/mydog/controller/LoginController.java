package kr.ac.mydog.controller;

import java.io.IOException;
import java.util.Base64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.member.dao.MemberDAO;
import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.dao.MemberBatisConfig;
import kr.ac.mydog.member.vo.MemberVO;

public class LoginController implements Controller {
/*	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
//파라미터값으로 로그인 하기 위한 방법		
		if(id==null) {
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
			return "index.jsp";
		}else {
			MemberVO memberVO = new MemberVO();
			memberVO.setId(id);
			
			MemberDAO memberDAO = new MemberDAO();	
			MemberVO member = memberDAO.getMemberById(memberVO.getId());
			
			if(member != null) {				
			//member가 널값이 아닐때 세션에 유저를 등록하고 파라미터값 삭제
			HttpSession session = request.getSession();
            session.setAttribute("user", member);           
            String currentUrl = request.getRequestURL().toString();
            
			}
			return "redirect:mydog.do";			
		}
	}*/

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
    	MemberDAO memberDao = new MemberDAO();
        String userId = request.getParameter("userId");
        String userPassword = request.getParameter("userPassword");

        MemberVO member = memberDao.selectMember(userId, userPassword);

        if (member != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", member);
            return "mydog.do";
        } else {
            request.setAttribute("loginFailed", true);
            return "loginForm.do";
        }
    }
    
}
