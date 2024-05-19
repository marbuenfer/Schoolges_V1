<%@page import="com.dao.DaoUsuario"%>
<%@page import="com.logica.Alumno"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.dao.DaoAlumno"%>

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

<title>Listado alumnos</title>

</head>
<body>
	<%@include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>


	<h2>LISTADO ALUMNOS</h2>

	<!-- Botones de acción -->
	<div>
		<button type="button" class="btn btn-warning text-white"
			style="margin: 10px;" onclick="matriculaciones()">Matriculaciones</button>
	</div>
<!--
    Esta tabla muestra una lista de alumnos con información detallada.
    Cada fila representa un alumno y muestra detalles como ID, DNI, nombre completo, etc.
-->
 	<table id="miTabla"
		class="table table-bordered table-striped table-border-top table-hover responsive"
		style="width: 100%">
		<thead>
			<tr>
				<th></th>
				<!-- Columna de selección -->
				<th>ID</th>
				<th>DNI</th>
				<th>Nombre Completo</th>
				<th>Título ingreso</th>
				<th>Fech Nac</th>
				<th>Teléfono</th>
				<th>Email</th>
				<th>Contraseña</th>
				<th>Provincia</th>
				<th>Localidad</th>
				<th>Dirección</th>
				<th>Activo</th>
				<th>Observaciones</th>

				<!-- Nueva columna para botones de acción -->
			</tr>
		</thead>
		<tbody>
		  <!-- 
            Iteramos sobre la lista de alumnos para mostrar los detalles de cada uno en filas de la tabla.
            Se asigna una clase 'table-danger' a las filas de alumnos inactivos para resaltarlos visualmente.
        -->
			<%
			DaoAlumno daoAlu = new DaoAlumno(DbConexion.getConn());
			List<Alumno> listaAlumnos = daoAlu.getAllAlumnos();

			for (Alumno alu : listaAlumnos) {
				//Alumnos alu = new Alumnos();
				//alu = daoUsu.getUsuarioById(alu.getIdAlu());
			%>
			<tr class="<%=(alu.getActivo() == 1) ? "" : "table-danger"%>">
				<td><input type="checkbox" class="seleccionar-fila"></td>
				<td><%=alu.getIdUsu()%></td>
				<td><%=alu.getDniUsu()%></td>
				<td><%=alu.getNomCompUsu()%></td>
				<td><%=alu.getTituIngAlu()%></td>
				<td><%=(alu.getFechNacUsu() != null) ? alu.getFechNacUsu() : "s/f"%></td>
				<td><%=alu.getTelUsu()%></td>
				<td><%=alu.getEmailUsu()%></td>
				<td><%=alu.getPswordUsu()%></td>
				<td><%=alu.getLocalUsu()%></td>
				<td><%=alu.getProvUsu()%></td>
				<td><%=alu.getDirecUsu()%></td>
				<td>
					<div
						class="<%=(alu.getActivo() == 1) ? "activo-verde" : "activo-rojo"%>"></div>
				</td>
				<td><%=alu.getObsUsu()%></td>

			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<script> 
	var tabla;
	var tipoRol;
	/**
	 * Esta función se ejecuta cuando el documento HTML ha sido completamente cargado y analizado.
	 * Inicializa la tabla utilizando el complemento DataTables para mejorar la funcionalidad y el estilo de la tabla.
	 * La tabla se hace seleccionable con la opción de selección múltiple activada.
	 * Se configura la paginación para dividir la visualización en páginas.
	 * Se establece el diseño del DOM para personalizar la disposición de los componentes de la tabla y los botones.
	 * Se especifica el número de registros a mostrar por página.
	 * Se agregan botones de exportación para exportar los datos de la tabla a PDF, Excel e impresión.
	 * Se define la respuesta de la tabla para que se adapte a diferentes tamaños de pantalla.
	 * Se establecen las columnas que son ordenables y las que no son ordenables.
	 * 
	 * @returns {void}
	 */
	$(document).ready(function() {
	     tabla = $('#miTabla').DataTable({
	        select: {
	            style: 'multi' // Permite la selección múltiple
	        },
	        
	        paging: true,
	        dom: '<"d-flex justify-content-center"f><"d-flex justify-content-end mb-2"B>t<"d-flex justify-content-end"i>',
	        pageLength: 18, // número de registros a mostrar por página
	        buttons: [
                {
                    extend: 'pdf',
                    title: 'Listado alumnos', // Título del archivo Excel
                    className: 'btn btn-outline-secondary', // Clase CSS para el botón
                    text: 'PDF', // Texto del botón
                    filename: 'listadoAlumnos', // Nombre del archivo PDF generado
                    className: 'btn-exportar-pdf', // Clase CSS adicional para el botón (si es necesario)
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13] // Mantener solo las primeras 12 columnas
                    },
 					orientation: 'landscape', // Establecer la orientación de la página como horizontal

                },
                {
                    extend: 'excel',
                    className: 'btn-outline-secondary',
                    text: 'Excel',
                    filename: 'listadoAlumnos',
                    className: 'btn-exportar-excel',
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13] // Mantener solo las primeras 12 columnas
                    },
                    customize: function (xlsx) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];

                        $('row', sheet).each(function (index) {
                            var row = $(this);
                            var rowClass = row.attr('class');
                            var activoIndex = 13; // Índice de la columna "Activo" (columna M)

                            // Verificar si la fila tiene la clase "activo-verde" o "activo-rojo"
                            var isActiveGreen = rowClass && rowClass.includes('activo-verde');
                            var isActiveRed = rowClass && rowClass.includes('activo-rojo');

                            // Obtener la celda en la columna "Activo" (columna M)
                            var activoCell = row.find('c[r="M' + (index + 1) + '"]');

                            // Actualizar el contenido de la celda en el archivo XML de Excel
                            if (isActiveGreen) {
                                activoCell.text('Sí');
                            } else if (isActiveRed) {
                                activoCell.text('No');
                            }
                        });
                    }
                },
                {
                    extend: 'print',
                    className: 'btn-exportar-imprimir', 
                    text: 'Imprimir',
                    filename: 'listadoAlumnos',
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13] // Mantener solo las primeras 12 columnas
                    },
                   
                }
                ],
	        responsive:true,
	        
	        columnDefs: [
	            { orderable: false, className: 'select-checkbox', targets: 0 },
	            { targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], orderable: true }
	        ],
	        // Otras opciones y configuraciones aquí
	    });

	 /**
	 * Esta función maneja el evento de clic en las filas de la tabla con el id "miTabla".
	 * Selecciona o deselecciona la fila y la casilla de verificación asociada.
	 * Además, muestra u oculta los botones de acción según la selección.
	 * 
	 * @param {object} e - Objeto del evento de clic.
	 * @returns {void}
	 */
	   $('#miTabla tbody').on('click', 'tr', function(e) {
			    // Verificar si se hizo clic en la casilla de verificación o en cualquier parte de la fila
			    var checkbox = $(this).find('.seleccionar-fila');
			    if ($(e.target).is('td:first-child input:checkbox')) {
			        // Cambiar la selección solo si se hizo clic en la casilla de verificación
			        checkbox.prop('checked', !checkbox.prop('checked'));
			    } else {
			        // Cambiar la selección de la fila y la casilla de verificación
			        $(this).toggleClass('selected');
			        checkbox.prop('checked', !checkbox.prop('checked'));
			    }
			
			    // Mostrar u ocultar botones de acción según la selección
			    var selectedRows = tabla.rows('.selected').count();
			    $('.accion-buttons').toggle(selectedRows > 0);
});

	    // Resto del código

		/**
		 * Asocia la función cerrarModal al botón de cancelar y a la "x" superior en el modal de confirmación.
		 * 
		 * @returns {void}
 */       $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
           cerrarModal();
       });
	});
	 /**
	  * Esta función maneja el evento de clic en cualquier parte de una fila de la tabla con el id "miTabla".
	  * Selecciona o deselecciona la fila y la casilla de verificación asociada.
	  * Además, muestra u oculta los botones de acción según la selección.
	  * 
	  * @param {object} e - Objeto del evento de clic.
	  * @returns {void}
	  */
