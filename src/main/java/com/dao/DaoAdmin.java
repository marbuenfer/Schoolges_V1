package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoAdmin {
	private Connection conn;

	public DaoAdmin(Connection conn) {
		super();
		this.conn = conn;
	}
	

	public DaoAdmin() {
		 
	}

	//realizada el 31/3 21:10
	public boolean borrarAdmin(int idAdm) {
		boolean f = false;
		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);

			// Primero, eliminar registro de la tabla alumnos
			String sqlAdmins = "DELETE FROM administradores WHERE idAdm = ?";
			try (PreparedStatement psAdmins = conn.prepareStatement(sqlAdmins)) {
				psAdmins.setInt(1, idAdm);
				int iAdmin = psAdmins.executeUpdate();

				// Luego, eliminar de la tabla usuarios
				String sqlUsuarios = "DELETE FROM usuarios WHERE idUsu = ?";
				try (PreparedStatement psUsuarios = conn.prepareStatement(sqlUsuarios)) {
					psUsuarios.setInt(1, idAdm);
					int iUsuario = psUsuarios.executeUpdate();

					// Si ambas eliminaciones fueron exitosas, confirmar la transacción
					if (iAdmin > 0 && iUsuario > 0) {
						conn.commit();
						f = true;
						System.out.println("Docente borrado exitosamente");
					}
				}
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción
			try {
				conn.rollback();
			} catch (SQLException rollbackException) {
				rollbackException.printStackTrace();
			}

			e.printStackTrace();
			System.out.println("Error Borrando Admin");
		} finally {
			// Restaurar auto-commit al estado original
			try {
				conn.setAutoCommit(true);
			} catch (SQLException autoCommitException) {
				autoCommitException.printStackTrace();
			}
		}

		return f;
	}
	
//	public boolean registrarAdmin(Admin d) {
//		boolean f = false;
//
//		try { 
//			 
//			String sql = "insert into administradores(idAd,fechAltAd,fechBajAd,catAd) values(?,?,?,?)";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setInt(1, d.getIdAd());
//			ps.setDate(2, d.getFechAltAd());
//			ps.setDate(3, d.getFechBajAd());
//			ps.setString(4, d.getCatAd());
//		 
// 
//			int i = ps.executeUpdate();
//			if (i == 1) {
//				f = true;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return f;
//	}
//
//	public List<Admin> getAllAdmins() {
//		List<Admin> list = new ArrayList<Admin>();
//		Admin d = null;
//		try {
//
//			String sql = "select * from administradores order by id desc";
//			PreparedStatement ps = conn.prepareStatement(sql);
//
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				d = new Admin();
//				d.setIdAd(rs.getInt(1));
//				d.setFechAltAd(rs.getDate(2));
//				d.setCatAd(rs.getString(3)) ;
//				 
//				list.add(d);
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
//
//	public Admin getAdminPorId(int id) {
//
//		Admin d = null;
//		try {
//
//			String sql = "select * from administradores where id=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setInt(1, id);
//			ResultSet rs = ps.executeQuery();
//			
//			while (rs.next()) {
//				d = new Admin();
//				d.setIdAd(rs.getInt(1));
//				d.setFechAltAd(rs.getDate(2));
//				d.setCatAd(rs.getString(3)) ;
//				 
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return d;
//	}
//
//	public boolean actualizarAdmin(Admin d) {
//		boolean f = false;
//
//		try {
//			String sql = "update administradores set IdAd=?,fechAltAd=?,fechBajAd=?,catAd=? where id=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setInt(1, d.getIdAd());
//			ps.setDate(2, d.getFechAltAd());
//			ps.setDate(3, d.getFechBajAd());
//			ps.setString(4, d.getCatAd());
//			
//			int i = ps.executeUpdate();
//
//			if (i == 1) {
//				f = true;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return f;
//	}
//
//	public boolean borrarAdmin(int id) {
//		boolean f = false;
//		try {
//			String sql = "delete from administradores where id=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setInt(1, id);
//
//			int i = ps.executeUpdate();
//			if (i == 1) {
//				f = true;
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return f;
//	}

//	public Alumno login(String email, String psw) {
//		Alumno d = null;
//		try {
//
//			String sql = "select * from Alumnos where email=? and password=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setString(1, email);
//			ps.setString(2, psw);
//
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				d = new Alumno(0, sql, sql, sql);
////				d = new Alumno();
//				d.setIdAlu(rs.getInt(1));
//				d.setFullName(rs.getString(2));
//				d.setDob(rs.getString(3));
//				d.setQualification(rs.getString(4));
//				d.setSpecialist(rs.getString(5));
//				d.setEmail(rs.getString(6));
//				d.setMobNo(rs.getString(7));
//				d.setPassword(rs.getString(8));
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return d;
//	}
 
		public int contarAlumnos() {
			int i = 0;
			try {
				String sql = "select * from Alumnos";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					i++;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return i;
		}
		public int contarDocentes() {
			int i = 0;
			try {
				String sql = "select * from docentes";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					i++;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return i;
		}
		public int contarEstudiosDisponibles() {
			int i = 0;
			try {
				String sql = "select * from estudiosDisponibles";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					i++;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return i;
		}
		
		public int contarCentros() {
			int i = 0;
			try {
				String sql = "select * from centros";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					i++;
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			}
	
			return i;
		}
		
		public int contarAdministradores() {
			int i = 0;
			try {
				String sql = "select * from administradores";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					i++;
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			}
	
			return i;
		}
		public int contarMateriasEnEstudios() {
			int i = 0;
			try {
				String sql = "select * from materiasEnEstudios";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					i++;
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			}
	
			return i;
		}
		
		public int contarMaterias() {
			int i = 0;
			try {
				String sql = "select * from materias ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					i++;
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			}
	
			return i;
		}
//	public int countAppointmentByDocotrId(int did) {
//		int i = 0;
//		try {
//			String sql = "select * from appointment where doctor_id=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setInt(1, did);
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				i++;
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return i;
//	}

//	public int countUSer() {
//		int i = 0;
//		try {
//			String sql = "select * from user_dtls";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				i++;
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return i;
//	}

//	

//	public boolean checkOldPassword(int userid, String oldPassword) {
//		boolean f = false;
//
//		try {
//			String sql = "select * from Alumnos where id=? and password=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setInt(1, userid);
//			ps.setString(2, oldPassword);
//
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				f = true;
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return f;
//	}
//
//	public boolean changePassword(int userid, String newPassword) {
//		boolean f = false;
//
//		try {
//			String sql = "update Alumnos set password=? where id=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setString(1, newPassword);
//			ps.setInt(2, userid);
//
//			int i = ps.executeUpdate();
//			if (i == 1) {
//				f = true;
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return f;
//	}

//	public boolean editAlumnoProfile(Alumno d) {
//		boolean f = false;
//
//		try {
//			String sql = "update Alumnos set full_name=?,dob=?,qualification=?,specialist=?,email=?,mobno=? where id=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setString(1, d.getFullName());
//			ps.setString(2, d.getDob());
//			ps.setString(3, d.getQualification());
//			ps.setString(4, d.getSpecialist());
//			ps.setString(5, d.getEmail());
//			ps.setString(6, d.getMobNo());
//			ps.setInt(7, d.getId());
//			int i = ps.executeUpdate();
//
//			if (i == 1) {
//				f = true;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return f;
//	}

}