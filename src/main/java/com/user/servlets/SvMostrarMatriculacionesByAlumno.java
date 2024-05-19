package com.user.servlets;

import java.io.IOException;
import java.util.List;

import com.dao.DaoMatricula;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.logica.Matricula;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/SvMostrarMatriculacionesByAlumno")
public class SvMostrarMatriculacionesByAlumno extends HttpServlet {
    //Sirve para obtener las materias en las que se ha matriculado un alumno en la caja desplegable de la sección
	//de actividades
	private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	// Obtén el ID del estudio desde los parámetros de la solicitud
	String idAluParam = request.getParameter("idAlu");
	//String idEstParam = request.getParameter("idEst");

	int idAlu = (idAluParam != null && !idAluParam.isEmpty()) ? Integer.parseInt(idAluParam) : 0;
	//int idEst = (idEstParam != null && !idEstParam.isEmpty()) ? Integer.parseInt(idEstParam) : 0;

	
	System.out.println(idAlu);
	//System.out.println(idEst);
	// Utiliza tu lógica para obtener las materias desde la base de datos
	DaoMatricula daoMatricula = new DaoMatricula(DbConexion.getConn());
	List<Matricula> matri= daoMatricula.getMatriculasByAlumnoRolAlumno(idAlu);
	System.out.println(matri.toString());

	// Convierte la lista de materias a formato JSON
	Gson gson = new Gson();
	String jsonMatricula = gson.toJson(matri);

	// Configura la respuesta HTTP
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");

	// Envía la respuesta JSON al cliente
	response.getWriter().write(jsonMatricula);
}
}
