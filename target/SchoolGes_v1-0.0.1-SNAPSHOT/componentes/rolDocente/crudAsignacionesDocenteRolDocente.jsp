
<%@page import="com.logica.Docente"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.logica.AsignacionDocente"%>
<%@page import="com.dao.DaoDocente"%>
<%@page import="com.dao.DaoUsuario"%>

<%@page import="java.util.List"%>
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

<title>Listado de asignaciones de materias a docentes</title>

</head>

<body>
	<%@ include file="/resources/css/allcss.jsp"%>

	<%@include file="/componentes/navbar.jsp"%>

	<h2>ASIGNACIONES A DOCENTES</h2>


	<table id="miTabla"
		class="table table-bordered table-striped table-border-top table-hover responsive table-custom-padding"
		style="width: 100%;">
		<!-- añadir para que salga tambien elcentro que lo recoge mi sql -->
		<thead>
			<tr>
				<th>Id. Asig</th>
				<th>Id. Doc</th>
				<th>DNI</th>
				<th>Nombre Completo</th>
				<th>email</th>
				<th>Id. Mat</th>
				<th>Nombre materia</th>
				<th>Fech.Ini</th>
				<th>Fech.Fin</th>
				<th>Activo</th>
				<th>Observaciones</th>
				<!-- 				<th>Acciones</th> -->
			</tr>
		</thead>
		<tbody>
			<%
			//Usuario usu = new Usuario(DbConexion.getConn());
			DaoDocente daoDoc = new DaoDocente(DbConexion.getConn());
			List<AsignacionDocente> listaAsignacionesDocente = daoDoc.getAllAsignacionDocentes();

			for (AsignacionDocente asigDoc : listaAsignacionesDocente) {
				//Alumnos alu = new Alumnos();
				//alu = daoUsu.getUsuarioById(alu.getIdAlu());
			%>
			<tr class="<%=(asigDoc.getActivo() == 1) ? "" : "table-danger"%>">
				<td><%=asigDoc.getIdAsg()%></td>
				<td><%=asigDoc.getIdDoc()%></td>
				<td><%=asigDoc.getDniUsu()%></td>
				<td><%=asigDoc.getNomCompUsu()%></td>
				<%-- 				<td><%=matri.getIdEst()%></td> --%>
				<%-- 				<td><%=matri.getNomEst()%></td> --%>
				<td><%=asigDoc.getEmailUsu()%></td>

				<td><%=asigDoc.getIdMat()%></td>
				<td><%=asigDoc.getNomMat()%></td>

				<%-- 				<td><%=matri.getIdDoc()%></td> --%>
				<%-- 				<td><%=asigDoc.getNomDoc()%></td> --%>

				<%-- 				<td><%=asigDoc.getModMatri()%></td> --%>
				<td><%=(asigDoc.getFechIniAsigDoc() != null) ? asigDoc.getFechIniAsigDoc() : "s/f"%></td>
				<td><%=(asigDoc.getFechFinAsigDoc() != null) ? asigDoc.getFechFinAsigDoc() : "s/f"%></td>


				<td>
					<div
						class="<%=(asigDoc.getActivo() == 1) ? "activo-verde" : "activo-rojo"%>"></div>
				</td>
				<td><%=asigDoc.getObsAsigDoc()%></td>

			</tr>
			<%
			}
			%>
		</tbody>
	</table>


	<script>
		var tabla;
		var tipoRol;
		$(document)
				.ready(
						function() {
							tabla = $('#miTabla')
									.DataTable(
											{
												scrollY : 'auto', // la altura 
												// Habilita la paginación
												select : {
													style : 'multi' // Permite la selección múltiple
												},
												paging : true,

												dom : '<"d-flex justify-content-center"f><"d-flex justify-content-end mb-2"B>t<"d-flex justify-content-end"i>',
												pageLength : 18, // número de registros a mostrar por página
												responsive : true,
												buttons : [
														{
															extend : 'csv',
															className : 'btn-exportar-csv',
														},
														{
															extend : 'excel',
															className : 'btn-outline-secondary',
															filename : 'listadoAsignacionesDocentesAMaterias',
															className : 'btn-exportar-excel',
															customize : function(
																	xlsx) {
																var sheet = xlsx.xl.worksheets['listado de asignaciones docentes.xml'];

																// Iterar sobre las filas del archivo XML de Excel
																$('row', sheet)
																		.each(
																				function(
																						index) {
																					var row = $(this);
																					var rowClass = row
																							.attr('class');
																					var activoIndex = 15; // Índice de la columna "Activo" en DataTables

																					// Verificar si el valor en DataTables es "Sí"
																					var table = $(
																							'#miTabla')
																							.DataTable();
																					var activoValueInTable = table
																							.cell(
																									index,
																									activoIndex)
																							.data();

																					// Obtener la celda en el archivo XML de Excel
																					var cell = row
																							.find('c[r="'
																									+ activoIndex
																									+ '"]');

																					// Actualizar el valor en el archivo XML de Excel solo si el valor en DataTables es "Sí"
																					if (activoValueInTable === 'Sí') {
																						cell
																								.text('Sí');
																					}
																				});
															}
														},
														{
															extend : 'pdf',
															className : 'btn btn-outline-secondary',
															orientation : 'landscape',
															className : 'btn-exportar-pdf',
															customize : function(
																	doc) {
																// Obtener el contenido de la tabla
																var table = $(
																		'#miTabla')
																		.DataTable();
																var data = table
																		.rows()
																		.data();

																// Obtener el índice del campo "Activo"
																var activoIndex = table
																		.column(
																				':contains("Activo")')
																		.index();

																// Iterar sobre las filas de datos
																data
																		.each(function(
																				value,
																				index) {
																			// Obtener el valor del campo "Activo"
																			var activoValue = value[activoIndex];

																			// Verificar si la fila tiene la clase "activo-verde" o "activo-rojo"
																			var rowNode = table
																					.row(
																							index)
																					.node();
																			var isActiveGreen = $(
																					rowNode)
																					.find(
																							'.activo-verde').length > 0;
																			var isActiveRed = $(
																					rowNode)
																					.find(
																							'.activo-rojo').length > 0;

																			// Asignar el color de fondo adecuado al valor del campo "Activo"
																			var cell = doc.content[1].table.body[index + 1];
																			if (cell !== undefined) {
																				if (isActiveGreen) {
																					activoValue = 'Sí';
																					// Aplicar color de fondo verde al valor del campo "Activo" en el PDF
																					cell[activoIndex].fillColor = '#28a745';
																				} else if (isActiveRed) {
																					activoValue = 'No';
																					// Aplicar color de fondo rojo al valor del campo "Activo" en el PDF
																					cell[activoIndex].fillColor = '#dc3545';
																				}
																			}

																			// Actualizar el valor en el PDF
																			doc.content[1].table.body[index + 1][activoIndex].text = activoValue;
																		});
															}
														},
														{
															extend : 'print',
															className : 'btn-exportar-imprimir',
															text : 'Imprimir',
															customize : function(
																	win) {
																var loadingMessage = '<div class="text-center"><i class="fa fa-spinner fa-spin"></i> Generando impresión...</div>';
																$(
																		win.document.body)
																		.html(
																				loadingMessage);

																setTimeout(
																		function() {
																			// Obtener el contenido de la tabla
																			var table = $(
																					'#miTabla')
																					.DataTable();
																			var data = table
																					.rows()
																					.data();

																			// Obtener la cabecera de las columnas
																			var headers = table
																					.columns()
																					.header()
																					.toArray()
																					.map(
																							function(
																									th) {
																								return $(
																										th)
																										.text();
																							});

																			// Obtener el índice del campo "Activo"
																			var activoIndex = table
																					.column(
																							':contains("Activo")')
																					.index();

																			// Crear una tabla HTML para la personalización de impresión
																			var html = '<table border="1" cellpadding="5" cellspacing="0"><thead><tr>';

																			// Agregar las cabeceras de las columnas
																			headers
																					.forEach(function(
																							header) {
																						html += '<th>'
																								+ header
																								+ '</th>';
																					});

																			html += '</tr></thead><tbody>';

																			// Iterar sobre las filas de datos
																			data
																					.each(function(
																							value,
																							index) {
																						// Iniciar una nueva fila en la tabla HTML
																						html += '<tr>';

																						// Iterar sobre las celdas de la fila
																						value
																								.each(function(
																										cellValue,
																										i) {
																									// Verificar si la celda corresponde a la columna "Activo"
																									if (i === activoIndex) {
																										// Verificar si la fila tiene la clase "activo-verde" o "activo-rojo"
																										var rowNode = table
																												.row(
																														index)
																												.node();
																										var isActiveGreen = $(
																												rowNode)
																												.find(
																														'.activo-verde').length > 0;
																										var isActiveRed = $(
																												rowNode)
																												.find(
																														'.activo-rojo').length > 0;

																										// Asignar el color de fondo adecuado al valor del campo "Activo"
																										if (isActiveGreen) {
																											cellValue = 'Sí';
																											// Aplicar color de fondo verde a la celda en la tabla HTML
																											html += '<td style="background-color: #28a745;">'
																													+ cellValue
																													+ '</td>';
																										} else if (isActiveRed) {
																											cellValue = 'No';
																											// Aplicar color de fondo rojo a la celda en la tabla HTML
																											html += '<td style="background-color: #dc3545;">'
																													+ cellValue
																													+ '</td>';
																										}
																									} else {
																										// Agregar el valor de la celda sin modificaciones
																										html += '<td>'
																												+ cellValue
																												+ '</td>';
																									}
																								});

																						// Cerrar la fila en la tabla HTML
																						html += '</tr>';
																					});

																			// Cerrar la tabla HTML
																			html += '</tbody></table>';

																			// Actualizar el contenido del cuerpo del documento de impresión
																			$(
																					win.document.body)
																					.html(
																							html);
																		}, 100);
															}
														}

												],
												responsive : true,
												columnDefs : [
														{
															orderable : false,
															className : 'select-checkbox',
															targets : 0
														},
														{
															targets : [ 1, 2,
																	3, 4, 5, 6,
																	7, 8, 9, 10 ],
															orderable : true
														} ],
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

						});

		function matriculaciones() {
			// Redirigir a tu página .jsp
			window.location.href = 'crudAlumnosMatriculas.jsp';
		}
	</script>


</body>
</html>
