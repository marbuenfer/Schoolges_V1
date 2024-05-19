package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.dao.DaoMateria;
import com.db.DbConexion;
import com.logica.Materia;
import org.json.JSONObject;

@WebServlet("/SvGuardarMateria")
public class SvGuardarMateria extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// Crear un objeto JSON para enviar al cliente

		JSONObject jsonResponse = new JSONObject();

		DaoMateria daoMateria = new DaoMateria(DbConexion.getConn());
		String idMatParam;
		String idHorasParam;

		int idMat = 0;
		String nomMat = "";
		int horasMat = 0;
		String obsMat = "";
		 
		boolean resultado = false;

		idMatParam = request.getParameter("idMat");
		idHorasParam = request.getParameter("horasMat");

		System.out.println("recibido de formulario en SvGuardarMateria.... idMatParam " + idMatParam);
		System.out.println("recibido de formulario en SvGuardarMateria.... idHorasParam " + idHorasParam);

		// Verifica si los parámetros de edición están presentes
		// si son nulos entonces es una inserción en caso contraio edición

		// boolean isEdit = (idMatParam == null && idMatParam.isEmpty());
		System.out.println(" formulario en SvGuardarMateria....");
		 
		 nomMat = request.getParameter("nomMat");
	//	String espeEst = request.getParameter("espeEst");
		// int horasMat = request.getParameter("horasMat");
		 obsMat = request.getParameter("obsMat");

		String tipo = request.getParameter("tipo");

		System.out.println("dentro de servlet guardar estudio...." + "  idMatParam  " + idMatParam);
		System.out.println("dentro de servlet guardar estudio...." + "  tipo  " + tipo);

		try {

			if ("editar".equals(tipo)) {
				if (idMatParam != null) {

					idMat = Integer.parseInt(idMatParam);
					if (idHorasParam != null) {
						horasMat = Integer.parseInt(idHorasParam);

					}

					Materia mat = new Materia(idMat, nomMat, horasMat, obsMat);

					// Convertir otros parámetros si es necesario...

					// Realiza la actualización de la matrícula existente
					resultado = daoMateria.actualizarMateriaDao(mat);
				}

			} else if ("nuevo".equals(tipo)) {
				// es inserción de un nuevo estudio
				if (idHorasParam != null) {
					horasMat = Integer.parseInt(idHorasParam);
				}
				Materia mat = new Materia(idMat, nomMat, horasMat, obsMat);

				resultado = daoMateria.insertarMateriaDao(mat);
			}

			// Maneja el resultado de la inserción
			if (resultado) {
				// Si la inserción fue exitosa, envía un mensaje de éxito
				jsonResponse.put("success", true);
				jsonResponse.put("message", " operación realizada con éxito");

//					response.setStatus(HttpServletResponse.SC_OK); // Código de estado 200 (OK)
//					response.getWriter().write("Matriculación exitosa");
			} else {
				// Si hubo un problema durante la inserción, envía un mensaje de error al
				// cliente

				// Si hubo un problema durante la operación, envía un mensaje de error
				jsonResponse.put("success", false);
				jsonResponse.put("message", "Error al realizar la operación");
//					response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Código de estado 400 (Bad Request)
//					response.getWriter().write("Error al realizar la matriculación"); // Mensaje de error genérico
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

//	private Date parseDate(String dateStr, String format) throws ParseException {
//		if (dateStr != null && !dateStr.isEmpty()) {
//			SimpleDateFormat sdf = new SimpleDateFormat(format);
//			return new Date(sdf.parse(dateStr).getTime());
//		}
//		return null;
//	}
}
