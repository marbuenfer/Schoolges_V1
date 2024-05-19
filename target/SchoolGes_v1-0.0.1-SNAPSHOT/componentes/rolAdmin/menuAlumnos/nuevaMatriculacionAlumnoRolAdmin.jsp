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

<title>Nueva Matricula</title>

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
					String idParamStr = request.getParameter("id");
					String idAlu = request.getParameter("idAlu");
					String nomComp = request.getParameter("nomComp");
					String fechMatri = request.getParameter("fechMatri");
					String modMatri = request.getParameter("modMatri");
					String activo = request.getParameter("activo");
					String idEst = request.getParameter("idEst");
					String idMat = request.getParameter("idMat");
					String obsMatri = request.getParameter("obsMatri");
					DaoUsuario daoUsu = null;
					Usuario usu = null;
					DaoAlumno daoAlu = null;

					daoUsu = new DaoUsuario(DbConexion.getConn());
					daoAlu = new DaoAlumno(DbConexion.getConn());
					System.out.println(
							"\nvalor de alu del que se quiere hacer una matriculación..." + usu + "estoy dentro de nuevaMatriculacion, ");
					%>


					<form accept-charset="UTF-8" action="SvGuardarMatricula"
						method="post">

						<%
						DaoAlumno daoAlumno = new DaoAlumno(DbConexion.getConn());
						List<Alumno> listaAlumnos = daoAlumno.getAllAlumnos();
						request.setAttribute("listaAlumnos", listaAlumnos);
						%>
						<div class="row mb-3">
							<label class="form-label etiqueta-negrita" for="idUsu_id">Seleccionar
								alumno</label>
							<div class="custom-select">
								<select id="idUsu_id" class="form-control" name="idUsu">
									<option value="">No hay alumnos disponibles</option>
									<%
									for (Alumno alumno : listaAlumnos) {
										// Verifica si la alumno actual es el que se ha seleccionado
										boolean isSelected = (idAlu != null && idAlu.equals(String.valueOf(alumno.getIdUsu())));

										// Genera la opción del select
									%>
									<option value="<%=alumno.getIdUsu()%>"
										<%=isSelected ? "selected" : ""%>><%=alumno.getNomCompUsu()%></option>
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
								<label class="form-label etiqueta-negrita" for="fechMatri_id">Fecha
									de matriculación</label> <input required name="fechMatri"
									id="fechMatri_id" type="date" class="form-control">
							</div>
							<div class="mb-3 col-3" id="modMatri_div">
								<label class="form-label etiqueta-negrita" for="modMatri_id">Modalidad</label>
								<select id="modMatri_id" name="modMatri" class="form-control">
									<option value="" <%=(modMatri == null) ? "selected" : ""%>>Selecciona...</option>
									<option value="BAS"
										<%=(modMatri != null && modMatri.equals("BAS")) ? "selected" : ""%>>BASICA</option>
									<option value="ES"
										<%=(modMatri != null && modMatri.equals("ES")) ? "selected" : ""%>>ESTÁNDAR</option>
									<option value="PR"
										<%=(modMatri != null && modMatri.equals("PR")) ? "selected" : ""%>>PREMIUM</option>
								</select>
							</div>
							<div class="mb-3 col-3" id="activoDiv">
								<div class="form-check">
									<label class="form-check-label ml-2 etiqueta-negrita"
										for="activo_id">¿Activo?</label> <input type="checkbox"
										class="form-check-input" id="activo_id" name="activo"
										<%=(activo != null && activo.equals("1")) ? "checked" : ""%> />
								</div>
							</div>
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
									<option value="">No hay estudios disponibles</option>
									<%
									for (Estudio estudio : listaEstudios) {
										// Verifica si el estudio actual es el que se ha pasado como parámetro
										boolean isSelected = (idEst != null && idEst.equals(String.valueOf(estudio.getIdEst())));
									%>
									<option value="<%=estudio.getIdEst()%>"
										<%=isSelected ? "selected" : ""%>><%=estudio.getNomEst()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>

						<%
						// Obtener el idEst de los parámetros si se proporciona
						int idEstParam = (idEst != null) ? Integer.parseInt(idEst) : 0; // Valor predeterminado a 0

						DaoMateria daoMateria = new DaoMateria(DbConexion.getConn());
						List<MateriaEnEstudio> listaMateriasEnEstudio = daoMateria.getMateriasByEstudio(idEstParam);
						request.setAttribute("listaMateriasEnEstudio", listaMateriasEnEstudio);
						%>

						<div class="mb-6">
							<label class="form-label etiqueta-negrita" for="obsMatri_id">Observaciones</label>
							<textarea class="form-control custom-textarea" id="obsMatri_id"
								name="obsMatri">
       									 <%=(obsMatri != null) ? obsMatri : ""%>
   							</textarea>
						</div>

						<!-- Botón que activa el MODAL -->
						<div class="col-md-4 mt-2">
							<button type="button" id="botonModal"
								class="btn btn-primary text-white mb-4 ms-2 col-auto d-flex align-items-center justify-content-center"
								style="margin: 10px;" data-idestudio="">
								<i class="fa fa-plus" aria-hidden="true"></i>Agregar Materia
							</button>
						</div>

						<h2>Listado matriculaciones</h2>

						<table id="miTabla"
							class="table table-bordered table-striped table-border-top table-hover responsive">
							<thead>
								<tr>
									<th>Estudio</th>
									<th>Id.Mat</th>
									<th>Materia</th>
									<th>Fech.Mat</th>
									<th>Modalidad</th>
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
								id="btnMatricular" enabled onclick="realizarMatriculacion()">Realizar
								matriculación</button>

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
							onclick="guardarSeleccionMaterias()">Guardar Selección</button>
					</div>

				</div>
			</div>
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/funciones.js"></script>

	<script>
		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});

			}

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
							var urlSvDevolverDatosByAlumno = baseUrl
									+ "/SvDevolverDatosByAlumno"
							var idAluSelec = $(this).val(); // Obtener el ID del alumno seleccionado
							$
									.ajax({
										url : urlSvDevolverDatosByAlumno,
										method : 'GET',
										data : {
											idAlu : idAluSelec
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
		/**
		 * Asocia la función cerrarFormulario al evento click del botón "btnCerrar".
		 * Esta función se ejecutará cuando se haga clic en el botón para cerrar el formulario.
		 */
		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});
		/**
		 * Asocia la función cerrarModal al evento click del botón "btnCerrarModal".
		 * Esta función se ejecutará cuando se haga clic en el botón para cerrar el modal.
		 * También se puede descomentar la línea para llamar a la función actualizarEstadoBotones después de cerrar el modal.
		 */
		document.getElementById("btnCerrarModal").addEventListener("click",
				function() {
					cerrarModal();
					//actualizarEstadoBotones();
				});
		/**
		 * Asocia la función cargarMateriasEnTablaForm() al evento click del botón con id "botonModal".
		 * Esta función se ejecutará cuando se haga clic en el botón para abrir el modal.
		 * CargarMateriasEnTablaForm() se llama dentro de una promesa para asegurarse de que se complete antes de abrir el modal.
		 * Una vez completada la carga de materias, se muestra el modal.
		 */
		$('#botonModal').click(function() {
			// Llamada a cargarMateriasEnTablaForm() dentro de una promesa para asegurarnos de que se complete antes de abrir el modal
			cargarMateriasEnTablaForm().then(function() {
				// Abrir el modal después de que cargarMateriasEnTablaForm() haya completado su ejecución
				$('#materiasModalContent').modal('show');
			});
		});
		/**
		 * Cierra manualmente el modal de materias.
		 * Esta función se utiliza para cerrar el modal de materias de forma programática.
		 */
		function cerrarModal() {
			// Cierra el modal manualmente
			$('#materiasModalContent').modal('hide');
		}
		/**
		 * Redirige a la página principal de CRUD de alumnos para el rol de administrador.
		 * Esta función se utiliza para cerrar el formulario actual y regresar a la página principal de gestión de alumnos.
		 */
		function cerrarFormulario() {
			window.location.href = 'crudAlumnosRolAdmin.jsp';
			console
					.log("La función cerrarFormulario() se ha llamado correctamente.");
		}
	</script>
</body>
</html>

