package com.logica;

import java.sql.Date;

public class Docente extends Usuario{
	//private int idDoc;
	private String espeDoc;
	private String gradAcadDoc;
	private Date fechAltaDoc;
	private Date fechBajaDoc;
	
	
	public Docente(int idUsu, String dniUsu, String nomCompUsu, String emailUsu,int activo,int idDoc, String espeDoc, String gradAcadDoc, Date fechAltaDoc, Date fechBajaDoc) {
		super( idUsu,  dniUsu,  nomCompUsu,  emailUsu, activo);
	//	this.idDoc = idDoc;
		this.espeDoc = espeDoc;
		this.gradAcadDoc = gradAcadDoc;
		this.fechAltaDoc = fechAltaDoc;
		this.fechBajaDoc = fechBajaDoc;
	}
	
	public Docente(int idUsu, String dniUsu, String nomCompUsu, String emailUsu,int activo) {
		super(idUsu,  dniUsu,  nomCompUsu,  emailUsu, activo);
		
	}
	public Docente() {
		super();
		// TODO Auto-generated constructor stub
	}


//	public Docente(int idUsu, String dniUsu, String nomCompUsu, String emailUsu,int activo) {
//		super(idUsu, dniUsu, nomCompUsu, emailUsu, activo);
//		// TODO Auto-generated constructor stub
//	}
//
//
//	public Docente(String dniUsu, String nomCompUsu, String telUsu, String obsUsu, String direcUsu, Date fechNacUsu,
//			String emailUsu, String pswordUsu, String tipoRolUsu, String localUsu, String provUsu, int activo) {
//		super(dniUsu, nomCompUsu, telUsu, obsUsu, direcUsu, fechNacUsu, emailUsu, pswordUsu, tipoRolUsu, localUsu, provUsu,
//				activo);
//		// TODO Auto-generated constructor stub
//	}


	public Docente(String espeDoc, String gradAcadDoc, Date fechaAltaDoc, Date fechaBajaDoc) {
		this.espeDoc = espeDoc;
		this.gradAcadDoc = gradAcadDoc;
		this.fechAltaDoc = fechAltaDoc;
		this.fechBajaDoc = fechBajaDoc;
	}

	public String getEspeDoc() {
		return espeDoc;
	}


	public void setEspeDoc(String espeDoc) {
		this.espeDoc = espeDoc;
	}


	public String getGradAcadDoc() {
		return gradAcadDoc;
	}


	public void setGradAcadDoc(String gradAcadDoc) {
		this.gradAcadDoc = gradAcadDoc;
	}


	public Date getFechAltaDoc() {
		return fechAltaDoc;
	}


	public void setFechAltaDoc(Date fechAltaDoc) {
		this.fechAltaDoc = fechAltaDoc;
	}


	public Date getFechBajaDoc() {
		return fechBajaDoc;
	}


	public void setFechBajaDoc(Date fechBajaDoc) {
		this.fechBajaDoc = fechBajaDoc;
	}

	@Override
	public String toString() {
		return "Docente [espeDoc=" + espeDoc + ", gradAcadDoc=" + gradAcadDoc + ", fechAltaDoc=" + fechAltaDoc
				+ ", fechBajaDoc=" + fechBajaDoc + "]";
	}


//	public int getIdDoc() {
//		return idDoc;
//	}
//
//
//	public void setIdDoc(int idDoc) {
//		this.idDoc = idDoc;
//	}
	
}
