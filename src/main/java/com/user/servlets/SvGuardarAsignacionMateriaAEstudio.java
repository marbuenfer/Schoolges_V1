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
import com.logica.MateriaEnEstudio;

import org.json.JSONObject;

@WebServlet("/SvGuardarAsignacionMateriaAEstudio")
public class SvGuardarAsignacionMateriaAEstudio extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Crear un objeto JSON para enviar al cliente
        JSONObject jsonResponse = new JSONObject();

        DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());

        boolean resultado = false;

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
        String obsMatEst = jsonObject.getString("obsMatEst");

        System.out.println("Valores de idEstudioStr, idMateriaStr, obsMatEst:  en SvGuardarAsignacion" + idEst + ", " + idMat + ", " + obsMatEst);

        try {
            if (idEst != 0 && idMat != 0) {
                // Verificar si la asignación ya existe en la base de datos
                boolean existe = daoEstudio.existeAsignacion(idEst, idMat);

                System.out.println("Valor de existe en existeAsignacion: " + existe);

                if (!existe) {
                    // Si la asignación no existe, intenta insertarla en la base de datos
                    MateriaEnEstudio est = new MateriaEnEstudio(idEst, idMat, obsMatEst);
                    resultado = daoEstudio.insertarMateriasEnEstudios(est);
                    if (resultado) {
                        // Si la inserción fue exitosa, envía un mensaje de éxito
                        jsonResponse.put("success", true);
                        jsonResponse.put("message", "La asignación se ha guardado correctamente");
                    } else {
                        // Si hubo un problema durante la inserción, envía un mensaje de error al cliente
                        jsonResponse.put("success", false);
                        jsonResponse.put("message", "Error al guardar la asignación");
                    }
                } else {
                    // Si la asignación ya existe, envía un mensaje de error al cliente
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "La asignación ya existe y no se puede insertar nuevamente");
                }
            } else {
                // Los parámetros son nulos, enviar una respuesta de error al cliente
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Los parámetros 'idEst' y 'idMat' son necesarios.");
            }
        } catch (Exception e) {
            // Si hubo un problema durante la operación, envía un mensaje de error al cliente
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error al realizar la operación");
        }

        // Enviar el objeto JSON como respuesta al cliente
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }
}