$(document).ready(function() {
    // Manejar clic en cualquier parte de la fila para seleccionarla
    $('#miTabla tbody').on('click', 'tr', function(e) {
        // Verificar si se hizo clic en la casilla de verificación o en cualquier parte de la fila
        var checkbox = $(this).find('.seleccionar-fila');
        if ($(e.target).is('td:first-child input:checkbox')) {
            // Cambiar la selección solo si se hizo clic en la casilla de verificación
            checkbox.prop('checked', !checkbox.prop('checked'));
        } else {
            // Cambiar la selección de la fila y la casilla de verificación
            $(this).toggleClass('selected');
            checkbox.prop('checked', !checkbox.prop('checked'));
        }

        // Mostrar u ocultar botones de acción según la selección
        var selectedRows = tabla.rows('.selected').count();
        $('.accion-buttons').toggle(selectedRows > 0);
    });

   
    /**
     * Redirige a la página "registroAlu.jsp" con el ID proporcionado como parámetro en la URL.
     * 
     * @param {string} id - El ID que se pasará como parámetro en la URL.
     * @returns {void}
     */
	function redirectToRegistroAlu(id){
 	 console.log(id);
	    window.location.href = "registroAlu.jsp?id=" + id;
	}


     /**
      * Envia una solicitud al servidor para eliminar un usuario con el ID proporcionado utilizando AJAX.
      * Muestra un mensaje de éxito o error utilizando SweetAlert2 y recarga la página después de eliminar el usuario con éxito.
      * 
      * @param {string} id - El ID del usuario que se eliminará.
      * @returns {void}
      */
    function borrarUsuario(id) {
    // Enviar la solicitud al servidor para borrar el usuario con el id proporcionado
    console.log("idFila en enviarSolicitudBorrado  " + id);
    var tipoRol = "AL";
    var contextPath = "/SchoolGes_v1"
    var servletUrl = contextPath + "/SvBorrarUsuario?idUsu=" + id + "&tipoRol=" + tipoRol;

    fetch(servletUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                Swal.fire({
                    icon: 'success',
                    title: '¡Éxito!',
                    text: data.message,
                    confirmButtonText: 'Aceptar'
                }).then(() => {
                    window.location.reload(); // Recargar la página después de borrar
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '¡Error!',
                    text: data.message,
                    confirmButtonText: 'Aceptar'
                });
            }
        })
        .catch(error => {
            console.error('Error:', error);
            Swal.fire({
                icon: 'error',
                title: '¡Error!',
                text: 'Error al comunicarse con el servidor',
                confirmButtonText: 'Aceptar'
            });
        });
}

      /**
       * Redirige al usuario a la página 'crudMatriculacionesRolAdmin.jsp'.
       * Esta función se utiliza para navegar a la página donde se administran las matriculaciones.
       * 
       * @returns {void}
       */
	    
	function matriculaciones() {
	    // Redirigir a tu página .jsp
	    window.location.href = 'crudMatriculacionesRolAdmin.jsp';
	}


	</script>
</body>
</html>
