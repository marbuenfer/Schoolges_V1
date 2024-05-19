<%@ page import="com.dao.DaoUsuario"%>
<%@page import="com.db.DbConexion"%>
<%@page import="com.logica.Alumno"%>
<%@page import="com.logica.Centro"%>
<%@page import="com.dao.DaoAlumno"%>
<%@page import="com.dao.DaoCentro"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DATOS CENTRO</title>


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
							centros</p>
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
						String idParamStr = request.getParameter("idCen");
						System.out.println("Parametro idParamStr recibido de crudCentrosRolAdmin" + idParamStr);

						DaoCentro daoCen = null;
						Centro cen = null;
						daoCen = new DaoCentro(DbConexion.getConn()); // Mueve esto al principio del método doPost

						if (idParamStr != null && !idParamStr.isEmpty()) {
							int idParam = Integer.parseInt(idParamStr);

							cen = daoCen.getCentroById(idParam);
						}

						System.out.println("\nvalor de  ..." + cen
								+ "estoy dentro de nuevoCentroRolAdmin, cen tiene valor o no tiene depende de si edicion y actual");
						%>

<!--
Representa un formulario HTML para guardar un centro.
El formulario tiene los siguientes elementos y configuraciones:
- Utiliza el conjunto de caracteres UTF-8 para la codificación de caracteres.
- Envia los datos a través de una solicitud POST al servlet "SvGuardarCentro".
- Contiene dos campos ocultos: "tipo" y "idCen", cuyos valores se obtienen de los parámetros de la solicitud.
- Utiliza clases de Bootstrap para el diseño y la disposición de los elementos del formulario.

Dentro del formulario, se encuentran los siguientes campos:-->
						<form accept-charset="UTF-8"
							action="${pageContext.request.contextPath}/SvGuardarCentro"
							method="post">
							
							
							
						<input type="hidden" name="tipo"
							value="<%=request.getParameter("tipo")%>"> <input
							type="hidden" name="idCen"
							value="<%=request.getParameter("idCen")%>">
							<div class="row">
								<div class="mb-3 col-8">
									<label class="form-label">Nombre centro</label> <input required
										name="nomCen" id="nomCen_id" type="text" class="form-control"
										maxlength="45"
										value="<%=(cen != null) ? cen.getNomCen() : ""%>">
								</div>
								<div class="mb-3 col-3">
									<label class="form-label">Teléfono</label> <input required
										name="telCen" id="telCen_id" type="text" class="form-control"
										value="<%=(cen != null) ? cen.getTelCen() : ""%>">
								</div>
								<div class="mb-3 col-4">
									<label class="form-label">Dirección</label> <input required
										name="direCen" id="direCen_id" type="text"
										class="form-control" autocomplete="direCen"
										value="<%=(cen != null) ? cen.getDireCen() : ""%>">
								</div>

								<div class="mb-3 col-4">
									<label class="form-label">Localidad</label> <input required
										name="localCen" id="localCen_id" type="text"
										class="form-control" maxlength="50"
										value="<%=(cen != null) ? cen.getLocalCen() : ""%>">
								</div>
								<input type="hidden" name="tipoRolUsu" value="AL">
								<div class="mb-3 col-3">
									<label class="form-label">Provincia</label> <input required
										name="provCen" id="provCen_id" type="text"
										class="form-control" maxlength="50"
										value="<%=(cen != null) ? cen.getProvCen() : ""%>">
								</div>
							</div>
							<div class="row">
								<div class="mb-3 col-3">
									<label class="form-label">Responsable</label> <input
										name="respCen" id="respCen_id" type="text" class="form-control" maxlength="50"
										value="<%=(cen != null) ? cen.getRespCen() : ""%>">
								</div>
								<div class="mb-3">
									<label class="form-label">Observaciones</label>
									<div class="d-flex">
										<textarea class="form-control flex-grow-1" id="obsCen_id"
											name="obsCen" rows="4" maxlength="250"
											style="resize: none; overflow: auto;"><%=(cen != null && cen.getObsCen() != null) ? cen.getObsCen().trim() : ""%></textarea>
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
	/**
	 * Cierra el formulario actual y redirige al usuario a la página de administración de centros.
	 * Utiliza el contexto de la aplicación para construir la URL de destino.
	 * 
	 * @returns {void}
	 */
		function cerrarFormulario() {
			var contextPath = "${pageContext.request.contextPath}";
			var url = contextPath
					+ "/componentes/rolAdmin/menuCentros/crudCentrosRolAdmin.jsp";
			window.location.href = url;

			console
					.log("La función cerrarFormulario() se ha llamado correctamente.");
		}

	 /**
	  * Asocia la función cerrarFormulario() al evento clic del botón de cierre.
	  * 
	  * @param {Event} event - El evento clic que activa la función.
	  * @returns {void}
	  */		document.getElementById("btnCerrar").addEventListener("click",
				function() {
					cerrarFormulario();
				});
	</script>
	
	<script>
	/**
	 * Registra un controlador de eventos para el evento de envío del formulario.
	 * Realiza una solicitud AJAX al servlet especificado en el atributo "action" del formulario.
	 * 
	 * @param {Event} event - El evento de envío del formulario.
	 * @returns {void}
	 */
	$(document).ready(function() {
        // Capturar el envío del formulario
        $('form').submit(function(event) {
            // Detener el envío del formulario para manejarlo manualmente
            event.preventDefault();
            
            // Realizar una solicitud AJAX al servlet
            $.ajax({
                url: $(this).attr('action'), // Obtener la URL del formulario
                type: $(this).attr('method'), // Obtener el método del formulario (POST)
                data: $(this).serialize(), // Obtener los datos del formulario serializados
                dataType: 'json', // Esperar una respuesta JSON del servidor
                success: function(response) {
                    // Manejar la respuesta del servidor
                    if (response.success) {
                        // Si la operación fue exitosa, mostrar un mensaje de éxito con Swal
                        Swal.fire({
                            icon: 'success',
                            title: 'Éxito',
                            text: response.message
                        });
                    } else {
                        // Si la operación falló, mostrar un mensaje de error con Swal
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: response.message
                        });
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // Si la solicitud AJAX falla, mostrar un mensaje de error genérico
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error al procesar la solicitud'
                    });
                }
            });
        });
    });
	</script>
</body>
</html>

