package com.logica;

public class AsignacionCentroEstudio {
	private int idAsig;

	private int idCen;
	private String nomCen;

	private int idEst;
	private String nomEst;
	
	private String obsEstCen;

	public AsignacionCentroEstudio() {
		super();
	}

	public AsignacionCentroEstudio(int idAsig, int idCen, String nomCen, int idEst, String nomEst, String obsEstCen) {
		this.idAsig = idAsig;
		this.idCen = idCen;
		this.nomCen = nomCen;
		this.idEst = idEst;
		this.nomEst = nomEst;
		this.obsEstCen = obsEstCen;
	}

	public AsignacionCentroEstudio(int idCen, String nomCen, int idEst, String nomEst, String obsEstCen) {
		this.idCen = idCen;
		this.nomCen = nomCen;
		this.idEst = idEst;
		this.nomEst = nomEst;
		this.obsEstCen = obsEstCen;
	}

	public int getIdAsig() {
		return idAsig;
	}

	public void setIdAsig(int idAsig) {
		this.idAsig = idAsig;
	}

	public int getIdCen() {
		return idCen;
	}

	public void setIdCen(int idCen) {
		this.idCen = idCen;
	}

	public String getNomCen() {
		return nomCen;
	}

	public void setNomCen(String nomCen) {
		this.nomCen = nomCen;
	}

	public int getIdEst() {
		return idEst;
	}

	public void setIdEst(int idEst) {
		this.idEst = idEst;
	}

	public String getNomEst() {
		return nomEst;
	}

	public void setNomEst(String nomEst) {
		this.nomEst = nomEst;
	}

	public String getObsEstCen() {
		return obsEstCen;
	}

	public void setObsEstCen(String obsEstCen) {
		this.obsEstCen = obsEstCen;
	}

	@Override
	public String toString() {
		return "AsignacionCentroEstudio [idAsig=" + idAsig + ", idCen=" + idCen + ", nomCen=" + nomCen + ", idEst="
				+ idEst + ", nomEst=" + nomEst + ", obsEstCen=" + obsEstCen + "]";
	}
	
}
