package com.user.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.dao.DaoCentro;
import com.db.DbConexion;
import com.logica.Centro;
import org.json.JSONObject;

@WebServlet("/SvGuardarCentro")
public class SvGuardarCentro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// Crear un objeto JSON para enviar al cliente

		JSONObject jsonResponse = new JSONObject();
		// Date fechMatri = Date.valueOf(request.getParameter("fechMatri"));
		DaoCentro daoCentro = new DaoCentro(DbConexion.getConn());

		int idCen = 0;
		String idCenParam = "";
		boolean resultado = false;

		idCenParam = request.getParameter("idCen");
		
		System.out.println("recibido de formulario en SvGuardarCentro.... idCenParam " +  idCenParam);
       

		// Verifica si los parámetros de edición están presentes
		// si son nulos entonces es una inserción en caso contraio edición
		
		//boolean isEdit = (idCenParam == null && idCenParam.isEmpty());
		System.out.println(" formulario en SvGuardarCentro...." );

		String nomCen = request.getParameter("nomCen");
		String telCen = request.getParameter("telCen");
		String direCen = request.getParameter("direCen");
		String localCen = request.getParameter("localCen");
		String provCen = request.getParameter("provCen");
		String respCen = request.getParameter("respCen");
		String obsCen = request.getParameter("obsCen");
		
		String tipo = request.getParameter("tipo");


		System.out.println("dentro de servlet guardar centro...." + "  idCenParam  " + idCenParam);
		System.out.println("dentro de servlet guardar centro...." + "  tipo  " + tipo);

		try {

			 
		        if("editar".equals(tipo)) {	
		        	if(idCenParam!= null ) {	
		    
				idCen = Integer.parseInt(idCenParam);
		        	
				Centro cen = new Centro(idCen, nomCen, telCen, direCen, localCen, provCen, respCen, obsCen);

				// Convertir otros parámetros si es necesario...

				// Realiza la actualización de la matrícula existente
				resultado = daoCentro.actualizarCentroDao(cen);
		        	}

			} else if("nuevo".equals(tipo)) {
				// es inserción de un nuevo centro
				Centro cen = new Centro(nomCen, telCen, direCen, localCen, provCen, respCen, obsCen);

				resultado = daoCentro.insertarCentroDao(cen);
			}

			// Maneja el resultado de la inserción
			if (resultado) {
				// Si la inserción fue exitosa, envía un mensaje de éxito
				jsonResponse.put("success", true);
				jsonResponse.put("message", " operación realizada con éxito");

//					response.setStatus(HttpServletResponse.SC_OK); // Código de estado 200 (OK)
//					response.getWriter().write("Matriculación exitosa");
			} else {
				// Si hubo un problema durante la inserción, envía un mensaje de error al
				// cliente

				// Si hubo un problema durante la operación, envía un mensaje de error
				jsonResponse.put("success", false);
				jsonResponse.put("message", "Error al realizar la operación");
//					response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Código de estado 400 (Bad Request)
//					response.getWriter().write("Error al realizar la matriculación"); // Mensaje de error genérico
			}

		}catch(

	Exception e)
	{

		// Si hubo un problema durante la operación, envía un mensaje de error
		jsonResponse.put("success", false);
		jsonResponse.put("message", "Error al realizar la operación");
	}

	// Enviar el objeto JSON como respuesta al cliente
	response.setContentType("application/json");response.setCharacterEncoding("UTF-8");response.getWriter().write(jsonResponse.toString());

	}

	private Date parseDate(String dateStr, String format) throws ParseException {
		if (dateStr != null && !dateStr.isEmpty()) {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			return new Date(sdf.parse(dateStr).getTime());
		}
		return null;
	}
}
