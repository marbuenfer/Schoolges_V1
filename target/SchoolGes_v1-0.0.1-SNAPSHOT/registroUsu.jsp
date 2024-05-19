<%@page import="com.dao.DaoUsuario"%>
<%@page import="com.db.DbConexion"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REGISTRO USUARIOS</title>
<%-- <%@include file="componentes/allcss.jsp"%> --%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
	<%@include file="componentes/navbar.jsp"%>

	<div class="container p-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card paint-card">
					<div class="card-body">
						<!-- 						<button type="button" class="btn-close" aria-label="Close" -->
						<!-- 							id="btnCerrar"></button> -->
						<p class="fs-4 text-center">Registro de Usuarios</p>
						<c:if test="${not empty sucMsg}">
							<p class="text-center text-success fs-3">${sucMsg}</p>
							<c:remove var="sucMsg" scope="session" />
						</c:if>
						<c:if test="${not empty errorMsg}">
							<p class="text-center text-success fs-3">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<form action="SvGuardarUsuario" method="post">
							<div class="row">
								<div class="mb-3 col-8">
									<label class="form-label">Email address</label> <input required
										name="emailUsu" id="emailUsu_id" type="email"
										class="form-control">
								</div>

								<div class="mb-3 col-4">
									<label class="form-label">Password</label> <input required
										name="pswordUsu" id="pswordUsu_id" type="password"
										class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-4">
									<label class="form-label">Tipo de rol</label> <select
										class="form-select" id="tipoRolUsu_id" name="tipoRolUsu">
										<option value="AD">Administrador</option>
										<option value="AL">Alumno</option>
										<option value="DO">Docente</option>
									</select>
								</div>
								<div class="mb-3 col-3">
									<label class="form-label">Fecha de nacimiento</label> <input
										required name="fechNacUsu" id="fechNacUsu_id" type="date"
										class="form-control">
								</div>
								<div class="mb-3 col-4">
									<label class="form-label">DNI</label> <input required
										name="dniUsu" id="dniUsu_id" type="text" maxlength="15"
										class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-9">
									<label class="form-label">Nombre Completo</label> <input
										required name="nomCompUsu" id="nomCompUsu_id" type="text"
										maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-3">
									<label class="form-label">Teléfono</label> <input name="telUsu"
										id="telUsu_id" type="tel" class="form-control"
										pattern="[0-9]{9}">
								</div>

								<div class="mb-3 col-9">
									<label class="form-label">Dirección</label> <input
										name="direcUsu" id="direcUsu_id" type="text" maxlength="50"
										class="form-control">
								</div>
							</div>
							<div class="row">

								<div class="mb-3 col-5">
									<label class="form-label">Localidad</label> <input type="text"
										class="form-control" id="localUsu_id" name="localUsu"
										maxlength="50">
								</div>

								<div class="mb-3 col-5">
									<label class="form-label">Provincia</label> <input type="text"
										class="form-control" id="provUsu_id" name="provUsu"
										maxlength="50">
								</div>
							</div>

							<div class="row">
								<!-- Campo de especialidad Docente(inicialmente oculto) -->
								<div class="mb-3 col-12" id="espeDocDiv" style="display: none;">
									<label class="form-label">Especialidad</label> <input
										type="text" class="form-control" id="espeDoc_id"
										name="espeDocDoc" maxlength="45">
								</div>

							</div>
							<!-- 							<div class="row"> -->
							<!-- 								Campo de fecha alta usuario -->
							<!-- 								<div class="mb-3 col-3" id="fechIngrDocDiv"> -->
							<!-- 									<label class="form-label">Fecha Alta</label> <input type="date" -->
							<!-- 										class="form-control" id="fechAltUsu_id" name="fechAltUsu"> -->
							<!-- 								</div> -->


							<!-- 								Campo de fecha baja usuario -->
							<!-- 								<div class="mb-3 col-3" id="fechBajDocDiv"> -->
							<!-- 									<label class="form-label">Fecha Baja</label> <input type="date" -->
							<!-- 										class="form-control" id="fechBajUsu_id" name="fechBajUsu"> -->
							<!-- 								</div> -->




							<!-- - LOS CAMPOS EXCLUSIVOS PARA ADMINISTRADOR Y DOCENTE SE DEBEN OCULTAR Y QUE APAREZCAN
    SEGÚN EL TIPO ROL FIJARSE DE LOS COMENTARIOS -->
							<!-- Campo de empresa(inicialmente oculto) -->
							<div class="mb-3 col-9" id="empAdminDiv">
								<label class="form-label">Empresa</label> <input type="text"
									class="form-control" id="empAdmin_id" name="empAdmin"
									maxlength="45">
							</div>



							<div class="row">
								<!-- Campo de titulo ingreso Alumno (inicialmente oculto) -->
								<div class="mb-3 col-9" id="tituIngAluDiv"
									style="display: none;">
									<label class="form-label">Título ingreso</label> <input
										type="text" class="form-control" id="tituIngAlu_id"
										name="tituIngAlu">
								</div>
								<!-- Campo de año academico Alumno(inicialmente oculto) -->
								<!-- 								<div class="mb-3 col-3" id="annoAcaAluDiv" -->
								<!-- 									style="display: none;"> -->
								<!-- 																		<label class="form-label">Año obtención</label> <input -->
								<!-- 																			type="text" class="form-control" id="annoAcaAlu_id" -->
								<!-- 																			name="annoAcaAlu"> -->

								<!-- 									<label class="form-label">Año obtención</label> <select -->
								<!-- 										id="annoAcaAlu" name="annoAcaAlu_id" class="form-select"></select> -->



								<!-- 								</div> -->
							</div>
							<!-- 							<div class="row"> -->
							<!-- 								Campo de número de Matricula de Alumno(inicialmente oculto) -->
							<!-- 								<div class="mb-3 col-3" id="numMatriAluDiv" -->
							<!-- 									style="display: none;"> -->
							<!-- 									<label class="form-label">Número matricula</label> <input -->
							<!-- 										type="text" class="form-control" id="numMatriAlu_id" -->
							<!-- 										name="numMatriAlu" maxlength="10"> -->
							<!-- 								</div> -->
							<!-- 								Campo de Modalidad ingreso Alumno (inicialmente oculto) -->
							<!-- 								<div class="mb-3 col-3" id="modaAluDiv" style="display: none;"> -->
							<!-- 									<label class="form-label">Modalidad</label> <select -->
							<!-- 										class="form-select" id="modaAluDiv" name="modaAlu"> -->
							<!-- 										<option value="BAS">BASICA</option> -->
							<!-- 										<option value="ES">ESTÁNDAR</option> -->
							<!-- 										<option value="PR">PREMIUM</option> -->
							<!-- 									</select> -->
							<!-- 								</div> -->

							<!-- 								Campo de fecha matriculación Alumno(inicialmente oculto) -->
							<!-- 								<div class="mb-3 col-3" id="fechMatriAluDiv" -->
							<!-- 									style="display: none;"> -->
							<!-- 									<label class="form-label">Fecha matriculación</label> <input -->
							<!-- 										type="date" class="form-control" id="fechMatriAlu_id" -->
							<!-- 										name="fechMatriAlu"> -->
							<!-- 								</div> -->
							<!-- 							</div> -->

							<div class="row">
								<div class="mb-3 col-3" id="activoDiv">
									<label class="form-label">Activo</label>
									<div class="form-check">
										<input type="checkbox" class="form-check-input" id="activo_id"
											name="activo" checked> <label
											class="form-check-label" for="activo_id">¿Activo?</label>
									</div>
								</div>




								<div class="mb-3">
									<label class="form-label">Observaciones</label>
									<textarea class="form-control" id="obsUsu_id" name="obsUsu"
										rows="4" maxlength="255">
								</textarea>
								</div>
							</div>

							<div class="row d-flex justify-content-center">
								<button type="submit"
									class="btn btn-success text-white mb-4 me-2 col-auto">Registrar</button>
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
		function mostrarOcultarCampos() {
			var tipoRolSelect = document.getElementById("tipoRolUsu_id");

			// Obtener los elementos de los campos de alumno
			var camposAlumno = [ document.getElementById("tituIngAluDiv")];

			// Obtener los elementos de los campos de Docente
			var camposDocente = [ document.getElementById("espeDocDiv")];

			// Obtener los elementos de los campos de administrador
			var camposAdmin = [ document.getElementById("empAdminDiv") ];

			// Asignar un evento change al elemento select
			tipoRolSelect.addEventListener("change", function() {
				// Ocultar todos los campos al principio
				ocultarCampos(camposAlumno);
				ocultarCampos(camposDocente);
				ocultarCampos(camposAdmin);

				// Obtener el valor seleccionado
				var selectedValue = tipoRolSelect.value;

				// Mostrar campos adicionales según la opción seleccionada
				if (selectedValue === "AL") {
					mostrarCampos(camposAlumno);
					//generarOpcionesAnios();
				} else if (selectedValue === "DO") {
					mostrarCampos(camposDocente);
				} else if (selectedValue === "AD") {
					mostrarCampos(camposAdmin);
				}
			});

			// Función para ocultar campos
			function ocultarCampos(campos) {
				campos.forEach(function(campo) {
					campo.style.display = "none";
				});
			}

			// Función para mostrar campos
			function mostrarCampos(campos) {
				campos.forEach(function(campo) {
					campo.style.display = "block";
				});
			}
		}

		// Llama a la función al cargar la página
		mostrarOcultarCampos();

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
		// generarOpcionesAnios();

		function cerrarFormulario() {
			// 			// Lógica para cerrar el formulario

			// 			// Verifica el origen y redirige según sea necesario
			// 			var origen = '${session.getAttribute("origen")}';
			// 			var rolUsuario = '${session.getAttribute("rolUsuario")}';

			// 			if (origen === 'login') {
			// 				window.location.href = 'login.jsp';
			// 			} else if (origen === 'editUsuario') {
			// 				// Lógica para redirigir al dashboard según el rol
			// 				switch (rolUsuario) {
			// 				case 'admin':
			// 					window.location.href = 'dashboardAdmin.jsp';
			// 					break;
			// 				case 'alumno':
			// 					window.location.href = 'dashboardAlumno.jsp';
			// 					break;
			// 				case 'docente':
			// 					window.location.href = 'dashboardDocente.jsp';
			// 					break;
			// 				default:
			// 					// Redirección predeterminada en caso de un rol desconocido
			// 					window.location.href = 'index.jsp';
			// 				}
			// 	

			window.location.href = 'usuarioLogin.jsp';
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