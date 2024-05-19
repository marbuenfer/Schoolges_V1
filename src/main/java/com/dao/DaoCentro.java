package com.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.logica.Alumno;
import com.logica.Centro;
import com.logica.AsignacionCentroEstudio;

public class DaoCentro {
	private Connection conn;

	public DaoCentro(Connection conn) {
		super();
		this.conn = conn;
	}

	public Centro getCentroById(int id) {

		Centro cen = new Centro();
		try (PreparedStatement ps = conn.prepareStatement("select * from centros where idCen=?")) {

			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					cen = new Centro();
					cen.setIdCen(rs.getInt(1));
					cen.setNomCen(rs.getString(2));
					cen.setTelCen(rs.getString(3));
					cen.setDireCen(rs.getString(4));
					cen.setLocalCen(rs.getString(5));
					cen.setProvCen(rs.getString(6));
					cen.setRespCen(rs.getString(7));
					cen.setObsCen(rs.getString(8));
				}
			} // try

		} catch (Exception e) {
			e.printStackTrace();
		} // try
		return cen;
	}

	public List<Centro> getAllCentros() {
		List<Centro> list = new ArrayList<Centro>();
		Centro cen = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
		String sql = "SELECT * FROM centros ";
		System.out.println(sql + "estoy dentro de getAllCentos");

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				cen = new Centro();
				cen.setIdCen(rs.getInt(1));
				cen.setNomCen(rs.getString(2));
				cen.setTelCen(rs.getString(3));
				cen.setDireCen(rs.getString(4));
				cen.setLocalCen(rs.getString(5));
				cen.setProvCen(rs.getString(6));
				cen.setRespCen(rs.getString(7));
				cen.setObsCen(rs.getString(8));
				list.add(cen);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;
	}
	
	public List<AsignacionCentroEstudio> getAllAsigEstudiosACentros() {
		List<AsignacionCentroEstudio> list = new ArrayList<AsignacionCentroEstudio>();
		AsignacionCentroEstudio estCen = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
 		String sql = "SELECT * FROM estudiosencentro ";
		System.out.println(sql + "estoy dentro de getAllAsigEstudiosACentros");

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				estCen = new AsignacionCentroEstudio();
				estCen.setIdAsig(rs.getInt(1));
				estCen.setIdCen(rs.getInt(2));
				estCen.setNomCen(rs.getString(3));
				estCen.setIdEst(rs.getInt(4));
				estCen.setNomEst(rs.getString(5));
				estCen.setObsEstCen(rs.getString(6));
				list.add(estCen);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;
	}

	public boolean insertarCentroDao(Centro cen) {
		boolean f = false;
		int iCentro;
		String insertarCentroSQL = "INSERT INTO centros(nomCen,telCen,direCen,localCen,"
				+ "provCen, respCen, obsCen) VALUES(?,?,?,?,?,?,?)";

		try {
			PreparedStatement psInsertarCentro = conn.prepareStatement(insertarCentroSQL);

			psInsertarCentro.setString(1, cen.getNomCen());
			psInsertarCentro.setString(2, cen.getTelCen());
			psInsertarCentro.setString(3, cen.getDireCen());
			psInsertarCentro.setString(4, cen.getLocalCen());
			psInsertarCentro.setString(5, cen.getProvCen());
			psInsertarCentro.setString(6, cen.getRespCen());
			psInsertarCentro.setString(7, cen.getObsCen());

			iCentro = psInsertarCentro.executeUpdate();
			if (iCentro > 0) {
				f = true;
				System.out.println("Centro insertado exitosamente");
			} else {
				f = false;
				System.out.println("Centro no ha sido insertado");
			}

		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción

			e.printStackTrace();
			System.out.println("Error insertando centro");
		}

		return f;
	}

	public boolean actualizarCentroDao(Centro cen) {
		boolean f = false;
		int iCentro;
		String insertarCentroSQL = "UPDATE centros SET nomCen = ?, telCen = ?, direCen = ?, localCen = ?, provCen = ?, respCen = ?, obsCen = ? WHERE idCen = ?";

		try {
			PreparedStatement psInsertarCentro = conn.prepareStatement(insertarCentroSQL);

			psInsertarCentro.setString(1, cen.getNomCen());
			psInsertarCentro.setString(2, cen.getTelCen());
			psInsertarCentro.setString(3, cen.getDireCen());
			psInsertarCentro.setString(4, cen.getLocalCen());
			psInsertarCentro.setString(5, cen.getProvCen());
			psInsertarCentro.setString(6, cen.getRespCen());
			psInsertarCentro.setString(7, cen.getObsCen());
			psInsertarCentro.setInt(8, cen.getIdCen());

			iCentro = psInsertarCentro.executeUpdate();
			if (iCentro > 0) {
				f = true;
				System.out.println("Centro actualizado exitosamente");
			} else {
				f = false;
				System.out.println("Centro no ha sido actualizado");
			}
		} catch (Exception e) {
			// En caso de error, hacer rollback de la transacción
			e.printStackTrace();
			System.out.println("Error actualizando centro");
		}
		return f;
	}
	
	public boolean borrarCentro(int idCen) {
	    boolean f = false;

	    String sqlCentros = "DELETE FROM centros WHERE idCen = ?";
	    try {
	        PreparedStatement psCentros = conn.prepareStatement(sqlCentros);
	        psCentros.setInt(1, idCen);
	        int iCentro = psCentros.executeUpdate();
	        if (iCentro > 0) {
	            f = true;
	            System.out.println("Centro borrado exitosamente");
	        } else {
	            f = false;
	            System.out.println("No se puede borrar el centro");
	        }
	    } catch (SQLIntegrityConstraintViolationException e) {
	        // Manejar la excepción específica de violación de integridad de la SQL
	        e.printStackTrace();
	        System.out.println("No se puede borrar el centro debido a restricciones de integridad de la base de datos");
	    } catch (SQLException e) {
	        // Manejar otras excepciones SQL
	        e.printStackTrace();
	        System.out.println("Error borrando centro");
	    }
	    return f;
	}

	}


