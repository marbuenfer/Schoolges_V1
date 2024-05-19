package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.io.IOException;

 
import com.dao.DaoMateria;
import com.db.DbConexion;

@WebServlet("/SvBorrarMateria")
public class SvBorrarMateria extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtén los parámetros de la solicitud
        String idMatStr = req.getParameter("idMat");
        System.out.println("ID de materia recogido: " + idMatStr);

        int idMat = 0;
        DaoMateria daoMat = new DaoMateria(DbConexion.getConn());
        JSONObject jsonResponse = new JSONObject();

        try {
            if (idMatStr != null && !idMatStr.isEmpty()) {
            	idMat = Integer.parseInt(idMatStr.trim()); // Se Utiliza trim() para eliminar espacios en blanco adicionales
                boolean valorDevuelto = daoMat.borrarMateria(idMat);
                System.out.println("ID de estudio a borrar: " + idMat);

                if (valorDevuelto) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Materia borrada exitosamente");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message","No se puede borrar la materia debido a restricciones de integridad de la base de datos");
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
