package kr.ac.mydog.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.mydog.member.dao.MemberBatisConfig;
import kr.ac.mydog.member.dao.MemberDAO;

/**
 * Servlet implementation class CheckUserIdServlet
 */
@WebServlet("/checkUserId.ajax")
public class CheckUserIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberDAO memberDAO;

  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckUserIdServlet() {
        super();
        memberDAO = new MemberDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	/* 디버그모드에서 실행시 42번라인에 브레이크포인트를 걸면 f6로 한줄씩 실행이 가능해짐 */
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
        boolean isAvailable = memberDAO.checkUserId(userId);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (isAvailable) {
            response.getWriter().write("available");
        } else {
            response.getWriter().write("unavailable");
        }
        response.getWriter().flush();
        response.getWriter().close();
        
	}

}
