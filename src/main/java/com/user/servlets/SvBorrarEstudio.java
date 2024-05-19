package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.io.IOException;

import com.dao.DaoCentro;
import com.dao.DaoEstudio;
import com.db.DbConexion;

@WebServlet("/SvBorrarEstudio")
public class SvBorrarEstudio extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtén los parámetros de la solicitud
        String idEstStr = req.getParameter("idEst");
        System.out.println("ID de estudio recogido: " + idEstStr);

        int idEst = 0;
        DaoEstudio daoEst = new DaoEstudio(DbConexion.getConn());
        JSONObject jsonResponse = new JSONObject();

        try {
            if (idEstStr != null && !idEstStr.isEmpty()) {
            	idEst = Integer.parseInt(idEstStr.trim()); // Se Utiliza trim() para eliminar espacios en blanco adicionales
                boolean valorDevuelto = daoEst.borrarEstudio(idEst);
                System.out.println("ID de estudio a borrar: " + idEst);

                if (valorDevuelto) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Estudio borrado exitosamente");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message","No se puede borrar el estudio debido a restricciones de integridad de la base de datos");
                }
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Parámetro de solicitud inválido");
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error al realizar borrado");
        }

        // Enviar la respuesta JSON al cliente
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonResponse.toString());
    }
}
