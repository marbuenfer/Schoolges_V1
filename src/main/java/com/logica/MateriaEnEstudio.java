package com.logica;

public class MateriaEnEstudio {
	private int idEst;
	private String nomEst;

	private String nomMat;
	private int idMat;
	private int horasMat;
	private String obsMatEst;
	
	
	public MateriaEnEstudio() {
		 
	}


	public String getNomEst() {
		return nomEst;
	}


	public void setNomEst(String nomEst) {
		this.nomEst = nomEst;
	}


	public MateriaEnEstudio(int idEst, String nomEst, String nomMat, int idMat, int horasMat, String obsMatEst) {
		super();
		this.idEst = idEst;
		this.nomEst = nomEst;
		this.nomMat = nomMat;
		this.idMat = idMat;
		this.horasMat = horasMat;
		this.obsMatEst = obsMatEst;
	}


	public MateriaEnEstudio(int idEst, String nomMat, int idMat, int horasMat, String obsMatEst) {
		this.idEst = idEst;
		this.nomMat = nomMat;
		this.idMat = idMat;
		this.horasMat = horasMat;
		this.obsMatEst = obsMatEst;
	}
	


	public MateriaEnEstudio(int idEst, int idMat, String obsMatEst) {
		super();
		this.idEst = idEst;
		this.idMat = idMat;
		this.obsMatEst = obsMatEst;
	}


	public int getIdEst() {
		return idEst;
	}


	public void setIdEst(int idEst) {
		this.idEst = idEst;
	}


	public String getNomMat() {
		return nomMat;
	}


	public void setNomMat(String nomMat) {
		this.nomMat = nomMat;
	}


	public int getIdMat() {
		return idMat;
	}


	public void setIdMat(int idMat) {
		this.idMat = idMat;
	}


	public int getHorasMat() {
		return horasMat;
	}


	public void setHorasMat(int horasMat) {
		this.horasMat = horasMat;
	}


	public String getObsMatEst() {
		return obsMatEst;
	}


	public void setObsMatEst(String obsMatEst) {
		this.obsMatEst = obsMatEst;
	}


	@Override
	public String toString() {
		return "MateriaEnEstudio [idEst=" + idEst + ", nomEst=" + nomEst + ", nomMat=" + nomMat + ", idMat=" + idMat
				+ ", horasMat=" + horasMat + ", obsMatEst=" + obsMatEst + "]";
	}
	
 
}
