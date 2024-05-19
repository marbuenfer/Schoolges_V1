package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.logica.Alumno;
import com.logica.Matricula;
import com.logica.Usuario;

public class DaoAlumno {
	private Connection conn;

	public DaoAlumno(Connection conn) {
		this.conn = conn;
	}

	public DaoAlumno() {

	}

	// modificado 20/2
	public boolean insertarAlumnoDao(Alumno alu) {
		boolean f = false;
		int iAlumno;
		int iUsuario;
		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);

			// Verificar si el email ya existe en la tabla usuarios
			String verificarEmailSQL = "SELECT COUNT(*) FROM usuarios WHERE emailUsu = ?";
			try (PreparedStatement psVerificarEmail = conn.prepareStatement(verificarEmailSQL)) {
				psVerificarEmail.setString(1, alu.getEmailUsu());
				
				try (ResultSet rs = psVerificarEmail.executeQuery()) {
					rs.next();
					int count = rs.getInt(1);

					if (count == 0) {
						// El email no existe, proceder con la inserción
						String insertarUsuarioSQL = "INSERT INTO usuarios(dniUSu,nomCompUsu,telUSu,obsUsu,direcUsu,"
								+ "fechNacUsu, emailUsu, pswordUsu,tipoRolUsu,localUsu,provUsu, "
								+ "activo) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

						try (PreparedStatement psInsertarUsuario = conn.prepareStatement(insertarUsuarioSQL,
								Statement.RETURN_GENERATED_KEYS)) {
							psInsertarUsuario.setString(1, alu.getDniUsu());
							psInsertarUsuario.setString(2, alu.getNomCompUsu());
							psInsertarUsuario.setString(3, alu.getTelUsu());
							psInsertarUsuario.setString(4, alu.getObsUsu());
							psInsertarUsuario.setString(5, alu.getDirecUsu());
							psInsertarUsuario.setDate(6, alu.getFechNacUsu());
							psInsertarUsuario.setString(7, alu.getEmailUsu());
							psInsertarUsuario.setString(8, alu.getPswordUsu());
							psInsertarUsuario.setString(9, alu.getTipoRolUsu());
							psInsertarUsuario.setString(10, alu.getLocalUsu());
							psInsertarUsuario.setString(11, alu.getProvUsu());
							psInsertarUsuario.setInt(12, alu.getActivo());

							iUsuario = psInsertarUsuario.executeUpdate();
							int idUsuarioGenerado = 0;

							System.out.println("resultado de inserción numero insertados..." + iUsuario );
							
							if (iUsuario > 0) {
								// Obtener las claves generadas (en este caso, el ID del usuario)
								try (ResultSet generatedKeys = psInsertarUsuario.getGeneratedKeys()) {
									if (generatedKeys.next()) {
										idUsuarioGenerado = generatedKeys.getInt(1);
										// Ahora 'idUsuarioGenerado' contiene el ID del usuario recién registrado
										System.out.println("ID del usuario recién registrado: " + idUsuarioGenerado);

										// Luego, insertar en la tabla alumnos
										String insertarAlumnoSQL = "INSERT INTO Alumnos(idAlu,tituIngAlu) VALUES(?,?)";
										try (PreparedStatement psInsertarAlumno = conn
												.prepareStatement(insertarAlumnoSQL)) {
											psInsertarAlumno.setInt(1, idUsuarioGenerado);
											psInsertarAlumno.setString(2, alu.getTituIngAlu());
											// Setear los demás campos de la tabla Alumnos según sea necesario

											iAlumno = psInsertarAlumno.executeUpdate();

											// Si ambas inserciones fueron exitosas, confirmar la transacción
											if (iAlumno > 0) {
												conn.commit();
												f = true;
												System.out.println("Usuario y Alumno insertado exitosamente");
											}
										}
									} else {
										System.out.println("No se pudo obtener el ID del usuario recién registrado.");
									}
								}
							}
						}
					} else {
						// El email ya existe, no se puede insertar
						System.out.println("El email ya existe en la tabla usuarios.");
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
			System.out.println("Error insertando usuario y Alumno");
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

	// modificado 20/2
	public boolean actualizarAlumnoDao(Usuario usu, Alumno alu) {
		boolean f = false;
		int iAlumno;
		int iUsuario;
		System.out.println("Estoy en actualizarAlumnoDao");
		System.out.println("alu recogido por parametro " + alu.toString());

		System.out.println("usu recogido por parametro " + usu.toString());

		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);

			// Primero, insertar registro de la tabla (alumnos)usuarios
			String sqlUsuarios = "UPDATE usuarios SET dniUSu = ?, nomCompUsu = ?, telUSu = ?, direcUsu = ?, "
					+ "pswordUsu = ?, tipoRolUsu = ?, emailUsu = ?, localUsu = ?, provUsu = ?, "
					+ "obsUsu = ?, fechNacUsu = ?, activo = ?" + " WHERE idUsu = ?";

			try (PreparedStatement psUsuarios = conn.prepareStatement(sqlUsuarios)) {
				psUsuarios.setString(1, usu.getDniUsu());
				psUsuarios.setString(2, usu.getNomCompUsu());
				psUsuarios.setString(3, usu.getTelUsu());
				psUsuarios.setString(4, usu.getDirecUsu());
				psUsuarios.setString(5, usu.getPswordUsu());
				psUsuarios.setString(6, usu.getTipoRolUsu());
				psUsuarios.setString(7, usu.getEmailUsu());
				psUsuarios.setString(8, usu.getLocalUsu());
				psUsuarios.setString(9, usu.getProvUsu());
				psUsuarios.setString(10, usu.getObsUsu());
				psUsuarios.setDate(11, usu.getFechNacUsu());
				psUsuarios.setInt(12, usu.getActivo());
				psUsuarios.setInt(13, usu.getIdUsu());

				iUsuario = psUsuarios.executeUpdate();

				// Luego, eliminar de la tabla (usuarios)alumnos
				String sqlAlumnos = "update Alumnos set tituIngAlu=? where idAlu=?";
				try (PreparedStatement psAlumnos = conn.prepareStatement(sqlAlumnos)) {
					// psAlumnos.setInt(1, alu.getIdAlu());
					psAlumnos.setString(1, alu.getTituIngAlu());
//					psAlumnos.setString(2, alu.getNumMatriAlu());
//					psAlumnos.setString(3, alu.getModaAlu());
//					psAlumnos.setDate(4, alu.getFechMatriAlu());
//					psAlumnos.setString(5, alu.getAnnoAcaAlu());
					psAlumnos.setInt(2, usu.getIdUsu());

					iAlumno = psAlumnos.executeUpdate();
					System.out.println(iAlumno);

					// Si ambas inserciones fueron exitosas, confirmar la transacción
					if (iAlumno > 0 && iUsuario > 0) {
						// conn.commit();
						f = true;
						System.out.println("Usuario y Alumno insertado exitosamente");
					}
				}
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción
//			try {
//				//conn.rollback();
//			} catch (SQLException rollbackException) {
//				rollbackException.printStackTrace();
//			}
			e.printStackTrace();
			System.out.println("Error actualizando usuario y Alumno");
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

	public boolean borrarAlumno(int idAlu) {
		boolean f = false;
		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);
			System.out.println("Dentro de método borrarAlumno de DaoAlumno");
			// Primero, eliminar registro de la tabla alumnos
			String sqlAlumnos = "DELETE FROM alumnos WHERE idAlu = ?";
			try (PreparedStatement psAlumnos = conn.prepareStatement(sqlAlumnos)) {
				psAlumnos.setInt(1, idAlu);
				int iAlumno = psAlumnos.executeUpdate();

				// Luego, eliminar de la tabla usuarios
				String sqlUsuarios = "DELETE FROM usuarios WHERE idUsu = ?";
				try (PreparedStatement psUsuarios = conn.prepareStatement(sqlUsuarios)) {
					psUsuarios.setInt(1, idAlu);
					int iUsuario = psUsuarios.executeUpdate();

					// Si ambas eliminaciones fueron exitosas, confirmar la transacción
					if (iAlumno > 0 && iUsuario > 0) {
						conn.commit();
						f = true;
						System.out.println("Alumno borrado exitosamente");
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
			System.out.println("Error Borrando Alumno");
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

	// modificado 20/2 !!!ATENCIÓN NO CERRAR RECURSOS, PORQUE DSPUÉS NO ME FUNCIONA!!!!
	public List<Alumno> getAllAlumnos() {
		List<Alumno> list = new ArrayList<Alumno>();
		Alumno d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT u.*, a.tituIngAlu " + " FROM usuarios  u " + " JOIN alumnos a ON u.idUsu = a.idAlu;";
		System.out.println(sql + "estoy dentro de getAllAlumnos"   );

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
	            d = new Alumno();
				d.setIdUsu(rs.getInt(1));
				d.setDniUsu(rs.getString(2));
				d.setNomCompUsu(rs.getString(3));
				d.setTelUsu(rs.getString(4));
				d.setObsUsu(rs.getString(5));
				d.setDirecUsu(rs.getString(6));
				d.setFechNacUsu(rs.getDate(7));
				d.setEmailUsu(rs.getString(8));
				d.setPswordUsu(rs.getString(9));
				d.setTipoRolUsu(rs.getString(10));
				d.setLocalUsu(rs.getString(11));
				d.setProvUsu(rs.getString(12));
				d.setActivo(rs.getInt(13));
				d.setTituIngAlu(rs.getString(14));

				list.add(d);
			}

		} catch (Exception e) {
			 e.printStackTrace();;
		} 
	   

		return list;
	}

	// modificado 20/2
	public Alumno getAlumnoById(int id) {
	    Alumno d = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    String sql = "SELECT u.*, a.tituIngAlu " +
	                 "FROM usuarios u " +
	                 "JOIN alumnos a ON u.idUsu = a.idAlu " +
	                 "WHERE u.idUsu = ?";

	    System.out.print("Estoy en getAlumnoById");
	    try {
	        ps = conn.prepareStatement(sql);

	        // Establecer el valor del parámetro
	        ps.setInt(1, id);

	        // Ejecutar la consulta
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            d = new Alumno();
	            d.setIdUsu(rs.getInt(1));
	            d.setDniUsu(rs.getString(2));
	            d.setNomCompUsu(rs.getString(3));
	            d.setTelUsu(rs.getString(4));
	            d.setObsUsu(rs.getString(5));
	            d.setDirecUsu(rs.getString(6));
	            d.setFechNacUsu(rs.getDate(7));
	            d.setEmailUsu(rs.getString(8));
	            d.setPswordUsu(rs.getString(9));
	            d.setTipoRolUsu(rs.getString(10));
	            d.setLocalUsu(rs.getString(11));
	            d.setProvUsu(rs.getString(12));
	            d.setActivo(rs.getInt(13));
	            d.setTituIngAlu(rs.getString(14));
	            
	            System.out.println(d + "resultset obtenido de alumno encontrado");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		return d;
	}

	
	///ESTO HABRÍA QUE PASARLO A DAOMATRICULAS
	// Matriculas
	public List<Matricula> getAllMatriculaciones() {
		// Otros métodos de la clase
		List<Matricula> matriculas = new ArrayList<>();
		String sql = "SELECT matriculaciones.idAlu, usuarios.nomCompUsu AS nomCompAlu, "
				+ "       matriculaciones.idEst, estudiosDisponibles.nomEst AS nomEst, "
				+ "       matriculaciones.fechMatri, matriculaciones.modMatri, matriculaciones.obsMatri "
				+ " FROM matriculaciones " + " JOIN usuarios ON matriculaciones.idAlu = usuarios.idUsu "
				+ " JOIN estudiosDisponibles ON matriculaciones.idEst = estudiosDisponibles.idEst";

		// Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			// conn = DbConexion.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			while (rs.next()) {
				Matricula matricula = new Matricula();
				// matricula.setIdMatri(rs.getInt("idMatri"));
				matricula.setIdAlu(rs.getInt("idAlu"));
				matricula.setNomCompAlu(rs.getString("nomCompAlu"));
				matricula.setIdEst(rs.getInt("idEst"));
				matricula.setNomEst(rs.getString("nomEst"));
				//matricula.setFechMatri(rs.getDate("fechMatri"));
				 
               matricula.setFechMatri(rs.getDate("fechMatri"));
  
				matricula.setModMatri(rs.getString("modMatri"));
				matricula.setObsMatri(rs.getString("obsMatri"));

				// Agregar la matricula a la lista
				matriculas.add(matricula);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Manejo adecuado de excepciones en tu aplicación
		} finally {
			// Cerrar recursos en el bloque finally para asegurar su liberación
			try {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return matriculas;
	}

	public boolean borrarMatricula(int idMatri) {
		boolean f = false;

		// Deshabilitar auto-commit para iniciar la transacción
		// conn.setAutoCommit(false);

		// Primero, eliminar registro de la tabla matriculaciones utilizando los tres
		// campos
		String sqlMatriculas = "DELETE FROM matriculaciones WHERE idMatri = ?";
		try (PreparedStatement psMatriculas = conn.prepareStatement(sqlMatriculas)) {
			psMatriculas.setInt(1, idMatri);
 

			if (psMatriculas.executeUpdate() > 0) {
				f = true;
				System.out.println("Matricula borrada exitosamente");
			} else {
				f = false;
				System.out.println("No se puede borrar la matricula");
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción
			e.printStackTrace();
			System.out.println("Error borrando matricula");
		}

		return f;
	}
	
	
	//ROL ALUMNO
	
	
	public List<Alumno> getAllAlumnosByEstudio(int idAlu) {
		List<Alumno> list = new ArrayList<Alumno>();
		Alumno d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
//		String sql = "SELECT DISTINCT u.idUsu, u.nomCompUsu, u.emailUsu, e.nomEst\r\n"
//				+ "FROM usuarios u\r\n"
//				+ "INNER JOIN matriculaciones m ON u.idUsu = m.idAlu\r\n"
//				+ "INNER JOIN estudiosDisponibles e ON m.idEst = e.idEst\r\n"
//				+ "WHERE m.idEst IN (SELECT idEst FROM matriculaciones WHERE idAlu = ?)\r\n"
//				+ "AND u.idUsu != ?;";
		String sql = "SELECT DISTINCT u.idUsu, u.nomCompUsu, u.emailUsu "
				+ "FROM usuarios u\r\n"
				+ "INNER JOIN matriculaciones m ON u.idUsu = m.idAlu\r\n"
				+ "INNER JOIN estudiosDisponibles e ON m.idEst = e.idEst\r\n"
				+ "WHERE m.idEst IN (SELECT idEst FROM matriculaciones WHERE idAlu = ?)\r\n"
				+ "AND u.idUsu != ?;"; 
		System.out.println(sql + "estoy dentro de getAllAlumnosByEstudio"   );

		try {
			ps = conn.prepareStatement(sql);
	        ps.setInt(1, idAlu); // Asigna el valor del primer parámetro idAlu
	        ps.setInt(2, idAlu); // Asigna el valor del segundo parámetro idAlu

			rs = ps.executeQuery();
			while (rs.next()) {
	            d = new Alumno();
				d.setIdUsu(rs.getInt(1));
				d.setNomCompUsu(rs.getString(2));
				d.setEmailUsu(rs.getString(3));
				//d.setNomEst(rs.getString(4));
				list.add(d);
			}

		} catch (Exception e) {
			 e.printStackTrace();;
		} 
	   

		return list;
	}

	

}