package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.dao.DaoAdmin;
import com.dao.DaoAlumno;
import com.dao.DaoDocente;
import com.db.DbConexion;
import com.logica.Alumno;
import com.logica.Docente;
import com.logica.Usuario;

/**
 * Servlet implementation class SvGuardarUsuario
 * Este servlet gestiona la inserción y actualización de usuarios en el sistema.
 * Dependiendo del rol del usuario (Alumno, Docente, Admin), se manejan diferentes operaciones.
 */
@WebServlet("/SvGuardarUsuario")
public class SvGuardarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SvGuardarUsuario() {

	}

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    req.setCharacterEncoding("UTF-8"); // para que no salgan caracteres extraños al grabar
	    boolean f = false;
	    DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
	    DaoDocente daoDoc = new DaoDocente(DbConexion.getConn());
	    DaoAdmin daoAdmin = new DaoAdmin(DbConexion.getConn());

	    Usuario usu = new Usuario();
	    Alumno alu = new Alumno();
	    Docente doc = new Docente();

	    String tipoRolUsu = req.getParameter("tipoRolUsu");

	    if (tipoRolUsu == null) {
	        System.out.println("El parámetro tipoRolUsu es nulo");
	        HttpSession session = req.getSession();
	        session.setAttribute("errorMsg", "El tipo de rol de usuario no existe");
	       // resp.sendRedirect(req.getContextPath() + "/errorPage.jsp");
	        return;
	    }

	    usu = recogerDatosComunes(req);

	    try {
	        if (tipoRolUsu.equals("DO")) {
	            doc = recogerDatosDocente(req);
	            manejarDocente(req, resp, daoDoc, usu, doc);
	        } else if (tipoRolUsu.equals("AL")) {
	            alu = recogerDatosAlumno(req);
	            manejarAlumno(req, resp, daoAlu, usu, alu);
	        } else if (tipoRolUsu.equals("AD")) {
	            // Lógica para administrar
	        } else {
	            System.out.println("El tipo de rol de usuario no existe");
	        }
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	    }
	}

	private void manejarDocente(HttpServletRequest req, HttpServletResponse resp, DaoDocente daoDoc, Usuario usu, Docente doc) throws IOException {
	    boolean f;
	    if (usu.getIdUsu() == 0) {
	        f = daoDoc.insertarDocenteDao(usu, doc);
	    } else {
	        f = daoDoc.actualizarDocenteDao(doc);
	    }
	    manejarResultado(req, resp, f, "/componentes/rolAdmin/menuDocentes/crudDocentesRolAdmin.jsp");
	}

	private void manejarAlumno(HttpServletRequest req, HttpServletResponse resp, DaoAlumno daoAlu, Usuario usu, Alumno alu) throws IOException {
	    boolean f;
	    Alumno aluCompleto = new Alumno(usu.getDniUsu(), usu.getNomCompUsu(), usu.getTelUsu(), usu.getObsUsu(), usu.getDirecUsu(), usu.getFechNacUsu(), usu.getEmailUsu(), usu.getPswordUsu(), usu.getTipoRolUsu(), usu.getLocalUsu(), usu.getProvUsu(), usu.getActivo(), alu.getTituIngAlu());
	    if (usu.getIdUsu() == 0) {
	        f = daoAlu.insertarAlumnoDao(aluCompleto);
	    } else {
	        f = daoAlu.actualizarAlumnoDao(usu, alu);
	    }
	    manejarResultado(req, resp, f, "/componentes/rolAdmin/menuAlumnos/crudAlumnosRolAdmin.jsp");
	}

	private void manejarResultado(HttpServletRequest req, HttpServletResponse resp, boolean f, String url) throws IOException {
	    HttpSession session = req.getSession();
	    if (f) {
	        session.setAttribute("sucMsg", "operación exitosa");
	    } else {
	        session.setAttribute("errorMsg", "Algo va mal");
	    }
	    resp.sendRedirect(req.getContextPath() + url);
	}


//ESTE MÉTODO SE DUPLICA PARA DOCENTE Y ADMINISTRADOR//////////
	private Usuario recogerDatosComunes(HttpServletRequest req) {
	    Usuario usu = null;
	    int idUsu = 0;
	    Date fechNacUsu = null;

	    String idUsuParam = req.getParameter("idUsu");

	    if (idUsuParam != null && !idUsuParam.isEmpty()) {
	        try {
	            idUsu = Integer.parseInt(idUsuParam);
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        }
	    }

	    String dniUsu = req.getParameter("dniUsu");
	    String nomCompUsu = req.getParameter("nomCompUsu");
	    String telUsu = req.getParameter("telUsu");
	    String obsUsu = req.getParameter("obsUsu");
	    String direcUsu = req.getParameter("direcUsu");

	    try {
	        fechNacUsu = parseDate(req.getParameter("fechNacUsu"), "yyyy-MM-dd");
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }

	    String emailUsu = req.getParameter("emailUsu");
	    String pswordUsu = req.getParameter("pswordUsu");
	    String tipoRolUsu = req.getParameter("tipoRolUsu");
	    String localUsu = req.getParameter("localUsu");
	    String provUsu = req.getParameter("provUsu");
	    String activoStr = req.getParameter("activo");

	    boolean activoBoolean = "on".equals(activoStr);
	    int activoInt = activoBoolean ? 1 : 0;

	    usu = new Usuario(idUsu, dniUsu, nomCompUsu, telUsu, obsUsu, direcUsu, fechNacUsu, emailUsu, pswordUsu, tipoRolUsu, localUsu, provUsu, activoInt);
	    return usu;
	}


	private Date parseDate(String dateStr, String format) throws ParseException {
		if (dateStr != null && !dateStr.isEmpty()) {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			return new Date(sdf.parse(dateStr).getTime());
		}
		return null;
	}

	private Alumno recogerDatosAlumno(HttpServletRequest req) {
		Alumno alu = null;
		String tituIngAlu = req.getParameter("tituIngAlu");
		System.out.println("estoy en servlet SvGuardar, es ACTUALIZAR");
		alu = new Alumno(tituIngAlu);
		System.out.println("DATOS ALUMNO" + alu.toString());
		return alu;
	}

	private Docente recogerDatosDocente(HttpServletRequest req) {
		Docente doc = null;
		String espeDoc = req.getParameter("espeDoc");
		String gradAcadDoc = req.getParameter("gradAcadDoc");

		Date fechaAlta = null;
		Date fechaBaja = null;

		try {
			fechaAlta = parseDate(req.getParameter("fechaAltaDoc"), "yyyy-MM-dd");
			fechaBaja = parseDate(req.getParameter("fechaBajaDoc"), "yyyy-MM-dd");

		} catch (ParseException e) {
			e.printStackTrace();
		}

//		System.out.println("estoy en servlet SvGuardar(recogerDatosDocente), comprobando es actualizacion o inserción");
//		System.out.println("estoy en servlet SvGuardar, es ACTUALIZAR");

		doc = new Docente(espeDoc, gradAcadDoc, fechaAlta, fechaBaja);
		System.out.println("OBJETO doc para ACTUALIZAR" + doc.toString());
		return doc;
	}

}
