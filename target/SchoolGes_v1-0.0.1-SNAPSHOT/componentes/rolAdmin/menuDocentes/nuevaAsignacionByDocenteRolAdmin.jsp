<%@ page
	import="com.dao.DaoUsuario, com.db.DbConexion, com.logica.*, com.dao.*, java.util.List, com.google.gson.Gson"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->

<title>Nueva asignación de materias</title>

<style type="text/css">

/* Estilo para el cuadro de selección personalizado */
body {
	margin: 0; /* Elimina el margen predeterminado del body */
	padding: 0; /* Elimina el relleno predeterminado del body */
	overflow-x: hidden; /* Evita la barra de desplazamiento horizontal */
}

#contenedorPrincipal {
	max-width: 100%;
	/* Establece un ancho máximo para el contenedor principal */
	margin: 0 auto; /* Centra el contenedor en la pantalla */
	padding: 20px;
	/* Añade un relleno para mayor espacio alrededor de los elementos */
}

.etiqueta-negrita {
	font-weight: bold;
}

.custom-select {
	position: relative;
	width: 100%;
}

/* Estilo para ocultar la flecha predeterminada del cuadro de selección */
.custom-select select {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	padding-right: 2 rem;
	/* Ajusta el espaciado a la derecha para la flecha */
}

/* Estilo para la flecha personalizada */
.custom-select:after {
	content: '\25BC'; /* Código Unicode para la flecha hacia abajo */
	font-size: 12px;
	color: #555;
	position: absolute;
	top: 50%;
	right: 20px; /* Ajusta la posición de la flecha a la derecha */
	transform: translateY(-50%);
}
</style>

