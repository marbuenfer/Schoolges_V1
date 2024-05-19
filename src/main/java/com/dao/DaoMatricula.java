package com.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.logica.*;

/**
 * Clase DaoMatricula que contiene todos los métodos que realizan operaciones
 * con la tabla matriculaciones en la base de datos.
 * 
 * @param a El primer número a sumar.
 * @param b El segundo número a sumar.
 * @return La suma de los dos números.
 */
public class DaoMatricula {

	/**
	 * Atributo conn de tipo Connection
	 */
	private Connection conn;

	/**
	 * Constructor clase DaoMatricula con un parámetro, que se encarga de
	 * inicializar el atributo 'conn' de tipo Connection
	 */
	public DaoMatricula(Connection conn) {
		this.conn = conn;
	}

	/**
	 * Constructor clase DaoMatricula sin parámetros, que se encarga de inicializar
	 * el atributo 'conn' de tipo Connection
	 */
	public DaoMatricula() {

	}

	public List<Matricula> getMatriculasByAlumno() {
		List<Matricula> list = new ArrayList<Matricula>();
		// Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT\r\n" + "    m.idAlu,\r\n" + "    m.idMatri,\r\n" + "    u.nomCompUsu,\r\n"
				+ "    m.idEst,\r\n" + "    ed.nomEst,\r\n" + "    ma.idMat,\r\n" + "    ma.nomMat,\r\n"
				+ "    m.fechMatri,\r\n" + "    m.modMatri,\r\n" + "    m.obsMatri,\r\n" + "    u.activo,\r\n"
				+ "    ec.idCen,\r\n" + "    c.nomCen,\r\n" + "    ad.idDoc,\r\n"
				+ "    doc.nomCompUsu AS nomCompDoc\r\n" + "FROM\r\n" + "    matriculaciones m\r\n" + "JOIN\r\n"
				+ "    usuarios u ON m.idAlu = u.idUsu\r\n" + "JOIN\r\n"
				+ "    estudiosDisponibles ed ON m.idEst = ed.idEst\r\n" + "JOIN\r\n"
				+ "    materias ma ON m.idMat = ma.idMat\r\n" + "LEFT JOIN\r\n"
				+ "    estudiosEnCentro ec ON m.idEst = ec.idEst\r\n" + "LEFT JOIN\r\n"
				+ "    centros c ON ec.idCen = c.idCen\r\n" + "LEFT JOIN\r\n"
				+ "    asignacionDocentes ad ON m.idMat = ad.idMat\r\n" + "LEFT JOIN\r\n"
				+ "    usuarios doc ON ad.idDoc = doc.idUsu\r\n";
		try {
			ps = conn.prepareStatement(sql);
			boolean isResultSet = ps.execute();
			if (isResultSet) {
				rs = ps.getResultSet();

				while (rs.next()) {
					Matricula d = new Matricula();
					d.setIdMatri(rs.getInt("idMatri"));
					d.setIdAlu(rs.getInt("idAlu"));
					d.setNomCompAlu(rs.getString("nomCompUsu"));
					// d.setEmail(rs.getString("emailUsu"));
					// d.setTelefono(rs.getString("telUsu"));

					d.setIdEst(rs.getInt("idEst"));
					d.setNomEst(rs.getString("nomEst"));

					d.setIdMat(rs.getInt("idMat"));
					d.setNomMat(rs.getString("nomMat"));

					d.setIdDoc(rs.getInt("idDoc"));
					d.setNomDoc(rs.getString("nomCompDoc"));

					d.setModMatri(rs.getString("modMatri"));
					d.setFechMatri(rs.getDate("fechMatri"));
					d.setObsMatri(rs.getString("obsMatri"));

					d.setIdCen(rs.getInt("idCen"));
					d.setNomCen(rs.getString("nomCen"));

					d.setActivo(rs.getInt("activo"));
					list.add(d);
				}
			} else {
				System.out.println("No hay resultados");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<Matricula> getMatriculasByAlumno(int idAlu) {
		List<Matricula> list = new ArrayList<Matricula>();
		// Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT\r\n" + "    m.idAlu ,\r\n" + "    m.idMatri,\r\n" + "    u.nomCompUsu,\r\n"
				+ "    m.idEst,\r\n" + "    ed.nomEst,\r\n" + "    ma.idMat,\r\n" + "    ma.nomMat,\r\n"
				+ "    m.fechMatri,\r\n" + "    m.modMatri,\r\n" + "    m.obsMatri,\r\n" + "    u.activo,\r\n"
				+ "    ec.idCen,\r\n" + "    c.nomCen,\r\n" + "    ad.idDoc,\r\n"
				+ "    doc.nomCompUsu AS nomCompDoc\r\n" + "FROM\r\n" + "    matriculaciones m\r\n" + "JOIN\r\n"
				+ "    usuarios u ON m.idAlu = u.idUsu\r\n" + "JOIN\r\n"
				+ "    estudiosDisponibles ed ON m.idEst = ed.idEst\r\n" + "JOIN\r\n"
				+ "    materias ma ON m.idMat = ma.idMat\r\n" + "LEFT JOIN\r\n"
				+ "    estudiosEnCentro ec ON m.idEst = ec.idEst\r\n" + "LEFT JOIN\r\n"
				+ "    centros c ON ec.idCen = c.idCen\r\n" + "LEFT JOIN\r\n"
				+ "    asignacionDocentes ad ON m.idMat = ad.idMat\r\n" + "LEFT JOIN\r\n"
				+ "    usuarios doc ON ad.idDoc = doc.idUsu\r\n" + "WHERE\r\n" + "    m.idAlu = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAlu); // Establecer el valor del parámetro idAlu

			boolean isResultSet = ps.execute();
			if (isResultSet) {
				rs = ps.getResultSet();

				while (rs.next()) {
					Matricula d = new Matricula();
					d.setIdMatri(rs.getInt("idMatri"));
					d.setIdAlu(rs.getInt("idAlu"));
					d.setNomCompAlu(rs.getString("nomCompUsu"));
					// d.setEmail(rs.getString("emailUsu"));
					// d.setTelefono(rs.getString("telUsu"));

					d.setIdEst(rs.getInt("idEst"));
					d.setNomEst(rs.getString("nomEst"));

					d.setIdMat(rs.getInt("idMat"));
					d.setNomMat(rs.getString("nomMat"));

					d.setIdDoc(rs.getInt("idDoc"));
					d.setNomDoc(rs.getString("nomCompDoc"));

					d.setModMatri(rs.getString("modMatri"));
					d.setFechMatri(rs.getDate("fechMatri"));
					d.setObsMatri(rs.getString("obsMatri"));

					d.setIdCen(rs.getInt("idCen"));
					d.setNomCen(rs.getString("nomCen"));

					d.setActivo(rs.getInt("activo"));
					list.add(d);
				}
			} else {
				System.out.println("No hay resultados");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	public List<Matricula> getMatriculasByAlumnoRolAlumno(int idAlu) {
		List<Matricula> list = new ArrayList<Matricula>();
		// Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT\r\n"
				+ "    m.idMatri,\r\n"
				+ "    m.idEst,\r\n"
				+ "    ed.nomEst,\r\n"
				+ "    m.idMat,\r\n"
				+ "    ma.nomMat,\r\n"
				+ "    m.fechMatri,\r\n"
				+ "    m.modMatri\r\n"
				+ "FROM\r\n"
				+ "    matriculaciones m\r\n"
				+ "JOIN\r\n"
				+ "    estudiosDisponibles ed ON m.idEst = ed.idEst\r\n"
				+ "JOIN\r\n"
				+ "    materias ma ON m.idMat = ma.idMat\r\n"
				+ "WHERE\r\n"
				+ "    m.idAlu = ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAlu); // Establecer el valor del parámetro idAlu
			//ps.setInt(2, idEst); // Establecer el valor del parámetro idEst

			boolean isResultSet = ps.execute();
			if (isResultSet) {
				rs = ps.getResultSet();

				while (rs.next()) {
					Matricula d = new Matricula();
					d.setIdMatri(rs.getInt("idMatri"));
//					d.setIdAlu(rs.getInt("idAlu"));
//					d.setNomCompAlu(rs.getString("nomCompUsu"));
					// d.setEmail(rs.getString("emailUsu"));
					// d.setTelefono(rs.getString("telUsu"));

					d.setIdEst(rs.getInt("idEst"));
					d.setNomEst(rs.getString("nomEst"));

					d.setIdMat(rs.getInt("idMat"));
					d.setNomMat(rs.getString("nomMat"));

					//d.setIdDoc(rs.getInt("idDoc"));
					//d.setNomDoc(rs.getString("nomCompDoc"));

					d.setModMatri(rs.getString("modMatri"));
					d.setFechMatri(rs.getDate("fechMatri"));
					//d.setObsMatri(rs.getString("obsMatri"));

//					d.setIdCen(rs.getInt("idCen"));
//					d.setNomCen(rs.getString("nomCen"));

//					d.setActivo(rs.getInt("activo"));
					list.add(d);
				}
			} else {
				System.out.println("No hay resultados");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public List<Matricula> getMatriculasByAlumnoRolAlumno(int idAlu, int idEst) {
		List<Matricula> list = new ArrayList<Matricula>();
		// Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT\r\n"
				+ "    m.idMatri,\r\n"
				+ "    m.idEst,\r\n"
				+ "    ed.nomEst,\r\n"
				+ "    m.idMat,\r\n"
				+ "    ma.nomMat,\r\n"
				+ "    m.fechMatri,\r\n"
				+ "    m.modMatri\r\n"
				+ "FROM\r\n"
				+ "    matriculaciones m\r\n"
				+ "JOIN\r\n"
				+ "    estudiosDisponibles ed ON m.idEst = ed.idEst\r\n"
				+ "JOIN\r\n"
				+ "    materias ma ON m.idMat = ma.idMat\r\n"
				+ "WHERE\r\n"
				+ "    m.idAlu = ? and m.idEst = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAlu); // Establecer el valor del parámetro idAlu
			ps.setInt(2, idEst); // Establecer el valor del parámetro idEst

			boolean isResultSet = ps.execute();
			if (isResultSet) {
				rs = ps.getResultSet();

				while (rs.next()) {
					Matricula d = new Matricula();
					d.setIdMatri(rs.getInt("idMatri"));
//					d.setIdAlu(rs.getInt("idAlu"));
//					d.setNomCompAlu(rs.getString("nomCompUsu"));
					// d.setEmail(rs.getString("emailUsu"));
					// d.setTelefono(rs.getString("telUsu"));

					d.setIdEst(rs.getInt("idEst"));
					d.setNomEst(rs.getString("nomEst"));

					d.setIdMat(rs.getInt("idMat"));
					d.setNomMat(rs.getString("nomMat"));

					//d.setIdDoc(rs.getInt("idDoc"));
					//d.setNomDoc(rs.getString("nomCompDoc"));

					d.setModMatri(rs.getString("modMatri"));
					d.setFechMatri(rs.getDate("fechMatri"));
					//d.setObsMatri(rs.getString("obsMatri"));

//					d.setIdCen(rs.getInt("idCen"));
//					d.setNomCen(rs.getString("nomCen"));

//					d.setActivo(rs.getInt("activo"));
					list.add(d);
				}
			} else {
				System.out.println("No hay resultados");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	/**
	 * Recupera una lista de matrículas de estudios distintos en los que un alumno está matriculado.
	 * @param idAlu El ID del alumno del que se desean obtener los estudios matriculados.
	 * @return Una lista de objetos Matricula, cada uno representando un estudio distinto en el que el alumno está matriculado.
	 */
	public List<Matricula> getEstudiosMatriculadosByAlumnoRolAlumnoDistinct(int idAlu) {
		List<Matricula> list = new ArrayList<Matricula>();
		// Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT DISTINCT\r\n"
				+ "    m.idEst,\r\n"
				+ "    ed.nomEst   \r\n"
				+ "FROM\r\n"
				+ "    matriculaciones m\r\n"
				+ "JOIN\r\n"
				+ "    estudiosDisponibles ed ON m.idEst = ed.idEst\r\n"
				+ "WHERE\r\n"
				+ "    m.idAlu = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAlu); // Establecer el valor del parámetro idAlu

			boolean isResultSet = ps.execute();
			if (isResultSet) {
				rs = ps.getResultSet();

				while (rs.next()) {
					Matricula d = new Matricula();
					
					d.setIdEst(rs.getInt("idEst"));
					d.setNomEst(rs.getString("nomEst"));
					list.add(d);
				}
			} else {
				System.out.println("No hay resultados");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	/**
	 * método getAllMatriculas(), que se encarga de devolver un ArrayList de objetos
	 * de tipo Matricula con todos los registros que existen en la tabla Matriculas
	 * 
	 * @return Lista de tipo ArrayList de objetos Matricula .
	 */

	public Matricula getMatriculaByAlumno(int idAlu, int idMatri) {
		Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT\r\n" + "    m.idAlu ,\r\n" + "    m.idMatri,\r\n" + "    u.nomCompUsu,\r\n"
				+ "    m.idEst,\r\n" + "    ed.nomEst,\r\n" + "    ma.idMat,\r\n" + "    ma.nomMat,\r\n"
				+ "    m.fechMatri,\r\n" + "    m.modMatri,\r\n" + "    m.obsMatri,\r\n" + "    u.activo,\r\n"
				+ "    ec.idCen,\r\n" + "    c.nomCen,\r\n" + "    ad.idDoc,\r\n"
				+ "    doc.nomCompUsu AS nomCompDoc\r\n" + "FROM\r\n" + "    matriculaciones m\r\n" + "JOIN\r\n"
				+ "    usuarios u ON m.idAlu = u.idUsu\r\n" + "JOIN\r\n"
				+ "    estudiosDisponibles ed ON m.idEst = ed.idEst\r\n" + "JOIN\r\n"
				+ "    materias ma ON m.idMat = ma.idMat\r\n" + "LEFT JOIN\r\n"
				+ "    estudiosEnCentro ec ON m.idEst = ec.idEst\r\n" + "LEFT JOIN\r\n"
				+ "    centros c ON ec.idCen = c.idCen\r\n" + "LEFT JOIN\r\n"
				+ "    asignacionDocentes ad ON m.idMat = ad.idMat\r\n" + "LEFT JOIN\r\n"
				+ "    usuarios doc ON ad.idDoc = doc.idUsu\r\n" + "WHERE\r\n" + "    m.idAlu = ? and m.idMatri = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAlu); // Establecer el valor del parámetro idAlu
			ps.setInt(2, idMatri);

			boolean isResultSet = ps.execute();
			if (isResultSet) {
				rs = ps.getResultSet();

				while (rs.next()) {
					 d = new Matricula();
					d.setIdMatri(rs.getInt("idMatri"));
					d.setIdAlu(rs.getInt("idAlu"));
					// d.setNomCompAlu(rs.getString("nomCompUsu"));
					// d.setEmail(rs.getString("emailUsu"));
					// d.setTelefono(rs.getString("telUsu"));

					d.setIdEst(rs.getInt("idEst"));
					d.setNomEst(rs.getString("nomEst"));

					d.setIdMat(rs.getInt("idMat"));
					d.setNomMat(rs.getString("nomMat"));

					// d.setIdDoc(rs.getInt("idDoc"));
					// d.setNomDoc(rs.getString("nomCompDoc"));

					d.setModMatri(rs.getString("modMatri"));
					d.setFechMatri(rs.getDate("fechMatri"));
					d.setObsMatri(rs.getString("obsMatri"));

					// d.setIdCen(rs.getInt("idCen"));
					// d.setNomCen(rs.getString("nomCen"));

					d.setActivo(rs.getInt("activo"));

				}
			} else {
				System.out.println("No hay resultados");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return d;
	}

	/**
	 * método getAllMatriculas(), que se encarga de devolver un ArrayList de objetos
	 * de tipo Matricula con todos los registros que existen en la tabla Matriculas
	 * 
	 * @return Lista de tipo ArrayList de objetos Matricula .
	 */

	public List<Matricula> getAllMatriculas() {
		List<Matricula> list = new ArrayList<Matricula>();
		// Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT DISTINCT m.*, u.nomCompUsu, u.activo , ed.nomEst, ma.nomMat, c.nomCen, ad.idDoc, c.idCen, uad.nomCompUsu AS nomCompUsuAsignado, ad.obsAsigDoc\r\n"
				+ "FROM matriculaciones m\r\n"
				+ "JOIN usuarios u ON m.idAlu = u.idUsu\r\n"
				+ "JOIN estudiosDisponibles ed ON m.idEst = ed.idEst\r\n"
				+ "JOIN materias ma ON m.idMat = ma.idMat\r\n"
				+ "LEFT JOIN estudiosEnCentro ec ON m.idEst = ec.idEst\r\n"
				+ "LEFT JOIN centros c ON ec.idCen = c.idCen\r\n"
				+ "LEFT JOIN asignacionDocentes ad ON m.idMat = ad.idMat\r\n"
				+ "LEFT JOIN usuarios uad ON ad.idDoc = uad.idUsu;\r\n"
				+ "\r\n"
				+ "";

		System.out.println(sql + "estoy dentro de getAllMatriculas");

		try {
			ps = conn.prepareStatement(sql);
			boolean isResultSet = ps.execute();
			if (isResultSet) {
				rs = ps.getResultSet();

				while (rs.next()) {
					Matricula d = new Matricula();
					d.setIdMatri(rs.getInt("idMatri"));
					d.setIdAlu(rs.getInt("idAlu"));
					d.setNomCompAlu(rs.getString("nomCompUsu"));
					// d.setEmail(rs.getString("emailUsu"));
					// d.setTelefono(rs.getString("telUsu"));

					d.setIdEst(rs.getInt("idEst"));
					d.setNomEst(rs.getString("nomEst"));

					d.setIdMat(rs.getInt("idMat"));
					d.setNomMat(rs.getString("nomMat"));

					d.setIdDoc(rs.getInt("idDoc"));
					d.setNomDoc(rs.getString("nomCompUsuAsignado"));

					d.setModMatri(rs.getString("modMatri"));
					d.setFechMatri(rs.getDate("fechMatri"));
					d.setObsMatri(rs.getString("obsMatri"));

					d.setIdCen(rs.getInt("idCen"));
					d.setNomCen(rs.getString("nomCen"));

					d.setActivo(rs.getInt("activo"));
					list.add(d);
				}
			} else {
				System.out.println("No hay resultados");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	/**
	 * método getMatriculaByIdMatri(int idMatri), que se encarga de devolver un
	 * objeto Matricula con información obtenida de la tabla matriculaciones y de
	 * tablas relacionadas y que coincide con el idMatri (id matricula) recibido
	 * 
	 * @param idMatri id identificativo único de matricula registrada en tabla
	 *                matriculaciones.
	 * @return d, objeto de tipo Matricula, con información relacionada respecto a
	 *         la matricula almacenada.
	 */
	public Matricula getMatriculaByIdMatri(int idMatri) {
		Matricula d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT ma.idMatri, ma.idAlu, ua.nomCompUsu AS nomCompAlu, ua.emailUsu, "
				+ " ua.telUsu, ad.idDoc, ud.nomCompUsu AS nomCompDoc, ua.activo, ma.idEst, "
				+ " e.nomEst, ma.fechMatri, ma.modMatri, ma.obsMatri, ec.idCen, c.nomCen AS nomCentro "
				+ " FROM matriculaciones ma JOIN usuarios ua ON ma.idAlu = ua.idUsu JOIN alumnos a "
				+ " ON ma.idAlu = a.idAlu JOIN estudiosDisponibles e ON ma.idEst = e.idEst "
				+ " LEFT JOIN asignacionDocentes ad ON ma.idEst = ad.idEst "
				+ " LEFT JOIN usuarios ud ON ad.idDoc = ud.idUsu LEFT JOIN estudiosEnCentro ec ON e.idEst = ec.idEst "
				+ " LEFT JOIN centros c ON ec.idCen = c.idCen WHERE ma.idMatri = ?  ;";

		System.out.print("Estoy en getMatriculaByIdAluIdEstFechMatri");
		try {
			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, idMatri);

			// Ejecutar la consulta
			rs = ps.executeQuery();
			int rowCount = 0;
			while (rs.next()) {
				rowCount++;
				d = new Matricula();
				d.setIdMatri(rs.getInt("idMatri"));
				d.setIdAlu(rs.getInt("idAlu"));

				d.setNomCompAlu(rs.getString("nomCompAlu"));
				d.setEmail(rs.getString("emailUsu"));
				d.setTelefono(rs.getString("telUsu"));

				d.setActivo(rs.getInt("activo"));
				d.setIdEst(rs.getInt("idEst"));
				d.setNomEst(rs.getString("nomEst"));

				d.setFechMatri(rs.getDate("fechMatri"));

				d.setModMatri(rs.getString("modMatri"));
				d.setIdCen(rs.getInt("idCen"));
				d.setNomCen(rs.getString("nomCentro"));
				d.setObsMatri(rs.getString("obsMatri"));
				System.out.println(d + "\n*****ResultSet obtenido de matricula por clave,");
			}
			System.out.println("\nNúmero de filas devueltas: " + rowCount);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return d;

	}

	/**
	 * método insertarMatricula(Matricula matri), que se encarga de devolver un
	 * boolean que indica si la operación de insertar una matricula en la tabla
	 * matriculaciones ha sido éxito o fracaso
	 * 
	 * @param matricula objeto de tipo Matricula con la información a insertar en
	 *                  tabla matriculaciones.
	 * @return false o true, si ha habido fracaso o éxito respectivamente.
	 */
//	public boolean insertarMatricula(Matricula matri) {
//
//		PreparedStatement ps = null;
//		String insertarMatriSQL = "INSERT INTO matriculaciones(idAlu,idEst,idMat,fechMatri,modMatri,"
//				+ "obsMatri) VALUES(?,?,?,?,?,?)";
//
//		try {
//			// Preparar la consulta SQL
//			ps = conn.prepareStatement(insertarMatriSQL);
//
//			// Establecer los valores de los parámetros
//			ps.setInt(1, matri.getIdAlu());
//			ps.setInt(2, matri.getIdEst());
//			ps.setInt(3, matri.getIdMat());
//			ps.setDate(4, matri.getFechMatri());
//			ps.setString(5, matri.getModMatri());
//			ps.setString(6, matri.getObsMatri());
//
//			// Ejecutar la consulta
//			int filasAfectadas = ps.executeUpdate();
//
//			// Verificar si se insertó correctamente
//			if(filasAfectadas>0) {
//				return true;
//			}else {
//				return false;
//			}
//			//return filasAfectadas > 0;
//			
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//			// Manejar cualquier excepción de SQL aquí
//			return false;
//		} finally {
//			// Cerrar recursos
//			if (ps != null) {
//				try {
//					ps.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			}
//		}
//	}

	public boolean insertarMatricula(Matricula matricula) {

		PreparedStatement ps = null;
		String insertarMatriSQL = "INSERT INTO matriculaciones(idAlu,idEst,idMat,fechMatri,modMatri,"
				+ "obsMatri) VALUES(?,?,?,?,?,?)";

		try {
			// Preparar la consulta SQL
			ps = conn.prepareStatement(insertarMatriSQL);

			// Establecer los valores de los parámetros
			ps.setInt(1, matricula.getIdAlu());
			ps.setInt(2, matricula.getIdEst());
			ps.setInt(3, matricula.getIdMat());
			ps.setDate(4, matricula.getFechMatri());
			ps.setString(5, matricula.getModMatri());
			ps.setString(6, matricula.getObsMatri());

			// Ejecutar la consulta
			int filasAfectadas = ps.executeUpdate();

			// Verificar si se insertó correctamente
			if (filasAfectadas > 0) {
				return true;
			} else {
				return false;
			}
			// return filasAfectadas > 0;

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

	public boolean actualizarMatricula(Matricula matri) {
		PreparedStatement ps = null;
		String actualizarMatriSQL = "UPDATE matriculaciones SET idAlu=?, idEst=?, idMat=?, fechMatri=?, modMatri=?, obsMatri=? WHERE idMatri=?";

		try {
			// Preparar la consulta SQL
			ps = conn.prepareStatement(actualizarMatriSQL);

			// Establecer los valores de los parámetros
			ps.setInt(1, matri.getIdAlu());
			ps.setInt(2, matri.getIdEst());
			ps.setInt(3, matri.getIdMat());
			ps.setDate(4, matri.getFechMatri());
			ps.setString(5, matri.getModMatri());
			ps.setString(6, matri.getObsMatri());
			ps.setInt(7, matri.getIdMatri());

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

	/**
	 * método validarClaveUnica(int idAlu, int idEst, int idMat, Date fechMatri),
	 * que se encarga de devolver un boolean que indica si la existe la clave única
	 * compuesta por (idAlu, idEst, idMat y fechMatri) En caso de devolver true, la
	 * clave compuesta existe y no se puede insertar dicha matricula. En caso de
	 * devolver false, la clave compuesta no existe y si se puede insertar dicha
	 * matricula.
	 * 
	 * @param idAlu,     id identificativo del alumno a matricular
	 * @param idEst,     id identificativo del estudio a matricular para el alumno
	 * @param idMat,     id identificativo de la materia a matricular para el alumno
	 * @param fechMatri, fecha en la que se realiza la matricula.
	 * @return existe, variable booleana que será true o false en caso de éxito o
	 *         fracaso respectivamente.
	 */
	public boolean validarClaveUnica(int idAlu, int idEst, int idMat, Date fechMatri) {
		boolean existe = false;
		System.out.println("Alu  " + idAlu);
		System.out.println("idEst   " + idEst);
		System.out.println("idMAt  " + idMat);
		System.out.println("fecha matri " + fechMatri);

		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT 1 FROM matriculaciones WHERE idAlu = ? AND idEst = ? AND idMat = ? AND DATE(fechMatri) = DATE(?)";

		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, idAlu);
			ps.setInt(2, idEst);
			ps.setInt(3, idMat);
			ps.setDate(4, fechMatri); // setDate para una columna de tipo fecha

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
