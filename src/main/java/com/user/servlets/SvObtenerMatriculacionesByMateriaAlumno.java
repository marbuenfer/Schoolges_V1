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
import com.dao.DaoMatricula;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.logica.ActividadAlumno;
import com.logica.Matricula;
import com.logica.*;


@WebServlet("/SvObtenerMatriculacionesByMateriaAlumno")
public class SvObtenerMatriculacionesByMateriaAlumno extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Obtener el ID de Estudio de la solicitud

		String idAluStr = request.getParameter("idAlu");
		//int idMat;
		String idEstudioStr = request.getParameter("idEst");
		int idEst;
		int idAlu;

		//DaoMateria daoMat = new DaoMateria(DbConexion.getConn());
		DaoMatricula daoMat = new DaoMatricula(DbConexion.getConn());

		if ((idEstudioStr == null || idEstudioStr.isEmpty()) && (idAluStr == null || idAluStr.isEmpty())) {
			// Si no se proporciona un ID de materia o alumno, devolver un error
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		} else {
			try {
				idEst = Integer.parseInt(idEstudioStr);
				idAlu = Integer.parseInt(idAluStr);
				List<Matricula> listaMatriculasGroupMateria= daoMat.getMatriculasByAlumnoRolAlumno(idAlu, idEst);

				// Convertir las act a formato JSON
				Gson gson = new Gson();
				String json = gson.toJson(listaMatriculasGroupMateria);

				// Configurar la respuesta HTTP
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				PrintWriter out = response.getWriter();
				out.print(json);
				out.flush();
			} catch (NumberFormatException e) {
				// Manejar el caso en que el parámetro no sea un número válido
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				return;
			}
		}

		 
	}	
}
