package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.dao.DaoEstudio;
import com.db.DbConexion;
import com.logica.Estudio;
import org.json.JSONObject;

@WebServlet("/SvGuardarEstudio")
public class SvGuardarEstudio extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// Crear un objeto JSON para enviar al cliente

		JSONObject jsonResponse = new JSONObject();
		DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());

		int idEst = 0;
		int horaEst = 0;
		String idEstParam = "";
		String idHoraParam = "";
		boolean resultado = false;

		idEstParam = request.getParameter("idEst");
		idHoraParam = request.getParameter("horaEst");

		System.out.println("recibido de formulario en SvGuardarEstudio.... idEstParam " + idEstParam);
		System.out.println("recibido de formulario en SvGuardarEstudio.... idHoraParam " + idHoraParam);

		// Verifica si los parámetros de edición están presentes
		// si son nulos entonces es una inserción en caso contraio edición

		// boolean isEdit = (idEstParam == null && idEstParam.isEmpty());
		System.out.println(" formulario en SvGuardarEstudio....");

		String nomEst = request.getParameter("nomEst");
		String espeEst = request.getParameter("espeEst");
		// int horaEst = request.getParameter("horaEst");
		String obsEst = request.getParameter("obsEst");

		String tipo = request.getParameter("tipo");

		System.out.println("dentro de servlet guardar estudio...." + "  idEstParam  " + idEstParam);
		System.out.println("dentro de servlet guardar estudio...." + "  tipo  " + tipo);

		try {

			if ("editar".equals(tipo)) {
				if (idEstParam != null) {

					idEst = Integer.parseInt(idEstParam);
					if (idHoraParam != null) {
						horaEst = Integer.parseInt(idHoraParam);

					}

					Estudio est = new Estudio(idEst, nomEst, espeEst, horaEst, obsEst);

					// Convertir otros parámetros si es necesario...

					// Realiza la actualización de la matrícula existente
					resultado = daoEstudio.actualizarEstudioDao(est);
				}

			} else if ("nuevo".equals(tipo)) {
				// es inserción de un nuevo estudio
				if (idHoraParam != null) {
					horaEst = Integer.parseInt(idHoraParam);

				}
				Estudio est = new Estudio(nomEst, espeEst, horaEst, obsEst);

				resultado = daoEstudio.insertarEstudioDao(est);
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
