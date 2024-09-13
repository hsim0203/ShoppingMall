package kr.ac.mydog.controller;

import java.util.Base64;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.dao.MemberDAO;
import kr.ac.mydog.member.vo.MemberVO;

public class LoginFormController implements Controller{
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//return "redirect:http://172.31.9.175:8080/loginForm";
		return "/member/login/loginForm.jsp";
	}
}
