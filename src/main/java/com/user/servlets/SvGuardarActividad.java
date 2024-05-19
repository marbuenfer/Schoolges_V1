package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.dao.DaoMateria;
import com.db.DbConexion;
import com.logica.Actividad;
import com.logica.ActividadAlumno;
import org.json.JSONObject;

@WebServlet("/SvGuardarActividad")
public class SvGuardarActividad extends HttpServlet {
	private static final long serialVersionUID = 1L;
//Guarda una actividad perteneciente a una materia(todavía no tiene nota, es una actividad general)
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// Crear un objeto JSON para enviar al cliente

		JSONObject jsonResponse = new JSONObject();

		DaoMateria daoMateria = new DaoMateria(DbConexion.getConn());

		// String idActParam;
		String idActParam;
		String idMatParam;
		String enuActParam;
 
 		String obsActParam;

		int idAct = 0;
		int idMat = 0;
		// String enuAct = "";
		double notaAct = 0;
		// String obsAct = "";

		boolean resultado = false;

		idActParam = request.getParameter("idAct");
		idMatParam = request.getParameter("idMat");
		//notaActParam = request.getParameter("notaAct");
		 enuActParam = request.getParameter("enuAct");
		 obsActParam = request.getParameter("obsAct");

		System.out.println("recibido de formulario en SvGuardarActividad.... idActParam " + idActParam);
		System.out.println("recibido de formulario en SvGuardarActividad.... idMatParam " + idMatParam);
		System.out.println("recibido de formulario en SvGuardarActividad.... enuActParam " + enuActParam);
		System.out.println("recibido de formulario en SvGuardarActividad.... obsActParam " + obsActParam);

		// System.out.println("recibido de formulario en SvGuardarActividad....
		// enuActParam " + enuActParam);
		// System.out.println("recibido de formulario en SvGuardarActividad....
		// obsActParam " + obsActParam);

		// Verifica si los parámetros de edición están presentes
		// si son nulos entonces es una inserción en caso contraio edición

		//enuAct = request.getParameter("enuAct");
		//obsAct = request.getParameter("obsAct");
		
		String tipo = request.getParameter("tipo");

		System.out.println("dentro de servlet guardar actividad...." + "  tipo  " + tipo);

		try {

			if ("editar".equals(tipo)) {
				if (idMatParam != null) {

					idMat = Integer.parseInt(idMatParam);
//					if (notaActParam != null) {
//						notaAct = Double.parseDouble(notaActParam);
//					}
					Actividad act = new Actividad(idMat, enuActParam, obsActParam);

					// Realiza la actualización de la matrícula existente
					resultado = daoMateria.actualizarActividadDao(act);

				}

			} else if ("nuevo".equals(tipo)) {
				// es inserción de un nuevo estudio
				if (idMatParam != null) {
					idMat = Integer.parseInt(idMatParam);
					System.out.println("Id Mat nueva actividad en servlet GuardarActividad..." + idMat);

				
				Actividad act = new Actividad(idMat,enuActParam, obsActParam);

				resultado = daoMateria.insertarActividadDao(act);
				}
			}

			// Maneja el resultado de la inserción
			if (resultado) {
				// Si la inserción fue exitosa, envía un mensaje de éxito
				jsonResponse.put("success", true);
				jsonResponse.put("message", " operación realizada con éxito");
			} else {
				// Si hubo un problema durante la inserción, envía un mensaje de error al
				// cliente

				// Si hubo un problema durante la operación, envía un mensaje de error
				jsonResponse.put("success", false);
				jsonResponse.put("message", "Error al realizar la operación");
			}

		} catch (Exception e) {

			// Si hubo un problema durante la operación, envía un mensaje de error
			jsonResponse.put("success", false);
			jsonResponse.put("message", "Error al realizar la operación");
		}

		// Enviar el objeto JSON como respuesta al cliente
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonResponse.toString());

	}
}
