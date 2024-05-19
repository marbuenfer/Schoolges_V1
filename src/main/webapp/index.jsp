<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>

 <%@ include file="/resources/css/allcss.jsp"%>
<%@include file="/componentes/navbar.jsp"%>
<!--  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->



<style>
.sidebar .nav-item .nav-link .img-profile, .topbar .nav-item .nav-link .img-profile
	{
	height: 2rem;
	width: 2rem;
}

.topbar {
	height: 4.375rem;
}
</style>
</head>
<body class="d-flex flex-column min-vh-100">


	<%@ page import="com.db.DbConexion"%>
	<%@ page import="java.sql.Connection"%>

	<%
	try {
		Connection conn = DbConexion.getConn();
		// Resto del código aquí
	} catch (Exception e) {
		e.printStackTrace();
		// Manejo de la excepción, por ejemplo, redirigir a una página de error
	}
	
	%>
	<c:if test="${not empty userObj and userObj.tipoRolUsu eq 'AD'}">
		<%@ include file="/componentes/rolAdmin/dashboardRolAdmin.jsp" %>
	</c:if>


	<c:if test="${not empty userObj and userObj.tipoRolUsu eq 'AL'}">
			<%@ include file="/componentes/rolAlumno/dashboardRolAlumno.jsp" %>
	
	</c:if>

	<c:if test="${not empty userObj and userObj.tipoRolUsu eq 'DO'}">
			<%@ include file="/componentes/rolDocente/dashboardRolDocente.jsp" %>
	</c:if>


	<c:if test="${ empty userObj}">
	
		<div id="carouselExample" class="carousel slide">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="img/aula-virtual-espacio-estudio.jpg"
						class="d-block w-100" alt="..." height="855px">
				</div>
				<div class="carousel-item">
					<img src="img/joven-escribiendo-cuaderno-sesion-estudio.jpg"
						class="d-block w-100" alt="..." height="855px">
				</div>
				<div class="carousel-item">
					<img src="img/mujer-trabajando-oficina.jpg" class="d-block w-100"
						alt="..." height="855px">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExample" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExample" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>

	</c:if>


	<!-- footer -->
	<%@include file="componentes/footer.jsp"%>
	<!-- footer -->


	<script>
		function redirectToLogin() {
			window.location.href = "usuarioLogin.jsp"
		}
	</script>

</body>



</html>