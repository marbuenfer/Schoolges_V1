package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.dao.DaoEstudio;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.logica.MateriaEnEstudio;

@WebServlet("/SvObtenerAsignacionMateriaYEstudio")
public class SvObtenerAsignacionMateriaYEstudio extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Obtener el ID de Estudio de la solicitud

		String idEstudioStr = request.getParameter("idEst");
		int idEst;
		System.out.println("idEstudio dentro del servlet" + idEstudioStr );

		DaoEstudio daoEst = new DaoEstudio(DbConexion.getConn());

		if (idEstudioStr == null || idEstudioStr.isEmpty()) {
			// Si no se proporciona un ID de Estudio, devolver un error
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		} else {
			try {
				idEst = Integer.parseInt(idEstudioStr);
			} catch (NumberFormatException e) {
				// Manejar el caso en que el parámetro no sea un número válido
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				return;
			}
		}

		try {
			 idEst = Integer.parseInt(idEstudioStr);
			// Obtener las asignaciones de materia para el ID de Estudio dado (puedes
			// adaptar este código según tu lógica)
			List<MateriaEnEstudio> asigMatAEst = daoEst.getAllAsignacionesMateriaEstudio(idEst);

			// Convertir las asigMatAEst a formato JSON
			Gson gson = new Gson();
			String json = gson.toJson(asigMatAEst);

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
