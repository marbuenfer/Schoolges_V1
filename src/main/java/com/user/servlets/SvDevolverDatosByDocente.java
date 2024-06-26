package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.dao.DaoMateria;
import com.dao.DaoUsuario;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.logica.MateriaEnEstudio;
import com.logica.Usuario;

/**
 * Servlet implementation class SvDevolverEmailByDocente
 */
@WebServlet("/SvDevolverDatosByDocente")
public class SvDevolverDatosByDocente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Obtén el ID del estudio desde los parámetros de la solicitud
		String idDocParam = request.getParameter("idDoc");
		int idDoc = (idDocParam != null && !idDocParam.isEmpty()) ? Integer.parseInt(idDocParam) : 0;
		
		
		System.out.println(idDoc);
		// Utiliza tu lógica para obtener las materias desde la base de datos
		DaoUsuario daoUsuario = new DaoUsuario(DbConexion.getConn());
		Usuario doc = daoUsuario.getUsuarioById(idDoc);
		System.out.println("docente en servlet SvDelvolverDatosByDocente " + doc.toString());

		// Convierte la lista de materias a formato JSON
		Gson gson = new Gson();
		String jsonDoc = gson.toJson(doc);

		// Configura la respuesta HTTP
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Envía la respuesta JSON al cliente
		response.getWriter().write(jsonDoc);
	}
}