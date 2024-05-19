<%@ page import="com.dao.DaoUsuario"%>
<%@page import="com.db.DbConexion"%>
<%@page import="com.logica.Alumno"%>
<%@page import="com.logica.Matricula"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.dao.DaoMatricula"%>
<%@page import="com.dao.DaoUsuario"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DATOS MATRICULAS</title>
<%-- <%@include file="/componentes/allcss.jsp"%> --%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
	<div class="container p-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card paint-card">
					<div class="card-body">
						<p style="font-size: 50px;" class="text-center">Registro de
							matriculación</p>
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
						String idParamStr = request.getParameter("idMatri");
						System.out.println("Parametro idParamStr recibido de registroAluMatri" + idParamStr);

						//int idParam = 0; // Valor predeterminado o un valor que tenga sentido en tu aplicación
						//DaoUsuario daoUsu = null;
						DaoMatricula daoMatri = null;
						//Usuario usu = null;
						Matricula matri = null;
						daoMatri = new DaoMatricula(DbConexion.getConn()); // Mueve esto al principio del método doPost

						if (idParamStr != null && !idParamStr.isEmpty()) {
							int idParam = Integer.parseInt(idParamStr);

							matri = daoMatri.getMatriculaByIdMatri(idParam);
						}

						System.out.println("\nvalor de matri..." + matri
								+ "estoy dentro de registroAluMatri, matri tiene valor o no tiene depende de si edicion y actual");
					

						
						%>

						<!-- Coloca aquí el código HTML para mostrar los datos del alumno en los campos del formulario -->
						<!-- 						<form accept-charset="UTF-8" action="SvUpdateUsuario" -->
						<form accept-charset="UTF-8" action="SvGuardarUsuario"
							method="post">
							<div class="row">
								<div class="mb-3 col-3">
									<label class="form-label">id. Alu</label> <input required
										name="idAlu" id="idAlu_id" type="hidden" class="form-control"
										value="<%=(matri != null) ? matri.getIdAlu() : ""%>">
								</div>

								<div class="mb-3 col-3">
									<label class="form-label">id. Est</label> <input required
										name="idEst" id="idEst_id" type="text" class="form-control"
										value="<%=(matri != null) ? matri.getIdEst() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-8">
									<label class="form-label">Estudio</label> <input required
										type="text" class="form-control" maxlength="45"
										value="<%=(matri != null) ? matri.getNomEst() : ""%>">
								</div>

								<div class="mb-3 col-3">
									<label class="form-label">Fecha de matriculación</label> <input
										required name="fechMatri" id="fechMatri_id" type="date"
										class="form-control"
										value="<%=(matri != null) ? matri.getFechMatri() : ""%>">
								</div>

								<div class="mb-3 col-3" id="modaAluDiv">

									<label class="form-label">Modalidad</label> <select>

										<option
											value="<%=(matri != null && matri.getModMatri() != null) ? matri.getModMatri() : ""%>"
											<%=(matri != null && matri.getModMatri() != null) ? "selected" : ""%>>
											<%=(matri != null && matri.getModMatri() != null) ? matri.getModMatri() : "Selecciona..."%>
										</option>

										<option value="" selected>Selecciona...</option>

										<option value="BAS">BASICA</option>
										<option value="ES">ESTÁNDAR</option>
										<option value="PR">PREMIUM</option>
									</select>
								</div>

							</div>

							<div class="mb-3">
								<label class="form-label">Observaciones</label>
								<textarea class="form-control" id="obsUsu_id" name="obsUsu"
									rows="4" maxlength="250">
       								 <%=(matri != null && matri.getObsMatri() != null) ? matri.getObsMatri() : ""%>
   									 </textarea>

							</div>
							<div></div>
							<input type="hidden" name="source" value="registroAlu.jsp">

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
			window.location.href = 'crudAlumnos.jsp';
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

