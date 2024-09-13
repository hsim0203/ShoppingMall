package kr.ac.mydog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.mydog.framework.Controller;

public class SignupFormController implements Controller {

    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
        return "/member/signup/signupForm.jsp";
    }
}
