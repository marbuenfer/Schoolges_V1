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

<title>Edición de Matriculas</title>
<script
	src="${pageContext.request.contextPath}/resources/js/funciones.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/estilos.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Bootstrap CSS (opcional) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<!-- DataTables CSS -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">

<!-- DataTables JS -->
<script
	src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>

<link rel="stylesheet" type="text/css" href="componentes/estilos.css">

<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->

<!-- SweetAlert -->
<!-- <script src="resources/js/sweetalert2.min.js"></script> -->
<link rel="stylesheet" href="resources/css/sweetalert2.min.css">


<style type="text/css">
/* .paint-card { */
/* 	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3); */
/* } */
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
					<p style="font-size: 50px;" class="text-center mb-4">Edición de
						matricula</p>
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

					DaoMatricula daoMatri = null;
					Matricula matri = null;

					DaoUsuario daoUsu = null;
					Usuario usu = null;

					DaoAlumno daoAlu = null;

					daoUsu = new DaoUsuario(DbConexion.getConn());
					daoAlu = new DaoAlumno(DbConexion.getConn());
					daoMatri = new DaoMatricula(DbConexion.getConn());

					System.out.println(
							"\nvalor de alu del que se quiere hacer una matriculación..." + usu + "estoy dentro de nuevaMatriculacion, ");
					%>
					<form accept-charset="UTF-8" action="SvGuardarMatricula"
						method="post">
						<div class="row">
							<div class="mb-3 col-2">
								<label class="form-label etiqueta-negrita" for="idUsu_id">id.
									Alu</label> <input required name="idUsu" id="idUsu_id"
									class="form-control" value="<%=(idAlu != null) ? idAlu : ""%>">
							</div>
							<div class="mb-3 col-7">
								<label class="form-label etiqueta-negrita" for="nomCompUsu_id">Nombre
									completo</label> <input required name="nomCompUsu" id="nomCompUsu_id"
									class="form-control"
									value="<%=(nomComp != null) ? nomComp : ""%>">
							</div>
							<%
							DaoUsuario daoUsuario = new DaoUsuario(DbConexion.getConn());
							int idAluInt = 0;

							if (idAlu != null && !idAlu.isEmpty()) {
								try {
									idAluInt = Integer.parseInt(idAlu);
									System.out.println("El número entero es: " + idAluInt);

								} catch (NumberFormatException e) {
									// Manejar la excepción si la cadena no es un número válido
									e.printStackTrace(); //  imprimir la traza o realizar otras acciones según tus necesidades
									System.err.println("Error: El String no representa un número entero válido.");

								}
							}

							usu = daoUsuario.getUsuarioById(idAluInt);
							%>

							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita" for="emailUsu_id">email</label>
								<input required name="emailUsu" id="emailUsu_id" type="text"
									class="form-control"
									value="<%=(usu.getEmailUsu() != null) ? usu.getEmailUsu() : ""%>">
							</div>
						</div>
						<div class="row">
							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita" for="fechMatri_id">Fecha
									de matriculación</label> <input required name="fechMatri"
									id="fechMatri_id" type="date" class="form-control"
									value="<%=(fechMatri != null) ? fechMatri : ""%>">
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

						<div class="row mb-3">
							<label class="form-label etiqueta-negrita" for="idMat_id">Seleccionar
								Materia</label>
							<div class="custom-select">
								<select id="idMat_id" class="form-control" required name="idMat">
									<option value="">No hay materias disponibles</option>
									<%
									for (MateriaEnEstudio materia : listaMateriasEnEstudio) {
										// Verifica si la materia actual es la que se ha pasado como parámetro
										boolean isSelected = (idMat != null && idMat.equals(String.valueOf(materia.getIdMat())));

										// Genera la opción del select
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
							<label class="form-label">Observaciones</label>
							<div class="d-flex">
								<textarea class="form-control flex-grow-1" id="obsMatri_id"
									name="obsMatri" rows="4" maxlength="250"
									style="resize: none; overflow: auto;"><%=(obsMatri != null) ? obsMatri.trim() : ""%></textarea>
							</div>
						</div>
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
	<script
		src="${pageContext.request.contextPath}/resources/js/funciones.js"></script>
	<script src="resources/js/funciones.js"></script>
	<script>
		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});
		// Asocia la función cerrarFormulario() al hacer clic en el botón de cierre

		function cerrarFormulario() {
			window.location.href = 'crudMatriculaciones.jsp';
			console
					.log("La función cerrarFormulario() se ha llamado correctamente.");
		}

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
	</script>


</body>
</html>

