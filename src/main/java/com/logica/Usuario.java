package com.logica;

import java.sql.Date;

//import java.sql.Date;

/**
 *
 * @author María del Carmen Buenestado Fernández
 */
public class Usuario {
	protected int idUsu;
	protected String dniUsu;
	protected String nomCompUsu;
	protected String telUsu;
	protected String obsUsu;
	protected String direcUsu;
	protected Date fechNacUsu;
	protected String emailUsu;
	protected String pswordUsu;
	protected String tipoRolUsu;
	protected String localUsu;
	protected String provUsu;
	protected int activo;
	
	
	public Usuario() {
	}



	public Usuario(String dniUsu, String nomCompUsu, String telUsu, String obsUsu, String direcUsu, Date fechNacUsu,
			String emailUsu, String pswordUsu, String tipoRolUsu, String localUsu, String provUsu, int activo) {
		this.dniUsu = dniUsu;
		this.nomCompUsu = nomCompUsu;
		this.telUsu = telUsu;
		this.obsUsu = obsUsu;
		this.direcUsu = direcUsu;
		this.fechNacUsu = fechNacUsu;
		this.emailUsu = emailUsu;
		this.pswordUsu = pswordUsu;
		this.tipoRolUsu = tipoRolUsu;
		this.localUsu = localUsu;
		this.provUsu = provUsu;
		this.activo = activo;
	}

	public Usuario(int idUsu, String dniUsu, String nomCompUsu, String telUsu, String obsUsu, String direcUsu,
			Date fechNacUsu, String emailUsu, String pswordUsu, String tipoRolUsu, String localUsu, String provUsu,
			int activo) {
		this.idUsu = idUsu;
		this.dniUsu = dniUsu;
		this.nomCompUsu = nomCompUsu;
		this.telUsu = telUsu;
		this.obsUsu = obsUsu;
		this.direcUsu = direcUsu;
		this.fechNacUsu = fechNacUsu;
		this.emailUsu = emailUsu;
		this.pswordUsu = pswordUsu;
		this.tipoRolUsu = tipoRolUsu;
		this.localUsu = localUsu;
		this.provUsu = provUsu;
		this.activo = activo;
	}
	 
	public Usuario(int idUsu, String dniUsu, String nomCompUsu, String emailUsu, int activo) {
		super();
		this.idUsu = idUsu;
		this.dniUsu = dniUsu;
		this.nomCompUsu = nomCompUsu;
		this.emailUsu = emailUsu;
		this.activo = activo;
	}

	public int getIdUsu() {
		return idUsu;
	}


	public void setIdUsu(int idUsu) {
		this.idUsu = idUsu;
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


	public String getTelUsu() {
		return telUsu;
	}


	public void setTelUsu(String telUsu) {
		this.telUsu = telUsu;
	}


	public String getObsUsu() {
		return obsUsu;
	}


	public void setObsUsu(String obsUsu) {
		this.obsUsu = obsUsu;
	}


	public String getDirecUsu() {
		return direcUsu;
	}


	public void setDirecUsu(String direcUsu) {
		this.direcUsu = direcUsu;
	}


	public Date getFechNacUsu() {
		return fechNacUsu;
	}


	public void setFechNacUsu(Date fechNacUsu) {
		this.fechNacUsu = fechNacUsu;
	}


	public String getEmailUsu() {
		return emailUsu;
	}


	public void setEmailUsu(String emailUsu) {
		this.emailUsu = emailUsu;
	}


	public String getPswordUsu() {
		return pswordUsu;
	}


	public void setPswordUsu(String pswordUsu) {
		this.pswordUsu = pswordUsu;
	}


	public String getTipoRolUsu() {
		return tipoRolUsu;
	}


	public void setTipoRolUsu(String tipoRolUsu) {
		this.tipoRolUsu = tipoRolUsu;
	}


	public String getLocalUsu() {
		return localUsu;
	}


	public void setLocalUsu(String localUsu) {
		this.localUsu = localUsu;
	}


	public String getProvUsu() {
		return provUsu;
	}


	public void setProvUsu(String provUsu) {
		this.provUsu = provUsu;
	}


	public int getActivo() {
		return activo;
	}


	public void setActivo(int activo) {
		this.activo = activo;
	}


	@Override
	public String toString() {
		return "Usuario [idUsu=" + idUsu + ", dniUsu=" + dniUsu + ", nomCompUsu=" + nomCompUsu + ", telUsu=" + telUsu
				+ ", obsUsu=" + obsUsu + ", direcUsu=" + direcUsu + ", fechNacUsu=" + fechNacUsu + ", emailUsu="
				+ emailUsu + ", pswordUsu=" + pswordUsu + ", tipoRolUsu=" + tipoRolUsu + ", localUsu=" + localUsu
				+ ", provUsu=" + provUsu + ", activo=" + activo + "]";
	}






}
