package com.logica;

//import java.sql.Date;

/**
 *
 * @author María del Carmen Buenestado Fernández
 */
public class Curso {
	private int idCur;
	private String nomCur;
	private String espCur;
	private String tipPlanCur;
	private String annoPlanCur;
	private String horTotCur;
	private Byte activoCur;
	private String obsCur;
	
	public Curso(int idCur, String nomCur, String espCur, String tipPlanCur, String annoPlanCur, String horTotCur,
			Byte activoCur, String obsCur) {
		super();
		this.idCur = idCur;
		this.nomCur = nomCur;
		this.espCur = espCur;
		this.tipPlanCur = tipPlanCur;
		this.annoPlanCur = annoPlanCur;
		this.horTotCur = horTotCur;
		this.activoCur = activoCur;
		this.obsCur = obsCur;
	}
	
	public Curso(String nomCur, String espCur, String tipPlanCur, String annoPlanCur, String horTotCur, Byte activoCur,
			String obsCur) {
		super();
		this.nomCur = nomCur;
		this.espCur = espCur;
		this.tipPlanCur = tipPlanCur;
		this.annoPlanCur = annoPlanCur;
		this.horTotCur = horTotCur;
		this.activoCur = activoCur;
		this.obsCur = obsCur;
	}
	public int getIdCur() {
		return idCur;
	}
	public void setIdCur(int idCur) {
		this.idCur = idCur;
	}
	public String getNomCur() {
		return nomCur;
	}
	public void setNomCur(String nomCur) {
		this.nomCur = nomCur;
	}
	public String getEspCur() {
		return espCur;
	}
	public void setEspCur(String espCur) {
		this.espCur = espCur;
	}
	public String getTipPlanCur() {
		return tipPlanCur;
	}
	public void setTipPlanCur(String tipPlanCur) {
		this.tipPlanCur = tipPlanCur;
	}
	public String getAnnoPlanCur() {
		return annoPlanCur;
	}
	public void setAnnoPlanCur(String annoPlanCur) {
		this.annoPlanCur = annoPlanCur;
	}
	public String getHorTotCur() {
		return horTotCur;
	}
	public void setHorTotCur(String horTotCur) {
		this.horTotCur = horTotCur;
	}
	public Byte getActivoCur() {
		return activoCur;
	}
	public void setActivoCur(Byte activoCur) {
		this.activoCur = activoCur;
	}
	public String getObsCur() {
		return obsCur;
	}
	public void setObsCur(String obsCur) {
		this.obsCur = obsCur;
	}
	@Override
	public String toString() {
		return "Curso [idCur=" + idCur + ", nomCur=" + nomCur + ", espCur=" + espCur + ", tipPlanCur=" + tipPlanCur
				+ ", annoPlanCur=" + annoPlanCur + ", horTotCur=" + horTotCur + ", activoCur=" + activoCur + ", obsCur="
				+ obsCur + "]";
	}
	
	 

}
