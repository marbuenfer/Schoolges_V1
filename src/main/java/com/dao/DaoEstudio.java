package com.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import com.logica.Estudio;
import com.logica.MateriaEnEstudio;

public class DaoEstudio {
	private Connection conn;

	public DaoEstudio() {

	}

	public DaoEstudio(Connection conn) {
		super();
		this.conn = conn;
	}

//	public Estudio getCentroById(int id) {
//		PreparedStatement ps = null;
//		ResultSet rs = null;
//		String sql = "SELECT * FROM estudiosdisponibles WHERE idEst = ?";
//		System.out.println(sql + "estoy dentro de getCentroById");
//		Estudio est = null;
//
//		try {
//			ps = conn.prepareStatement(sql);
//			ps.setInt(1, id); // Establecer el valor del parámetro id
//			rs = ps.executeQuery();
//			while (rs.next()) {
//				est = new Estudio();
//				est.setIdEst(rs.getInt(1));
//				est.setNomEst(rs.getString(2));
//				est.setEspeEst(rs.getString(3));
//				est.setHoraEst(rs.getInt(4));
//				est.setObsEst(rs.getString(5));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// Cerrar recursos (ResultSet, PreparedStatement) aquí si es necesario
//		}
//		return est;
//	}

	public Estudio getEstudioById(int id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM estudiosdisponibles WHERE idEst = ?";
		System.out.println(sql + "estoy dentro de getEstudioById");
		Estudio est = null;

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id); // Establecer el valor del parámetro id
			rs = ps.executeQuery();
			while (rs.next()) {
				est = new Estudio();
				est.setIdEst(rs.getInt(1));
				est.setNomEst(rs.getString(2));
				est.setEspeEst(rs.getString(3));
				est.setHoraEst(rs.getInt(4));
				est.setObsEst(rs.getString(5));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// Cerrar recursos (ResultSet, PreparedStatement) aquí si es necesario
		}
		return est;
	}

	public List<Estudio> getAllEstudios() {
		List<Estudio> list = new ArrayList<Estudio>();
		Estudio est = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT * FROM estudiosdisponibles ";
		System.out.println(sql + "estoy dentro de getAllEstudios");

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				est = new Estudio();
				est.setIdEst(rs.getInt(1));
				est.setNomEst(rs.getString(2));
				est.setEspeEst(rs.getString(3));
				est.setHoraEst(rs.getInt(4));

				est.setObsEst(rs.getString(5));
				list.add(est);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;
	}

	/*
	 * Devuelve el estudio correspondiente a una materia
	 */
	public Estudio getEstudioByMateria(String idMat) {
		Estudio d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT med.idEst, ed.nomEst\r\n" + "FROM materiasenestudios med\r\n"
				+ "JOIN estudiosDisponibles ed ON med.idEst = ed.idEst\r\n" + "WHERE med.idMat = ?;";
		try {

			ps = conn.prepareStatement(sql);

			ps.setString(1, idMat);

			rs = ps.executeQuery();

			while (rs.next()) {
				d = new Estudio();
				d.setIdEst(rs.getInt("idEst"));
				d.setNomEst(rs.getString("nomEst"));

			}
			// System.out.println(materias.toString());

		} catch (Exception e) {
			e.printStackTrace(); // Manejo adecuado de la excepción en tu aplicación
		}

		return d;
	}

	public List<MateriaEnEstudio> getAllAsignacionesMateriaEstudios() {
		List<MateriaEnEstudio> list = new ArrayList<MateriaEnEstudio>();
		MateriaEnEstudio matEnEst = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT me.idEst, e.nomEst, me.idMat, m.nomMat, me.obsMatEst\r\n"
				+ "FROM materiasEnEstudios me\r\n" + "JOIN estudiosDisponibles e ON me.idEst = e.idEst\r\n"
				+ "JOIN materias m ON me.idMat = m.idMat;\r\n" + "";
		System.out.println(sql + "estoy dentro de getAllAsignacionesMateriaEstudios");

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				matEnEst = new MateriaEnEstudio();
				matEnEst.setIdEst(rs.getInt(1));
				matEnEst.setNomEst(rs.getString(2));
				matEnEst.setIdMat(rs.getInt(3));
				matEnEst.setNomMat(rs.getString(4));

				matEnEst.setObsMatEst(rs.getString(5));
				list.add(matEnEst);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;
	}

	public List<MateriaEnEstudio> getAllAsignacionesMateriaEstudio(int idEst) {
		List<MateriaEnEstudio> list = new ArrayList<MateriaEnEstudio>();
		MateriaEnEstudio matEnEst = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT me.idEst, e.nomEst, me.idMat, m.nomMat, me.obsMatEst " + "FROM materiasEnEstudios me "
				+ "JOIN estudiosDisponibles e ON me.idEst = e.idEst " + "JOIN materias m ON me.idMat = m.idMat "
				+ "WHERE me.idEst = ?";
		System.out.println(sql + "estoy dentro de getAllAsignacionesMateriaEstudios");

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEst); // Establecer el parámetro idEst en la consulta
			rs = ps.executeQuery();
			while (rs.next()) {
				matEnEst = new MateriaEnEstudio();
				matEnEst.setIdEst(rs.getInt(1));
				matEnEst.setNomEst(rs.getString(2));
				matEnEst.setIdMat(rs.getInt(3));
				matEnEst.setNomMat(rs.getString(4));
				matEnEst.setObsMatEst(rs.getString(5));
				list.add(matEnEst);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;
	}
	public MateriaEnEstudio getAsignacionMateriaYEstudio(int idEst, int idMat) {
		MateriaEnEstudio asig = new  MateriaEnEstudio() ;
		//MateriaEnEstudio matEnEst = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT me.idEst, e.nomEst, me.idMat, m.nomMat, me.obsMatEst " + "FROM materiasEnEstudios me "
				+ "JOIN estudiosDisponibles e ON me.idEst = e.idEst " + "JOIN materias m ON me.idMat = m.idMat "
				+ "WHERE me.idEst = ? and idMat = ? ";
 		System.out.println(sql + "estoy dentro de getAsignacionMateriaYEstudio");

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEst); // Establecer el parámetro idEst en la consulta
			ps.setInt(1, idMat); // Establecer el parámetro idMat en la consulta
			rs = ps.executeQuery();
			while (rs.next()) {
				asig = new MateriaEnEstudio();
				asig.setIdEst(rs.getInt(1));
				asig.setNomEst(rs.getString(2));
				asig.setIdMat(rs.getInt(3));
				asig.setNomMat(rs.getString(4));
				asig.setObsMatEst(rs.getString(5));	 
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return asig;
	}
	// Método para verificar si existe una asignación con los ID de Estudio y
	// Materia dados
	public boolean existeAsignacion(int idEst, int idMat) {
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT COUNT(*) FROM materiasEnEstudios WHERE idEst = ? AND idMat = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEst);
			ps.setInt(2, idMat);

			rs = ps.executeQuery();
			if (rs.next()) {
				/*
				 * La línea int count = resultSet.getInt(1); obtiene el valor de la primera
				 * columna del resultado de la consulta SQL en la posición actual del cursor del
				 * ResultSet. En este caso, como la consulta SQL usa COUNT(*), el resultado
				 * devuelto será un solo valor que representa el número de filas que cumplen con
				 * la condición de la consulta.
				 */
				int count = rs.getInt(1);
				if(count>0) {
					//existe asignacion
					return true ;
				}else {
					//no existe asignacion
					return false;
				}
				//return count > 0; // Devuelve true si existe al menos una asignación
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return true; // En caso de error, asumimos que existe la asignación
	}

	public boolean insertarEstudioDao(Estudio est) {
		boolean f = false;
		int iEstudio;
		String insertarEstudioSQL = "INSERT INTO estudiosdisponibles(nomEst,espeEst,horaEst,obsEst) VALUES(?,?,?,?)";

		try {
			PreparedStatement ps = conn.prepareStatement(insertarEstudioSQL);

			ps.setString(1, est.getNomEst());
			ps.setString(2, est.getEspeEst());
			ps.setInt(3, est.getHoraEst());
			ps.setString(4, est.getObsEst());

			iEstudio = ps.executeUpdate();
			if (iEstudio > 0) {
				f = true;
				System.out.println("Estudio insertado exitosamente");
			} else {
				f = false;
				System.out.println("Estudio no ha sido insertado");
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción

			e.printStackTrace();
			System.out.println("Error insertando esttro");
		}

		return f;
	}

	public boolean actualizarEstudioDao(Estudio est) {
		boolean f = false;
		int iEstudio;
		String insertarEstudioSQL = "UPDATE estudiosdisponibles SET nomEst = ?, espeEst = ?, horaEst = ?, obsEst = ? WHERE idEst = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(insertarEstudioSQL);

			ps.setString(1, est.getNomEst());
			ps.setString(2, est.getEspeEst());
			ps.setInt(3, est.getHoraEst());
			ps.setString(4, est.getObsEst());
			ps.setInt(5, est.getIdEst()); // Establecer el valor del parámetro idEst

			iEstudio = ps.executeUpdate();
			if (iEstudio > 0) {
				f = true;
				System.out.println("Estudio actualizado exitosamente");
			} else {
				f = false;
				System.out.println("Estudio no ha sido actualizado");
			}
		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción
			e.printStackTrace();
			System.out.println("Error actualizando estudio");
		}
		return f;
	}

	public boolean insertarMateriasEnEstudios(MateriaEnEstudio matEnEst) {
		boolean f = false;
		int iEstudio;
		String insertarEstudioSQL = "INSERT INTO materiasenestudios(idEst,idMat,obsMatEst) VALUES(?,?,?)";
		System.out.print("objeto pasado por parametro. "  + matEnEst.toString() );

		try {
			PreparedStatement ps = conn.prepareStatement(insertarEstudioSQL);

			ps.setInt(1, matEnEst.getIdEst());
			ps.setInt(2, matEnEst.getIdMat());

			ps.setString(3, matEnEst.getObsMatEst());

			iEstudio = ps.executeUpdate();
			System.out.print("EStoy dentro de insertarMateriasEnEstudios..valor de iEstudio  " + iEstudio);
			if (iEstudio > 0) {
				f = true;
				System.out.println("Estudio insertado exitosamente");
			} else {
				f = false;
				System.out.println("Estudio no ha sido insertado");
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción

			e.printStackTrace();
			System.out.println("Error insertando registro");
		}

		return f;
	}
	
	public boolean actualizarMateriaEnEstudio(int idEst, int idMat, String obsMatEst) {
		
        System.out.println("valores pasados por parametro a actualizarMAteriaEnEstudio, idEst, idMat e obsMatEst" + idEst + "," + idMat  + "," + obsMatEst);

	    boolean f = false;
	    int rowsAffected;
	    String updateStatement = "UPDATE materiasenestudios SET obsMatEst = ? WHERE idEst = ? AND idMat = ?";

	    try {
	        PreparedStatement ps = conn.prepareStatement(updateStatement);
	        ps.setString(1, obsMatEst);
	        ps.setInt(2, idEst);
	        ps.setInt(3, idMat);

	        rowsAffected = ps.executeUpdate();
	        if (rowsAffected > 0) {
	            f = true;
	            System.out.println("Asignación de materia a estudio actualizada exitosamente");
	        } else {
	            f = false;
	            System.out.println("No se encontró ninguna asignación de materia a estudio para actualizar");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("Error al actualizar la asignación de materia a estudio");
	    }

	    return f;
	}

	public boolean borrarEstudio(int idEst) {
		boolean f = false;
		 String message = "";
		String sqlEstudios = "DELETE FROM estudiosdisponibles WHERE idEst = ?";
		try {
			PreparedStatement psEstudios = conn.prepareStatement(sqlEstudios);
			psEstudios.setInt(1, idEst);
			int iEstudio = psEstudios.executeUpdate();
			if (iEstudio > 0) {
				f = true;
				System.out.println("Estudio borrado exitosamente");
			} else {
				f = false;
				System.out.println("No se puede borrar el estudio");
			}
		} catch (SQLIntegrityConstraintViolationException e) {
			// Manejar la excepción específica de violación de integridad de la SQL
			e.printStackTrace();
			 message = "No se puede borrar el estudio debido a restricciones de integridad de la base de datos";
			System.out
					.println("No se puede borrar el estudio debido a restricciones de integridad de la base de datos");
		} catch (SQLException e) {
			// Manejar otras excepciones SQL
			e.printStackTrace();
			System.out.println("Error borrando estudio");
		}
		return f;
	}
	public boolean borrarMateriaEnEstudio(int idEst, int idMat) {
		boolean f = false;

		String sqlMateriasEnEstudios = "DELETE FROM materiasenestudios WHERE idEst = ? and idMat = ?";
		try {
			PreparedStatement psMateriasEnEstudios = conn.prepareStatement(sqlMateriasEnEstudios);
			psMateriasEnEstudios.setInt(1, idEst);
			psMateriasEnEstudios.setInt(2, idMat);
			int iMatEnEst = psMateriasEnEstudios.executeUpdate();
			if (iMatEnEst > 0) {
				f = true;
				System.out.println("asignación materia a estudio borrada exitosamente");
			} else {
				f = false;
				System.out.println("No se puede borrar la asignación de materia a estudio");
			}
		} catch (SQLIntegrityConstraintViolationException e) {
			// Manejar la excepción específica de violación de integridad de la SQL
			e.printStackTrace();
			System.out
					.println("No se puede borrar la asignación de materia a estudio debido a restricciones de integridad de la base de datos");
		} catch (SQLException e) {
			// Manejar otras excepciones SQL
			e.printStackTrace();
			System.out.println("Error borrando la asignación de materia a estudio");
		}
		return f;
	}

}
