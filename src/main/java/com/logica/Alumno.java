package com.logica;

import java.sql.Date;

/**
 *
 * @author María del Carmen Buenestado Fernández
 */
public class Alumno extends Usuario {
	// private int idAlu;
	private String tituIngAlu;
	private String nomEst;

//    private String numMatriAlu;
//    private String modaAlu;
//	  private Date fechMatriAlu;
//    private String annoAcaAlu;
//    
	public Alumno() {

	}

	public Alumno(String tituIngAlu, String emailUsu, String nomEst) {
		this.tituIngAlu = tituIngAlu;
		this.nomEst = nomEst;
		this.emailUsu = emailUsu;
	}
	public Alumno(String tituIngAlu, String emailUsu) {
		this.tituIngAlu = tituIngAlu;
		this.emailUsu = emailUsu;
	}
	public Alumno(int idUsu, String dniUsu, String nomCompUsu, String telUsu, String obsUsu, String direcUsu,
			Date fechNacUsu, String emailUsu, String pswordUsu, String tipoRolUsu, String localUsu, String provUsu,
			int activo, String tituIngAlu) {
		super(idUsu, dniUsu, nomCompUsu, telUsu, obsUsu, direcUsu, fechNacUsu, emailUsu, pswordUsu, tipoRolUsu,
				localUsu, provUsu, activo);
		this.tituIngAlu = tituIngAlu;
	}

	public Alumno(String dniUsu, String nomCompUsu, String telUsu, String obsUsu, String direcUsu, Date fechNacUsu,
			String emailUsu, String pswordUsu, String tipoRolUsu, String localUsu, String provUsu, int activo,
			String tituIngAlu) {
		super(dniUsu, nomCompUsu, telUsu, obsUsu, direcUsu, fechNacUsu, emailUsu, pswordUsu, tipoRolUsu, localUsu,
				provUsu, activo);
		this.tituIngAlu = tituIngAlu;
	}

	public Alumno(String tituIngAlu) {
		super();
		this.tituIngAlu = tituIngAlu;
	}

	public String getNomEst() {
		return nomEst;
	}

	public void setNomEst(String nomEst) {
		this.nomEst = nomEst;
	}

	public String getTituIngAlu() {
		return tituIngAlu;
	}

	public void setTituIngAlu(String tituIngAlu) {
		this.tituIngAlu = tituIngAlu;
	}

	public String getEmailUsu() {
		return emailUsu;
	}


	public void setEmailUsu(String emailUsu) {
		this.emailUsu = emailUsu;
	}

	@Override
	public String toString() {
		return "Alumno [tituIngAlu=" + tituIngAlu + "]";
	}

}