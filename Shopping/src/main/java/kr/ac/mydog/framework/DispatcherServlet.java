package kr.ac.mydog.framework;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet {

    private HandlerMapping mappings;

    @Override
    public void init(ServletConfig config) throws ServletException {
        String propLoc = config.getInitParameter("propLoc");
        System.out.println("Initializing DispatcherServlet with propLoc: " + propLoc); // 디버깅 메시지
        mappings = new HandlerMapping(propLoc);
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String uri = request.getRequestURI();
        uri = uri.substring(request.getContextPath().length());
        System.out.println("Request URI: " + uri); // 디버깅 메시지

        try {
            Controller control = mappings.getController(uri);
            String callPage = control.handleRequest(request, response);
            if (control == null) {
                throw new ServletException("No controller found for URI: " + uri);
            }
            
			/*
			 * if(callPage.endsWith("mydog.do") || callPage.startsWith("single.do")||
			 * callPage.startsWith("delcart.do")) { //return된 페이지를 리다이렉트
			 * response.sendRedirect(callPage); return; }else
			 */ if (callPage.startsWith("redirect:")) {
				callPage = callPage.substring("redirect:".length());
				response.sendRedirect(callPage);
            	return;
			}
            else {            //foward 방식으로할떄는 url은 변경되지않고 값(페이지)만 리턴됨
            RequestDispatcher dispatcher = request.getRequestDispatcher(callPage);
            dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
