package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import com.dao.DaoMateria;
import com.db.*;
import org.json.JSONObject;

@WebServlet("/SvBorrarActividadMateria")
public class SvBorrarActividadMateria extends HttpServlet {
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

	        // Obtener los valores de idAct del objeto JSON
	       
	        int idAct = jsonObject.getInt("idAct");

	        // Crear una instancia de DaoMateria
	        DaoMateria daoMateria = new DaoMateria(DbConexion.getConn());

	        try {
	            // Intentar borrar la actividad de materia 
	            boolean borrado = daoMateria.borrarActividad(idAct);

	            // Verificar si la actividad se borró correctamente
	            if (borrado) {
	                // Si el borrado fue exitoso, enviar un mensaje de éxito al cliente
	            	 response.setStatus(HttpServletResponse.SC_OK);
	                 response.setContentType("application/json");
	                 JSONObject successJson = new JSONObject();
	                 successJson.put("success", "La actividad se ha eliminado correctamente.");
	                 response.getWriter().write(successJson.toString());
	            } else {
	                // Si hubo un problema al borrar la actividad, enviar un mensaje de error al cliente
	            	// Si la actividad existe, enviar una respuesta de error al cliente
	                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	                response.setContentType("application/json");
	                JSONObject errorJson = new JSONObject();
	                errorJson.put("error", "La actividad no se pudo eliminar.");
	                response.getWriter().write(errorJson.toString());
	            }
	        } catch (Exception e) {
	            // Si se produce una excepción, enviar un mensaje de error al cliente
	        	response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                JSONObject errorJson = new JSONObject();
                errorJson.put("error", "La actividad no se pudo eliminar.");
                response.getWriter().write(errorJson.toString());
	        }
	    }
	}