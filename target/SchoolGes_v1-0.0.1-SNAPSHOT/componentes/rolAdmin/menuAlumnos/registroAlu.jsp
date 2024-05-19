<%@ page import="com.dao.DaoUsuario"%>
<%@page import="com.db.DbConexion"%>
<%@page import="com.logica.Alumno"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.dao.DaoAlumno"%>
<%@page import="com.dao.DaoUsuario"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DATOS ALUMNO</title>


<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>

	<%@ include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>
	<div class="container p-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card paint-card">
					<div class="card-body">
						<p style="font-size: 50px;" class="text-center">Registro de
							Alumnos</p>
						<c:if test="${not empty sucMsg}">
							<p class="text-center text-success fs-3">${sucMsg}</p>
							<c:remove var="sucMsg" scope="session" />
						</c:if>
						<c:if test="${not empty errorMsg}">
							<p class="text-center text-success fs-3">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<%
						// Obtenemos el parámetro "id" de la URL
						String idParamStr = request.getParameter("id");
						System.out.println("Parametro idParamStr recibido de registroAlu" + idParamStr);

						DaoAlumno daoAlu = null;
						Alumno alu = null;
						daoAlu = new DaoAlumno(DbConexion.getConn()); // Mueve esto al principio del método doPost

						if (idParamStr != null && !idParamStr.isEmpty()) {
							int idParam = Integer.parseInt(idParamStr);

							alu = daoAlu.getAlumnoById(idParam);
						}

						System.out.println("\nvalor de alu..." + alu
								+ "estoy dentro de registroAlu, alu tiene valor o no tiene depende de si edicion y actual");
						%>


						<form accept-charset="UTF-8"
							action="${pageContext.request.contextPath}/SvGuardarUsuario"
							method="post">
							<div class="row">

								<div class="mb-3 col-8">
									<label class="form-label">Nombre Completo</label> <input
										required name="nomCompUsu" id="nomCompUsu_id" type="text"
										class="form-control" maxlength="45"
										value="<%=(alu != null) ? alu.getNomCompUsu() : ""%>">
								</div>
								<div class="mb-3 col-3">
									<label class="form-label">DNI</label> <input required
										name="dniUsu" id="dniUsu_id" type="text" class="form-control"
										value="<%=(alu != null) ? alu.getDniUsu() : ""%>">
								</div>
								<div class="mb-3 col-4">
									<label class="form-label">Email address</label> <input required
										name="emailUsu" id="emailUsu_id" type="email"
										class="form-control" autocomplete="username"
										value="<%=(alu != null) ? alu.getEmailUsu() : ""%>">
								</div>

								<div class="mb-3 col-4">
									<label class="form-label">Password</label> <input required
										name="pswordUsu" id="pswordUsu_id" type="password"
										class="form-control" maxlength="8"
										autocomplete="current-password"
										value="<%=(alu != null) ? alu.getPswordUsu() : ""%>">
								</div>
								<input type="hidden" name="tipoRolUsu" value="AL">
								<div class="mb-3 col-3">
									<label class="form-label">Fecha de nacimiento</label> <input
										required name="fechNacUsu" id="fechNacUsu_id" type="date"
										class="form-control"
										value="<%=(alu != null) ? alu.getFechNacUsu() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-3">
									<label class="form-label">Teléfono</label> <input name="telUsu"
										id="telUsu_id" type="tel" class="form-control"
										pattern="[0-9]{9}"
										value="<%=(alu != null) ? alu.getTelUsu() : ""%>">
								</div>
								<div class="mb-3 col-8">
									<label class="form-label">Dirección</label> <input
										name="direcUsu" id="direcUsu_id" type="text"
										class="form-control" maxlength="45"
										value="<%=(alu != null) ? alu.getDirecUsu() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-5">
									<label class="form-label">Localidad</label> <input type="text"
										class="form-control" id="localUsu_id" name="localUsu"
										maxlength="45"
										value="<%=(alu != null) ? alu.getLocalUsu() : ""%>">
								</div>
								<div class="mb-3 col-5">
									<label class="form-label">Provincia</label> <input type="text"
										class="form-control" id="provUsu_id" name="provUsu"
										maxlength="45"
										value="<%=(alu != null) ? alu.getProvUsu() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-7" id="tituIngAluDiv">
									<label class="form-label">Título ingreso</label> <input
										type="text" class="form-control" id="tituIngAlu_id"
										name="tituIngAlu" maxlength="60"
										value="<%=(alu != null) ? alu.getTituIngAlu() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-3" id="activoDiv">
									<div class="form-check">
										<label class="form-check-label ml-2" for="activo_id">¿Activo?</label>
										<input type="checkbox" class="form-check-input" id="activo_id"
											name="activo"
											<%=(alu != null && alu.getActivo() == 1) ? "checked" : ""%>>
									</div>
								</div>


								<div class="mb-3">
									<label class="form-label">Observaciones</label>
									<textarea class="form-control" id="obsUsu_id" name="obsUsu"
										rows="4" maxlength="250">
       								 <%=(alu != null && alu.getObsUsu() != null) ? alu.getObsUsu() : ""%>
   									 </textarea>

								</div>
								<div>
									<input type="hidden" name="idUsu"
										value="<%=(alu != null) ? alu.getIdUsu() : ""%>">
								</div>

							</div>
							<input type="hidden" name="source" value="registroAlu.jsp">
							<input type="hidden" name="tipoRolUsu" value="AL">
							

							<div class="row d-flex justify-content-center">
								<button type="submit"
									class="btn btn-success text-white mb-4 me-2 col-auto">Guardar</button>
								<button type="button"
									class="btn btn-danger text-white mb-4  ms-2 col-auto"
									id="btnCerrar" onclick="cerrarFormulario()">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		// Define la función para generar las opciones de años
		// 		function generarOpcionesAnios() {
		// 			// Obtén el elemento select
		// 			var annoAcaAlu = document.getElementById("annoAcaAlu");

		// 			// Obtiene el año actual
		// 			var anioActual = new Date().getFullYear();

		// 			// Define el número de años hacia atrás que deseas incluir en la lista
		// 			var numAnios = 40;

		// 			// Genera las opciones para los años
		// 			for (var i = 0; i < numAnios; i++) {
		// 				var anio = anioActual - i;
		// 				var option = document.createElement("option");
		// 				option.value = anio;
		// 				option.text = anio;
		// 				annoAcaAlu.appendChild(option);
		// 			}
		// 		}

		// Llama a la función al cargar la página o en el momento que desees
		//	generarOpcionesAnios();

		function cerrarFormulario() {
			var contextPath = "${pageContext.request.contextPath}";
			var url = contextPath + "/componentes/rolAdmin/menuAlumnos/crudAlumnosRolAdmin.jsp";
			window.location.href = url;

			console
					.log("La función cerrarFormulario() se ha llamado correctamente.");
		}

		// Asocia la función cerrarFormulario() al hacer clic en el botón de cierre
		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});
	</script>

</body>
</html>

