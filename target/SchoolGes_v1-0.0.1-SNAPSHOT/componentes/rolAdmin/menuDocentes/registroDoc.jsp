<%@ page import="com.dao.DaoUsuario"%>
<%@page import="com.db.DbConexion"%>
<%@page import="com.logica.Docente"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.dao.DaoDocente"%>
<%@page import="com.dao.DaoUsuario"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DATOS DOCENTE</title>

<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
	<%@ include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>
	<div class="container-lg p-8">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card paint-card">
					<div class="card-body">
						<p style="font-size: 50px;" class="text-center">Registro de
							Docentes</p>
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
						System.out.println("Parametro idParamStr recogido de registroDoc" + idParamStr);

						DaoDocente daoDoc = null;
						Docente doc = null;
						daoDoc = new DaoDocente(DbConexion.getConn()); // Mueve esto al principio del método doPost

						if (idParamStr != null && !idParamStr.isEmpty()) {
							int idParam = Integer.parseInt(idParamStr);

							doc = daoDoc.getDocenteById(idParam);
						}

						System.out.println("\nvalor doc..." + doc + "estoy dentro de registroDoc");
						%>

						<form accept-charset="UTF-8"
							action="${pageContext.request.contextPath}/SvGuardarUsuario"
							method="post">
							<div class="row">

								<div class="mb-3 col-8">
									<label class="form-label">Nombre Completo</label> <input
										required name="nomCompUsu" id="nomCompUsu_id" type="text"
										class="form-control" maxlength="45"
										value="<%=(doc != null) ? doc.getNomCompUsu() : ""%>">
								</div>
								<div class="mb-3 col-3">
									<label class="form-label">DNI</label> <input required
										name="dniUsu" id="dniUsu_id" type="text" class="form-control"
										value="<%=(doc != null) ? doc.getDniUsu() : ""%>">
								</div>
								<div class="mb-3 col-4">
									<label class="form-label">Email address</label> <input required
										name="emailUsu" id="emailUsu_id" type="email"
										class="form-control" autocomplete="username"
										value="<%=(doc != null) ? doc.getEmailUsu() : ""%>">
								</div>
								<div class="mb-3 col-4">
									<label class="form-label">Password</label> <input required
										name="pswordUsu" id="pswordUsu_id" type="password"
										class="form-control" maxlength="8"
										autocomplete="current-password"
										value="<%=(doc != null) ? doc.getPswordUsu() : ""%>">
								</div>
								<input type="hidden" name="fechNacUsu" value="DO">
								<div class="mb-3 col-3">
									<label class="form-label">Fecha de nacimiento</label> <input
										required name="fechNacUsu" id="fechNacUsu_id" type="date"
										class="form-control"
										value="<%=(doc != null) ? doc.getFechNacUsu() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-3">
									<label class="form-label">Teléfono</label> <input name="telUsu"
										id="telUsu_id" type="tel" class="form-control"
										pattern="[0-9]{9}"
										value="<%=(doc != null) ? doc.getTelUsu() : ""%>">
								</div>
								<div class="mb-3 col-8">
									<label class="form-label">Dirección</label> <input
										name="direcUsu" id="direcUsu_id" type="text"
										class="form-control" maxlength="45"
										value="<%=(doc != null) ? doc.getDirecUsu() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-5">
									<label class="form-label">Localidad</label> <input type="text"
										class="form-control" id="localUsu_id" name="localUsu"
										maxlength="45"
										value="<%=(doc != null) ? doc.getLocalUsu() : ""%>">
								</div>
								<div class="mb-3 col-5">
									<label class="form-label">Provincia</label> <input type="text"
										class="form-control" id="provUsu_id" name="provUsu"
										maxlength="45"
										value="<%=(doc != null) ? doc.getProvUsu() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-6" id="espeDocDiv">
									<label class="form-label">Especialidad</label> <input
										type="text" class="form-control" id="espeDoc_id"
										name="espeDoc" maxlength="45"
										value="<%=(doc != null) ? doc.getEspeDoc() : ""%>">
								</div>
								<div class="mb-3 col-6" id="espeDocDiv">
									<label class="form-label">Grado académico</label> <input
										type="text" class="form-control" id="gradAcadDoc_id"
										name="gradAcadDoc" maxlength="45"
										value="<%=(doc != null) ? doc.getGradAcadDoc() : ""%>">
								</div>
								<div class="mb-3 col-7" id="fechAltaDocDiv">
									<label class="form-label">Fecha alta</label> <input type="date"
										class="form-control" id="fechAltaDoc_id" required
										name="fechAltaDoc"
										value="<%=(doc != null) ? doc.getFechAltaDoc() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-7" id="fechBajaDocDiv">
									<label class="form-label">Fecha baja</label> <input type="date"
										class="form-control" id="fechBajaDoc_id" name="fechBajaDoc"
										value="<%=(doc != null) ? doc.getFechBajaDoc() : ""%>">
								</div>
								<div class="mb-3 col-3" id="activoDiv">
									<div class="form-check">
										<label class="form-check-label ml-auto" for="activo_id">¿Activo?</label>
										<input type="checkbox" class="form-check-input" id="activo_id"
											name="activo" style="margin-left: auto; margin-right: auto;"
											<%=(doc != null && doc.getActivo() == 1) ? "checked" : ""%>>
									</div>
								</div>
								<div class="mb-3  mx-auto">
									<label class="form-label">Observaciones</label>
									<textarea class="form-control" id="obsUsu_id" name="obsUsu"
										rows="4" maxlength="250">
       								 <%=(doc != null && doc.getObsUsu() != null) ? doc.getObsUsu() : ""%>
   									 </textarea>
								</div>
								<div>
									<input type="hidden" name="idUsu"
										value="<%=(doc != null) ? doc.getIdUsu() : ""%>">
								</div>
							</div>
							<input type="hidden" name="source" value="registroDoc.jsp">
							<input type="hidden" name="tipoRolUsu" value="DO">

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
	</div>


	<script>
		/**
		 * Función para cerrar el formulario y redirigir a la página 'crudDocentesRolAdmin.jsp'.
		 */
		function cerrarFormulario() {
			var contextPath = "${pageContext.request.contextPath}";
			var url = contextPath
					+ "/componentes/rolAdmin/menuDocentes/crudDocentesRolAdmin.jsp";
			window.location.href = url;

		}

		/**
		 * Asocia la función cerrarFormulario() al hacer clic en el botón de cierre.
		 */
		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});
	</script>

</body>
</html>

