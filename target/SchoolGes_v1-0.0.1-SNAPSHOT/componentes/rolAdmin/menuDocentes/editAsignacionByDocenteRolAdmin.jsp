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
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Actualización de asignacion a docente</title>

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
	<%@include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>

	<div id="contenedorPrincipal">
		<div class="container p-5">
			<div class="row justify-content-center">
				<div class="col-md-8">
					<!-- 				<div class="card paint-card"> -->
					<!-- 					<div class="card-body"> -->
					<p style="font-size: 50px;" class="text-center mb-4">Edición de
						asignación a Docente</p>
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
					String idDoc = request.getParameter("idDoc");

					String idAsg = request.getParameter("idAsg");

					String nomCompUsu = request.getParameter("nomCompUsu");
					String emailUsu = request.getParameter("emailUsu");
					String fechIniAsigDoc = request.getParameter("fechIniAsigDoc");
					String fechFinAsigDoc = request.getParameter("fechFinAsigDoc");
					//String activo = request.getParameter("activo");
					String idMatStr = request.getParameter("idMat");
					String nomMat = request.getParameter("nomMatDoc");

					//out.println("Valor del parámetro idUsu: " + idParamStr);

					//DaoDocente daoMatri = null;
					AsignacionDocente asigDoc = null;

					System.out.println(
							"\nvalor de doc del que se quiere hacer una asignacion..." + "estoy dentro de nuevaAsignacionByDocente, ");
					%>

					<form accept-charset="UTF-8"
						action="${pageContext.request.contextPath}/SvGuardarAsignacionDocente"
						method="post">
						<input type="hidden" name="tipo" value="<%="editar"%>">
						<div class="row">
							<div class="mb-3 col-2">
								<label class="form-label etiqueta-negrita" for="idUsu_id">id.
									Doc</label> <input required name="idDoc" id="idDoc_id"
									class="form-control" value="<%=(idDoc != null) ? idDoc : ""%>"
									readonly
									style="background-color: #f8f9fa; color: #6c757d; border-color: #dee2e6;">
							</div>

							<div class="mb-3 col-7">
								<label class="form-label etiqueta-negrita" for="nomCompUsu_id">Nombre
									completo</label> <input required name="nomCompUsu" id="nomCompUsu_id"
									class="form-control"
									value="<%=(nomCompUsu != null) ? nomCompUsu : ""%>" readonly
									style="background-color: #f8f9fa; color: #6c757d; border-color: #dee2e6;">
							</div>

							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita" for="emailUsu_id">email</label>
								<input required name="emailUsu" id="emailUsu_id" type="text"
									class="form-control"
									value="<%=(emailUsu != null) ? emailUsu : ""%>" readonly
									style="background-color: #f8f9fa; color: #6c757d; border-color: #dee2e6;">
							</div>
						</div>
						<div class="row">
							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita"
									for="fechIniAsigDoc_id">Fecha inicio</label> <input required
									name="fechIniAsigDoc" id="fechIniAsigDoc_id" type="date"
									class="form-control" value="<%=fechIniAsigDoc%>">
							</div>
							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita"
									for="fechFinAsigDoc_id">Fecha fin</label> <input
									name="fechFinAsigDoc_id" id="fechFinAsigDoc_id" type="date"
									class="form-control" value="<%=fechFinAsigDoc%>">
							</div>
						</div>

						<%
						DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());
						List<Estudio> listaEstudios = daoEstudio.getAllEstudios();
						request.setAttribute("listaEstudios", listaEstudios);
						int idMatInt;

						if (idMatStr != null && !idMatStr.isEmpty()) {
							try {
								idMatInt = Integer.parseInt(idMatStr);
								System.out.println("El id de materia no es entero: " + idMatInt);

							} catch (NumberFormatException e) {
								// Manejar la excepción si la cadena no es un número válido
								e.printStackTrace(); // Puedes imprimir la traza o realizar otras acciones según tus necesidades
								System.err.println("Error: el id materia no representa un número entero válido.");

							}
						}

						Estudio est = daoEstudio.getEstudioByMateria(idMatStr);
						%>

						<div class="row mb-3">
							<label class="form-label etiqueta-negrita" for="idEst_id">Seleccionar
								Estudio</label>
							<div class="custom-select">
								<select id="idEst_id" class="form-control" required name="idEst"
									disabled>
									<%
									for (Estudio estudio : listaEstudios) {
										boolean isSelected = (est != null && String.valueOf(est.getIdEst()).equals(String.valueOf(estudio.getIdEst())));
									%>
									<option value="<%=est.getIdEst()%>"
										<%=isSelected ? "selected" : ""%>><%=est.getNomEst()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>


						<%
						// Obtener el idEst de los parámetros si se proporciona
						int idEstParam = (est != null) ? est.getIdEst() : 0; // Valor predeterminado a 0

						DaoMateria daoMateria = new DaoMateria(DbConexion.getConn());
						List<MateriaEnEstudio> listaMateriasEnEstudio = daoMateria.getMateriasByEstudio(idEstParam);
						request.setAttribute("listaMateriasEnEstudio", listaMateriasEnEstudio);
						%>


						<div class="row mb-3">
							<label class="form-label etiqueta-negrita" for="idMat_id">Seleccionar
								Materia</label>
							<div class="custom-select">
								<select id="idMat_id" class="form-control" required name="idMat">
									<option value="">No hay materias disponibles</option>
									<%
									for (MateriaEnEstudio materia : listaMateriasEnEstudio) {
										// Verifica si la materia actual es la que se ha pasado como parámetro
										boolean isSelected = (idMatStr != null && idMatStr.equals(String.valueOf(materia.getIdMat())));
									%>
									<option value="<%=materia.getIdMat()%>"
										<%=isSelected ? "selected" : ""%>><%=materia.getNomMat()%></option>
									<%
									}
									%>

								</select>
							</div>
						</div>

						<div class="mb-3">
							<label class="form-label etiqueta-negrita" for="obsAsigDoc_id">Observaciones</label>
							<textarea class="form-control flex-grow-1" id="obsAsigDoc_id"
								name="obsAsigDoc" rows="4" maxlength="250"
								style="resize: none; overflow: auto;">
       									 <%=(asigDoc != null && asigDoc.getObsAsigDoc() != null) ? asigDoc.getObsAsigDoc().trim() : ""%>
   							</textarea>
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

		<script
			src="${pageContext.request.contextPath}/resources/js/funciones.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/js/funcionesDocente.js"></script>
		<script>
			$(document).ready(function() {
				// Llama a la función al cargar la página para establecer el estado inicial de los botones
				actualizarEstadoBotones();
				// Llama a la función cuando se cierra el modal
				$('#materiasModalContent').on('hidden.bs.modal', function() {
					actualizarEstadoBotones();
				});
			});

			$(document)
					.ready(
							function() {
								$('#idEst_id')
										.change(
												function() {
													var idEstudioSeleccionado = $(
															this).val();

													// Realizar la solicitud AJAX al servlet para obtener las materias del estudio seleccionado
													$
															.ajax({
																url : "SvDevolverMateriasByEstudio", // Ruta del servlet
																method : "GET",
																data : {
																	idEst : idEstudioSeleccionado
																}, // Envía el ID del estudio seleccionado
																dataType : "json",
																success : function(
																		data) {
																	// Manejar la respuesta JSON que contiene las materias
																	$(
																			'#idMat_id')
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
			/**
			 * Cierra el formulario actual redirigiendo a la página "crudDocentesRolAdmin.jsp".
			 * Esta función se utiliza para cerrar el formulario actual y volver al menú principal de docentes en el rol de administrador.
			 */

			function cerrarFormulario() {
				var contextPath = "${pageContext.request.contextPath}";
				var url = contextPath
						+ "/componentes/rolAdmin/menuDocentes/crudDocentesRolAdmin.jsp";
				window.location.href = url;

				console
						.log("La función cerrarFormulario() se ha llamado correctamente.");
			}

			/**
			 * Asocia la función cerrarFormulario() al hacer clic en el botón de cierre.
			 * Esta función agrega un event listener al botón de cierre para cerrar el formulario actual al hacer clic en él.
			 */
			document.getElementById("btnCerrar").addEventListener("click",
					function() {
						cerrarFormulario();
					});
			
			
			/**
			 * Espera a que el documento esté completamente cargado para asociar la funcionalidad de enviar formularios a través de AJAX.
			 * Captura el evento de envío de formularios y realiza una solicitud AJAX al servlet especificado en el atributo "action" del formulario.
			 * Espera una respuesta JSON del servidor y muestra un mensaje de éxito o error utilizando la librería Swal.
			 */

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

