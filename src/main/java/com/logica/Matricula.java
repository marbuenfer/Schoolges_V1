package com.logica;

import java.sql.Date;
import java.time.LocalDate;

public class Matricula {
	private int idMatri;
	private int idAlu;
	//private int idMatri;
	
	private String nomCompAlu;
	private String email;
	private String telefono;

	private int idEst;
	private String nomEst;
	private Date fechMatri;
	
	private int idMat;
	private String nomMat;
	

	private int idDoc;
	private String nomDoc;
	
	private int idCen;
	private String nomCen;

	private String modMatri;
	private String obsMatri;
	private int activo;

	
	public Matricula() {
	}


	public Matricula(int idAlu, int idEst, Date fechMatri, int idMat, String modMatri, String obsMatri) {
		this.idAlu = idAlu;
		this.idEst = idEst;
		this.fechMatri = fechMatri;
		this.idMat = idMat;
		this.modMatri = modMatri;
		this.obsMatri = obsMatri;
	}
	public Matricula(int idMatri, int idAlu, String nomCompAlu, String email, String telefono, int idEst, String nomEst,
			Date fechMatri, int idMat, String nomMat, int idDoc, String nomDoc, int idCen, String nomCen,
			String modMatri, String obsMatri, int activo) {
		this.idMatri = idMatri;
		this.idAlu = idAlu;
		this.nomCompAlu = nomCompAlu;
		this.email = email;
		this.telefono = telefono;
		this.idEst = idEst;
		this.nomEst = nomEst;
		this.fechMatri = fechMatri;
		this.idMat = idMat;
		this.nomMat = nomMat;
		this.idDoc = idDoc;
		this.nomDoc = nomDoc;
		this.idCen = idCen;
		this.nomCen = nomCen;
		this.modMatri = modMatri;
		this.obsMatri = obsMatri;
		this.activo = activo;
	}


	public int getIdMatri() {
		return idMatri;
	}


	public void setIdMatri(int idMatri) {
		this.idMatri = idMatri;
	}


	public int getIdAlu() {
		return idAlu;
	}


	public void setIdAlu(int idAlu) {
		this.idAlu = idAlu;
	}


	public String getNomCompAlu() {
		return nomCompAlu;
	}


	public void setNomCompAlu(String nomCompAlu) {
		this.nomCompAlu = nomCompAlu;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getTelefono() {
		return telefono;
	}


	public void setTelefono(String telefono) {
		this.telefono = telefono;
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


	public Date getFechMatri() {
		return fechMatri;
	}


	public void setFechMatri(Date fechMatri) {
		this.fechMatri = fechMatri;
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


	public int getIdDoc() {
		return idDoc;
	}


	public void setIdDoc(int idDoc) {
		this.idDoc = idDoc;
	}


	public String getNomDoc() {
		return nomDoc;
	}


	public void setNomDoc(String nomDoc) {
		this.nomDoc = nomDoc;
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


	public int getActivo() {
		return activo;
	}


	public void setActivo(int activo) {
		this.activo = activo;
	}


	@Override
	public String toString() {
		return "Matricula [idMatri=" + idMatri + ", idAlu=" + idAlu + ", nomCompAlu=" + nomCompAlu + ", email=" + email
				+ ", telefono=" + telefono + ", idEst=" + idEst + ", nomEst=" + nomEst + ", fechMatri=" + fechMatri
				+ ", idMat=" + idMat + ", nomMat=" + nomMat + ", idDoc=" + idDoc + ", nomDoc=" + nomDoc + ", idCen="
				+ idCen + ", nomCen=" + nomCen + ", modMatri=" + modMatri + ", obsMatri=" + obsMatri + ", activo="
				+ activo + "]";
	}
 
}
