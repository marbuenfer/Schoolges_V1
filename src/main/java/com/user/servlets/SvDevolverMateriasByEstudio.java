package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.dao.DaoMateria;
import com.logica.MateriaEnEstudio;

import com.db.DbConexion;
import com.google.gson.Gson;

@WebServlet("/SvDevolverMateriasByEstudio")
public class SvDevolverMateriasByEstudio extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtén el ID del estudio desde los parámetros de la solicitud
        String idEstParam = request.getParameter("idEst");
        int idEst = (idEstParam != null && !idEstParam.isEmpty()) ? Integer.parseInt(idEstParam) : 0;
        
        System.out.println("estoy en servlet SvDevolverMateriasByEstudio");

        System.out.println(idEst);
        // Utiliza tu lógica para obtener las materias desde la base de datos
        DaoMateria daoMateria = new DaoMateria(DbConexion.getConn());
        List<MateriaEnEstudio> materias = daoMateria.getMateriasByEstudio(idEst);
        System.out.println("materias toString" + materias.toString());

        // Convierte la lista de materias a formato JSON
        Gson gson = new Gson();
        String jsonMaterias;

        if (materias.isEmpty()) {
            // Si no hay materias, crea un mensaje JSON indicando que no hay registros
            jsonMaterias = "{\"message\": \"No hay materias registradas para este estudio\"}";
        } else {
            jsonMaterias = gson.toJson(materias);
        }

        // Configura la respuesta HTTP
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Envía la respuesta JSON al cliente
        response.getWriter().write(jsonMaterias);
    }
}
