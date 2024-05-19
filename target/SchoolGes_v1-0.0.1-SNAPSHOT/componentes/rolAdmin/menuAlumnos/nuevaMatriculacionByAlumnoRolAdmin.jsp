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

<title>DATOS MATRICULAS</title>


<!-- <!-- jQuery -->
<!-- <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> -->

<!-- <!-- Bootstrap CSS (opcional) -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"> -->

<!-- <!-- DataTables CSS -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css"> -->

<!-- <!-- DataTables JS -->
<!-- <script -->
<!-- 	src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script> -->




<!-- <!-- SweetAlert -->
<!-- <link rel="stylesheet" href="resources/css/sweetalert2.min.css"> -->



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

	<script
		src="${pageContext.request.contextPath}/resources/js/sweetalert2.all.min.js"></script>

	<div id="contenedorPrincipal">
		<div class="container p-5">
			<div class="row justify-content-center">
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
					//out.println("Valor del parámetro idUsu: " + idParamStr);

					DaoMatricula daoMatri = null;
					Matricula matri = null;

					DaoUsuario daoUsu = null;
					Usuario usu = null;

					DaoAlumno daoAlu = null;

					daoUsu = new DaoUsuario(DbConexion.getConn());
					daoAlu = new DaoAlumno(DbConexion.getConn());
					daoMatri = new DaoMatricula(DbConexion.getConn());

					if (idParamStr != null && !idParamStr.isEmpty()) {
						int idParam = Integer.parseInt(idParamStr);
						usu = daoUsu.getUsuarioById(idParam);
					}
					System.out.println(
							"\nvalor de alu del que se quiere hacer una matriculación..." + usu + "estoy dentro de nuevaMatriculacion, ");
					%>


					<form accept-charset="UTF-8" action="SvGuardarMatricula"
						method="post">
						<div class="row">
							<div class="mb-3 col-2">
								<label class="form-label etiqueta-negrita" for="idUsu_id">id.
									Alu</label> <input required name="idUsu" id="idUsu_id"
									class="form-control"
									value="<%=(usu != null) ? usu.getIdUsu() : ""%>" readonly
									style="background-color: #f8f9fa; color: #6c757d; border-color: #dee2e6;">
							</div>

							<div class="mb-3 col-7">
								<label class="form-label etiqueta-negrita" for="nomCompUsu_id">Nombre
									completo</label> <input required name="nomCompUsu" id="nomCompUsu_id"
									class="form-control"
									value="<%=(usu != null) ? usu.getNomCompUsu() : ""%>" readonly
									style="background-color: #f8f9fa; color: #6c757d; border-color: #dee2e6;">
							</div>

							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita" for="emailUsu_id">email</label>
								<input required name="emailUsu" id="emailUsu_id" type="text"
									class="form-control"
									value="<%=(usu != null) ? usu.getEmailUsu() : ""%>" readonly
									style="background-color: #f8f9fa; color: #6c757d; border-color: #dee2e6;">
							</div>
						</div>
						<div class="row">
							<div class="mb-3 col-3">
								<label class="form-label etiqueta-negrita" for="fechMatri_id">Fecha
									de matriculación</label> <input required name="fechMatri"
									id="fechMatri_id" type="date" class="form-control"
									value="<%=(matri != null) ? matri.getFechMatri() : ""%>">
							</div>

							<div class="mb-3 col-3" id="modMatri_div">
								<label class="form-label etiqueta-negrita" for="modMatri_id">Modalidad</label>
								<select id="modMatri_id" name="modMatri" class="form-control">
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

							<div class="mb-3 col-3" id="activoDiv">
								<div class="form-check">
									<label class="form-check-label ml-2 etiqueta-negrita"
										for="activo_id">¿Activo?</label> <input type="checkbox"
										class="form-check-input" id="activo_id" name="activo"
										<%=(usu != null && usu.getActivo() == 1) ? "checked" : ""%> />
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
									<c:forEach var="estudio" items="${listaEstudios}">
										<option value="${estudio.getIdEst()}">${estudio.getIdEst()}
											- ${estudio.getNomEst()}</option>
									</c:forEach>
								</select>
							</div>
						</div>


						<div class="mb-3">
							<label class="form-label etiqueta-negrita" for="obsMatri_id">Observaciones</label>
							<textarea class="form-control" id="obsMatri_id" name="obsMatri"
								rows="4" maxlength="250">
       									 <%=(matri != null && matri.getObsMatri() != null) ? matri.getObsMatri() : ""%>
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
								id="btnMatricular" onclick="realizarMatriculacion()">Realizar
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

		<!-- Modal -->
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
	<!-- 	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> -->
	<script
		src="${pageContext.request.contextPath}/resources/js/funciones.js"></script>

	<script>
		$(document).ready(function() {
			// Llama a la función al cargar la página para establecer el estado inicial de los botones
			actualizarEstadoBotones();
			// Llama a la función cuando se cierra el modal
			$('#materiasModalContent').on('hidden.bs.modal', function() {
				actualizarEstadoBotones();
			});
		});

		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});
		document.getElementById("btnCerrarModal").addEventListener("click",
				function() {
					cerrarModal();
					//actualizarEstadoBotones();
				});

		function cerrarModal() {
			// Cierra el modal manualmente
			$('#materiasModalContent').modal('hide');
		}
		$('#botonModal').click(function() {
			// Llamada a cargarMateriasEnTablaForm() dentro de una promesa para asegurarnos de que se complete antes de abrir el modal
			cargarMateriasEnTablaForm().then(function() {
				// Abrir el modal después de que cargarMateriasEnTablaForm() haya completado su ejecución
				$('#materiasModalContent').modal('show');
			});
		});

		function cerrarFormulario() {
			var contextPath = "${pageContext.request.contextPath}";
			window.location.href = contextPath
					+ "/componentes/rolAdmin/menuAlumnos/crudAlumnosRolAdmin.jsp";

			console
					.log("La función cerrarFormulario() se ha llamado correctamente.");
		}
	</script>

</body>
</html>

