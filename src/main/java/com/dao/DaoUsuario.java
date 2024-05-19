package com.dao;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.logica.Usuario;

//este PROBablemente se tiene que quitar entero/////////////////////////7777
////////////////////////////77777

public class DaoUsuario {
	private Connection conn;

	public DaoUsuario(Connection conn) {
		super();
		this.conn = conn;
	}

	// BORRAR ESTE MÉTODO DE AQUÍ solo BORRAR USUARIO NO BORRA ALUMNO, NI DOCENTE,
	// NI ADMIN ///////////////////////777

//	public int registroUsuario(Usuario usuario) throws SQLException {
//		int idGenerado = 0;
//
//		try {
//			String sql = "insert into usuarios(dniUSu,nomCompUsu,telUSu,direcUsu,"
//					+ "pswordUsu,tipoRolUsu,emailUsu,localUsu,provUsu,obsUsu,fechNacUsu, activo) values(?,?,?,?,?,?,?,?,?,?,?,?)";
//			try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
//				ps.setString(1, usuario.getDniUsu());
//				ps.setString(2, usuario.getNomCompUsu());
//				ps.setString(3, usuario.getTelUsu());
//				ps.setString(4, usuario.getDirecUsu());
//				ps.setString(5, usuario.getPswordUsu());
//				ps.setString(6, usuario.getTipoRolUsu());
//				ps.setString(7, usuario.getEmailUsu());
////	            ps.setString(8, usuario.getCpUsu());
//				ps.setString(8, usuario.getLocalUsu());
//				ps.setString(9, usuario.getProvUsu());
//				ps.setString(10, usuario.getObsUsu());
//				ps.setDate(11, usuario.getFechNacUsu());
//				ps.setInt(12, usuario.getActivo());
////	            ps.setDate(14, usuario.getFechAltUsu());
////	            ps.setDate(15, usuario.getFechBajUsu());
//
//				int i = ps.executeUpdate();
//
//				if (i == 1) {
//					// Recupera las claves generadas automáticamente
//					try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
//						if (generatedKeys.next()) {
//							idGenerado = generatedKeys.getInt(1);
//						} else {
//							throw new SQLException("Error al obtener el ID generado.");
//						}
//					}
//				} else {
//					throw new SQLException("Error al insertar el usuario.");
//				}
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw e;
//		}
//
//		return idGenerado;
	//} // BORRAR ESTE MÉTODO DE AQUÍ ///////////////////////777

//	public boolean checkEmail(String emailUSu) throws EmailExistenteException {
//		try {
//			String sql = "SELECT COUNT(*) FROM Usuarios WHERE emailUsu=?";
//			try (PreparedStatement ps = conn.prepareStatement(sql)) {
//				ps.setString(1, emailUSu);
//				try (ResultSet rs = ps.executeQuery()) {
//					if (rs.next() && rs.getInt(1) > 0) {
//						// El correo electrónico ya existe
//						
//						throw new EmailExistenteException("¡No se puede registrar, el email ya existe!");
//					}
//				}
//			}
//		} catch (SQLException e) {
//			// Maneja la excepción de SQL según tus necesidades
//			e.printStackTrace();
//		}
//		return true;
//	}
//
//	public class EmailExistenteException extends Exception {
//		/**
//		 * 
//		 */
//		private static final long serialVersionUID = 1L;
//
//		public EmailExistenteException(String mensaje) {
//			super(mensaje);
//		}
//	}

