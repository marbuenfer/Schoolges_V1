<%@page import="com.db.DbConexion"%>
<%@page import="com.logica.Estudio"%>
<%@page import="com.dao.DaoEstudio"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DATOS ESTUDIOS</title>


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
							estudios</p>
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
						String idParamStr = request.getParameter("idEst");
						System.out.println("Parametro idParamStr recibido de crudEstudiosRolAdmin" + idParamStr);

						DaoEstudio daoEst = null;
						Estudio est = null;
						daoEst = new DaoEstudio(DbConexion.getConn()); // Mueve esto al principio del método doPost

						if (idParamStr != null && !idParamStr.isEmpty()) {
							int idParam = Integer.parseInt(idParamStr);

							est = daoEst.getEstudioById(idParam);
						}

						System.out.println("\nvalor de  ..." + est
								+ "estoy dentro de nuevoEstudioRolAdmin, est tiene valor o no tiene depende de si edicion y actual");
						%>


						<form accept-charset="UTF-8"
							action="${pageContext.request.contextPath}/SvGuardarEstudio"
							method="post">

							<input type="hidden" name="tipo"
								value="<%=request.getParameter("tipo")%>"> <input
								type="hidden" name="idEst"
								value="<%=request.getParameter("idEst")%>">
							<div class="row">
								<div class="mb-3 col-8">
									<label class="form-label">Nombre estudio</label> <input
										required name="nomEst" id="nomEst_id" type="text"
										class="form-control" maxlength="45"
										value="<%=(est != null) ? est.getNomEst() : ""%>">
								</div>
								<div class="mb-3 col-2">
									<label class="form-label">Horas</label> <input required
										name="horaEst" id="horaEst_id" type="text"
										class="form-control" autocomplete="horaEst"
										value="<%=(est != null) ? est.getHoraEst() : ""%>">
								</div>

							</div>
							<div class="row">
								<div class="mb-3 col-8">
									<label class="form-label">Especialidad</label> <input required
										name="espeEst" id="espEst_id" type="text" class="form-control"
										maxlength="45"
										value="<%=(est != null) ? est.getEspeEst() : ""%>">
								</div>

							</div>
							<div class="row">

								<div class="mb-3">
									<label class="form-label">Observaciones</label>
									<div class="d-flex">
										<textarea class="form-control flex-grow-1" id="obsEst_id"
											name="obsEst" rows="4" maxlength="250"
											style="resize: none; overflow: auto;"><%=(est != null && est.getObsEst() != null) ? est.getObsEst().trim() : ""%></textarea>
									</div>
								</div>

							</div>
							<!-- 								 

							 
<!-- 							<input type="hidden" name="source" value="nuevoEstudioRolAdmin.jsp"> -->

							<div class="row d-flex justify-content-center">
								<button type="submit"
									class="btn btn-success text-white mb-4 me-2 col-auto"
									id="btnGuardar">Guardar</button>
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
		function cerrarFormulario() {
			var contextPath = "${pageContext.request.contextPath}";
			var url = contextPath
					+ "/componentes/rolAdmin/menuEstudios/crudEstudiosRolAdmin.jsp";
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

	<script>
		$(document).ready(function() {
			// Capturar el envío del formulario
			$('form').submit(function(event) {
				// Detener el envío del formulario para manejarlo manualmente
				event.preventDefault();

				// Realizar una solicitud AJAX al servlet
				$.ajax({
					url : $(this).attr('action'), // Obtener la URL del formulario
					type : $(this).attr('method'), // Obtener el método del formulario (POST)
					data : $(this).serialize(), // Obtener los datos del formulario serializados
					dataType : 'json', // Esperar una respuesta JSON del servidor
					success : function(response) {
						// Manejar la respuesta del servidor
						if (response.success) {
							// Si la operación fue exitosa, mostrar un mensaje de éxito con Swal
							Swal.fire({
								icon : 'success',
								title : 'Éxito',
								text : response.message
							});
						} else {
							// Si la operación falló, mostrar un mensaje de error con Swal
							Swal.fire({
								icon : 'error',
								title : 'Error',
								text : response.message
							});
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						// Si la solicitud AJAX falla, mostrar un mensaje de error genérico
						Swal.fire({
							icon : 'error',
							title : 'Error',
							text : 'Error al procesar la solicitud'
						});
					}
				});
			});
		});
	</script>
</body>
</html>

