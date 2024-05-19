package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.io.IOException;

import com.dao.DaoCentro;
import com.db.DbConexion;

@WebServlet("/SvBorrarCentro")
public class SvBorrarCentro extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtén los parámetros de la solicitud
        String idCenStr = req.getParameter("idCen");
        System.out.println("ID de centro recogido: " + idCenStr);

        int idCen = 0;
        DaoCentro daoCen = new DaoCentro(DbConexion.getConn());
        JSONObject jsonResponse = new JSONObject();

        try {
            if (idCenStr != null && !idCenStr.isEmpty()) {
            	idCen = Integer.parseInt(idCenStr.trim()); // Se Utiliza trim() para eliminar espacios en blanco adicionales
                boolean valorDevuelto = daoCen.borrarCentro(idCen);
                System.out.println("ID de centro a borrar: " + idCen);

                if (valorDevuelto) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Centro borrado exitosamente");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "¡Centro no borrado, algo salió mal!");
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
