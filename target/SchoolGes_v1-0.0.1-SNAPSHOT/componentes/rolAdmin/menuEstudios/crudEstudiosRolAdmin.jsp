<%@page import="com.dao.DaoEstudio"%>

<%@page import="com.logica.Estudio"%>
<%@page import="com.dao.DaoCentro"%>

<%@page import="java.util.List"%>
<%@page import="com.db.DbConexion"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
	
<%
/**
 * Esta página JSP muestra un listado de estudios y proporciona funcionalidades para gestionarlos.
 */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">


</head>
<body>
	<%@include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>

	<h2>LISTADO ESTUDIOS</h2>

	<!-- Botones de acción -->
	<div>
		<button type="button" class="btn btn-primary" style="margin: 10px;"
			onclick="nuevo()">
			<i class="fa fa-plus" aria-hidden="true"></i> Nuevo Estudio
		</button>
		<button type="button" class="btn btn-warning text-white"
			style="margin: 10px;" onclick="nuevaAsignacionMateriaEstudio()">
			<i class="fa fa-plus" aria-hidden="true"></i>Nueva Asignación de
			Materias a estudio
		</button>

		<button type="button" class="btn btn-danger" style="margin: 10px;"
			onclick="borrarSeleccionados()">Borrar Seleccionados</button>

	</div>

	<table id="miTabla"
		class="table table-bordered table-striped table-border-top table-hover responsive"
		style="width: 100%">
		<thead>
			<tr>
				<th></th>
				<!-- Columna de selección -->
				<th>ID</th>
				<th>Nombre Estudio</th>
				<th>Especialidad</th>
				<th>Horas</th>
				<th>Observaciones</th>
				<th>Acciones</th>
				<!-- Nueva columna para botones de acción -->
			</tr>
		</thead>
		<tbody>
			<%
			//DaoUsuario daoUsu = new DaoUsuario(DbConexion.getConn());
			DaoEstudio daoEst = new DaoEstudio(DbConexion.getConn());
			List<Estudio> listaEstudios = daoEst.getAllEstudios();

			for (Estudio est : listaEstudios) {
			%>
			<tr>
				<td><input type="checkbox" class="seleccionar-fila"></td>
				<td><%=est.getIdEst()%></td>
				<td><%=est.getNomEst()%></td>
				<td><%=est.getEspeEst()%></td>
				<td><%=est.getHoraEst()%></td>
				<td><%=est.getObsEst()%></td>

				<!-- Botones de acción -->
				<td>
					<button type="button" class="btn btn-primary btn-sm"
						onclick="editarEstudio(<%=est.getIdEst()%>)">
						<i class="fa fa-pencil" aria-hidden="true"></i>
					</button>

					<button type="button" class="btn btn-danger btn-sm btn-borrar">
						<i class="fa fa-trash" aria-hidden="true"></i>
					</button>
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

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
    var contextPath = '${pageContext.request.contextPath}';
    /**
     * Inicialización de DataTable para la tabla 'miTabla'.
     */
	$(document).ready(function() {
		//$('#miTabla').DataTable().destroy();
	    tabla = $('#miTabla').DataTable({
	        scrollY: 'auto',
	        select: {
	            style: 'multi'
	        },
	        paging: true,
	        dom: '<"d-flex justify-content-center"f><"d-flex justify-content-end mb-2"B>t<"d-flex justify-content-end"i>',
	        pageLength: 18,
	        responsive: true,
	        buttons: [
	            {
	                extend: 'excel',
	                title: 'Listado estudios', // Título del archivo Excel
	                filename: 'listadoEstudios',
	                className: 'btn-exportar-excel',
	                exportOptions: {
	                    columns: ':not(:last-child)' // Excluir la última columna
	                },
 					orientation: 'landscape', // Establecer la orientación de la página como horizontal
	            },
	            {
	                extend: 'pdf',
	                title: 'Listado estudios', // Título del archivo Excel
	                className: 'btn btn-outline-secondary',
	                orientation: 'landscape',
	                className: 'btn-exportar-pdf',
	                exportOptions: {
	                    columns: ':not(:last-child)' // Excluir la última columna
	                }
	            },
	            {
	                extend: 'print',
	                title: 'Listado estudios', // Título del archivo Excel
	                className: 'btn-exportar-imprimir',
	                text: 'Imprimir',
	                customize: function (win) {
	                    // Código personalizado para la impresión
	                },
// 	                exportOptions: {
// 	                    columns: ':not(:last-child)' // Excluir la última columna
// 	                }
	            }
	        ],
	        responsive:true,
	        columnDefs: [
	            { orderable: false, className: 'select-checkbox', targets: 0 },
	            { targets: [1, 2, 3, 4, 5, 6], orderable: true }
	        ],
	    });
	 

	    // Agregar un manejador de clic a las filas de la tabla para seleccionar/deseleccionar
	   /**
		 * Maneja el clic en cualquier parte de la fila de la tabla 'miTabla' para seleccionarla.
		 * Si se hace clic en la casilla de verificación, cambia la selección solo de esa fila.
		 * Si se hace clic en cualquier otra parte de la fila, cambia la selección de la fila y la casilla de verificación.
		 * Además, muestra u oculta los botones de acción según la selección.
		 * 
		 * @param {Event} e - Evento de clic
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
 * Asocia la función 'cerrarModal()' al hacer clic en el botón de cierre ('close') del modal de confirmación y en el botón secundario ('btn-secondary').
 */
 $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
           cerrarModal();
       });
	    
	});

	/**
	 * Redirige a la página 'nuevoEstudioRolAdmin.jsp' para agregar un nuevo estudio, pasando el tipo de operación como parámetro.
	 */	 
