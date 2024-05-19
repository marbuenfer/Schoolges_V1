package com.user.servlets;

import java.io.IOException;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;

import com.dao.DaoUsuario;
import com.db.DbConexion;
import com.logica.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet( "/SvLoginUsuario" )
public class SvLoginUsuario extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// Obtén los parámetros del formulario
			/*
			 * String dniUsu = req.getParameter("dniUsu"); String nomCompUsu =
			 * req.getParameter("nomCompUsu"); String telUsu = req.getParameter("telUsu");
			 * String obsUsu = req.getParameter("obsUsu"); String direcUsu =
			 * req.getParameter("direcUsu"); // String fechaString =
			 * req.getParameter("fechNacUsu");
			 */
			String pswordUsu = req.getParameter("pswordUsu");
			// String tipoRolUsu = req.getParameter("tipoRolUsu");
			String emailUsu = req.getParameter("emailUsu");
			/*
			 * String cpUsu = req.getParameter("cpUsu"); String localUsu=
			 * req.getParameter("localUsu"); String provUsu = req.getParameter("provUsu");
			 */

			// Usuario usu = new Usuario(dniUsu, nomCompUsu, telUsu, obsUsu, direcUsu,
			// emailUsu, pswordUsu, tipoRolUsu, cpUsu, localUsu, provUsu);

			// conectar con la base de datos
			DaoUsuario dao = new DaoUsuario(DbConexion.getConn());

			HttpSession session = req.getSession();
			
			// En el servlet o código asociado a login.jsp
			//String origen = req.getParameter("origen");

			// Coloca este origen en la sesión si es necesario
			//session.setAttribute("origen", origen);


			Usuario usu = dao.login(emailUsu, pswordUsu);
			System.out.println(usu);

			if (usu != null) {
				session.setAttribute("userObj", usu);
				session.setAttribute("succMsg", "¡Inicio de sesión exitoso!");
				resp.sendRedirect("index.jsp");
				//resp.sendRedirect(req.getContextPath() + "/index.jsp");
				
				System.out.println("Usuario existe");
			} else {
				session.setAttribute("errorMsg", "¡Inválido email & password!");
				resp.sendRedirect("usuarioLogin.jsp");

			}


		} catch (Exception e) {
			// Manejar otras excepciones
			e.printStackTrace();
			System.out.println("Error general");
		}
		  
	}
	
	 
	     
	}

