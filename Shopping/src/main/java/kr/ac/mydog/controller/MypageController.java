package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.vo.MemberVO;

public class MypageController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            MemberVO user = (MemberVO) session.getAttribute("user");
            request.setAttribute("user", user);
            return "/member/mypage.jsp";
        } else {
           // return "redirect:loginForm.do";
            return "loginForm.do";
        }
    }
}
