package com.logica;

import java.sql.Date;

public class MatriculaJson {
	private int idUsu;
	private int idEst;
	private int idMat;
	private String nomMat;
	private Date fechMatri;
	private String modMatri;
	private String obsMatri;
	public MatriculaJson(int idUsu, int idEst, int idMat, String nomMat, Date fechMatri, String modMatri,
			String obsMatri) {
		super();
		this.idUsu = idUsu;
		this.idEst = idEst;
		this.idMat = idMat;
		this.nomMat = nomMat;
		this.fechMatri = fechMatri;
		this.modMatri = modMatri;
		this.obsMatri = obsMatri;
	}
	public MatriculaJson() {
		super();
	}
	public int getIdUsu() {
		return idUsu;
	}
	public void setIdUsu(int idUsu) {
		this.idUsu = idUsu;
	}
	public int getIdEst() {
		return idEst;
	}
	public void setIdEst(int idEst) {
		this.idEst = idEst;
	}
	public int getIdMat() {
		return idMat;
	}
	public void setIdMat(int idMat) {
		this.idMat = idMat;
	}
	public String getNomMat() {
		return nomMat;
	}
	public void setNomMat(String nomMat) {
		this.nomMat = nomMat;
	}
	public Date getFechMatri() {
		return fechMatri;
	}
	public void setFechMatri(Date fechMatri) {
		this.fechMatri = fechMatri;
	}
	public String getModMatri() {
		return modMatri;
	}
	public void setModMatri(String modMatri) {
		this.modMatri = modMatri;
	}
	public String getObsMatri() {
		return obsMatri;
	}
	public void setObsMatri(String obsMatri) {
		this.obsMatri = obsMatri;
	}
	@Override
	public String toString() {
		return "MatriculaJson [idUsu=" + idUsu + ", idEst=" + idEst + ", idMat=" + idMat + ", nomMat=" + nomMat
				+ ", fechMatri=" + fechMatri + ", modMatri=" + modMatri + ", obsMatri=" + obsMatri + "]";
	}
}