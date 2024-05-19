package com.logica;

import java.sql.Date;

public class AsignacionDocente {
	
	private int idAsg;
	private int idDoc;
	private String dniUsu;
	private String nomCompUsu;
	private String emailUsu;
	private int idMat;
	private String nomMat;
	private Date fechIniAsigDoc;
	private Date fechFinAsigDoc;
	private String obsAsigDoc;
	protected int activo;


	
	
	public AsignacionDocente(int idAsg, int idDoc, int idMat, Date fechIniAsigDoc, Date fechFinAsigDoc,
			String obsAsigDoc) {
		super();
		this.idAsg = idAsg;
		this.idDoc = idDoc;
		this.idMat = idMat;
		this.fechIniAsigDoc = fechIniAsigDoc;
		this.fechFinAsigDoc = fechFinAsigDoc;
		this.obsAsigDoc = obsAsigDoc;
	}

	
	
	public AsignacionDocente() {
		super();
	}

	public AsignacionDocente(int idAsg, int idDoc, String dniUsu, String nomCompUsu, String emailUsu, int idMat,
			String nomMat, Date fechIniAsigDoc, Date fechFinAsigDoc, String obsAsigDoc,int activo ) {
		super();
		this.idAsg = idAsg;
		this.idDoc = idDoc;
		this.dniUsu = dniUsu;
		this.nomCompUsu = nomCompUsu;
		this.emailUsu = emailUsu;
		this.idMat = idMat;
		this.nomMat = nomMat;
		this.fechIniAsigDoc = fechIniAsigDoc;
		this.fechFinAsigDoc = fechFinAsigDoc;
		this.obsAsigDoc = obsAsigDoc;
		this.activo = activo;
	}

	public AsignacionDocente(int idDoc, int idMat, String nomMat, Date fechIniAsigDoc, Date fechFinAsigDoc,
			String obsAsigDoc,int activo ) {
		this.idDoc = idDoc;
		this.idMat = idMat;
		this.nomMat = nomMat;
		this.fechIniAsigDoc = fechIniAsigDoc;
		this.fechFinAsigDoc = fechFinAsigDoc;
		this.obsAsigDoc = obsAsigDoc;
		this.activo=activo;
	}
	


	 
	public AsignacionDocente(int idDoc, int idMat, Date fechIniAsigDoc, Date fechFinAsigDoc, String obsAsigDoc) {
		super();
		this.idDoc = idDoc;
		this.idMat = idMat;
		this.fechIniAsigDoc = fechIniAsigDoc;
		this.fechFinAsigDoc = fechFinAsigDoc;
		this.obsAsigDoc = obsAsigDoc;
	}

	public int getIdAsg() {
		return idAsg;
	}

	public void setIdAsg(int idAsg) {
		this.idAsg = idAsg;
	}

	public int getIdDoc() {
		return idDoc;
	}

	public void setIdDoc(int idDoc) {
		this.idDoc = idDoc;
	}

	public String getDniUsu() {
		return dniUsu;
	}

	public void setDniUsu(String dniUsu) {
		this.dniUsu = dniUsu;
	}

	public String getNomCompUsu() {
		return nomCompUsu;
	}

	public void setNomCompUsu(String nomCompUsu) {
		this.nomCompUsu = nomCompUsu;
	}

	public String getEmailUsu() {
		return emailUsu;
	}

	public void setEmailUsu(String emailUsu) {
		this.emailUsu = emailUsu;
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

	public Date getFechIniAsigDoc() {
		return fechIniAsigDoc;
	}

	public void setFechIniAsigDoc(Date fechIniAsigDoc) {
		this.fechIniAsigDoc = fechIniAsigDoc;
	}

	public Date getFechFinAsigDoc() {
		return fechFinAsigDoc;
	}

	public void setFechFinAsigDoc(Date fechFinAsigDoc) {
		this.fechFinAsigDoc = fechFinAsigDoc;
	}

	public String getObsAsigDoc() {
		return obsAsigDoc;
	}

	public void setObsAsigDoc(String obsAsigDoc) {
		this.obsAsigDoc = obsAsigDoc;
	}

	public int getActivo() {
		return activo;
	}

	public void setActivo(int activo) {
		this.activo = activo;
	}

	@Override
	public String toString() {
		return "AsignacionDocente [idAsg=" + idAsg + ", idDoc=" + idDoc + ", dniUsu=" + dniUsu + ", nomCompUsu="
				+ nomCompUsu + ", emailUsu=" + emailUsu + ", idMat=" + idMat + ", nomMat=" + nomMat
				+ ", fechIniAsigDoc=" + fechIniAsigDoc + ", fechFinAsigDoc=" + fechFinAsigDoc + ", obsAsigDoc="
				+ obsAsigDoc + ", activo=" + activo + "]";
	}

	
	 
}
