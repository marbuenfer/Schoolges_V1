<%@page import="com.dao.DaoUsuario"%>
<%@page import="com.logica.Docente"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.dao.DaoDocente"%>

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

<title>Listado docentes</title>


</head>
<body>
	<%@ include file="/resources/css/allcss.jsp"%>

	<%@include file="/componentes/navbar.jsp"%>


	<h2>LISTADO DE DOCENTES</h2>

	<!-- Botones de acción -->
	<div>
		<button type="button" class="btn btn-primary" style="margin: 10px;"
			onclick="nuevoDocente()">
			<i class="fa fa-plus" aria-hidden="true"></i> Nuevo Docente
		</button>
		<button type="button" class="btn btn-danger" style="margin: 10px;"
			onclick="borrarSeleccionados()">Borrar Seleccionados</button>
		<button type="button" class="btn btn-warning text-white"
			style="margin: 10px;" onclick="AsignacionesAMaterias()">Asignaciones
			a materias</button>
	</div>



	<!-- 	DataTables -->
	<!--  Esta tabla muestra una lista de usuarios con su respectivo ID, DNI, nombre completo, fecha de nacimiento,
  teléfono, correo electrónico, contraseña, localidad, provincia, dirección, especialidad, grado académico,
 fecha de alta, fecha de baja, estado activo, observaciones y acciones disponibles.
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
				<th>Fech Nac</th>
				<th>Teléfono</th>
				<th>Email</th>
				<th>Contraseña</th>
				<th>Localidad</th>
				<th>Provincia</th>

				<th>Dirección</th>

				<th>Especialidad</th>
				<th>Grado académico</th>
				<th>fech Alta</th>
				<th>fech Baja</th>
				<th>Activo</th>
				<th>Observaciones</th>
				<th>Acciones</th>
				<!-- Nueva columna para botones de acción -->
			</tr>
		</thead>
		<tbody>
			<%
			DaoDocente daoDoc = new DaoDocente(DbConexion.getConn());
			List<Docente> listaDocentes = daoDoc.getAllDocentes();

			for (Docente doc : listaDocentes) {
			%>
			<tr class="<%=(doc.getActivo() == 1) ? "" : "table-danger"%>">
				<td><input type="checkbox" class="seleccionar-fila"></td>
				<td><%=doc.getIdUsu()%></td>
				<td><%=doc.getDniUsu()%></td>
				<td><%=doc.getNomCompUsu()%></td>
				<td><%=(doc.getFechNacUsu() != null) ? doc.getFechNacUsu() : "s/f"%></td>
				<td><%=doc.getTelUsu()%></td>
				<td><%=doc.getEmailUsu()%></td>
				<td><%=doc.getPswordUsu()%></td>
				<td><%=doc.getLocalUsu()%></td>
				<td><%=doc.getProvUsu()%></td>

				<td><%=doc.getDirecUsu()%></td>


				<td><%=doc.getEspeDoc()%></td>
				<td><%=doc.getGradAcadDoc()%></td>
				<td><%=doc.getFechAltaDoc()%></td>
				<td><%=doc.getFechBajaDoc()%></td>
				<td>
					<div
						class="<%=(doc.getActivo() == 1) ? "activo-verde" : "activo-rojo"%>"></div>
				</td>
				<td><%=doc.getObsUsu()%></td>
				<!-- botones en fila de datatables -->
				<td>
<!-- 					<button type="button" class="btn btn-warning btn-sm text-white" -->
<%-- 						onclick="nuevaAsignacionByDocenteRolAdmin(<%=doc.getIdUsu()%>)"> --%>
<!-- 						<i class="fa-solid fa-graduation-cap" aria-hidden="true"></i> -->
<!-- 					</button> -->
					<button type="button" class="btn btn-primary btn-sm"
						onclick="redirectToRegistroDoc(<%=doc.getIdUsu()%>)">
						<i class="fa fa-pencil" aria-hidden="true"></i>
					</button>
					<button type="button" class="btn btn-danger btn-sm"
						onclick="confirmarEliminar(<%=doc.getIdUsu()%>)">
						<i class="fa fa-trash" aria-hidden="true"></i>
					</button>
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<!--ventana modal confirmación borrado -->
	<!-- Agrega esta sección al final del archivo JSP -->
	<div id="confirmModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Confirmar Eliminación</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">¿Estás seguro de que deseas eliminar
					este registro?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cancelar</button>
					<button type="button" class="btn btn-danger" id="confirmDeleteBtn">Eliminar</button>
				</div>
			</div>
		</div>
	</div>
	<script> 
	var tabla;
	var tipoRol;
	/**
	 * Esta función inicializa el DataTable en la tabla con el id "miTabla".
	 * Configura las opciones de paginación, botones de exportación, selección múltiple y personalización de PDF e impresión.
	 * Además, define las columnas que no son ordenables y la clase de selección de checkbox.
	 */

	$(document).ready(function() {
	     tabla = $('#miTabla').DataTable({
	    	scrollY: 'auto', // la altura 
	        select: {
	            style: 'multi' // Permite la selección múltiple
	        },
	        dom: '<"d-flex justify-content-center"f><"d-flex justify-content-end mb-2"B>t<"d-flex justify-content-end"i>',
	        pageLength: 18, // número de registros a mostrar por página
	        responsive:true,
	        buttons: [
	        	{
                    extend: 'excel',
                    className: 'btn-outline-secondary',
                    text: 'Excel',
                    filename: 'listadoDocentes',
                    className: 'btn-exportar-excel',
                    exportOptions: {
                        columns: [0, 1, 2,3,5, 6, 8, 9,13,14] // Mantener solo las primeras 12 columnas
                    },
                    customize: function (xlsx) {
                        var sheet = xlsx.xl.worksheets['listado de docentes.xml'];
                        
                        // Iterar sobre las filas del archivo XML de Excel
                        $('row', sheet).each(function (index) {
                            var row = $(this);
                            var rowClass = row.attr('class');
                            var activoIndex = 15; // Índice de la columna "Activo" en DataTables

                            // Verificar si el valor en DataTables es "Sí"
                            var table = $('#miTabla').DataTable();
                            var activoValueInTable = table.cell(index, activoIndex).data(); 

                            // Obtener la celda en el archivo XML de Excel
                            var cell = row.find('c[r="' + activoIndex + '"]');
                            
                            // Actualizar el valor en el archivo XML de Excel solo si el valor en DataTables es "Sí"
                            if (activoValueInTable === 'Sí') {
                                cell.text('Sí');
                            }
                        });
                    }
                },
                {
                    extend: 'pdf',
                    title: 'ListadoDocentes', // Título del archivo Excel
                    className: 'btn btn-outline-secondary', // Clase CSS para el botón
                    text: 'PDF', // Texto del botón
                    filename: 'listadoAlumnos', // Nombre del archivo PDF generado
                    className: 'btn-exportar-pdf', // Clase CSS adicional para el botón (si es necesario)
                    exportOptions: {
                        columns: [0, 1, 2,3,5, 6, 8, 9,13,14] // Mantener solo las primeras 12 columnas
                    },
 					orientation: 'landscape', // Establecer la orientación de la página como horizontal

                },
                {
                    extend: 'print',
                    className: 'btn-exportar-imprimir', 
                    text: 'Imprimir',
                    filename: 'listadoDocentes',
                    exportOptions: {
                        columns: [0, 1, 2,3,5, 6, 8, 9,13,14] // Mantener solo las primeras 12 columnas
                    },
                   
                }
                ],
                responsive:true,
	        columnDefs: [
	            { orderable: false, className: 'select-checkbox', targets: 0 },
	            { targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], orderable: true }
	        ],
	    });

	    // Agregar un manejador de clic a las filas de la tabla para seleccionar/deseleccionar
/**
 * Esta función maneja el evento de clic en cualquier parte de una fila de la tabla con el id "miTabla".
 * Permite la selección de la fila al hacer clic en cualquier parte de la misma, incluida la casilla de verificación.
 * También muestra u oculta los botones de acción según la selección de las filas.
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
	   /**
	    * Asocia la función cerrarModal al botón de cancelar y a la "x" superior del modal con el id "confirmModal".
	    * Esta función se ejecuta al hacer clic en cualquiera de estos elementos y cierra el modal.
	    */
       $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
           cerrarModal();
       });
	});
	/**
	 * Asocia eventos de clic a las filas y botones de eliminación en la tabla con el id "miTabla".
	 * - Al hacer clic en cualquier parte de una fila, se selecciona/deselecciona y se muestran/ocultan los botones de acción.
	 * - Al hacer clic en un botón de eliminación dentro de una fila, se muestra una confirmación de borrado y se borra la fila si se confirma.
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
	     * Asocia un evento de clic al botón de eliminación en cada fila de la tabla con el id "miTabla".
	     * Al hacer clic en un botón de eliminación, se detiene la propagación del evento al tr y se muestra una confirmación de borrado.
	     * Si se confirma el borrado, se llama a la función para borrar el usuario y se elimina la fila del DataTables.
	     */
	    $('#miTabla tbody').on('click', '.btn-borrar', function(e) {
	        e.stopPropagation(); // Evitar la propagación del clic al tr

	        // Obtener la fila correspondiente al botón de eliminar
	        var fila = $(this).closest('tr');

	        // Obtener el idUsu de la segunda columna de la fila
	        var idUsu = fila.find('td:eq(1)').text(); // Ajusta el índice según la ubicación del idUsu en tu tabla

	        // Mostrar confirmación de borrado
	        Swal.fire({
	            icon: 'warning',
	            title: '¿Estás seguro?',
	            text: 'Esta acción borrará el registro seleccionado',
	            showCancelButton: true,
	            confirmButtonText: 'Sí, borrar',
	            cancelButtonText: 'Cancelar'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                // Llamar a la función para borrar la fila solo si se confirma la acción
	                borrarUsuario(idUsu);

	                // Eliminar la fila del DataTables después de borrarla exitosamente
	                fila.remove();
	            }
	        });
	    });
	});
	
	/**
	 * Redirige al usuario a la página de registro de un nuevo docente.
	 * Esta función cambia la URL del navegador para dirigir al usuario a la página "registroDoc.jsp".
	 */
	function nuevoDocente() {
	    // Redirigir a tu página .jsp
	    window.location.href = "registroDoc.jsp";
	}
	
	/**
	 * Redirige al usuario a la página de creación de una nueva asignación para un docente.
	 * @param {string} id - El ID del docente para el cual se creará la nueva asignación.
	 * Esta función cambia la URL del navegador para dirigir al usuario a la página "nuevaAsignacionByDocenteRolAdmin.jsp".
	 */
	function nuevaAsignacionByDocenteRolAdmin(id){
 	console.log(id);
       window.location.href = "nuevaAsignacionByDocenteRolAdmin.jsp?id=" + id;
	}
	 /**
	   * Redirige al usuario a la página de registro de un nuevo docente.
	   *
	   * @param {string} id - El ID del docente para el cual se realizará el registro.
	   *                      Se utiliza para construir la URL con el parámetro correspondiente.
	   * @returns {void} No devuelve ningún valor.
	   */
	function redirectToRegistroDoc(id){
 	 console.log(id);
	    window.location.href = "registroDoc.jsp?id=" + id;
	}
	   /**
	    * Configura el botón de confirmación para eliminar un usuario.
	    * 
	    * @param {string} idUsuario - El ID del usuario que se va a eliminar.
	    * @returns {void} No devuelve ningún valor.
	    */	 
    function confirmarEliminar(idUsuario) {
        // Configura el valor del atributo 'data-id' con el ID del usuario
        document.getElementById('confirmDeleteBtn').setAttribute('data-id', idUsuario);

        // Muestra el modal de confirmación
        $('#confirmModal').modal('show');
    }
	    /**
	     * Asocia la función borrarUsuario al botón de confirmación de eliminación.
	     * Cuando se hace clic en el botón de confirmación de eliminación, esta función
	     * obtiene el ID del usuario seleccionado y llama a la función borrarUsuario
	     * con ese ID como parámetro.
	     */
     document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        var idUsuario = this.getAttribute('data-id');
        borrarUsuario(idUsuario);
    });
    /**
     * Envía una solicitud al servidor para borrar un usuario utilizando AJAX.
     * @param {string} id - El ID del usuario que se va a borrar.
     * La función construye la URL de la solicitud utilizando el ID del usuario
     * y el tipo de rol. Luego, utiliza la función fetch para enviar la solicitud
     * al servidor. Si la solicitud es exitosa, muestra un mensaje de éxito y
     * recarga la página. Si hay algún error en la comunicación con el servidor,
     * muestra un mensaje de error.
     */
     function borrarUsuario(id) {
        // Enviar la solicitud al servidor para borrar el usuario con el id proporcionado
        console.log("idFila en enviarSolicitudBorrado  " + id);
        var tipoRol = "DO";
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
      * Borra los usuarios seleccionados en la tabla.
      * La función obtiene las casillas de verificación seleccionadas en la primera columna de la tabla,
      * luego extrae los IDs de los usuarios seleccionados a partir de esas casillas.
      * Muestra un mensaje de confirmación para verificar si el usuario está seguro de borrar los seleccionados.
      * Si se confirma, itera sobre los IDs de los usuarios y llama a la función para borrar cada uno.
      * Si no se selecciona ningún usuario, muestra un mensaje de advertencia.
      */
	 function borrarSeleccionados() {
	        // Obtener las casillas de verificación seleccionadas en la primera columna
	        var checkboxes = $('#miTabla tbody td:first-child input[type="checkbox"]:checked');

	        // Obtener los IDs de los usuarios seleccionados a partir de las casillas de verificación
	        var idsUsuarios = checkboxes.map(function() {
	            return $(this).closest('tr').find('td:eq(1)').text(); // Suponiendo que el ID esté en la segunda columna
	        }).get();

	        console.log('Estoy en función borrarSeleccionados:', idsUsuarios);

	        // Verificar si se seleccionó al menos un usuario
	        if (idsUsuarios.length > 0) {
	            Swal.fire({
	                icon: 'warning',
	                title: '¿Estás seguro?',
	                text: 'Esta acción borrará ' + (idsUsuarios.length > 1 ? 'todos los usuarios seleccionados' : 'el usuario seleccionado'),
	                showCancelButton: true,
	                confirmButtonText: 'Sí, borrar' + (idsUsuarios.length > 1 ? ' todos' : ''),
	                cancelButtonText: 'Cancelar'
	            }).then((result) => {
	                if (result.isConfirmed) {
	                    idsUsuarios.forEach((id) => {
	                        borrarUsuario(id, tipoRol);
	                    });
	                }
	            });
	        } else { // Si no se seleccionó ningún usuario, mostrar mensaje de advertencia
	            Swal.fire({
	                icon: 'warning',
	                title: 'Advertencia',
	                text: 'No se ha seleccionado ningún usuario para borrar',
	                confirmButtonText: 'Aceptar'
	            });
	        }
	    }
	 /**
	  * Redirige a la página .jsp donde se gestionan las asignaciones a materias para los docentes
	  */  
	function AsignacionesAMaterias() {
	    // Redirigir a tu página .jsp
	    window.location.href = 'crudAsignacionesDocenteRolAdmin.jsp';
	}
	/**
	 * Cierra el modal de confirmación.
	 * Realiza cualquier acción adicional necesaria al cerrar el modal.
	 */
	function cerrarModal() {
   	 $('#confirmModal').modal('hide');

        // Realiza cualquier acción adicional al cerrar el modal
        console.log('Modal cerrado');
   }
	</script>
</body>
</html>
