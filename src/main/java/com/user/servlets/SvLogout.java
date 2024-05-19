package com.user.servlets;

import java.io.IOException;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

  
@WebServlet("/SvLogout")
public class SvLogout extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
		session.removeAttribute("userObj");
		session.setAttribute("succMsg", "User Logout Sucessfully");
		System.out.println("Cerrando sesión");
		resp.sendRedirect("index.jsp");	
    }  
}
