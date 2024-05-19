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

import org.json.JSONObject;

import com.dao.DaoCentro;
import com.dao.DaoDocente;
import com.db.DbConexion;
import com.logica.AsignacionDocente;
import com.logica.Centro;

/**
 * Servlet implementation class SvGuardarAsignacionDocente
 */
@WebServlet("/SvGuardarAsignacionDocente")
public class SvGuardarAsignacionDocente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		JSONObject jsonResponse = new JSONObject();

		DaoDocente daoDocente = new DaoDocente(DbConexion.getConn());
		int idAsig = 0;
		int idDoc = 0;
		int idMat = 0;

		String idDocParam = "";
		// String idEstParam = "";
		String idMatParam = "";

		// Obtener parámetros de la solicitud
		Date fechIniAsigDoc = null;
		Date fechFinAsigDoc = null;

		String idAsigParam = request.getParameter("idAsig");

		// Verifica si los parámetros de edición están presentes
		// si son nulos entonces es una inserción en caso contraio edición
		// boolean isEdit = idAsigParam != null && !idAsigParam.isEmpty();

		idDocParam = request.getParameter("idUsu");
//		idEstParam = request.getParameter("idEst");
		idMatParam = request.getParameter("idMat");

		System.out.println("dentro de servlet guardar usuario...." + idDocParam);

		if (idDocParam != null && !idDocParam.isEmpty()) {
			try {
				idDoc = Integer.parseInt(idDocParam);
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
		String obsAsigDoc = request.getParameter("obsAsigDoc");

		try {
			fechIniAsigDoc = parseDate(request.getParameter("fechIniAsigDoc"), "yyyy-MM-dd");
		} catch (ParseException e) {
			e.printStackTrace();
		}

		try {
			fechFinAsigDoc = parseDate(request.getParameter("fechFinAsigDoc"), "yyyy-MM-dd");
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// Date fechMatri = Date.valueOf(request.getParameter("fechMatri"));
		// DaoDocente daoDocente = new DaoDocente(DbConexion.getConn());

		// validar si la clave (idUsu, idMat, fechIniAsig) no está ya registrada en
		// BD
		boolean claveUnicaExiste = daoDocente.validarClaveUnica(idDoc, idMat, fechIniAsigDoc);
		System.out.println("¿Clave unica existe   ?" + claveUnicaExiste);
		// En lugar de enviar mensajes directamente al cliente, puedes enviar un objeto
		// JSON con el resultado
		// Crear un objeto JSON para enviar al cliente

		// si la clave no existe en la tabla matriculaciones de la base de datos, se
		// puede insertar registro
		boolean resultado = false;
		if (!claveUnicaExiste) {

			// Crear objeto Matricula con los datos
			// AsignacionDocente asg = new AsignacionDocente(idDoc,
			// idMat,fechIniAsigDoc,fechFinAsigDoc, obsAsigDoc);
			System.out.println("verificando si clave unica existe o no ....");

			// String tipo = request.getParameter("tipo");

			try {

//				if ("editar".equals(tipo) ) {

				//idAsig = Integer.parseInt(idAsigParam);
//						System.out.println("dentro de servlet.... es editar idAsig  " + idAsig);
//
//						AsignacionDocente asigDoc = new AsignacionDocente(idAsig, idDoc, idMat, fechIniAsigDoc,
//								fechFinAsigDoc, obsAsigDoc);
//						System.out.println("objeto asigDoc  " + asigDoc.toString());

				// Convertir otros parámetros si es necesario...

				// Realiza la actualización de la matrícula existente
//						resultado = daoDocente.actualizarAsignacionDocente(asigDoc);

//				} else if ("nuevo".equals(tipo)) {
				//System.out.println("dentro de servlet.... es nuevo idAsig  " + idAsig);

				// es inserción de un nuevo AsignacionDocente
				AsignacionDocente asigDoc = new AsignacionDocente(idDoc, idMat, fechIniAsigDoc, fechFinAsigDoc,
						obsAsigDoc);

				resultado = daoDocente.insertarAsignacionDocente(asigDoc);
//				}

			} catch (Exception e) {
				jsonResponse.put("success", false);
				jsonResponse.put("message", "Error al realizar la operación");
			}
		}
		// Maneja el resultado de la inserción
		if (resultado) {
			// Si la inserción fue exitosa, envía un mensaje de éxito
			jsonResponse.put("success", true);
			jsonResponse.put("message", " operación realizada con éxito");

		} else {

			// Si hubo un problema durante la operación, envía un mensaje de error
			jsonResponse.put("success", false);
			jsonResponse.put("message", "Error al realizar la operación");

		}

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
