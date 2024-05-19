package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import com.dao.DaoEstudio;
import com.db.*;
import org.json.JSONObject;

@WebServlet("/SvBorrarAsignacionMateriaAEstudio")
public class SvBorrarAsignacionMateriaAEstudio extends HttpServlet {
	 private static final long serialVersionUID = 1L;

	    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        request.setCharacterEncoding("UTF-8");

	        // Crear un objeto JSON para enviar al cliente
	       // JSONObject jsonResponse = new JSONObject();

	        // Leer el cuerpo de la solicitud JSON
	        BufferedReader reader = request.getReader();
	        StringBuilder stringBuilder = new StringBuilder();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            stringBuilder.append(line);
	        }
	        String jsonString = stringBuilder.toString();

	        // Convertir el JSON a un objeto Java
	        JSONObject jsonObject = new JSONObject(jsonString);

	        // Obtener los valores de idEst y idMat del objeto JSON
	        int idEst = jsonObject.getInt("idEst");
	        int idMat = jsonObject.getInt("idMat");

	        // Crear una instancia de DaoEstudio
	        DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());

	        try {
	            // Intentar borrar la asignación de materia a estudio
	            boolean borrado = daoEstudio.borrarMateriaEnEstudio(idEst, idMat);

	            // Verificar si la asignación se borró correctamente
	            if (borrado) {
	                // Si el borrado fue exitoso, enviar un mensaje de éxito al cliente
	            	 response.setStatus(HttpServletResponse.SC_OK);
	                 response.setContentType("application/json");
	                 JSONObject successJson = new JSONObject();
	                 successJson.put("success", "La asignación se ha eliminado correctamente.");
	                 response.getWriter().write(successJson.toString());
	            } else {
	                // Si hubo un problema al borrar la asignación, enviar un mensaje de error al cliente
	            	// Si la asignación existe, enviar una respuesta de error al cliente
	                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	                response.setContentType("application/json");
	                JSONObject errorJson = new JSONObject();
	                errorJson.put("error", "La asignación no se pudo eliminar.");
	                response.getWriter().write(errorJson.toString());
	            }
	        } catch (Exception e) {
	            // Si se produce una excepción, enviar un mensaje de error al cliente
	        	response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                JSONObject errorJson = new JSONObject();
                errorJson.put("error", "La asignación no se pudo eliminar.");
                response.getWriter().write(errorJson.toString());
	        }
	    }
	}