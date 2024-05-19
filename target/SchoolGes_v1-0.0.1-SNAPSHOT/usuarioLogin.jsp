<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Usuario</title>
<%@include file="resources/css/allcss.jsp"%> 
<%-- <%@include file="/componentes/navbar.jsp"%> --%>

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
<body>
<%-- <jsp:include --%>
<%-- 			page="${pageContext.request.contextPath}/componentes/navbar.jsp" /> --%>

	<div class="container p-5">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card paint-card">
					<div class="card-body">
						<p class="fs-4 text-center">Login Usuario</p>
<%-- 						<c:if test="${not empty succMsg}"> --%>
<%-- 							<p class="text-center text-success fs-3">${succMsg}</p> --%>
<%-- 							<c:remove var="succMsg" scope="session" /> --%>
<%-- 						</c:if> --%>
						<c:if test="${not empty errorMsg}">
							<p class="text-center text-danger fs-5">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<form action="SvLoginUsuario" method="post">
							<div class="mb-3">
								<label class="form-label">Email address</label> <input required
									name="emailUsu" id="emailUsu_id" type="email"
									class="form-control">
							</div>
							<div class="mb-3">
								<label class="form-label">Password</label> <input required
									name="pswordUsu" id="pswordUsu_id" type="password"
									class="form-control">
							</div>
							<button type="submit" class="btn bg-success text-white col-md-12">Login</button>
						</form>
						<br>
<!-- 						<p> -->
<!-- 							¿No tienes cuenta?<a href="registroUsu.jsp?origen=login" -->
<!-- 								class="text-decoration-none">Registrate</a> -->
<!-- 						</p> -->

					</div>
				</div>
			</div>
		</div>
	</div>
</body>