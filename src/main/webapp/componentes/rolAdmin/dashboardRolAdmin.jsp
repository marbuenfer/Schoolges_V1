<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ page import="java.util.*"%>

<%@page isELIgnored="false"%>
<%@page import="com.db.DbConexion"%>
<%@page import="com.dao.DaoAdmin"%>


<%@ include file="/resources/css/allcss.jsp"%>

<%-- Cerrar la sesión y limpiar la variable de sesión --%>
<c:if test="${not empty sessionScope.navbarIncluded}">
	<%
	session.removeAttribute("navbarIncluded");
	%>
</c:if>


<div class="container p-5">
	<p class="text-center fs-3">Dashboard Administrador</p>
	<c:if test="${not empty errorMsg}">
		<p class="fs-3 text-center text-danger">${errorMsg}</p>
		<c:remove var="errorMsg" scope="session" />
	</c:if>
	<c:if test="${not empty succMsg}">
		<div class="fs-3 text-center text-success" role="alert">${succMsg}</div>
		<c:remove var="succMsg" scope="session" />
	</c:if>
	<%
	DaoAdmin daoAdmin = new DaoAdmin(DbConexion.getConn());
	%>

	<div class="row">
		<div class="col-md-4 mt-4">
			<a
				href="${pageContext.request.contextPath}/componentes/rolAdmin/menuAlumnos/crudAlumnosRolAdmin.jsp"
				class="text-decoration-none" style="font-size: 24px;">
				<div class="card paint-card">
					<div class="card-body text-center text-white bg-primary">
						<i class="fas fa-solid fa-graduation-cap fa-3x"></i>
						<p>Alumnos</p>
						<p class="fs-4 text-center"><%=daoAdmin.contarAlumnos()%>
						</p>
					</div>
				</div>
			</a>
		</div>

		<div class="col-md-4 mt-4">
			<a
				href="${pageContext.request.contextPath}/componentes/rolAdmin/menuDocentes/crudDocentesRolAdmin.jsp"
				class="text-decoration-none" style="font-size: 24px;">
				<div class="card paint-card">
					<div class="card-body text-center text-white bg-warning">
						<i class="fa-sharp fa-solid fa-person-chalkboard fa-3x"></i>
						<p>Docentes</p>
						<p class="fs-4 text-center"><%=daoAdmin.contarDocentes()%></p>
					</div>
				</div>
			</a>
		</div>

		<div class="col-md-4 mt-4">
			<a href="crudAlumnos2.jsp" id="adminLink"
				class="text-decoration-none disabled-link" style="font-size: 24px;">
				<div class="card paint-card" style="font-size: 24px;">
					<div class="card-body text-center text-white bg-secondary">
						<i class="fa-solid fa-school fa-3x"></i>
						<p>Administradores</p>
						<p class="fs-4 text-center"><%=daoAdmin.contarAdministradores()%></p>
					</div>
				</div>
			</a>
		</div>



		<!-- 	<div class="row"> -->
		<!-- 		<div class="col-md-4 mt-4"> -->
		<!-- 			<div class="card paint-card " data-bs-toggle="modal" -->
		<!-- 				data-bs-target="#exampleModal" style="font-size: 24px;"> -->
		<!-- 				<div class="card-body text-center text-white bg-danger "> -->
		<!-- 					<i class="fa-solid fa-school fa-3x"></i> -->
		<!-- 					<p>Centros</p> -->

		<%-- 					<p class="fs-4 text-center"><%=daoAdmin.contarCentros()%> --%>
		<!-- 				</div> -->
		<!-- 			</div> -->
		<!-- 		</div> -->

		<div class="col-md-4 mt-4">
			<a
				href="${pageContext.request.contextPath}/componentes/rolAdmin/menuCentros/crudCentrosRolAdmin.jsp"
				class="text-decoration-none" style="font-size: 24px;">
				<div class="card paint-card">
					<div class="card-body text-center text-white bg-danger">
						<i class="fa-solid fa-school fa-3x"></i>
						<p>Centros</p>

						<p class="fs-4 text-center"><%=daoAdmin.contarCentros()%>
					</div>
				</div>
			</a>
		</div>


		<div class="col-md-4 mt-4">
			<a
				href="${pageContext.request.contextPath}/componentes/rolAdmin/menuEstudios/crudEstudiosRolAdmin.jsp"
				class="text-decoration-none" style="font-size: 24px;">
				<div class="card paint-card">
					<div class="card-body text-center text-white bg-info">
						<i class="fa-solid fa-people-roof fa-3x"></i>
						<p>Estudios</p>

						<p class="fs-4 text-center"><%=daoAdmin.contarEstudiosDisponibles()%>
					</div>
				</div>
			</a>
		</div>
		<div class="col-md-4 mt-4">
			<a
				href="${pageContext.request.contextPath}/componentes/rolAdmin/menuMaterias/crudMateriasRolAdmin.jsp"
				class="text-decoration-none" style="font-size: 24px;">
				<div class="card paint-card">
					<div class="card-body text-center text-white bg-success">
						<i class="fa-solid fa-book-open fa-3x"></i>
						<p>Materias</p>

						<p class="fs-4 text-center"><%=daoAdmin.contarMaterias()%>
					</div>
				</div>
			</a>
		</div>
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="modalAyudaLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modalAyudaTitle">Ayuda</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form action="../addSpecialist" method="post">

					<div class="form-group">
						<label>Enter Specialist Name</label> <input type="text"
							name="specName" class="form-control">
					</div>
					<div class="text-center mt-3">
						<button type="submit" class="btn btn-primary">Add</button>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>

			</div>
		</div>
	</div>x
</div>