function nuevo() {
    var tipo = 'nuevo';
    window.location.href = contextPath + "/componentes/rolAdmin/menuEstudios/nuevoEstudioRolAdmin.jsp?tipo=" + tipo;
}
/**
 * Redirige a la página 'nuevoEstudioRolAdmin.jsp' para editar un estudio específico, pasando el ID del estudio y el tipo de operación como parámetros.
 * @param {string} idEst - El ID del estudio que se desea editar.
 */
function editarEstudio(idEst) {
    var tipo = 'editar';
    window.location.href = contextPath + "/componentes/rolAdmin/menuEstudios/nuevoEstudioRolAdmin.jsp?idEst=" + idEst + '&tipo=' + tipo;
}

function borrarEstudio(id) {
	 // Enviar la solicitud al servidor para borrar el usuario con el id proporcionado
   console.log("idFila en enviarSolicitudBorrado  " + id);
   //var tipoRol = "AL";
  // var contextPath = "/SchoolGes_v1"
   var servletUrl = contextPath + "/SvBorrarEstudio?idEst=" + id  ;

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
 * Envía una solicitud al servidor para borrar un estudio específico con el ID proporcionado.
 * @param {string} id - El ID del estudio que se desea borrar.
 */
function borrarSeleccionados() {
   // Obtener las casillas de verificación seleccionadas en la primera columna
   var checkboxes = $('#miTabla tbody td:first-child input[type="checkbox"]:checked');

   // Obtener los IDs de los usuarios seleccionados a partir de las casillas de verificación
   var idsCentros = checkboxes.map(function() {
       return $(this).closest('tr').find('td:eq(1)').text().trim(); // Suponiendo que el ID esté en la segunda columna
   }).get();

   console.log('Estoy en función borrarSeleccionados:', idsCentros);

   // Verificar si se seleccionó al menos un usuario
   if (idsCentros.length > 0) {
       Swal.fire({
           icon: 'warning',
           title: '¿Estás seguro?',
           text: 'Esta acción borrará ' + (idsCentros.length > 1 ? 'todos los estudios seleccionados' : 'el centro seleccionado'),
           showCancelButton: true,
           confirmButtonText: 'Sí, borrar' + (idsCentros.length > 1 ? ' todos' : ''),
           cancelButtonText: 'Cancelar'
       }).then((result) => {
           if (result.isConfirmed) {
               idsCentros.forEach((id) => {
                   console.log('Borrando centro con ID:', id);
                   borrarEstudio(id);
               });
           }
       });
   } else { // Si no se seleccionó ningún usuario, mostrar mensaje de advertencia
       Swal.fire({
           icon: 'warning',
           title: 'Advertencia',
           text: 'No se ha seleccionado ningún centro para borrar',
           confirmButtonText: 'Aceptar'
       });
   }
}
 /**
  * Cierra manualmente el modal de confirmación.
  */
function cerrarModal() {
    $('#confirmModal').modal('hide');
    console.log('Modal cerrado');
}
/**
 * Asocia la función para borrar un estudio al hacer clic en el botón de confirmación de eliminación en el modal.
 */
document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
    var idEst = this.getAttribute('data-id');
    borrarEstudio(idEst);
});
/**
 * Asocia la función para seleccionar filas al hacer clic en cualquier parte de la fila en la tabla.
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

    // Manejar clic en el botón de eliminar sin afectar la selección de filas
    $('#miTabla tbody').on('click', '.btn-borrar', function(e) {
        e.stopPropagation(); // Evitar la propagación del clic al tr

        // Obtener la fila correspondiente al botón de eliminar
        var fila = $(this).closest('tr');

        // Obtener el idEst de la segunda columna de la fila
        var idEst = fila.find('td:eq(1)').text(); // Ajusta el índice según la ubicación del idEst en tu tabla

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
                borrarEstudio(idEst);

                // Eliminar la fila del DataTables después de borrarla exitosamente
                fila.remove();
            }
        });
    });
});

/**
 * Redirige a la página para crear una nueva asignación de materia a un estudio.
 */ 
function nuevaAsignacionMateriaEstudio() {
    // Redirigir a tu página .jsp
    // Definir la URL base de la aplicación  
     var contextPath = '${pageContext.request.contextPath}';

    window.location.href = contextPath + '/componentes/rolAdmin/menuEstudios/nuevaAsignacionMateriaEstudioRolAdmin.jsp';
}
	</script>

</body>
</html>
