package com.logica;

public class Materia {
	private int idMat;
	private String nomMat;
	private int horasMat;
	private String obsMat;
	
	
	public Materia() {
		super();
	}
	public Materia(int idMat, String nomMat, int horasMat, String obsMat) {
		this.idMat = idMat;
		this.nomMat = nomMat;
		this.horasMat = horasMat;
		this.obsMat = obsMat;
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
	public int getHorasMat() {
		return horasMat;
	}
	public void setHorasMat(int horasMat) {
		this.horasMat = horasMat;
	}
	public String getObsMat() {
		return obsMat;
	}
	public void setObsMat(String obsMat) {
		this.obsMat = obsMat;
	}
	@Override
	public String toString() {
		return "Materia [idMat=" + idMat + ", nomMat=" + nomMat + ", horasMat=" + horasMat + ", obsMat=" + obsMat + "]";
	}

	 
}
