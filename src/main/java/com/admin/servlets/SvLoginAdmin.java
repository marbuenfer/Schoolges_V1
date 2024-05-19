package com.admin.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.DaoUsuario;
import com.db.DbConexion;
import com.logica.Usuario;

/**
 * Servlet implementation class SvLoginAdmin
 */
 
public class SvLoginAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SvLoginAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String emailUsuAdmin = request.getParameter("emailUsu");
			String pswordUsuAdmin = request.getParameter("pswordUsu");
			
			HttpSession session = request.getSession();
			//Obtiene o crea una sesión HTTP. Las sesiones se utilizan para mantener 
			//el estado entre múltiples solicitudes del mismo usuario
			
			if("admin@gmail.com".equals(emailUsuAdmin)&& "admin".equals(pswordUsuAdmin)) {
				//se ha introducido el email y contraseña de administrador
				/* Si las credenciales coinciden, se establece un atributo en la sesión llamado "adminObj" con un nuevo objeto
				 *  de la clase Usuario. Este objeto podría contener información adicional sobre el usuario administrador.*/
				session.setAttribute("adminObj", new Usuario());
				
				//Redirige al usuario a la página "admin/index.jsp" después de una autenticación 
				//exitosa del administrador.
				response.sendRedirect("admin/index.jsp");
			}else {//no tiene contraseña de administrador, pues se busca si tiene es usuario 
				 try {
			          
			            String pswordUsu = request.getParameter("pswordUsu");
			         
			            String emailUsu = request.getParameter("emailUsu");
			         
			                    // conectar con la base de datos
			                    DaoUsuario dao = new DaoUsuario(DbConexion.getConn());
			                   
			                  //  HttpSession session = request.getSession();
			                                        
			                        Usuario usu = dao.login(emailUsu, pswordUsu);

			                        if (usu!=null) {//se llama al index.jsp raiz
			                        	session.setAttribute("userObj", usu);
			                        	response.sendRedirect("index.jsp");
			                          
			                        } else {
			                        	session.setAttribute("errorMsg", "¡Inválido email & password!");
			                        	response.sendRedirect("registroUsu.jsp");
			                            
			                        }
			        } catch (Exception e) {
			            // Manejar otras excepciones
			            e.printStackTrace();
			            System.out.println("Error general");
			        }
				
				
				
				
			//	session.setAttribute("errorMsg", "¡correo y contraseña invalida!");
			//	response.sendRedirect("adminLogin.jsp");

			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
