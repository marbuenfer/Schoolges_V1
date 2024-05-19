package com.logica;

public class Estudio {
private int idEst;
private String nomEst;
private String espeEst;
private int horaEst;
private String obsEst;


public Estudio() {

}

public Estudio(String nomEst, String espeEst, int horaEst, String obsEst) {
	this.nomEst = nomEst;
	this.espeEst = espeEst;
	this.horaEst = horaEst;
	this.obsEst = obsEst;
}

public Estudio(int idEst, String nomEst, String espeEst, int horaEst, String obsEst) {
	this.idEst = idEst;
	this.nomEst = nomEst;
	this.espeEst = espeEst;
	this.horaEst = horaEst;
	this.obsEst = obsEst;
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


public String getEspeEst() {
	return espeEst;
}


public void setEspeEst(String espeEst) {
	this.espeEst = espeEst;
}


public int getHoraEst() {
	return horaEst;
}


public void setHoraEst(int horaEst) {
	this.horaEst = horaEst;
}


public String getObsEst() {
	return obsEst;
}


public void setObsEst(String obsEst) {
	this.obsEst = obsEst;
}


@Override
public String toString() {
	return "Estudio [idEst=" + idEst + ", nomEst=" + nomEst + ", espeEst=" + espeEst + ", horaEst=" + horaEst
			+ ", obsEst=" + obsEst + "]";
}

 
}
