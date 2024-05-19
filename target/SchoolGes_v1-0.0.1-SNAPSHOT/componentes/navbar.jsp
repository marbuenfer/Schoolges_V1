<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page isELIgnored="false"%>



<nav class="navbar navbar-expand navbar-dark bg-success topbar mb-4 ">

	<div class="container-fluid">
		<a class="navbar-brand"
			href="${pageContext.request.contextPath}/index.jsp"><i
			class="fa-solid fa-school"><span class="ms-2"></span></i>SCHOOLGES</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">


			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<c:if test="${not empty userObj}">
					<c:choose>
						<c:when test="${userObj.tipoRolUsu == 'AL'}">
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/index.jsp">HOME</a></li>
							<!-- 							<li class="nav-item"><a class="nav-link active" -->
							<%-- 								href="${pageContext.request.contextPath}/componentes/rolAlumno/menuMaterias/crudMateriasRolAlumno.jsp">MATERIAS</a></li> --%>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAlumno/crudActividadesRolAlumno.jsp">ACTIVIDADES</a></li>
						</c:when>
						<c:when test="${userObj.tipoRolUsu == 'AD'}">
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/index.jsp">HOME</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAdmin/menuAlumnos/crudAlumnosRolAdmin.jsp">ALUMNOS</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAdmin/menuDocentes/crudDocentesRolAdmin.jsp">DOCENTES</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAdmin/menuAdmins/crudAdminRolAdmin.jsp">ADMINISTRADORES</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAdmin/menuEstudios/crudEstudiosRolAdmin.jsp">ESTUDIOS</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAdmin/menuMaterias/crudMateriasRolAdmin.jsp">MATERIAS</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAdmin/menuMaterias/crudActividadesRolAdmin.jsp">ACTIVIDADES</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolAdmin/menuCentros/crudCentrosRolAdmin.jsp">CENTROS</a></li>
						</c:when>
						<c:when test="${userObj.tipoRolUsu == 'DO'}">
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/index.jsp">HOME</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolDocente/crudAlumnosRolDocente.jsp">ALUMNOS</a></li>
							<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/componentes/rolDocente/crudDocentesRolDocente.jsp">DOCENTES</a></li>
						</c:when>
					</c:choose>
				</c:if>

			</ul>
			<c:if test="${empty userObj}">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link text-warning"
						href="${pageContext.request.contextPath}/usuarioLogin.jsp">Iniciar
							sesion</a></li>
				</ul>
			</c:if>



			<c:if test="${not empty userObj }">


				<ul class="navbar-nav">
					<li class="nav-item"><c:choose>
							<c:when test="${userObj.tipoRolUsu eq 'AD'}">
								<a class="nav-link text-warning"
									href="${pageContext.request.contextPath}/resources/ayudaEnLinea/ayudaRolAdmin.pdf"><i
									class="fa-solid fa-circle-question fa-3x"></i></a>
							</c:when>
							<c:when test="${userObj.tipoRolUsu eq 'AL'}">
								<a class="nav-link text-warning"
									href="${pageContext.request.contextPath}/resources/ayudaEnLinea/ayudaRolAlumno.pdf"><i
									class="fa-solid fa-circle-question fa-3x"></i></a>
							</c:when>
							<c:when test="${userObj.tipoRolUsu eq 'DO'}">
								<a class="nav-link text-warning"
									href="${pageContext.request.contextPath}/resources/ayudaEnLinea/ayudaRolDocentes.pdf"><i
									class="fa-solid fa-circle-question fa-3x"></i></a>
							</c:when>
							<c:otherwise>
								<a class="nav-link disabled" href="#">sin definir</a>
							</c:otherwise>
						</c:choose></li>
				</ul>


				<!-- Men�s a la izquierda: ms-auto,  la lista de elementos de navegaci�n (navbar-nav) 
				tendr� margen izquierdo autom�tico, y los elementos de navegaci�n se alinear�n 
				a la derecha de la barra de navegaci�n-->
				<ul class="navbar-nav ms-auto">
					<li class="nav-item dropdown">
						<button class="btn btn-success" aria-expanded="false">
							${userObj.nomCompUsu}</button>
					</li>

				</ul>




				<ul class="navbar-nav">
					<li class="nav-item"><c:choose>
							<c:when test="${userObj.tipoRolUsu eq 'AD'}">
								<a class="nav-link disabled text-warning" href="#">Admin</a>
							</c:when>
							<c:when test="${userObj.tipoRolUsu eq 'AL'}">
								<a class="nav-link disabled text-warning" href="#">Alumno</a>
							</c:when>
							<c:when test="${userObj.tipoRolUsu eq 'DO'}">
								<a class="nav-link disabled text-warning" href="#">Docente</a>
							</c:when>
							<c:otherwise>
								<a class="nav-link disabled text-warning" href="#">sin
									definir</a>
							</c:otherwise>
						</c:choose></li>
				</ul>

				<ul class="navbar-nav ms-auto">
					<form class="text-end"
						action="${pageContext.request.contextPath}/SvLogout" method="get">
						<button class="btn btn-light" type="submit">Cerrar sesion</button>
					</form>
				</ul>
			</c:if>

		</div>

	</div>

</nav>
<script>
	function limpiarUrl() {
		history.replaceState({}, document.title, window.location.pathname);
	}
	$(document).ready(function() {
		$('.dropdown-toggle').dropdown();
	});

	//     document.addEventListener("DOMContentLoaded", function() {
	//         const enlacesMenu = document.querySelectorAll('.nav-link.active');
	//         enlacesMenu.forEach(enlace => {
	//             enlace.addEventListener('click', function(event) {
	//                 event.preventDefault(); // Evitar la acci�n de redirecci�n predeterminada
	//                 limpiarUrl(); // Limpia la URL
	//                 window.location.href = this.href; // Redirecciona a la nueva URL
	//             });
	//         });
	//     });
</script>




