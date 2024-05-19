package com.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.logica.Alumno;
import com.logica.AsignacionDocente;
import com.logica.Docente;
import com.logica.Matricula;
import com.logica.Usuario;

public class DaoDocente {
	private Connection conn;

	public DaoDocente(Connection conn) {
		this.conn = conn;
	}

	public DaoDocente() {

	}

	public boolean insertarDocenteDao(Usuario usu, Docente doc) {
		boolean f = false;
		int iDocente;
		int iUsuario;
		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);

			// Verificar si el email ya existe en la tabla usuarios
			String verificarEmailSQL = "SELECT COUNT(*) FROM usuarios WHERE emailUsu = ?";
			try (PreparedStatement psVerificarEmail = conn.prepareStatement(verificarEmailSQL)) {
				psVerificarEmail.setString(1, doc.getEmailUsu());

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
							psInsertarUsuario.setString(1, usu.getDniUsu());
							psInsertarUsuario.setString(2, usu.getNomCompUsu());
							psInsertarUsuario.setString(3, usu.getTelUsu());
							psInsertarUsuario.setString(4, usu.getObsUsu());
							psInsertarUsuario.setString(5, usu.getDirecUsu());
							psInsertarUsuario.setDate(6, usu.getFechNacUsu());
							psInsertarUsuario.setString(7, usu.getEmailUsu());
							psInsertarUsuario.setString(8, usu.getPswordUsu());
							psInsertarUsuario.setString(9, usu.getTipoRolUsu());
							psInsertarUsuario.setString(10, usu.getLocalUsu());
							psInsertarUsuario.setString(11, usu.getProvUsu());
							psInsertarUsuario.setInt(12, usu.getActivo());

							iUsuario = psInsertarUsuario.executeUpdate();
							int idUsuarioGenerado = 0;

							System.out.println("resultado de inserción numero insertados..." + iUsuario);

							if (iUsuario > 0) {
								// Obtener las claves generadas (en este caso, el ID del usuario)
								try (ResultSet generatedKeys = psInsertarUsuario.getGeneratedKeys()) {
									if (generatedKeys.next()) {
										idUsuarioGenerado = generatedKeys.getInt(1);
										// Ahora 'idUsuarioGenerado' contiene el ID del usuario recién registrado
										System.out.println("ID del usuario recién registrado: " + idUsuarioGenerado);

										// Luego, insertar en la tabla alumnos
										String insertarDocenteSQL = "INSERT INTO docentes(idDoc, espeDoc,gradAcadDoc,fechAltaDoc,fechBajaDoc) VALUES(?,?,?,?,?)";
										try (PreparedStatement psInsertarDocente = conn
												.prepareStatement(insertarDocenteSQL)) {
											psInsertarDocente.setInt(1, idUsuarioGenerado);
											psInsertarDocente.setString(2, doc.getEspeDoc());
											psInsertarDocente.setString(3, doc.getGradAcadDoc());
											psInsertarDocente.setDate(4, doc.getFechAltaDoc());
											psInsertarDocente.setDate(5, doc.getFechBajaDoc());

											iDocente = psInsertarDocente.executeUpdate();

											// Si ambas inserciones fueron exitosas, confirmar la transacción
											if (iDocente > 0) {
												conn.commit();
												f = true;
												System.out.println("Usuario y docente insertado exitosamente");
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
						System.out.println("El email ya existe en la tabla usuario.");
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
			System.out.println("\n\nError insertando usuario y docente");
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
	public boolean actualizarDocenteDao(Docente doc) {
		boolean f = false;
		int iDocente;
		int iUsuario;

		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);

			// Primero, insertar registro de la tabla (alumnos)usuarios
			String sqlUsuarios = "UPDATE usuarios SET dniUSu = ?, nomCompUsu = ?, telUSu = ?, direcUsu = ?, "
					+ "pswordUsu = ?, tipoRolUsu = ?, emailUsu = ?, localUsu = ?, provUsu = ?, "
					+ "obsUsu = ?, fechNacUsu = ?, activo = ?" + " WHERE idUsu = ?";

			try (PreparedStatement psUsuarios = conn.prepareStatement(sqlUsuarios)) {
				psUsuarios.setString(1, doc.getDniUsu());
				psUsuarios.setString(2, doc.getNomCompUsu());
				psUsuarios.setString(3, doc.getTelUsu());
				psUsuarios.setString(4, doc.getDirecUsu());
				psUsuarios.setString(5, doc.getPswordUsu());
				psUsuarios.setString(6, doc.getTipoRolUsu());
				psUsuarios.setString(7, doc.getEmailUsu());
				psUsuarios.setString(8, doc.getLocalUsu());
				psUsuarios.setString(9, doc.getProvUsu());
				psUsuarios.setString(10, doc.getObsUsu());
				psUsuarios.setDate(11, doc.getFechNacUsu());
				psUsuarios.setInt(12, doc.getActivo());
				psUsuarios.setInt(13, doc.getIdUsu());

				iUsuario = psUsuarios.executeUpdate();

				String sqlDocentes = "UPDATE docentes SET gradAcadDoc=?, espeDoc=?, fechAltaDoc=?, fechBajaDoc=? WHERE idDoc=?";
				try (PreparedStatement psDocentes = conn.prepareStatement(sqlDocentes)) {
					psDocentes.setString(1, doc.getGradAcadDoc());
					psDocentes.setString(2, doc.getEspeDoc());
					psDocentes.setDate(3, doc.getFechAltaDoc());
					psDocentes.setDate(4, doc.getFechBajaDoc());
					psDocentes.setInt(5, doc.getIdUsu());

					iDocente = psDocentes.executeUpdate();
					System.out.println(iDocente);

					// Si ambas inserciones fueron exitosas, confirmar la transacción
					if (iDocente > 0 && iUsuario > 0) {
						// conn.commit();
						f = true;
						System.out.println("Usuario y docente actualizado exitosamente");
					}
				}
			}

		} catch (Exception e) {

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

	public boolean actualizarAsignacionDocente(AsignacionDocente asigDoc) {
		PreparedStatement ps = null;
		String actualizarAsgSQL = "UPDATE asignacionDocentes SET idDoc=?, idMat=?, fechIniAsigDoc=?,fechFinAsigDoc=?, obsAsigDoc=? WHERE idAsig=?";

		try {
			// Preparar la consulta SQL
			ps = conn.prepareStatement(actualizarAsgSQL);

			// Establecer los valores de los parámetros
			ps.setInt(1, asigDoc.getIdDoc());

			ps.setInt(2, asigDoc.getIdMat());
			ps.setDate(3, asigDoc.getFechIniAsigDoc());
			ps.setDate(4, asigDoc.getFechFinAsigDoc());
			ps.setString(5, asigDoc.getObsAsigDoc());
			ps.setInt(6, asigDoc.getIdAsg());

			// Ejecutar la consulta
			int filasAfectadas = ps.executeUpdate();

			// Verificar si se actualizó correctamente
			return filasAfectadas > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			// Manejar cualquier excepción de SQL aquí
			return false;
		} finally {
			// Cerrar recursos
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public List<AsignacionDocente> getAllAsignacionesByDocente(int idDoc) {
		List<AsignacionDocente> list = new ArrayList<AsignacionDocente>();
		AsignacionDocente d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAsignacionDocente daoAlu = new DaoAsignacionDocente(DbConexion.getConn());
		
		//ME QUEDA ADAPTAR ESTO PARA QUE MUESTRE LAS ASIGNACIONES A DOCENTE
		String sql = "SELECT DISTINCT u.idUsu, u.nomCompUsu, u.emailUsu, e.nomEst\r\n"
				+ "FROM usuarios u\r\n"
				+ "INNER JOIN matriculaciones m ON u.idUsu = m.idAlu\r\n"
				+ "INNER JOIN estudiosDisponibles e ON m.idEst = e.idEst\r\n"
				+ "WHERE m.idEst IN (SELECT idEst FROM matriculaciones WHERE idDoc = ?)\r\n"
				+ "AND u.idUsu != ?;";
			 
		System.out.println(sql + "estoy dentro de getAllAsignacionesByDocente"   );

		try {
			ps = conn.prepareStatement(sql);
	        ps.setInt(1, idDoc); // Asigna el valor del primer parámetro idDoc
	        ps.setInt(2, idDoc); // Asigna el valor del segundo parámetro idDoc

			rs = ps.executeQuery();
			while (rs.next()) {
	            d = new AsignacionDocente();
				d.setIdAsg(rs.getInt(1));
				//d.setIdDoc(rs.getString(2));
				d.setIdMat(idDoc);
				d.setNomMat(sql);
				d.setFechIniAsigDoc(null);
				d.setFechIniAsigDoc(null);

				list.add(d);
			}

		} catch (Exception e) {
			 e.printStackTrace();;
		} 
	   

		return list;
	}

	
	
	public List<AsignacionDocente> getAllDocentesByMateria(int idDoc) {
		List<AsignacionDocente> list = new ArrayList<AsignacionDocente>();
		AsignacionDocente d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT DISTINCT u.idUsu, u.nomCompUsu, u.emailUsu, m.idMat, m.nomMat\r\n"
				+ "FROM usuarios u\r\n"
				+ "INNER JOIN asignacionDocentes ad ON u.idUsu = ad.idDoc\r\n"
				+ "INNER JOIN materias m ON ad.idMat = m.idMat\r\n"
				+ "WHERE ad.idMat = (SELECT idMat FROM asignacionDocentes WHERE idDoc = ?)\r\n"
				+ "AND u.idUsu != ?;\r\n";

		System.out.println(sql + "estoy dentro de getAllDocentesByMateria"   );

		try {
			ps = conn.prepareStatement(sql);
	        ps.setInt(1, idDoc); // Asigna el valor del primer parámetro idAlu
	        ps.setInt(2, idDoc); // Asigna el valor del segundo parámetro idAlu

			rs = ps.executeQuery();
			while (rs.next()) {
	            d = new AsignacionDocente();
				d.setIdAsg(rs.getInt(1));
				d.setIdDoc(rs.getInt(2));
				d.setNomCompUsu(rs.getString(3));
				d.setEmailUsu(rs.getString(4));
				d.setIdMat(rs.getInt(5));
				d.setNomMat(rs.getString(6));
				d.setFechIniAsigDoc(rs.getDate(7));
				d.setFechFinAsigDoc(rs.getDate(8));
				list.add(d);
			}

		} catch (Exception e) {
			 e.printStackTrace();;
		} 
	   

		return list;
	}

	public boolean borrarDocente(int idDoc) {
		boolean f = false;
		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);

			// Primero, eliminar registro de la tabla alumnos
			String sqlDocentes = "DELETE FROM docentes WHERE idDoc = ?";
			try (PreparedStatement psDocentes = conn.prepareStatement(sqlDocentes)) {
				psDocentes.setInt(1, idDoc);
				int iDocente = psDocentes.executeUpdate();

				// Luego, eliminar de la tabla usuarios
				String sqlUsuarios = "DELETE FROM usuarios WHERE idUsu = ?";
				try (PreparedStatement psUsuarios = conn.prepareStatement(sqlUsuarios)) {
					psUsuarios.setInt(1, idDoc);
					int iUsuario = psUsuarios.executeUpdate();

					// Si ambas eliminaciones fueron exitosas, confirmar la transacción
					if (iDocente > 0 && iUsuario > 0) {
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
			System.out.println("Error Borrando Docente");
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

	// modificado 29/3 !!!ATENCIÓN NO CERRAR RECURSOS, PORQUE DSPUÉS NO ME
	// FUNCIONA!!!!
	public List<Docente> getAllDocentes() {
		List<Docente> list = new ArrayList<Docente>();
		Docente d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoDocente daoAlu = new DaoDocente(DbConexion.getConn());
		String sql = "SELECT u.*, d.* FROM usuarios u JOIN Docentes d ON u.idUsu = d.idDoc;\r\n" + "";
		System.out.println(sql + "estoy dentro de getAllDocentes");

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				d = new Docente();
				d.setIdUsu(rs.getInt(1));
				d.setDniUsu(rs.getString(2));
				d.setNomCompUsu(rs.getString(3));
				d.setTelUsu(rs.getString(4));
				d.setObsUsu(rs.getString(5));
				d.setDirecUsu(rs.getString(6));
				d.setFechNacUsu(rs.getDate(7));
				d.setEmailUsu(rs.getString(8));
				d.getEmailUsu();
				d.setPswordUsu(rs.getString(9));
				d.setTipoRolUsu(rs.getString(10));
				d.setLocalUsu(rs.getString(11));
				d.setProvUsu(rs.getString(12));
				d.setActivo(rs.getInt(13));
				d.setIdUsu(rs.getInt(14));
				d.setEspeDoc(rs.getString(15));
				d.setGradAcadDoc(rs.getString(16));
				d.setFechAltaDoc(rs.getDate(17));
				d.setFechBajaDoc(rs.getDate(18));

				list.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
			;
		}

		return list;
	}

	///

	public List<AsignacionDocente> getAllAsignacionDocentes() {
		List<AsignacionDocente> list = new ArrayList<AsignacionDocente>();
		AsignacionDocente asigDoc = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoDocente daoAlu = new DaoDocente(DbConexion.getConn());
		String sql = "SELECT d.idAsig, u.idUsu, u.dniUsu, u.nomCompUsu, u.emailUsu, u.activo, d.idMat, m.nomMat, d.fechIniAsigDoc, d.fechFinAsigDoc, d.obsAsigDoc FROM usuarios u JOIN asignaciondocentes d ON u.idUsu = d.idDoc  JOIN Materias m ON d.idMat = m.idMat;";
		System.out.println(sql + "estoy dentro de getAllAsignacionDocentes");

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				asigDoc = new AsignacionDocente();
				asigDoc.setIdAsg(rs.getInt("idAsig"));
				asigDoc.setIdDoc(rs.getInt("idUsu"));
				asigDoc.setDniUsu(rs.getString("dniUsu"));
				asigDoc.setNomCompUsu(rs.getString("nomCompUsu"));
				asigDoc.setEmailUsu(rs.getString("emailUsu"));
				asigDoc.setActivo(rs.getInt("activo"));
				asigDoc.setIdMat(rs.getInt("idMat"));
				asigDoc.setNomMat(rs.getString("nomMat"));
				asigDoc.setFechIniAsigDoc(rs.getDate("fechIniAsigDoc"));
				asigDoc.setFechFinAsigDoc(rs.getDate("fechFinAsigDoc"));
				asigDoc.setObsAsigDoc(rs.getString("obsAsigDoc"));
				list.add(asigDoc);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		return list;
	}

	public boolean borrarAsignacionDocente(int idAsig) {
		boolean f = false;
		try {
			// Deshabilitar auto-commit para iniciar la transacción
			conn.setAutoCommit(false);

			// Primero, eliminar registro de la tabla alumnos
			String sqlAsgDocentes = "DELETE FROM asignaciondocentes WHERE idAsig = ?";
			try (PreparedStatement psAsgDocentes = conn.prepareStatement(sqlAsgDocentes)) {
				psAsgDocentes.setInt(1, idAsig);
				int iDocente = psAsgDocentes.executeUpdate();

				// Si la eliminacion fue exitosas, confirmar la transacción
				if (iDocente > 0) {
					conn.commit();
					f = true;
					System.out.println("Asignación borrada exitosamente");
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
			System.out.println("Error Borrando asignación a docente");
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

	public boolean insertarAsignacionDocente(AsignacionDocente asg) {
		int filasAfectadas = 0;
		PreparedStatement ps = null;
		String insertarAsigSQL = "INSERT INTO asignaciondocentes(idDoc,idMat,fechIniAsigDoc,fechFinAsigDoc,"
				+ "obsAsigDoc) VALUES(?,?,?,?,?)";

		try {
			// Preparar la consulta SQL
			ps = conn.prepareStatement(insertarAsigSQL);

			// Establecer los valores de los parámetros
			ps.setInt(1, asg.getIdDoc());
			ps.setInt(2, asg.getIdMat());
			ps.setDate(3, asg.getFechIniAsigDoc());
			ps.setDate(4, asg.getFechFinAsigDoc());
			ps.setString(5, asg.getObsAsigDoc());
			System.out.println("\n\nEn funcion insertarAsignacionDocente");
			// Ejecutar la consulta
			  filasAfectadas = ps.executeUpdate();

			// Verificar si se insertó correctamente
			


		} catch (Exception e) {
			e.printStackTrace();

		}
		if (filasAfectadas > 0) {
			return true;
		} else {
			return false;
		}
		// return filasAfectadas > 0;
	}

	// modificado 20/2
	public Docente getDocenteById(int id) {
		Docente d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT u.*, d.* " +
	             "FROM usuarios u " +
	             "JOIN Docentes d ON u.idUsu = d.idDoc " +
	             "WHERE u.idUsu = ?";

		System.out.print("Estoy en getDocenteById");
		try {
			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, id);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				d = new Docente();
				d.setIdUsu(rs.getInt("idUsu")); // Esto está bien, ya que es la primera columna en tu SELECT

				// Asegúrate de que los índices de las columnas se correspondan con su posición
				// en la consulta SQL
				d.setDniUsu(rs.getString("dniUsu"));
				d.setNomCompUsu(rs.getString("nomCompUsu"));
				d.setTelUsu(rs.getString("telUsu"));
				d.setObsUsu(rs.getString("obsUsu"));
				d.setDirecUsu(rs.getString("direcUSu"));
				d.setFechNacUsu(rs.getDate("fechNacUsu"));
				d.setEmailUsu(rs.getString("emailUsu"));
				d.setPswordUsu(rs.getString("pswordUsu"));
				d.setLocalUsu(rs.getString("localUsu"));
				d.setProvUsu(rs.getString("provUsu"));
				d.setActivo(rs.getInt("activo"));
				d.setEspeDoc(rs.getString("espeDoc"));
				d.setGradAcadDoc(rs.getString("gradAcadDoc"));
				d.setFechAltaDoc(rs.getDate("fechAltaDoc"));
				d.setFechBajaDoc(rs.getDate("fechBajaDoc"));
				System.out.println(d + "resultset obtenido de Docente encontrado");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return d;
	}

	public int contarDocente() {
		int i = 0;
		try {
			String sql = "select * from Docentes";
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

	public boolean checkOldPassword(int userid, String oldPassword) {
		boolean f = false;

		try {
			String sql = "select * from Docentes where id=? and password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setString(2, oldPassword);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public boolean changePassword(int userid, String newPassword) {
		boolean f = false;

		try {
			String sql = "update Docentes set password=? where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, newPassword);
			ps.setInt(2, userid);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public boolean validarClaveUnica(int idDoc, int idMat, Date fechIniAsigDoc) {
		boolean existe = false;
		System.out.println("Doc  " + idDoc);
		System.out.println("idMAt  " + idMat);
		System.out.println("fecha inicio " + fechIniAsigDoc);

		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT 1 FROM asignaciondocentes WHERE idDoc = ?  AND idMat = ? AND DATE(fechIniAsigDoc) = DATE(?)";

		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, idDoc);
			ps.setInt(2, idMat);
			ps.setDate(3, fechIniAsigDoc); // setDate para una columna de tipo fecha

			rs = ps.executeQuery();

			if (rs.next()) {
				existe = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			existe = false;
		} finally {
			// Cerrar los recursos (ResultSet, PreparedStatement)
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return existe;
	}

}