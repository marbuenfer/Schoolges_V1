package com.logica;

//import java.sql.Date;

/**
 *
 * @author María del Carmen Buenestado Fernández
 */
public class Centro {
	private int idCen;
	private String nomCen;
	private String telCen;
	private String direCen;
	private String localCen;
	private String provCen;
	private String respCen;
	private String obsCen;
	
	
	public Centro() {
	}


	public Centro(int idCen, String nomCen, String telCen, String direCen, String localCen, String provCen,
			String respCen, String obsCen) {

		this.idCen = idCen;
		this.nomCen = nomCen;
		this.telCen = telCen;
		this.direCen = direCen;
		this.localCen = localCen;
		this.provCen = provCen;
		this.respCen = respCen;
		this.obsCen = obsCen;
	}


	public Centro(String nomCen, String telCen, String direCen, String localCen, String provCen, String respCen,
			String obsCen) {
		super();
		this.nomCen = nomCen;
		this.telCen = telCen;
		this.direCen = direCen;
		this.localCen = localCen;
		this.provCen = provCen;
		this.respCen = respCen;
		this.obsCen = obsCen;
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


	public String getTelCen() {
		return telCen;
	}


	public void setTelCen(String telCen) {
		this.telCen = telCen;
	}


	public String getDireCen() {
		return direCen;
	}


	public void setDireCen(String direCen) {
		this.direCen = direCen;
	}


	public String getLocalCen() {
		return localCen;
	}


	public void setLocalCen(String localCen) {
		this.localCen = localCen;
	}


	public String getProvCen() {
		return provCen;
	}


	public void setProvCen(String provCen) {
		this.provCen = provCen;
	}




	public String getRespCen() {
		return respCen;
	}


	public void setRespCen(String respCen) {
		this.respCen = respCen;
	}


	public String getObsCen() {
		return obsCen;
	}


	public void setObsCen(String obsCen) {
		this.obsCen = obsCen;
	}


	@Override
	public String toString() {
		return "Centro [idCen=" + idCen + ", nomCen=" + nomCen + ", telCen=" + telCen + ", direCen=" + direCen
				+ ", localCen=" + localCen + ", provCen=" + provCen + ", respCen=" + respCen + ", obsCen=" + obsCen
				+ "]";
	}
	
}
