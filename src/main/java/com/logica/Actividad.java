package com.logica;

public class Actividad {
	private int idAct;
	private int idMat;
	private String nomMat;
	private String enuAct;
	private String obsAct;
	
	public Actividad() {
		super();
	}
	
	public Actividad(int idMat, String nomMat, String enuAct, String obsAct) {
		this.idMat = idMat;
		this.nomMat = nomMat;
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}
 

	public Actividad(int idAct, int idMat, String nomMat, String enuAct, String obsAct) {
		this.idAct = idAct;
		this.idMat = idMat;
		this.nomMat = nomMat;
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}

	
	public Actividad(int idAct, int idMat,  String enuAct, String obsAct) {
		this.idAct = idAct;
		this.idMat = idMat;
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}

	public Actividad( int idMat, String enuAct, String obsAct) {
		this.idMat = idMat;
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}
	
	

	public Actividad(String enuAct, String obsAct) {
		super();
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}

	public int getIdAct() {
		return idAct;
	}

	public void setIdAct(int idAct) {
		this.idAct = idAct;
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

	public String getEnuAct() {
		return enuAct;
	}

	public void setEnuAct(String enuAct) {
		this.enuAct = enuAct;
	}

	public String getObsAct() {
		return obsAct;
	}

	public void setObsAct(String obsAct) {
		this.obsAct = obsAct;
	}

	@Override
	public String toString() {
		return "ActividadAlumno [idAct=" + idAct + ", idMat=" + idMat + ", nomMat=" + nomMat + ", enuAct=" + enuAct + ", obsAct=" + obsAct + "]";
	}

 
	
	
}
