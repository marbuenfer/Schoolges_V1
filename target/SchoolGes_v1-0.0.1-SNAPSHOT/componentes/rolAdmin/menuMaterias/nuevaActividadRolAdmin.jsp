<%@page import="com.db.DbConexion"%>
 <%@page import="com.dao.DaoMateria"%>
<%@page import="com.logica.Actividad"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DATOS ACTIVIDADES</title>


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
							actividades</p>
						<c:if test="${not empty sucMsg}">
							<p class="text-center text-success fs-3">${sucMsg}</p>
							<c:remove var="sucMsg" scope="session" />
						</c:if>
						<c:if test="${not empty errorMsg}">
							<p class="text-center text-success fs-3">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<%
						// Obtenemos los parámetros de la URL
										String idActParamStr = request.getParameter("idAct");
										String idMatParamStr = request.getParameter("idMat");
										String nomMat = null;

										// Variables para almacenar los valores de idAct y idMat
										int idAct = 0;
										int idMat = 0;

										DaoMateria daoAct = null;
										Actividad act = null;

										daoAct = new DaoMateria(DbConexion.getConn());

										// Verificar si idAct se proporcionó y no está vacío
										if (idActParamStr != null && !idActParamStr.isEmpty()) {
											idAct = Integer.parseInt(idActParamStr);

											// Obtener los datos de la actividad por su id
											act = daoAct.getActividadById(idAct);

										} else {

											// Verificar si idMat se proporcionó y no está vacío
											if (idMatParamStr != null && !idMatParamStr.isEmpty()) {
												idMat = Integer.parseInt(idMatParamStr);

												nomMat = daoAct.getNombreByIdMateria(idMat);
											} else {
												// Mostrar mensaje de advertencia si no se seleccionó una materia
						%>
						<script>
					            Swal.fire({
					                icon: 'warning',
					                title: '¡Atención!',
					                text: 'No has seleccionado una materia.',
					                confirmButtonText: 'Aceptar'
					            }).then(() => {
					                // Redirigir a la página anterior o realizar alguna acción adicional
					                window.history.back();
					            });
					        </script>
						<%
						}
						}
						%>


						<form accept-charset="UTF-8"
							action="${pageContext.request.contextPath}/SvGuardarActividad"
							method="post">
							<input type="hidden" name="tipo"
								value="<%=request.getParameter("tipo")%>"> <input
								type="hidden" name="idAct"
								value="<%=request.getParameter("idAct")%>">
							<div class="row">
								<div class="mb-3 col-2">
									<label class="form-label">Id materia</label> <input required
										name="idMat" id="idMat_id" type="text" class="form-control"
										maxlength="3"  readonly 
										value="<%=(act != null) ? act.getIdMat() : idMat%>">
								</div>
								<div class="mb-3 col-8">
									<label class="form-label">Nombre materia</label> <input
										 name="nomMat" id="nomMat_id" type="text"
										class="form-control" maxlength="3" disabled
										value="<%=(nomMat != null) ? nomMat : ""%>">
								</div>

							</div>
							<div class="row">
								<div class="mb-3 col-12">
									<label class="form-label">Enunciado</label>
									<textarea required name="enuAct" rows="4" id="enuAct_id"
										class="form-control" maxlength="250"
										style="resize: none; overflow: auto;"><%=(act != null && act.getEnuAct() != null) ? act.getEnuAct().trim() : ""%></textarea>

								</div>

<!-- 								<div class="mb-3 col-2"> -->
<!-- 									<label class="form-label">Nota</label> <input required -->
<!-- 										name="notaAct" id="notaAct_id" type="text" -->
<!-- 										class="form-control" maxlength="4" -->
<%-- 										value="<%=(act != null) ? act.getNotaAct() : ""%>"> --%>
<!-- 								</div> -->
							</div>
							<div class="row">

								<div class="mb-3">
									<label class="form-label">Observaciones</label>
									<div class="d-flex">
										<textarea class="form-control flex-grow-1" id="obsAct_id"
											name="obsAct" rows="4" maxlength="250"
											style="resize: none; overflow: auto;"><%=(act != null && act.getObsAct() != null) ? act.getObsAct().trim() : ""%></textarea>
									</div>
								</div>

							</div>


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
					+ "/componentes/rolAdmin/menuMaterias/crudActividadesRolAdmin.jsp";
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

