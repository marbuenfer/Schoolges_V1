package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import com.logica.Actividad;
import com.logica.ActividadAlumno;
import com.logica.Materia;
import com.logica.MateriaEnEstudio;

public class DaoMateria {
	private Connection conn;

	public DaoMateria() {

	}

	public DaoMateria(Connection conn) {
		this.conn = conn;
	}

	/**
	 * Obtiene todas las materias de la base de datos.
	 *
	 * @return Una lista de objetos Materia que representan todas las materias almacenadas en la base de datos.
	 */

	public List<Materia> getAllMateria() {
		List<Materia> list = new ArrayList<Materia>();
		Materia d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT * FROM materias ORDER BY nomMat ASC ";
		System.out.println(sql + "estoy dentro de getAllMaterias"   );

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
	            d = new Materia();
				d.setIdMat(rs.getInt(1));
				d.setNomMat(rs.getString(2));
				d.setHorasMat(rs.getInt(3));
				d.setObsMat(rs.getString(4)); 
				list.add(d);
			}

		} catch (Exception e) {
			 e.printStackTrace();;
		} 
		return list;
	}
	
	/**
	 * Obtiene una materia por su ID.
	 *
	 * @param idMat El ID de la materia que se desea obtener.
	 * @return Un objeto Materia que representa la materia con el ID especificado, o null si no se encuentra ninguna materia con ese ID.
	 */

	public Materia getMateriaById(int idMat) {
		Materia d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM materias WHERE idMat = ?";

		System.out.print("Estoy en getMateriaById");
		try {
			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, idMat);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				d = new Materia();
				d.setIdMat(rs.getInt(1));
				d.setNomMat(rs.getString(2));
				d.setHorasMat(rs.getInt(3));
				d.setObsMat(rs.getString(4));
				System.out.println(d + "resultset obtenido de materia encontrada");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return d;
	}
	/**
	 * Obtiene una materia por su ID.
	 *
	 * @param idAct El ID de la actividad que se desea obtener.
	 * @return Un objeto Materia que representa la materia con el ID especificado, o null si no se encuentra ninguna materia con ese ID.
	 */

	public Actividad  getActividadById(int idAct) {
		Actividad  d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT a.*, m.nomMat " +
	             "FROM actividades a " +
	             "JOIN materias m ON a.idMat = m.idMat " +
	             "WHERE a.idAct = ?";


		System.out.print("Estoy en getActividadById");
		try {
			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, idAct);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				d = new Actividad();
				d.setIdAct(rs.getInt(1));
			//	d.setIdMat(rs.getInt(2));
			//	d.setNotaAct(rs.getInt(2));
				d.setEnuAct(rs.getString(3));
				d.setObsAct(rs.getString(4));
				d.setNomMat(rs.getString(5));
				System.out.println(d + "resultset obtenido de actividad encontrada");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return d;
	}
	/**
	 * Obtiene todas las materias matriculadas por un estudiante en un estudio específico.
	 *
	 * @param idAlu El ID del estudiante para el cual se desean obtener las materias matriculadas.
	 * @param idEst El ID del estudio al que pertenecen las materias.
	 * @return Una lista de objetos Materia que representan las materias matriculadas por el estudiante en el estudio especificado, o una lista vacía si no hay materias matriculadas.
	 */

	public List<Materia> getMateriasEnMatricula(int idAlu, int idEst) {
		List<Materia> materias = new ArrayList<>();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT m.idMat, m.nomMat, m.horasMat " + "FROM materias m "
					+ "JOIN matriculaciones ma ON m.idMat = ma.idMat " + "WHERE ma.idAlu = ? AND ma.idEst = ?";

			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, idAlu);
			ps.setInt(2, idEst);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				int idMat = rs.getInt("idMat");
				String nomMat = rs.getString("nomMat");
				int horasMat = rs.getInt("horasMat");
				String obsMat = rs.getString("obsMat");
				Materia materia = new Materia(idMat, nomMat, horasMat,obsMat);
				materias.add(materia);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// Manejar la excepción según sea necesario

		}
		return materias;
	}
	
	
	
	/**
	 * Obtiene una materia por su nombre.
	 *
	 * @param nomMat El nombre de la materia que se desea obtener.
	 * @return Un objeto Materia que representa la materia encontrada, o null si no se encuentra.
	 */

	public Materia getMateriaByNom(String nomMat) {
		Materia d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM materias WHERE nomMat = ?";

		System.out.print("Estoy en getMateriaByNom para materia");
		try {
			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setString(1, nomMat);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				d = new Materia();
				d.setIdMat(rs.getInt(1));
				d.setNomMat(rs.getString(2));
				d.setHorasMat(rs.getInt(3));

				System.out.println(d + "resultset obtenido de materia encontrado");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return d;
	}
	
	/**
	 * Obtiene el nombre de una materia por su id
	 *
	 * @param idMat id identificativo de la materia cuyo nombre  se desea obtener.
	 * @return Un String con el nombre de la materia  o null si no se encuentra.
	 */

	public String getNombreByIdMateria(int idMat) {
		//Materia d = null;
		String nomMat = "";		
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT nomMat FROM materias WHERE idMat = ?";

		System.out.print("Estoy en getNombreByIdMateria para materia");
		try {
			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, idMat);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				nomMat = rs.getString(1);

				System.out.println( "nombre de materia obtenido  " + nomMat );
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return nomMat;
	}
	/**
	 * Obtiene todas las materias asociadas a un estudio específico.
	 *
	 * @param idEst El ID del estudio del cual se desean obtener las materias.
	 * @return Una lista de objetos MateriaEnEstudio que representan las materias asociadas al estudio.
	 */


	public List<MateriaEnEstudio> getMateriasByEstudio(int idEst) {
		List<MateriaEnEstudio> materias = new ArrayList<>();
		MateriaEnEstudio d = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT ME.*, M.* \r\n"
				+ "FROM MateriasEnEstudios ME\r\n"
				+ "JOIN Materias M ON ME.idMat = M.idMat\r\n"
				+ "WHERE ME.idEst = ?;\r\n"
				+ "";
		try {

			ps = conn.prepareStatement(sql);

			ps.setInt(1, idEst);

			rs = ps.executeQuery();

			while (rs.next()) {
				d = new MateriaEnEstudio();
				d.setIdEst(rs.getInt("idEst"));
				d.setIdMat(rs.getInt("idMat"));
				d.setNomMat(rs.getString("nomMat"));
				d.setHorasMat(rs.getInt("horasMat"));
				d.setObsMatEst(rs.getString("obsMatEst"));
				// Otros campos según tu estructura de datos
				materias.add(d);
				
			}
			//System.out.println(materias.toString());

		} catch (Exception e) {
			e.printStackTrace(); // Manejo adecuado de la excepción en tu aplicación
		}

		return materias;
	}
	/**
	 * Actualiza una materia existente en la base de datos.
	 *
	 * @param mat La materia con los nuevos datos que se desea actualizar.
	 * @return true si la materia se actualizó correctamente, false si no se pudo actualizar.
	 */

	public boolean actualizarMateriaDao(Materia mat) {
		boolean f = false;
		int iMateria;
		String insertarMateriaSQL = "UPDATE materias SET idMat = ?, nomMat = ?, horasMat = ?, obsMat = ? WHERE idMat = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(insertarMateriaSQL);
			ps.setInt(1, mat.getIdMat());
			ps.setString(2, mat.getNomMat());
			ps.setInt(3, mat.getHorasMat());
 			ps.setString(4, mat.getObsMat());
			iMateria = ps.executeUpdate();
			if (iMateria > 0) {
				f = true;
				System.out.println("Materia actualizado exitosamente");
			} else {
				f = false;
				System.out.println("Materia no ha sido actualizado");
			}
		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción
			e.printStackTrace();
			System.out.println("Error actualizando materia");
		}
		return f;
	}
	
	/**
	 * Inserta una nueva materia en la base de datos.
	 *
	 * @param mat La materia que se desea insertar.
	 * @return true si la materia se insertó correctamente, false si no se pudo insertar.
	 */
	
	public boolean insertarMateriaDao(Materia mat) {
		boolean f = false;
		int iMateria;
		String insertarMateriaSQL = "INSERT INTO materias(idMat,nomMat,horasMat,obsMat) VALUES(?,?,?,?)";

		try {
			PreparedStatement ps = conn.prepareStatement(insertarMateriaSQL);

			ps.setInt(1, mat.getIdMat());
			ps.setString(2, mat.getNomMat());
			ps.setInt(3, mat.getHorasMat());
 			ps.setString(4, mat.getObsMat());
			iMateria = ps.executeUpdate();
			if (iMateria > 0) {
				f = true;
				System.out.println("Materia insertado exitosamente");
			} else {
				f = false;
				System.out.println("Materia no ha sido insertado");
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción

			e.printStackTrace();
			System.out.println("Error insertando esttro");
		}

		return f;
	}
	
	/**
	* Borra una materia de la base de datos.
	* @param idMat El ID de la materia que se desea borrar.
	* @return true si la materia se borró correctamente, false si no se pudo borrar.
	*/
	
	public boolean borrarMateria(int idMat) {
		boolean f = false;
		 String message = "";
		String sqlActividades = "DELETE FROM materia WHERE idAct = ?";
		try {
			PreparedStatement psMaterias = conn.prepareStatement(sqlActividades);
			psMaterias.setInt(1, idMat);
			int iMateria= psMaterias.executeUpdate();
			if (iMateria > 0) {
				f = true;
				System.out.println("materia borrada exitosamente");
			} else {
				f = false;
				System.out.println("No se puede borrar la materia");
			}
		} catch (SQLIntegrityConstraintViolationException e) {
			// Manejar la excepción específica de violación de integridad de la SQL
			e.printStackTrace();
			 message = "No se puede borrar la materia debido a restricciones de integridad de la base de datos";
			System.out
					.println("No se puede borrar la materia debido a restricciones de integridad de la base de datos");
		} catch (SQLException e) {
			// Manejar otras excepciones SQL
			e.printStackTrace();
			System.out.println("Error borrando actividad");
		}
		return f;
	}
	
	////ACTIVIDADES
	
	
	/**
	 * Método para insertar una nueva actividad de alumno en la base de datos.
	 * @param act La actividad del alumno que se va a insertar.
	 * @return true si la inserción fue exitosa, false si ocurrió algún error.
	 */
	public boolean insertarActividadAlumnoDao(ActividadAlumno act) {
		boolean f = false;
		int iActividad;
		String insertarActividadAlumnoSQL = "INSERT INTO actividades(idAlu, idMat notaAct,  obsAct) VALUES(?,?,?,?)";

		try {
			PreparedStatement ps = conn.prepareStatement(insertarActividadAlumnoSQL);

			ps.setInt(1, act.getIdAlu());
			ps.setDouble(2, act.getIdAct());
			ps.setDouble(3, act.getNotaAct());
 			ps.setString(4, act.getObsAct());
 			iActividad = ps.executeUpdate();
			if (iActividad > 0) {
				f = true;
				System.out.println("ActividadAlumno insertada exitosamente");
			} else {
				f = false;
				System.out.println("ActividadAlumno no ha sido insertada");
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción

			e.printStackTrace();
			System.out.println("Error insertando actividad");
		}

		return f;
	}	

	/**
	 * Método para insertar una nueva actividad   la base de datos.
	 * @param act La actividad  que se va a insertar.
	 * @return true si la inserción fue exitosa, false si ocurrió algún error.
	 */
	public boolean insertarActividadDao(Actividad act) {
		boolean f = false;
		int iActividad;
		String insertarActividadAlumnoSQL = "INSERT INTO actividades( idMat, enuAct,  obsAct) VALUES(?,?,?)";

		try {
			PreparedStatement ps = conn.prepareStatement(insertarActividadAlumnoSQL);
			
			ps.setInt(1, act.getIdMat());
			ps.setString(2, act.getEnuAct());
 			ps.setString(3, act.getObsAct());
 			
			System.out.println("valores de get " + act.getIdMat());
			System.out.println("valores de get " + act.getEnuAct());
			System.out.println("valores de get " + act.getObsAct());

 			iActividad = ps.executeUpdate();
			if (iActividad > 0) {
				f = true;
				System.out.println("Actividad insertada exitosamente");
			} else {
				f = false;
				System.out.println("Actividad no ha sido insertada");
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción

			e.printStackTrace();
			System.out.println("Error insertando actividad");
		}

		return f;
	}	
	/**
	 * Actualiza actividad (rol admin o docente) existente en la base de datos.
	 *
	 * @param act La actividad con los nuevos datos que se desea actualizar.
	 * @return true si la actividad se actualizó correctamente, false si no se pudo actualizar.
	 */	
		public boolean actualizarActividadAlumnoDao(ActividadAlumno act) {
			boolean f = false;
			int iActividad;
			String insertarActividadSQL = "UPDATE actividadesenmateriaalumnos SET  notaAct = ?,  obsAct = ? WHERE idAct = ?";

			try {
				PreparedStatement ps = conn.prepareStatement(insertarActividadSQL);
			
				 
				ps.setDouble(1, act.getNotaAct());
	 			ps.setString(2, act.getObsAct());
	 			ps.setInt(3, act.getIdAct());
				iActividad = ps.executeUpdate();
				if (iActividad > 0) {
					f = true;
					System.out.println("Actividad de alumno/a actualizada exitosamente");
				} else {
					f = false;
					System.out.println("Actividad de alumno/a actualizado");
				}
			} catch (Exception e) {
				// En caso de error, hacer rollback de la transacción
				e.printStackTrace();
				System.out.println("Error actualizando ActividadAlumno");
			}
			return f;
		}
	

	public boolean actualizarActividadDao(Actividad  act) {
		boolean f = false;
		int iActividad;
		System.out.println("Recogido al principio act.getIdAct()" + act.getIdAct());
		String insertarActividadSQL = "UPDATE actividades SET  enuAct = ?,  obsAct = ? WHERE idAct = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(insertarActividadSQL);
		
			ps.setString(1, act.getEnuAct());
 			ps.setString(2, act.getObsAct());
 			ps.setInt(3, act.getIdAct());
			iActividad = ps.executeUpdate();
			if (iActividad > 0) {
				f = true;
				System.out.println("Actividad actualizada exitosamente");
			} else {
				f = false;
				System.out.println("Actividad no ha sido actualizado");
				System.out.println("act.getEnuAct()" + act.getEnuAct());
				System.out.println("act.getObsAct()" + act.getObsAct());
				System.out.println("act.getIdAct()" + act.getIdAct());



			}
		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción
			e.printStackTrace();
			System.out.println("Error actualizando Actividad");
		}
		return f;
	}
	
	/**
	* Borra una actividad de la base de datos.
	* @param idAct El ID de la actividad que se desea borrar.
	* @return true si la actividad se borró correctamente, false si no se pudo borrar.
	*/
	
	public boolean borrarActividad(int idAct) {
		boolean f = false;
		 String message = "";
		String sqlActividades = "DELETE FROM actividades WHERE idAct = ?";
		try {
			PreparedStatement psActividades = conn.prepareStatement(sqlActividades);
			psActividades.setInt(1, idAct);
			int iEstudio = psActividades.executeUpdate();
			if (iEstudio > 0) {
				f = true;
				System.out.println("actividad borrada exitosamente");
			} else {
				f = false;
				System.out.println("No se puede borrar la actividad");
			}
		} catch (SQLIntegrityConstraintViolationException e) {
			// Manejar la excepción específica de violación de integridad de la SQL
			e.printStackTrace();
			 message = "No se puede borrar el actividad debido a restricciones de integridad de la base de datos";
			System.out
					.println("No se puede borrar la actividad debido a restricciones de integridad de la base de datos");
		} catch (SQLException e) {
			// Manejar otras excepciones SQL
			e.printStackTrace();
			System.out.println("Error borrando actividad");
		}
		return f;
	}
	
	/**
	 * Obtiene todas las actividades asociadas a una materia específica.
	 *
	 * @param idMat El ID de la materia para la cual se desean obtener las actividades.
	 * @return Una lista de objetos ActividadAlumno que representan las actividades asociadas a la materia, o una lista vacía si no hay actividades.
	 */

	public List<Actividad> getActividadesEnMateria(int idMat) {
		List<Actividad> listaActividades = new ArrayList<>();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT a.*, m.nomMat\r\n"
					+ "FROM actividades a\r\n"
					+ "JOIN materias m ON a.idMat = m.idMat\r\n"
					+ "WHERE a.idMat = ?\r\n"
					+ "";

			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, idMat);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				int idAct = rs.getInt("idAct");
				//int idMat = rs.getInt("idMat");
				String nomMat = rs.getString("nomMat");
				String enuAct = rs.getString("enuAct");
				//double notaAct = rs.getDouble("notaAct");
				String obsAct = rs.getString("obsAct");

 				Actividad act = new Actividad( idAct, idMat,  nomMat,   enuAct,  obsAct);
				listaActividades.add(act);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// Manejar la excepción según sea necesario

		}
		return listaActividades;
	}
	
	/**
	 * Obtiene todas las actividades asociadas a una materia y alumno específica.
	 *
	 * @param idMat El ID de la materia para la cual se desean obtener las actividades.
	 * @param idAlu  El ID del alumno para la cual se desean obtener las actividades.
	 * @return Una lista de objetos ActividadAlumno que representan las actividades asociadas a la materia y alumno, o una lista vacía si no hay actividades.
	 */

	public List<ActividadAlumno> getActividadesAlumnoByMateria(int idMat, int idAlu) {
		List<ActividadAlumno> listaActividades = new ArrayList<>();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT a.*, m.nomMat\r\n"
					+ "FROM actividades a\r\n"
					+ "JOIN materias m ON a.idMat = m.idMat\r\n"
					+ "WHERE a.idMat = ?\r\n"
					+ "";

			ps = conn.prepareStatement(sql);

			// Establecer el valor del parámetro
			ps.setInt(1, idMat);

			// Ejecutar la consulta
			rs = ps.executeQuery();

			while (rs.next()) {
				int idAct = rs.getInt("idAct");
				//int idMat = rs.getInt("idMat");
				String nomMat = rs.getString("nomMat");
				String enuAct = rs.getString("enuAct");
				double notaAct = rs.getDouble("notaAct");
				String obsAct = rs.getString("obsAct");

 				ActividadAlumno act = new ActividadAlumno( idAct, idMat,  nomMat,  notaAct,  enuAct,  obsAct);
				listaActividades.add(act);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// Manejar la excepción según sea necesario

		}
		return listaActividades;
	}	
	
	
}
