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

<%
/**
 * Esta página JSP muestra un listado de alumnos y proporciona funcionalidades para gestionarlos.
 * Utiliza las clases DaoUsuario y DaoAlumno para acceder a la base de datos y obtener los datos de los alumnos.
 * También incluye funcionalidades para realizar acciones como nuevo alumno, borrar seleccionados y gestionar
 * matriculaciones.
 */
%>

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
		<button type="button" class="btn btn-primary" style="margin: 10px;"
			onclick="nuevoAlumno()">
			<i class="fa fa-plus" aria-hidden="true"></i> Nuevo Alumno
		</button>

		<button type="button" class="btn btn-danger" style="margin: 10px;"
			onclick="borrarSeleccionados()">Borrar Seleccionados</button>
		<button type="button" class="btn btn-warning text-white"
			style="margin: 10px;" onclick="matriculaciones()">Matriculaciones</button>
	</div>

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
				<th>Acciones</th>
				<!-- Nueva columna para botones de acción -->
			</tr>
		</thead>
		<tbody>
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
				<td>
					<!-- Botones de acción -->
					<button type="button" class="btn btn-warning btn-sm text-white"
						onclick="nuevaMatricula(<%=alu.getIdUsu()%>)">
						<i class="fa fa-graduation-cap" aria-hidden="true"></i>

					</button> <!-- este hay que modificarlo para editar-->

					<button type="button" class="btn btn-primary btn-sm"
						onclick="redirectToRegistroAlu(<%=alu.getIdUsu()%>)">
						<i class="fa fa-pencil" aria-hidden="true"></i>


					</button> <!-- este hay que modificarlo para borrar-->
					<button type="button" class="btn btn-danger btn-sm"
						onclick="confirmarEliminar('<%=alu.getIdUsu()%>')">
						<i class="fa fa-trash" aria-hidden="true"></i>
					</button> <!-- Agrega más botones según tus necesidades -->
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<!-- 	</div> -->
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
	            { targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], orderable: true }
	        ],
	         
	    });

	    // Agregar un manejador de clic a las filas de la tabla para seleccionar/deseleccionar
	   
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

	  

       // Asociar la función cerrarModal al botón de cancelar y a la "x" superior
       $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
           cerrarModal();
       });
	});

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
 * Redirige al usuario a la página "registroAlu.jsp" para agregar un nuevo alumno.
 */	
function nuevoAlumno() {
    // Redirigir a tu página .jsp
    window.location.href = "registroAlu.jsp";
}

/**
 * Redirige al usuario a la página "nuevaMatriculacionByAlumnoRolAdmin.jsp" para gestionar la matriculación de 
 * un alumno específico.
 * @param {number} id - El ID del alumno para el cual se gestionará la matriculación.
 */
function nuevaMatricula(id){
	console.log(id);
    window.location.href = "nuevaMatriculacionByAlumnoRolAdmin.jsp?id=" + id;

}

 /**
  * Redirige al usuario a la página "registroAlu.jsp" para editar los datos de un alumno específico.
  * @param {number} id - El ID del alumno cuyos datos se editarán.
  */
function redirectToRegistroAlu(id){
	 console.log(id);
    window.location.href = "registroAlu.jsp?id=" + id;
}
	
  /**
   * Configura el ID del usuario en el atributo 'data-id' del botón de confirmación y muestra el modal de confirmación para eliminar el usuario.
   * @param {number} idUsuario - El ID del usuario que se eliminará.
   */	 
function confirmarEliminar(idUsuario) {
    // Configura el valor del atributo 'data-id' con el ID del usuario
    document.getElementById('confirmDeleteBtn').setAttribute('data-id', idUsuario);

    // Muestra el modal de confirmación
    $('#confirmModal').modal('show');
}

   /**
    * Asocia la función 'borrarUsuario' al evento de clic del botón de confirmación de eliminación.
    * Cuando se hace clic en el botón de confirmación, se obtiene el ID del usuario a eliminar del atributo 'data-id' del botón y se llama a la función 'borrarUsuario' con dicho ID como parámetro.
    */
document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
    var idUsuario = this.getAttribute('data-id');
    borrarUsuario(idUsuario);
});
    

/**
 * Envia una solicitud al servidor para borrar el usuario con el ID proporcionado utilizando AJAX.
 * @param {number} id - El ID del usuario que se va a borrar.
 */
// Función para borrar el usuario utilizando AJAX
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
  * Obtiene las casillas de verificación seleccionadas en la primera columna de la tabla y los 
  * IDs de los usuarios seleccionados.
  * Luego, muestra un mensaje de confirmación para borrar los usuarios seleccionados. Si se confirma la acción, 
  * llama a la función 'borrarUsuario' para cada usuario seleccionado.
  * Si no se selecciona ningún usuario, muestra un mensaje de advertencia.
  */
function borrarSeleccionados() {
    // Obtener las casillas de verificación seleccionadas en la primera columna
    var checkboxes = $('#miTabla tbody td:first-child input[type="checkbox"]:checked');

    // Obtener los IDs de los usuarios seleccionados a partir de las casillas de verificación
    var idsUsuarios = checkboxes.map(function() {
        return $(this).closest('tr').find('td:eq(1)').text().trim(); // Suponiendo que el ID esté en la segunda columna
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
                    console.log('Borrando usuario con ID:', id);
                    borrarUsuario(id);
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
 * Redirige al usuario a la página JSP 'crudMatriculacionesRolAdmin.jsp', donde puede gestionar las 
 * matriculaciones de los alumnos.
 */	    
function matriculaciones() {
    // Redirigir a la página .jsp
    window.location.href = 'crudMatriculacionesRolAdmin.jsp';
}

/**
 * Cierra el modal de confirmación ('confirmModal').
 * Además, puede realizar acciones adicionales después de cerrar el modal, como imprimir un mensaje en la consola.
 */
function cerrarModal() {
  	 $('#confirmModal').modal('hide');

       // Realiza cualquier acción adicional al cerrar el modal
       console.log('Modal cerrado');
  }
	</script>
</body>
</html>
