package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.dao.DaoMatricula;
import com.db.DbConexion;
import com.logica.Matricula;
import org.json.JSONObject;

@WebServlet("/SvGuardarMatricula")
public class SvGuardarMatricula extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		int idUsu = 0;
		int idEst = 0;
		int idMat = 0;

		String idMatriParam = "";
		String idUsuParam = "";
		String idEstParam = "";
		String idMatParam = "";

		// Obtener parámetros de la solicitud
		Date fechMatri = null;

		idMatriParam = request.getParameter("idMatri");

		// Verifica si los parámetros de edición están presentes
		// si son nulos entonces es una inserción en caso contraio edición
		boolean isEdit = idMatriParam != null && !idMatriParam.isEmpty();

		idUsuParam = request.getParameter("idUsu");
		idEstParam = request.getParameter("idEst");
		idMatParam = request.getParameter("idMat");

		if (idUsuParam != null && !idUsuParam.isEmpty()) {
			try {
				idUsu = Integer.parseInt(idUsuParam);
			} catch (NumberFormatException e) {
				// Manejar la excepción si la cadena no es un número válido
				e.printStackTrace(); // Puedes imprimir la traza o realizar otras acciones según tus necesidades
			}
		}

		if (idEstParam != null && !idEstParam.isEmpty()) {
			try {
				idEst = Integer.parseInt(idEstParam);
			} catch (NumberFormatException e) {
				// Manejar la excepción si la cadena no es un número válido
				e.printStackTrace(); // Puedes imprimir la traza o realizar otras acciones según tus necesidades
			}
		}

		if (idMatParam != null && !idMatParam.isEmpty()) {
			try {
				idMat = Integer.parseInt(idMatParam);
			} catch (NumberFormatException e) {
				// Manejar la excepción si la cadena no es un número válido
				e.printStackTrace(); // Puedes imprimir la traza o realizar otras acciones según tus necesidades
			}
		}
		String modMatri = request.getParameter("modMatri");
		String obsMatri = request.getParameter("obsMatri");

		try {
			fechMatri = parseDate(request.getParameter("fechMatri"), "yyyy-MM-dd");
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// Date fechMatri = Date.valueOf(request.getParameter("fechMatri"));
		DaoMatricula daoMatricula = new DaoMatricula(DbConexion.getConn());

		// validar si la clave (idUsu, idEst, idMat, fechMatri) no está ya registrada en
		// BD
		boolean claveUnicaExiste = daoMatricula.validarClaveUnica(idUsu, idEst, idMat, fechMatri);
		System.out.println("¿Clave unica existe   ?" + claveUnicaExiste);
		// En lugar de enviar mensajes directamente al cliente, puedes enviar un objeto
		// JSON con el resultado
		// Crear un objeto JSON para enviar al cliente

		JSONObject jsonResponse = new JSONObject();

		// si la clave no existe en la tabla matriculaciones de la base de datos, se
		// puede insertar registro
		boolean resultado;
		if (!claveUnicaExiste) {

			// Crear objeto Matricula con los datos
			Matricula matricula = new Matricula(idUsu, idEst, fechMatri, idMat, modMatri, obsMatri);
			System.out.println("dentro de servlet...." + matricula.toString());
			try {

				if (isEdit) {
					int idMatri = Integer.parseInt(idMatriParam);
					// Convertir otros parámetros si es necesario...

					// Realiza la actualización de la matrícula existente
					resultado = daoMatricula.actualizarMatricula(matricula);
				} else {
					// Si no es una edición, realiza la inserción de una nueva matrícula
					// Realiza la inserción de una nueva matrícula
					resultado = daoMatricula.insertarMatricula(matricula);
				}
				// Intenta realizar la inserción de la matrícula en la base de datos
				// boolean resultado = daoMatricula.insertarMatricula(matricula);

				// Maneja el resultado de la inserción
				if (resultado) {
					// Si la inserción fue exitosa, envía un mensaje de éxito al cliente
					// Si la inserción fue exitosa, envía un mensaje de éxito
					jsonResponse.put("success", true);
					jsonResponse.put("message", "Matriculación exitosa");

//					response.setStatus(HttpServletResponse.SC_OK); // Código de estado 200 (OK)
//					response.getWriter().write("Matriculación exitosa");
				} else {
					// Si hubo un problema durante la inserción, envía un mensaje de error al
					// cliente

					// Si hubo un problema durante la inserción, envía un mensaje de error
					jsonResponse.put("success", false);
					jsonResponse.put("message", "Error al realizar la matriculación");
//					response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Código de estado 400 (Bad Request)
//					response.getWriter().write("Error al realizar la matriculación"); // Mensaje de error genérico
				}

			} catch (Exception e) {
				// Si se produce una excepción durante la inserción, envía un mensaje de error
				// al cliente
//				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Código de estado 500 (Internal
//																					// Server Error)
//				response.getWriter().write("Error al realizar la matriculación: " + e.getMessage()); // Mensaje de error
//			// excepción
				// Si hubo un problema durante la inserción, envía un mensaje de error
				jsonResponse.put("success", false);
				jsonResponse.put("message", "Error al realizar la matriculación");
			}

		} else {
			// registro compuesto por campos (idAlu, idEst, idMat, fechMatri, ya existe en
			// la tabla
//			MsgSwal("Matriculación", "Ya existe una matricula registrada", "info", "#17a2b8");
			// request.getSession().setAttribute("errorMsg", "Error ya existe matricula");
//			response.setStatus(444); // Código de estado personalizado
//			response.getWriter().write("Matricula de estudio y materia duplicada en la misma fecha"); // Mensaje de error genérico
			// Si hubo un problema durante la inserción, envía un mensaje de error
			jsonResponse.put("success", false);
			jsonResponse.put("message", "Ya existe una matricula registrada");
		}
		// Enviar el objeto JSON como respuesta al cliente
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonResponse.toString());

	}

	private Date parseDate(String dateStr, String format) throws ParseException {
		if (dateStr != null && !dateStr.isEmpty()) {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			return new Date(sdf.parse(dateStr).getTime());
		}
		return null;
	}
}

