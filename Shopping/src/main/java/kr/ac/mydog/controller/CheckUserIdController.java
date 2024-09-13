package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.ac.mydog.member.dao.MemberDAO;
import kr.ac.mydog.framework.Controller;
import kr.ac.mydog.member.dao.MemberBatisConfig;

public class CheckUserIdController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	MemberDAO memberDao = new MemberDAO();
    	
        String userId = request.getParameter("userId");
        boolean isAvailable = memberDao.checkUserId(userId);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (isAvailable) {
            response.getWriter().write("available");
        } else {
            response.getWriter().write("unavailable");
        }
        return null;
    }
}
