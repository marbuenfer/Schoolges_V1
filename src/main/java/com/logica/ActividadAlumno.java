package com.logica;

public class ActividadAlumno {
	private int idActMatAlu;
	private int idAlu;
	private int idAct;
	private String nomMat;
	private double notaAct;
	private String enuAct;
	private String obsAct;
	
	
	
	public ActividadAlumno() {
		
	}


	public ActividadAlumno(int idActMatAlu, int idAlu, int idAct, String nomMat, double notaAct, String enuAct,
			String obsAct) {
		super();
		this.idActMatAlu = idActMatAlu;
		this.idAlu = idAlu;
		this.idAct = idAct;
		this.nomMat = nomMat;
		this.notaAct = notaAct;
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}


	public ActividadAlumno(int idAlu, int idAct, String nomMat, double notaAct, String enuAct, String obsAct) {
		super();
		this.idAlu = idAlu;
		this.idAct = idAct;
		this.nomMat = nomMat;
		this.notaAct = notaAct;
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}

	public ActividadAlumno(int idAlu, int idAct,  double notaAct, String enuAct, String obsAct) {
		super();
		this.idAlu = idAlu;
		this.idAct = idAct;
		this.notaAct = notaAct;
		this.enuAct = enuAct;
		this.obsAct = obsAct;
	}
	
	public ActividadAlumno(double notaAct, String obsAct) {
		super();
		this.notaAct = notaAct;
		this.obsAct = obsAct;
	}


	public int getIdActMatAlu() {
		return idActMatAlu;
	}


	public void setIdActMatAlu(int idActMatAlu) {
		this.idActMatAlu = idActMatAlu;
	}


	public int getIdAlu() {
		return idAlu;
	}


	public void setIdAlu(int idAlu) {
		this.idAlu = idAlu;
	}


	public int getIdAct() {
		return idAct;
	}


	public void setIdAct(int idAct) {
		this.idAct = idAct;
	}


	public String getNomMat() {
		return nomMat;
	}


	public void setNomMat(String nomMat) {
		this.nomMat = nomMat;
	}


	public double getNotaAct() {
		return notaAct;
	}


	public void setNotaAct(double notaAct) {
		this.notaAct = notaAct;
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
		return "ActividadAlumno [idActMatAlu=" + idActMatAlu + ", idAlu=" + idAlu + ", idAct=" + idAct + ", nomMat=" + nomMat
				+ ", notaAct=" + notaAct + ", enuAct=" + enuAct + ", obsAct=" + obsAct + "]";
	}
	
	 
	
}
