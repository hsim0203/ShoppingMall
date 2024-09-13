package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.ac.mydog.member.dao.MemberDAO;
import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.dao.MemberBatisConfig;
import kr.ac.mydog.member.vo.MemberVO;

public class SignupController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	MemberDAO memberDao = new MemberDAO(); 
    	
        String userId = request.getParameter("userId");
        String userPassword = request.getParameter("userPassword");
        String userName = request.getParameter("userName");
        String birthDate = request.getParameter("birthDate");
        String phone = request.getParameter("phone");
        String post = request.getParameter("post");
        String basicAddr = request.getParameter("basicAddr");
        String detailAddr = request.getParameter("detailAddr");
        String userEmail = request.getParameter("userEmail");
        System.out.println(userName);
        MemberVO member = new MemberVO();
        member.setId(userId);
        member.setPassword(userPassword);
        member.setName(userName);
        member.setBirthDate(birthDate);
        member.setPhone(phone);
        member.setPost(post);
        member.setBasicAddr(basicAddr);
        member.setDetailAddr(detailAddr);
        member.setEmail(userEmail);
        boolean isSuccess = memberDao.insertMember(member);
        
        if (isSuccess) {
            return "/member/signup/signupSuccess.jsp";
        } else {
            request.setAttribute("errorMessage", "회원가입에 실패했습니다. 다시 시도해주세요.");
            return "/member/signup/signupForm.jsp";
        }
    }
}
