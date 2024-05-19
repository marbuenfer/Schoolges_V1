package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.dao.DaoAdmin;
import com.dao.DaoAlumno;
import com.dao.DaoDocente;
import com.db.DbConexion;
import com.google.gson.Gson;

/**
 * Servlet implementation class SvBorrarAsignacionMateria
 */
@WebServlet("/SvBorrarAsignacionMateria")
public class SvBorrarAsignacionMateria extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int idAsg = 0;
		String message = "";
		boolean valorDevuelto = false;

		String idAsgParam = req.getParameter("idAsg");

		// Verificar si el parámetro "idAsg" está presente y no es nulo
		if (idAsgParam != null && !idAsgParam.isEmpty()) {
			try {
				// Convertir el parámetro "idAsg" a un entero
				idAsg = Integer.parseInt(idAsgParam);

				// Resto del código...
			} catch (NumberFormatException e) {
				// Manejar la excepción si el parámetro "idAsg" no es un número válido
				e.printStackTrace(); // o cualquier otro manejo de error que desees
			}
		} else {
			// Manejar el caso en que el parámetro "idAsg" esté ausente o sea nulo
			System.out.println("El parámetro 'idAsg' no está presente en la solicitud o es nulo.");
		}

		// int idAsg = Integer.parseInt(req.getParameter("idAsg"));
		// String tipoRol = req.getParameter("tipoRol");

		// System.out.println("Valor recogido de tipoRol" + tipoRol);
		System.out.println("Valor recogido de idAsg" + idAsg);

		try {
			//DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
			DaoDocente daoDoc = new DaoDocente(DbConexion.getConn());
			// DaoAdmin daoAdm = new DaoAdmin(DbConexion.getConn());

			valorDevuelto = daoDoc.borrarAsignacionDocente(idAsg);

			if (valorDevuelto) {
				// Tu lógica para redirigir en caso de éxito
				message = "Registro de usuario borrado exitosamente";
			} else {
				// Tu lógica para redirigir en caso de error
				message = "Error al borrar el registro de usuario";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// Construir el objeto JsonResponse
		JsonResponse jsonResponse = new JsonResponse(valorDevuelto, message);

		// Convertir el objeto JsonResponse a JSON
		Gson gson = new Gson();
		String json = gson.toJson(jsonResponse);

		// Configurar la respuesta HTTP
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		// Escribir el JSON en el cuerpo de la respuesta HTTP
		PrintWriter out = resp.getWriter();
		out.print(json);
		out.flush();
	}

}
