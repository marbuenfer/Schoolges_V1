package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import com.dao.DaoEstudio;
import com.db.DbConexion;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/SvActualizarAsignacionMateriaAEstudio")
public class SvActualizarAsignacionMateriaAEstudio extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("Estoy dentro de servlet SvActualizarAsignacionMateriaAEstudio ");

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
        String idEstudioStr = jsonObject.has("idEst") ? jsonObject.get("idEst").getAsString() : null;
        String idMateriaStr = jsonObject.has("idMat") ? jsonObject.get("idMat").getAsString() : null;
        String obsMatEst = jsonObject.has("obsMatEst") ? jsonObject.get("obsMatEst").getAsString() : null;

        System.out.println("Valores de idEstudioStr, idMateriaStr, obsMatEst: " + idEstudioStr + ", " + idMateriaStr + ", " + obsMatEst);
        if (idEstudioStr == null || idEstudioStr.isEmpty() || idMateriaStr == null || idMateriaStr.isEmpty()) {
            // Si no se proporciona un ID de Estudio, de Materia o de observaciones,
            // devolver un error
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            // Convertir los parámetros a números enteros
            int idEst = Integer.parseInt(idEstudioStr);
            int idMat = Integer.parseInt(idMateriaStr);

            // Crear una instancia de DaoEstudio
            DaoEstudio daoEst = new DaoEstudio(DbConexion.getConn());

            // Actualizar la asignación de materia en el estudio
            boolean success = daoEst.actualizarMateriaEnEstudio(idEst, idMat, obsMatEst);

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
