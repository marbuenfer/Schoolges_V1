package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.io.IOException;
import com.dao.DaoAlumno;
import com.db.DbConexion;

@WebServlet("/SvBorrarMatricula")
public class SvBorrarMatricula extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtén los parámetros de la solicitud
        String idMatriStr = req.getParameter("idMatri");
        System.out.println("ID de matrícula recogido: " + idMatriStr);

        int idMatri = 0;
        DaoAlumno daoMatri = new DaoAlumno(DbConexion.getConn());
        JSONObject jsonResponse = new JSONObject();

        try {
            if (idMatriStr != null && !idMatriStr.isEmpty()) {
                idMatri = Integer.parseInt(idMatriStr.trim()); // Se Utiliza trim() para eliminar espacios en blanco adicionales
                boolean valorDevuelto = daoMatri.borrarMatricula(idMatri);
                System.out.println("ID de matrícula a borrar: " + idMatri);

                if (valorDevuelto) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Matrícula borrada exitosamente");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "¡Matrícula no borrada, algo salió mal!");
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
