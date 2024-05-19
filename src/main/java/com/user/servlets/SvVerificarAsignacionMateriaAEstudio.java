package com.user.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import org.json.JSONObject;

import com.dao.DaoEstudio;
import com.db.DbConexion;

/**
 * Servlet implementation class SvVerificarAsignacionMateriaAEstudio
 */
@WebServlet("/SvVerificarAsignacionMateriaAEstudio")
public class SvVerificarAsignacionMateriaAEstudio extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
   
		DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());

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

        // Obtener los valores de los parámetros del objeto JSON
        int idEst = jsonObject.getInt("idEst");
        int idMat = jsonObject.getInt("idMat");

        System.out.println("valor en ServletVerificar idEst: " + idEst);
        System.out.println("valor en ServletVerificar idMat: " + idMat);

     // Verificar si la asignación existe
        boolean asignacionExiste = false;
		try {
			asignacionExiste = daoEstudio.existeAsignacion(idEst, idMat);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (asignacionExiste) {
            // Si la asignación existe, enviar una respuesta de error al cliente
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            JSONObject errorJson = new JSONObject();
            errorJson.put("error", "La asignación ya existe.");
            response.getWriter().write(errorJson.toString());
        } else {
            // Si la asignación no existe, enviar una respuesta satisfactoria al cliente
            response.setStatus(HttpServletResponse.SC_OK);
            response.setContentType("application/json");
            JSONObject successJson = new JSONObject();
            successJson.put("success", "La asignación no existe.");
            response.getWriter().write(successJson.toString());
        }
    }
}