	public Usuario getUsuarioById(int id) {

		Usuario usu = new Usuario();
		try (PreparedStatement ps = conn.prepareStatement("select * from usuarios where idUsu=?")) {
			System.out.println("****|n|nEstoy en getUsuarioById");
//			String sql = "select * from usuarios where idUsu=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					usu = new Usuario();

					usu.setIdUsu(rs.getInt(1));
					usu.setDniUsu(rs.getString(2));
					usu.setNomCompUsu(rs.getString(3));
					usu.setTelUsu(rs.getString(4));
					usu.setObsUsu(rs.getString(5));
					usu.setDirecUsu(rs.getString(6));
					usu.setFechNacUsu(rs.getDate(7));
					usu.setEmailUsu(rs.getString(8));
					usu.setPswordUsu(rs.getString(9));
					usu.setTipoRolUsu(rs.getString(10));
					usu.setLocalUsu(rs.getString(11));
					usu.setProvUsu(rs.getString(12));
					usu.setActivo(rs.getInt(13));	 
				}
			} // try

		} catch (Exception e) {
			e.printStackTrace();
		} // try
		return usu;
	}

	


	public Usuario login(String email, String psWord) {
		Usuario usu = null;
		try {

			String sql = "select * from usuarios where emailUsu =? and pswordUsu=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, psWord);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				usu = new Usuario();
				usu.setIdUsu(rs.getInt(1));
				usu.setDniUsu(rs.getString(2));
				usu.setNomCompUsu(rs.getString(3));
				usu.setTelUsu(rs.getString(4));
				usu.setObsUsu(rs.getString(5));
				usu.setDirecUsu(rs.getString(6));
//				usu.setCpUsu(rs.getString(10));
				usu.setFechNacUsu(rs.getDate(7));
				usu.setEmailUsu(rs.getString(8));
				usu.setPswordUsu(rs.getString(9));
				usu.setTipoRolUsu(rs.getString(10));
				usu.setLocalUsu(rs.getString(11));
				usu.setProvUsu(rs.getString(12));
				usu.setActivo(rs.getInt(13));
//				usu.setFechAltUsu(rs.getDate(15));
//				usu.setFechBajUsu(rs.getDate(16));
				System.out.println("Estoy en login de daoUsuario");
				System.out.println(usu);

			}

		} catch (Exception e) {
			// TODO: handle exception
		}

		return usu;

	}



	// Otros métodos de la clase
	public boolean actualizarUsuario(Usuario d) {
		boolean f = false;

		try {
			String sql = "update Usuarios set dniUsu=?,nomCompUsu=?,telUsu=?,obsUsu=?,direcUsu=?,pswordUsu=?,tipoRolUsu=?,emailUsu=?,localUsu=?,provUsu=?,fechNacUsu=?,activo=? where idUsu=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, d.getDniUsu());
			ps.setString(2, d.getNomCompUsu());
			ps.setString(3, d.getTelUsu());
			ps.setString(4, d.getObsUsu());
			ps.setString(5, d.getDirecUsu());
			ps.setString(6, d.getPswordUsu());
			ps.setString(7, d.getTipoRolUsu());
			ps.setString(8, d.getEmailUsu());
//		        ps.setString(9, d.getCpUsu());
			ps.setString(9, d.getLocalUsu());
			ps.setString(10, d.getProvUsu());
			ps.setDate(11, d.getFechNacUsu());
			ps.setInt(12, d.getActivo());
			ps.setInt(13, d.getIdUsu()); // Añadido el ID al final

			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

//	 public boolean borrarUsuario(int idUsu) {
//		    boolean f = false;
//		    try {
//		        String sql = "DELETE usuarios, alumnos FROM usuarios " +
//		                     "LEFT JOIN alumnos ON usuarios.idUsu = alumnos.idAlu " +
//		                     "WHERE usuarios.idUsu = ?";
//		        PreparedStatement ps = conn.prepareStatement(sql);
//		        ps.setInt(1, idUsu);
//
//		        int i = ps.executeUpdate();
//		        if (i == 1) {
//		            f = true;
//			        System.out.println("Lo ha encontrado el usuario y alumno para borrarlo");
//
//		        }
//
//		    } catch (Exception e) {
//		        e.printStackTrace();
//		        System.out.println("Error Borrando Usuario y alumno");
//		    }
//
//		    return f;
//		}

}
