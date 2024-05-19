package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import com.dao.DaoMateria;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.logica.Actividad;

@WebServlet("/SvActualizarActividadMateria")
public class SvActualizarActividadMateria extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("Estoy dentro de servlet SvActualizarActividadMateria ");
		int idAct;
		// Leer el cuerpo de la solicitud como JSON
		BufferedReader reader = request.getReader();
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		String jsonBody = sb.toString();

		// Parsear el JSON para extraer los parámetros
		JsonObject jsonObject = JsonParser.parseString(jsonBody).getAsJsonObject();
		String idActStr = jsonObject.has("idAct") ? jsonObject.get("idAct").getAsString() : null;
		// String idAluStr = jsonObject.has("idAlu") ?
		// jsonObject.get("idAlu").getAsString() : null;
		String enuAct = jsonObject.has("enuAct") ? jsonObject.get("enuAct").getAsString() : null;
		// double notaAct = jsonObject.has("notaAct") ?
		// jsonObject.get("notaAct").getAsDouble() : null;
		String obsAct = jsonObject.has("obsAct") ? jsonObject.get("obsAct").getAsString() : null;

		System.out.println("Valores recogidos en servlet SvActualizarActividadMateria : " + idActStr + ", " + enuAct
				+ ", " + obsAct);
		if (idActStr == null || idActStr.isEmpty() || enuAct == null || enuAct.isEmpty()) {
			// Si no se proporciona datos
			// devolver un error
			System.out.println("valores nulos en  SvActualizarActividadMateria ");
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		} else {//datos distintos de null
			try {
				System.out.println("valores tienen valores en  SvActualizarActividadMateria ");

				// Convertir los parámetros a números enteros
				  idAct = Integer.parseInt(idActStr);
					System.out.println("valor de idAct " + idAct );


				Actividad act = new Actividad(idAct, enuAct, obsAct);

				// Crear una instancia de DaoEstudio
				DaoMateria daoMat = new DaoMateria(DbConexion.getConn());

				// Actualizar la asignación de materia en el estudio
				boolean success = daoMat.actualizarActividadDao(act);
				// Crear un objeto que represente la respuesta
				UpdateResponse updateResponse = new UpdateResponse(success);

				// Convertir el objeto a formato JSON
				Gson gson = new Gson();
				String json = gson.toJson(updateResponse);

				// Configurar la respuesta HTTP
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				PrintWriter out = response.getWriter();
				out.print(json);
				out.flush();
			} catch (NumberFormatException e) {
				// Si hay un error al convertir los parámetros a números, devolver un error
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			} catch (Exception ex) {
				// Si ocurre otro tipo de error, devolver un error interno del servidor
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				ex.printStackTrace(); // Opcional: imprime el rastro de la pila para el registro de errores
			}
		}
	}

	// Clase para representar la respuesta del servlet
	private static class UpdateResponse {
		private boolean success;

		public UpdateResponse(boolean success) {
			this.success = success;
		}

		public boolean isSuccess() {
			return success;
		}

		public void setSuccess(boolean success) {
			this.success = success;
		}
	}
}