</head>
<body>
	<%@ include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>
	<div id="contenedorPrincipal">
		<div class="container p-5">
			<div class="row">
				<div class="col-md-8">
					<p style="font-size: 50px;" class="text-center mb-4">Nueva
						asignación de materias</p>
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
					// Verificar si el parámetro id no es null ni está vacío

					DaoUsuario daoUsu = null;
					Usuario usu = null;

					DaoDocente daoDoc = null;

					daoUsu = new DaoUsuario(DbConexion.getConn());
					daoDoc = new DaoDocente(DbConexion.getConn());

					System.out.println("\nvalor de doc del que se quiere hacer una asignacion...estoy dentro de AsignacionDocente, ");
					%>


					<form accept-charset="UTF-8" action="SvGuardarAsignacionDocente"
						method="post">
						<input type="hidden" name="tipo" value="<%="nuevo"%>">

						<%
						DaoDocente DaoDocente = new DaoDocente(DbConexion.getConn());
						List<Docente> listaDocentes = DaoDocente.getAllDocentes();
						request.setAttribute("listaDocentes", listaDocentes);
						%>


						<div class="row mb-3">
							<label class="form-label etiqueta-negrita" for="idUsu_id">Seleccionar
								Docente</label>
							<div class="custom-select">
								<select id="idUsu_id" class="form-control" name="idUsu">
									<option value="">No hay docentes seleccionados</option>
									<%
									for (Docente docente : listaDocentes) {
									%>
									<option value="<%=docente.getIdUsu()%>">
										<%=docente.getIdUsu()%> -
										<%=docente.getNomCompUsu()%>
									</option>
									<%
									}
									%>
								</select>
							</div>

							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita" for="emailUsu_id">email</label>
								<input required name="emailUsu" id="emailUsu_id" type="text"
									disabled class="form-control">
							</div>
						</div>

						<div class="row">
							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita"
									for="fechIniAsigDoc_id">Fecha inicio</label> <input required
									name="fechIniAsigDoc" id="fechIniAsigDoc_id" type="date"
									class="form-control">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita"
									for="fechFinAsigDoc_id">Fecha fin</label> <input required
									name="fechFinAsigDoc" id="fechFinAsigDoc_id" type="date"
									class="form-control">
							</div>

							<!-- 							<div class="mb-3 col-3" id="activoDiv"> -->
							<!-- 								<div class="form-check"> -->
							<!-- 									<label class="form-check-label ml-2 etiqueta-negrita" -->
							<!-- 										for="activo_id">¿Activo?</label> <input type="checkbox" -->
							<!-- 										class="form-check-input" id="activo_id" name="activo" -->
							<%-- 										<%=(activo != null && activo.equals("1")) ? "checked" : ""%> /> --%>
							<!-- 								</div> -->
							<!-- 							</div> -->

						</div>

						<%
						DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());
						List<Estudio> listaEstudios = daoEstudio.getAllEstudios();
						request.setAttribute("listaEstudios", listaEstudios);
						%>

						<div class="row mb-3">
							<label class="form-label etiqueta-negrita" for="idEst_id">Seleccionar
								Estudio</label>
							<div class="custom-select">
								<select id="idEst_id" class="form-control" required name="idEst">
									<option value="">No hay estudios seleccionados</option>
									<%
									for (Estudio estudio : listaEstudios) {
									%>
									<option value="<%=estudio.getIdEst()%>">
										<%=estudio.getNomEst()%>
									</option>
									<%
									}
									%>
								</select>

							</div>
						</div>




						<div class="mb-6">
							<label class="form-label etiqueta-negrita" for="obsAsigDoc_id">Observaciones</label>
							<textarea class="form-control custom-textarea" id="obsAsigDoc_id"
								name="obsAsigDoc"></textarea>
						</div>

						<!-- Botón que activa el MODAL -->
						<div class="col-md-4 mt-2">
							<button type="button" id="botonModal"
								class="btn btn-primary text-white mb-4 ms-2 col-auto d-flex align-items-center justify-content-center"
								style="margin: 10px;" data-idestudio="">
								<i class="fa fa-plus" aria-hidden="true"></i>Agregar Materia
							</button>
						</div>

						<h2>Listado asignaciones</h2>

						<table id="miTabla"
							class="table table-bordered table-striped table-border-top table-hover responsive">
							<thead>
								<tr>
									<th>Estudio</th>
									<th>Id.Mat</th>
									<th>Materia</th>
									<th>Fech.Ini</th>
									<th>Fech.Fin</th>
									<th>Obs.Mat</th>
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>

						<div class="row d-flex justify-content-center">
							<button type="button"
								class="btn btn-success text-white mb-4 ms-2 col-auto"
								id="btnAsignar"
								onclick="realizarAsignacionDocente()">Realizar
								asignación</button>
							<button type="button"
								class="btn btn-primary text-white mb-4 ms-2 col-auto"
								id="btnCerrar" onclick="cerrarFormulario()">Cerrar</button>
							<button type="button"
								class="btn btn-danger text-white mb-4 ms-2 col-auto"
								id="btnBorrarAll" onclick="borrarAllMaterias()">Quitar
								matriculas</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="modal fade" id="materiasModalContent" tabindex="-1"
			role="dialog" aria-labelledby="materiasModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="materiasModalLabel">Seleccionar
							Materias</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close" id="btnCerrarModal"></button>
					</div>
					<div class="modal-body">
						<!-- Aquí va la tabla con las materias -->
						<table class="table">
							<thead>
								<tr>
									<th>ID Materia</th>
									<th>Nombre Materia</th>
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody id="materiasTableBody">
								<!-- Aquí se llenarán las filas de la tabla con datos dinámicamente -->
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button"
							class="btn btn-danger text-white mb-4 ms-2 col-auto"
							onclick="cerrarModal()">Cerrar</button>
						<button type="button"
							class="btn btn-primary text-white mb-4 ms-2 col-auto"
							onclick="guardarSeleccionMateriasAsignadasDocente()">Guardar
							Selección</button>
					</div>

				</div>
			</div>
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/funciones.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/funcionesDocente.js"></script>

	<script>
		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});

		$(document)
				.ready(
						function() {
							// Llama a la función al cargar la página para establecer el estado inicial de los botones
							actualizarEstadoBotones();
							// Llama a la función cuando se cierra el modal
							$('#materiasModalContent').on('hidden.bs.modal',
									function() {
										actualizarEstadoBotones();
									});
							$('#idEst_id')
									.change(
											function() {
												var idEstudioSeleccionado = $(
														this).val();
												// Definir la URL base de la aplicación
												var baseUrl = window.location.origin
														+ '/SchoolGes_v1';

												// Construir la URL para el servlet SvDevolverDatosByAlumno
												var urlSvDevolverDatosByEstudio = baseUrl
														+ "/SvDevolverMateriasByEstudio"

												// Realizar la solicitud AJAX al servlet para obtener las materias del estudio seleccionado
												$
														.ajax({
															url : urlSvDevolverDatosByEstudio, // Ruta del servlet
															method : "GET",
															data : {
																idEst : idEstudioSeleccionado
															}, // Envía el ID del estudio seleccionado
															dataType : "json",
															success : function(
																	data) {
																// Manejar la respuesta JSON que contiene las materias
																$('#idMat_id')
																		.empty(); // Limpiar el select de materias

																// Verificar si hay materias disponibles
																if (data.length === 0) {
																	// Si no hay materias, agregar una opción que lo indique
																	$(
																			'#idMat_id')
																			.append(
																					'<option value="">No hay materias disponibles</option>');
																} else {
																	// Si hay materias, agregar las opciones de materias al select
																	$
																			.each(
																					data,
																					function(
																							index,
																							materia) {
																						$(
																								'#idMat_id')
																								.append(
																										$(
																												'<option>',
																												{
																													value : materia.idMat,
																													text : materia.nomMat
																												}));
																					});
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																console
																		.error(
																				"Error en la solicitud AJAX:",
																				textStatus,
																				errorThrown);
																// Manejar el error si la solicitud AJAX falla
															}
														});
											});
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

		// 	Seleccionar el email según el alumno seleccionado
		$('#idUsu_id')
				.change(
						function() {
							console
									.log('Cambio detectado en el elemento de selección');
							// Definir la URL base de la aplicación
							var baseUrl = window.location.origin
									+ '/SchoolGes_v1';

							// Construir la URL para el servlet SvDevolverDatosByAlumno
							var urlSvDevolverDatosByDocente = baseUrl
									+ "/SvDevolverDatosByDocente"
							var idDocSelec = $(this).val(); // Obtener el ID del docente seleccionado
							console.log("idDocSelec" + idDocSelec);
							$
									.ajax({
										url : urlSvDevolverDatosByDocente,
										method : 'GET',
										data : {
											idDoc : idDocSelec
										},
										dataType : 'json',
										success : function(response) {
											console.log(
													'Respuesta del servidor:',
													response); // Imprimir la respuesta del servidor en la consola
											// Verificar si la respuesta contiene el correo electrónico esperado
											if (response && response.emailUsu) {
												$('#emailUsu_id').val(
														response.emailUsu); // Rellenar el campo de correo electrónico
												$('#activo_id').prop('checked',
														response.activo === 1); // Marcar o desmarcar el checkbox según el valor de "activo"

											} else {
												console
														.error('La respuesta del servidor no contiene los datos esperados.');
											}
										},
										error : function(jqXHR, textStatus,
												errorThrown) {
											console
													.error(
															'Error en la solicitud AJAX:',
															textStatus,
															errorThrown);
										}
									});
						});
		// Asociar la función cerrarFormulario al evento click del botón con el id "btnCerrar"
		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});
		document.getElementById("btnCerrarModal").addEventListener("click",
				function() {
					cerrarModal();
					//actualizarEstadoBotones();
				});
		// Asociar la función cerrarModal al evento click del botón con el id "btnCerrarModal"
		$('#botonModal').click(function() {
			// Llamada a cargarMateriasEnTablaForm() dentro de una promesa para asegurarnos de que se complete antes de abrir el modal
			cargarMateriasAsignacionEnTablaFormEstudio().then(function() {
				// Abrir el modal después de que cargarMateriasEnTablaForm() haya completado su ejecución
				$('#materiasModalContent').modal('show');
			});
		});
		/**
		 * Función para cerrar manualmente el modal de materias.
		 */
		function cerrarModal() {
			// Cierra el modal manualmente
			$('#materiasModalContent').modal('hide');
		}
		/**
		 * Función para cerrar el formulario y redirigir a la página 'crudDocentesRolAdmin.jsp'.
		 */
		function cerrarFormulario() {
			window.location.href = 'crudDocentesRolAdmin.jsp';
			console
					.log("La función cerrarFormulario() se ha llamado correctamente.");
		}
	</script>


</body>
</html>

