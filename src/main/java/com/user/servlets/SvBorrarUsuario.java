package com.user.servlets;

import java.io.IOException;

import com.dao.DaoAdmin;
import com.dao.DaoAlumno;
import com.dao.DaoDocente;
import com.db.DbConexion;

import com.google.gson.Gson;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SvBorrarUsuario")
public class SvBorrarUsuario extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int idUsu = 0;
		 String idUsuParam = req.getParameter("idUsu");
		    
		    // Verificar si el parámetro "idUsu" está presente y no es nulo
		    if (idUsuParam != null && !idUsuParam.isEmpty()) {
		        try {
		            // Convertir el parámetro "idUsu" a un entero
		             idUsu = Integer.parseInt(idUsuParam);
		            
		            // Resto del código...
		        } catch (NumberFormatException e) {
		            // Manejar la excepción si el parámetro "idUsu" no es un número válido
		            e.printStackTrace(); // o cualquier otro manejo de error que desees
		        }
		    } else {
		        // Manejar el caso en que el parámetro "idUsu" esté ausente o sea nulo
		        System.out.println("El parámetro 'idUsu' no está presente en la solicitud o es nulo.");
		    }
		
		
		//int idUsu = Integer.parseInt(req.getParameter("idUsu"));
		String tipoRol = req.getParameter("tipoRol");
		

		System.out.println("Valor recogido de tipoRol" + tipoRol);
		System.out.println("Valor recogido de idUSu" + idUsu);

		DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		DaoDocente daoDoc = new DaoDocente(DbConexion.getConn());
		DaoAdmin daoAdm = new DaoAdmin(DbConexion.getConn());

		boolean valorDevuelto = false;
		String message = "";
		// Tu lógica para borrar el usuario y obtener el resultado
		try {
			switch (tipoRol) {
			case "AL":
				// Borrar registro de la tabla Usuarios
				valorDevuelto = daoAlu.borrarAlumno(idUsu);
				break;
			case "DO":
				// Borrar registro de la tabla Usuarios
				valorDevuelto = daoDoc.borrarDocente(idUsu);
				break;
			case "AD":
				// Borrar registro de la tabla Usuarios
				valorDevuelto = daoAdm.borrarAdmin(idUsu);
				break;
			default:
				message = "¡Registro de usuario no borrado, tipo de rol no válido!";
			}

			if (valorDevuelto) {
				// Tu lógica para redirigir en caso de éxito
				message = "Registro de usuario borrado exitosamente";
			} else {
				// Tu lógica para redirigir en caso de error
				message = "Error al borrar el registro de usuario";
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = "Error al procesar la solicitud";
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

class JsonResponse {
	private boolean success;
	private String message;

	public JsonResponse(boolean success, String message) {
		this.success = success;
		this.message = message;
	}

	// Getters y setters
}
