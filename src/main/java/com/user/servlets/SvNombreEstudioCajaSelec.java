package com.user.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.db.DbConexion;
import com.logica.Estudio;
import com.dao.DaoEstudio;

/**
 * Servlet implementation class SvNombreEstudioCajaSelec
 */
public class SvNombreEstudioCajaSelec extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvNombreEstudioCajaSelec() {
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest req, HttpServletResponse resp)
     */
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
//        // Obtener el idEst desde la solicitud, por ejemplo, desde un parámetro
//        int idEst;
//        Estudio estu = null;
//        String funcion = req.getParameter("funcion");
//        String idEstStr = req.getParameter("idEst_id");
//        String nomEst = req.getParameter("nomEst_id");
//
//        // Lógica común que puedes necesitar para ambas solicitudes
//        DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());
//
//        if ("cargarIdEstOpciones".equals(funcion)) {
//            // Lógica para cargar las opciones de Id.Estudio
//            if (idEstStr != null && !idEstStr.isEmpty()) {
//                try {
//                    // Convertir String a int
//                    idEst = Integer.parseInt(idEstStr);
//                    // Obtener objeto Estudio por id
//                    estu = daoEstudio.getEstudioById(idEst);
//                    // Setear el nombre en formulario
//                    req.setAttribute("nomEst_id", estu.getNomEst());
//                    // Enviar respuesta al cliente
//                    RequestDispatcher dispatcher = req.getRequestDispatcher("registroAluMatri.jsp");
//                    dispatcher.forward(req, resp);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            } else {
//                System.out.println("Error: El idEst está vacío o no se ha recogido en el servlet");
//            }
//        } else if ("cargarNomEstOpciones".equals(funcion)) {
//            // Lógica para cargar las opciones de Nombre de Estudio
//            if (nomEst != null && !nomEst.isEmpty()) {
//                try {
//                    // Obtener objeto Estudio por nombre
//                    estu = daoEstudio.getEstudioByNom(nomEst);
//                    // Setear el id en formulario
//                    req.setAttribute("idEst_id", estu.getIdEst());
//                    // Enviar respuesta al cliente
//                    RequestDispatcher dispatcher = req.getRequestDispatcher("registroAluMatri.jsp");
//                    dispatcher.forward(req, resp);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            } else {
//                System.out.println("Error: El nomEst está vacío o no se ha recogido en el servlet");
//            }
//        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest req, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        // Aquí iría cualquier lógica específica que necesites para el método POST
    }
}
