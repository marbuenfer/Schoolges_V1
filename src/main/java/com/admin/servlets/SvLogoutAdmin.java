package com.admin.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class SvLoginAdmin
 */
@WebServlet(name = "SvLogoutAdmin", urlPatterns= "/SvLogoutAdmin")
public class SvLogoutAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SvLogoutAdmin() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();
			// Obtiene o crea una sesión HTTP. Las sesiones se utilizan para mantener
			// el estado entre múltiples solicitudes del mismo usuario

			session.removeAttribute("adminObj");

			session.setAttribute("succMsg", "Admin Logout Sucessfully");

			response.sendRedirect("adminLogin.jsp");

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
