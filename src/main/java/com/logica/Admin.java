package com.logica;

import java.sql.Date;

/**
 *
 * @author María del Carmen Buenestado Fernández
 */
public class Admin extends Usuario {
	private int idAd;
    private Date fechAltAd;
    private Date fechBajAd;
    private String catAd;
   
    
	public Admin(int idAd, Date fechAltAd, Date fechBajAd, String catAd) {
		super();
		this.idAd = idAd;
		this.fechAltAd = fechAltAd;
		this.fechBajAd = fechBajAd;
		this.catAd = catAd;
	}
	public Admin() {
		super();
	}
	public int getIdAd() {
		return idAd;
	}
	public void setIdAd(int idAd) {
		this.idAd = idAd;
	}
	public Date getFechAltAd() {
		return fechAltAd;
	}
	public void setFechAltAd(Date fechAltAd) {
		this.fechAltAd = fechAltAd;
	}
	public Date getFechBajAd() {
		return fechBajAd;
	}
	public void setFechBajAd(Date fechBajAd) {
		this.fechBajAd = fechBajAd;
	}
	public String getCatAd() {
		return catAd;
	}
	public void setCatAd(String catAd) {
		this.catAd = catAd;
	}
	
    
 
}

