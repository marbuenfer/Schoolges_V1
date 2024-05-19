<%@page import="com.dao.DaoUsuario"%>
<%@page import="com.logica.Matricula"%>
<%@page import="com.logica.Alumno"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.dao.DaoAlumno"%>
<%@page import="com.dao.DaoMatricula"%>



<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="com.db.DbConexion"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Listado alumnos</title>
 
</head>
<body>
	<%-- 	<%@include file="/resources/css/allcss.jsp"%> --%>
	<%-- 	<%@include file="/componentes/navbar.jsp"%> --%>
	<h2>DATOS PERSONALES</h2>

	<%
	Usuario userObj = (Usuario) session.getAttribute("userObj");
	%>
	<!-- Este bloque de código representa un formulario para mostrar información de usuario. -->
	<div class="row">
		<div class="mb-3 col-3">
			<label class="form-label">Nombre completo</label> <input readonly
				style="width: 100%;" name="nomCompUsu" id="nomCompUsu_id"
				type="text" class="form-control"
				value="<%=(userObj != null) ? userObj.getNomCompUsu() : ""%>">
		</div>
		<div class="mb-3 col-2">
			<label class="form-label">DNI</label> <input readonly
				style="width: 50%;" name="dniUsu" id="dniUsu_id" type="text"
				class="form-control"
				value="<%=(userObj != null) ? userObj.getDniUsu() : ""%>">
		</div>
		<div class="mb-3 col-3">
			<label class="form-label">email</label> <input readonly
				name="emailUsu" id="emailUsu_id" type="email" readonly
				style="width: 50%;" class="form-control"
				value="<%=(userObj != null) ? userObj.getEmailUsu() : ""%>">
		</div>
		<div class="mb-3 col-3">
			<label class="form-label">Fecha de nac.</label> <input readonly
				style="width: 25%;" name="fechNacUsu" id="fechNacUsu_id" type="date"
				class="form-control"
				value="<%=(userObj != null) ? userObj.getFechNacUsu() : ""%>">
		</div>
		<div class="mb-3 col-3">
			<label class="form-label">Teléfono</label> <input readonly
				style="width: 20%;" name="telUsu" id="telUsu_id" type="text"
				class="form-control"
				value="<%=(userObj != null) ? userObj.getTelUsu() : ""%>">
		</div>
	</div>
	<div class="row">
		<div class="mb-3 col-3">
			<label class="form-label">Dirección</label> <input readonly
				style="width: 100%;" name="direUsu" id="direUsu_id" type="text"
				class="form-control"
				value="<%=(userObj != null) ? userObj.getDirecUsu() : ""%>">
		</div>
		<div class="mb-3 col-3">
			<label class="form-label">Localidad</label> <input readonly
				style="width: 100%;" name="localUsu" id="localUsu_id" type="text"
				class="form-control"
				value="<%=(userObj != null) ? userObj.getLocalUsu() : ""%>">
		</div>
		<div class="mb-3 col-3">
			<label class="form-label">Provincia</label> <input readonly
				style="width: 100%;" name="provUsu" id="provUsu_id" type="text"
				class="form-control"
				value="<%=(userObj != null) ? userObj.getProvUsu() : ""%>">
		</div>
	</div>
	<h2 class="mt-5">COMPAÑEROS DE ESTUDIO</h2>
	<div style="margin-top: 50px;">
		<button type="button" class="btn btn-warning text-white"
			style="margin: 10px;" id="botonMisMatriculas"
			data-id="<%=userObj.getIdUsu()%>">Mis matriculas</button>

	</div>
	<!-- Esta tabla muestra información de los alumnos. -->
	<table id="miTabla"
		class="table table-bordered table-striped table-border-top table-hover responsive"
		style="width: 100%">
		<thead>
			<tr>
				<th></th>
				<!-- Columna de selección -->
				<th>ID</th>
				<th>Nombre Completo</th>
				<th>Email</th>
				<th>Estudio</th>
			</tr>
		</thead>
		<tbody>
			<%
			DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());

			// Verificar si userObj no es nulo y si tiene un idAlu
			if (userObj != null && userObj.getIdUsu() != 0) {
				int idAlu = userObj.getIdUsu(); // Obtener el idAlu de userObj
				List<Alumno> listaAlumnos = daoAlu.getAllAlumnosByEstudio(idAlu);
				System.out.println("objeto userobj" + userObj.toString());
				// Utilizar listaAlumnos para mostrar la tabla y los botones
				for (Alumno alu : listaAlumnos) {
			%>
			<tr>
				<td><input type="checkbox" class="seleccionar-fila"></td>
				<td><%=alu.getIdUsu()%></td>
				<td><%=alu.getNomCompUsu()%></td>
				<td><%=alu.getEmailUsu()%></td>
				<td><%=alu.getNomEst()%></td>

			</tr>
			<%
			} // Fin del bucle for
			} else {

			response.sendRedirect("/usuarioLogin.jsp");
			}
			%>
		</tbody>
	</table>

	<!-- 	<h2 class="mt-5">MIS ACTIVIDADES</h2> -->
	<!-- 	<div style="margin-top: 50px;"> -->
	<!-- 		<button type="button" class="btn btn-warning text-white" -->
	<!-- 			style="margin: 10px;" id="botonMisActividades" -->
	<%-- 			data-id="<%=userObj.getIdUsu()%>">Mis actividades</button> --%>
	<!-- 	</div> -->


	<!-- Modal modalMisMatriculas-->
	<div class="modal fade" id="modalMisMatriculas" tabindex="-1"
		role="dialog" aria-labelledby="modalMisMatriculasTitulo"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-xl"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalMisMatriculasTitulo">Mis
						matriculas</h5>

				</div>

				<div class="modal-body"></div>

				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="botonModalMisMatriculasCerrar">Cerrar</button>
				</div>

			</div>
		</div>

	</div>

	<!-- Fin del modal modalMisMatriculas -->


	<script>
		var tabla;
		var tipoRol;
		/**
		 * Maneja el evento de clic en el botón para cerrar el modal de mis matrículas.
		 * Oculta el modal correspondiente.
		 */
		$('#botonModalMisMatriculasCerrar').click(function() {
			$('#modalMisMatriculas').modal('hide');
		});
		/**
		 * Maneja el evento de clic en el botón para cargar las matrículas del usuario.
		 * Obtiene el ID del usuario desde el atributo 'data-id' del botón y llama a la función cargarMisMatriculas con dicho ID.
		 */
		$('#botonMisMatriculas').click(function() {
			var id = $(this).data('id');
			cargarMisMatriculas(id);
		});

		/**
		 * Realiza una solicitud AJAX para cargar las matrículas del alumno con el ID especificado.
		 * 
		 * @param {number} idAlu - El ID del alumno cuyas matrículas se cargarán.
		 */
		function cargarMisMatriculas(idAlu) {
			var contextPath = '${pageContext.request.contextPath}';
			var servletUrl = contextPath + "/SvMostrarMatriculacionesByAlumno";
			var url = servletUrl + "?idAlu=" + idAlu;
			$.ajax({
				url : url,
				method : 'GET',
				dataType : 'json',
				success : function(matriculas) {
					// Función para manejar la respuesta exitosa del servlet
					mostrarMatriculas(matriculas);
				},
				error : function(xhr, status, error) {
					// Función para manejar errores de la llamada AJAX
					console.error('Error al cargar matrículas:', error);
				}
			});
		}
		/**
		 * Muestra las matrículas recibidas en un modal.
		 * 
		 * @param {Array} matriculas - Matrículas a mostrar en el modal.
		 */
		function mostrarMatriculas(matriculas) {
			// Obtener el cuerpo del modal donde se mostrarán las matrículas
			var modalBody = document.getElementById('modalMisMatriculas')
					.getElementsByClassName('modal-body')[0];

			// Limpiar el contenido actual del modal
			modalBody.innerHTML = '';

			// Crear una tabla para mostrar las matrículas
			var table = document.createElement('table');
			table.classList.add('table');

			// Crear la cabecera de la tabla
			var thead = document.createElement('thead');
			var headerRow = document.createElement('tr');
			var headers = [ 'ID Matrícula', 'ID Estudio', 'NOM Estudio',
					'ID MAT', 'NOM MAT', 'Fech Matri,', 'Modalidad' ];

			headers.forEach(function(headerText) {
				var th = document.createElement('th');
				th.textContent = headerText;
				headerRow.appendChild(th);
			});

			thead.appendChild(headerRow);
			table.appendChild(thead);

			// Crear el cuerpo de la tabla
			var tbody = document.createElement('tbody');
			matriculas.forEach(function(matricula) {
				var row = document.createElement('tr');
				var cells = [ matricula.idMatri, matricula.idEst,
						matricula.nomEst, matricula.idMat, matricula.nomMat,
						matricula.fechMatri, matricula.modMatri ];

				cells.forEach(function(cellText) {
					var cell = document.createElement('td');
					cell.textContent = cellText;
					row.appendChild(cell);
				});

				tbody.appendChild(row);
			});

			table.appendChild(tbody);
			modalBody.appendChild(table);

			// Mostrar el modal
			$('#modalMisMatriculas').modal('show');
		}

		$(document)
				.ready(
						function() {
							tabla = $('#miTabla')
									.DataTable(
											{
												select : {
													style : 'multi' // Permite la selección múltiple
												},

												paging : true,
												dom : '<"d-flex justify-content-center"f><"d-flex justify-content-end mb-2"B>t<"d-flex justify-content-end"i>',
												pageLength : 18, // número de registros a mostrar por página
												buttons : [
														{
															extend : 'pdf',
															title : 'Listado alumnos', // Título del archivo Excel
															className : 'btn btn-outline-secondary', // Clase CSS para el botón
															text : 'PDF', // Texto del botón
															filename : 'listadoAlumnos', // Nombre del archivo PDF generado
															className : 'btn-exportar-pdf', // Clase CSS adicional para el botón (si es necesario)
															exportOptions : {
																columns : [ 0,
																		1, 2, 3 ]
															// Mantener solo las primeras 12 columnas
															},
															orientation : 'landscape', // Establecer la orientación de la página como horizontal

														},
														{
															extend : 'excel',
															className : 'btn-outline-secondary',
															text : 'Excel',
															filename : 'listadoAlumnos',
															className : 'btn-exportar-excel',
															exportOptions : {
																columns : [ 0,
																		1, 2, 3 ]
															// Mantener solo las primeras 12 columnas
															},

														},
														{
															extend : 'print',
															className : 'btn-exportar-imprimir',
															text : 'Imprimir',
															filename : 'listadoAlumnos',
															exportOptions : {
																columns : [ 0,
																		1, 2, 3 ]
															// Mantener solo las primeras 12 columnas
															},

														} ],
												responsive : true,

												columnDefs : [
														{
															orderable : false,
															className : 'select-checkbox',
															targets : 0
														},
														{
															targets : [ 1, 2,
																	3, 4 ],
															orderable : true
														} ],
											// Otras opciones y configuraciones aquí
											});

							// Agregar un manejador de clic a las filas de la tabla para seleccionar/deseleccionar

							$('#miTabla tbody')
									.on(
											'click',
											'tr',
											function(e) {
												// Verificar si se hizo clic en la casilla de verificación o en cualquier parte de la fila
												var checkbox = $(this).find(
														'.seleccionar-fila');
												if ($(e.target)
														.is(
																'td:first-child input:checkbox')) {
													// Cambiar la selección solo si se hizo clic en la casilla de verificación
													checkbox
															.prop(
																	'checked',
																	!checkbox
																			.prop('checked'));
												} else {
													// Cambiar la selección de la fila y la casilla de verificación
													$(this).toggleClass(
															'selected');
													checkbox
															.prop(
																	'checked',
																	!checkbox
																			.prop('checked'));
												}

												// Mostrar u ocultar botones de acción según la selección
												var selectedRows = tabla.rows(
														'.selected').count();
												$('.accion-buttons').toggle(
														selectedRows > 0);
											});

							// Resto del código

							$(document)
									.ready(
											function() {
												// Manejar clic en cualquier parte de la fila para seleccionarla
												$('#miTabla tbody')
														.on(
																'click',
																'tr',
																function(e) {
																	// Verificar si se hizo clic en la casilla de verificación o en cualquier parte de la fila
																	var checkbox = $(
																			this)
																			.find(
																					'.seleccionar-fila');
																	if ($(
																			e.target)
																			.is(
																					'td:first-child input:checkbox')) {
																		// Cambiar la selección solo si se hizo clic en la casilla de verificación
																		checkbox
																				.prop(
																						'checked',
																						!checkbox
																								.prop('checked'));
																	} else {
																		// Cambiar la selección de la fila y la casilla de verificación
																		$(this)
																				.toggleClass(
																						'selected');
																		checkbox
																				.prop(
																						'checked',
																						!checkbox
																								.prop('checked'));
																	}

																	// Mostrar u ocultar botones de acción según la selección
																	var selectedRows = tabla
																			.rows(
																					'.selected')
																			.count();
																	$(
																			'.accion-buttons')
																			.toggle(
																					selectedRows > 0);
																});
											});

						});

		/**
		 * Maneja el evento de clic en el botón para cargar las actividades por materias del usuario.
		 * Obtiene el ID del usuario desde el atributo 'data-id' del botón y llama a la función cargarMisMatriculas con dicho ID.
		 */
		// 		$('#botonMisActividades').click(function() {
		// 			var id = $(this).data('id');
		// 			// 			cargarMisMatriculas(id);
		// 			var url = contextPath + "/componentes/rolAdmin/menuMaterias/nuevaActividadRolAdmin.jsp";
		// 		    url += "?idAlu=" + idAlu; // Añadir el parámetro idAlu
		// 		    console.log("url  " + url);
		// 		    // Redirigir a la nueva página con los parámetros de consulta
		// 		    window.location.href = url;
		// 		});
		/**
		 * Realiza una solicitud AJAX para cargar las matrículas del alumno con el ID especificado.
		 * 
		 * @param {number} idAlu - El ID del alumno cuyas matrículas se cargarán.
		 */
		// 		function cargarMisActividades(idAlu) {
		// 			var contextPath = '${pageContext.request.contextPath}';
		// 			var servletUrl = contextPath + "/SvMostrarMatriculacionesByAlumno";
		// 			var url = servletUrl + "?idAlu=" + idAlu;
		// 			$.ajax({
		// 				url : url,
		// 				method : 'GET',
		// 				dataType : 'json',
		// 				success : function(matriculas) {
		// 					// Función para manejar la respuesta exitosa del servlet
		// 					mostrarMatriculas(matriculas);
		// 				},
		// 				error : function(xhr, status, error) {
		// 					// Función para manejar errores de la llamada AJAX
		// 					console.error('Error al cargar matrículas:', error);
		// 				}
		// 			});
		// 		}
	</script>
</body>
</html>
