package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.dao.DaoDocente;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.logica.AsignacionDocente;

@WebServlet("/SvObtenerAsignacionesPorDocente")
public class SvObtenerAsignacionesPorDocente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Obtén el ID del estudio desde los parámetros de la solicitud
		String idDocParam = request.getParameter("idDoc");
		int idDoc = (idDocParam != null && !idDocParam.isEmpty()) ? Integer.parseInt(idDocParam) : 0;
		
		
		System.out.println(idDoc);
		// Utiliza tu lógica para obtener las materias desde la base de datos
		DaoDocente daoDocente = new DaoDocente(DbConexion.getConn());
		List<AsignacionDocente> matri= daoDocente.getAllAsignacionesByDocente(idDoc);
		System.out.println(matri.toString());

		// Convierte la lista de materias a formato JSON
		Gson gson = new Gson();
		String jsonAsignacionDocente = gson.toJson(matri);

		// Configura la respuesta HTTP
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Envía la respuesta JSON al cliente
		response.getWriter().write(jsonAsignacionDocente);
	}
	}