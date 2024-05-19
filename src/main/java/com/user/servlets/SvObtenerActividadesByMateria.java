package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.dao.DaoMateria;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.logica.Actividad;
import com.logica.ActividadAlumno;

@WebServlet("/SvObtenerActividadesByMateria")
public class SvObtenerActividadesByMateria extends HttpServlet {
	private static final long serialVersionUID = 1L;
//Obtiene las actividades asociadas a una materia en general(no tienen nota)
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Obtener el ID de Estudio de la solicitud

		//String idMateriaStr = request.getParameter("idEst");
		//int idMat;
		String idMateriaStr = request.getParameter("idMat");
		int idMat;

		DaoMateria daoMat = new DaoMateria(DbConexion.getConn());

		if (idMateriaStr == null || idMateriaStr.isEmpty()) {
			// Si no se proporciona un ID de Estudio, devolver un error
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		} else {
			try {
				idMat = Integer.parseInt(idMateriaStr);
			} catch (NumberFormatException e) {
				// Manejar el caso en que el parámetro no sea un número válido
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				return;
			}
		}

		try {
			 idMat = Integer.parseInt(idMateriaStr);
			// idMat= Integer.parseInt(idMateriaStr);
			// Obtener las asignaciones de materia para el ID de Estudio dado (puedes
			// adaptar este código según tu lógica)
				List<Actividad> listaActividades= daoMat.getActividadesEnMateria(idMat);

			// Convertir las act a formato JSON
			Gson gson = new Gson();
			String json = gson.toJson(listaActividades);

			// Configurar la respuesta HTTP
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
		} catch (NumberFormatException e) {
			// Si el ID de Estudio no es un número válido, devolver un error
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
	}	
}
