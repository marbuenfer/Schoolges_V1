<%@page import="com.dao.DaoUsuario"%>
<%@page import="com.logica.Alumno"%>
<%@page import="com.logica.Matricula"%>
<%@page import="com.dao.DaoMatricula"%>

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

<title>Listado de matriculas</title>

</head>

<body>
	<%@ include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>

	<h2>MATRICULACIONES DE ALUMNOS</h2>

	<!-- Botones de acción -->
	<div>
		<button type="button" class="btn btn-primary" style="margin: 10px;"
			onclick="nuevaMatriculacion()">
			<i class="fa fa-plus" aria-hidden="true"></i> Nueva matriculación
		</button>
		<button type="button" class="btn btn-danger" style="margin: 10px;"
			onclick="borrarSeleccionados()">Borrar Seleccionados</button>
	</div>
	<!-- Tabla mostrar datos -->
	<table id="miTabla"
		class="table table-bordered table-striped table-border-top table-hover responsive table-custom-padding"
		style="width: 100%;">
		<!-- añadir para que salga tambien elcentro que lo recoge mi sql -->
		<thead>
			<tr>
				<th></th>
				<!-- Columna de selección -->
				<th>ID. MATRI</th>
				<th>ID.ALU</th>
				<th>Nombre Completo</th>
				<th>ID.EST</th>
				<th>Nombre estudio</th>
				<th>ID.MAT</th>
				<th>Nombre Materia</th>
				<th>ID.Doc</th>
				<th>Nombre Docente</th>

				<th>Modalidad</th>
				<th>Fech.Matri</th>
				<th>Observaciones</th>
				<th>Id.Cen</th>
				<th>Nombre centro</th>
				<th>Activo</th>
				<th>Acciones</th>
			</tr>
		</thead>
		<tbody>
			<%
			DaoMatricula daoMatri = new DaoMatricula(DbConexion.getConn());
			List<Matricula> listaMatriculas = daoMatri.getAllMatriculas();

			for (Matricula matri : listaMatriculas) {
				//Alumnos alu = new Alumnos();
				//alu = daoUsu.getUsuarioById(alu.getIdAlu());
			%>
			<tr class="<%=(matri.getActivo() == 1) ? "" : "table-danger"%>">
				<td><input type="checkbox" class="seleccionar-fila"></td>
				<td><%=matri.getIdMatri()%></td>
				<td><%=matri.getIdAlu()%></td>
				<td><%=matri.getNomCompAlu()%></td>
				<td><%=matri.getIdEst()%></td>
				<td><%=matri.getNomEst()%></td>
				<td><%=matri.getIdMat()%></td>
				<td><%=matri.getNomMat()%></td>

				<td><%=matri.getIdDoc()%></td>
				<td><%=matri.getNomDoc()%></td>

				<td><%=matri.getModMatri()%></td>
				<td><%=(matri.getFechMatri() != null) ? matri.getFechMatri() : "s/f"%></td>

				<td><%=matri.getObsMatri()%></td>
				<td><%=matri.getIdCen()%></td>
				<td><%=matri.getNomCen()%></td>
				<td>
					<div
						class="<%=(matri.getActivo() == 1) ? "activo-verde" : "activo-rojo"%>"></div>
				</td>
				<!-- Botones de acción en la fila de la tabla -->
				<td><a
					href="editMatriculacionRolAdmin.jsp?idMatri=<%=matri.getIdMatri()%>&idAlu=<%=matri.getIdAlu()%>&nomComp=<%=matri.getNomCompAlu()%>&email=<%=matri.getEmail()%>&fechMatri=<%=matri.getFechMatri()%>&modMatri=<%=matri.getModMatri()%>&activo=<%=matri.getActivo()%>&idEst=<%=matri.getIdEst()%>&idMat=<%=matri.getIdMat()%>&obsMatri=<%=matri.getObsMatri()%>">
						<button type="button" class="btn btn-primary btn-sm">
							<i class="fa fa-pencil" aria-hidden="true"></i>
						</button>
				</a>
					<button type="button" class="btn btn-danger btn-sm btn-borrar">
						<i class="fa fa-trash" aria-hidden="true"></i>
					</button>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>


	<script> 
	var tabla;
	$(document).ready(function() {
	     tabla = $('#miTabla').DataTable({
	    	 scrollY: 'auto', // la altura 
	    	 // Habilita la paginación
	    	 select: {
	            style: 'multi' // Permite la selección múltiple
	        },
	        paging: true,
	  	  
	        dom: '<"d-flex justify-content-center"f><"d-flex justify-content-end mb-2"B>t<"d-flex justify-content-end"i>',
	        pageLength: 18, // número de registros a mostrar por página
	        responsive: true,
	        buttons: [
                {
                    extend: 'csv',
                    className: 'btn-exportar-csv',
                },
                {
                    extend: 'excel',
                    className: 'btn-outline-secondary',
                    filename: 'listadoMatriculaciones',
                    className: 'btn-exportar-excel',
                    customize: function (xlsx) {
                        var sheet = xlsx.xl.worksheets['listado de matriculas.xml'];
                        
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
                    className: 'btn btn-outline-secondary',
                    orientation: 'landscape',
                    className: 'btn-exportar-pdf', 
                    customize: function (doc) {
                        // Obtener el contenido de la tabla
                        var table = $('#miTabla').DataTable();
                        var data = table.rows().data();

                        // Obtener el índice del campo "Activo"
                        var activoIndex = table.column(':contains("Activo")').index();

                        // Iterar sobre las filas de datos
                        data.each(function (value, index) {
                            // Obtener el valor del campo "Activo"
                            var activoValue = value[activoIndex];

                            // Verificar si la fila tiene la clase "activo-verde" o "activo-rojo"
                            var rowNode = table.row(index).node();
                            var isActiveGreen = $(rowNode).find('.activo-verde').length > 0;
                            var isActiveRed = $(rowNode).find('.activo-rojo').length > 0;

                            // Asignar el color de fondo adecuado al valor del campo "Activo"
                            if (isActiveGreen) {
                                activoValue = 'Sí';
                                // Aplicar color de fondo verde al valor del campo "Activo" en el PDF
                                doc.content[1].table.body[index + 1][activoIndex].fillColor = '#28a745';
                            } else if (isActiveRed) {
                                activoValue = 'No';
                                // Aplicar color de fondo rojo al valor del campo "Activo" en el PDF
                                doc.content[1].table.body[index + 1][activoIndex].fillColor = '#dc3545';
                            }

                            // Actualizar el valor en el PDF
                            doc.content[1].table.body[index + 1][activoIndex].text = activoValue;
                        });
                    }
                },
                {
                    extend: 'print',
                    className: 'btn-exportar-imprimir', 
                    text: 'Imprimir',
                    customize: function (win) {
                        var loadingMessage = '<div class="text-center"><i class="fa fa-spinner fa-spin"></i> Generando impresión...</div>';
                        $(win.document.body).html(loadingMessage);

                        setTimeout(function () {
                            // Obtener el contenido de la tabla
                            var table = $('#miTabla').DataTable();
                            var data = table.rows().data();

                            // Obtener la cabecera de las columnas
                            var headers = table.columns().header().toArray().map(function (th) {
                                return $(th).text();
                            });

                            // Obtener el índice del campo "Activo"
                            var activoIndex = table.column(':contains("Activo")').index();

                            // Crear una tabla HTML para la personalización de impresión
                            var html = '<table border="1" cellpadding="5" cellspacing="0"><thead><tr>';

                            // Agregar las cabeceras de las columnas
                            headers.forEach(function (header) {
                                html += '<th>' + header + '</th>';
                            });

                            html += '</tr></thead><tbody>';

                            // Iterar sobre las filas de datos
                            data.each(function (value, index) {
                                // Iniciar una nueva fila en la tabla HTML
                                html += '<tr>';

                                // Iterar sobre las celdas de la fila
                                value.each(function (cellValue, i) {
                                    // Verificar si la celda corresponde a la columna "Activo"
                                    if (i === activoIndex) {
                                        // Verificar si la fila tiene la clase "activo-verde" o "activo-rojo"
                                        var rowNode = table.row(index).node();
                                        var isActiveGreen = $(rowNode).find('.activo-verde').length > 0;
                                        var isActiveRed = $(rowNode).find('.activo-rojo').length > 0;

                                        // Asignar el color de fondo adecuado al valor del campo "Activo"
                                        if (isActiveGreen) {
                                            cellValue = 'Sí';
                                            // Aplicar color de fondo verde a la celda en la tabla HTML
                                            html += '<td style="background-color: #28a745;">' + cellValue + '</td>';
                                        } else if (isActiveRed) {
                                            cellValue = 'No';
                                            // Aplicar color de fondo rojo a la celda en la tabla HTML
                                            html += '<td style="background-color: #dc3545;">' + cellValue + '</td>';
                                        }
                                    } else {
                                        // Agregar el valor de la celda sin modificaciones
                                        html += '<td>' + cellValue + '</td>';
                                    }
                                });

                                // Cerrar la fila en la tabla HTML
                                html += '</tr>';
                            });

                            // Cerrar la tabla HTML
                            html += '</tbody></table>';

                            // Actualizar el contenido del cuerpo del documento de impresión
                            $(win.document.body).html(html);
                        }, 100);
                    }
                }

            ],  
	        responsive:true,
	        columnDefs: [
	            { orderable: false, className: 'select-checkbox', targets: 0 },
	            { targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], orderable: true }
	        ],      
	    });
  

 /**
 * Maneja el evento de clic en una fila de la tabla.
 * Si se hace clic en la casilla de verificación, cambia la selección de la fila.
 * Si se hace clic en cualquier parte de la fila excepto la casilla de verificación, cambia la selección de la fila y la casilla de verificación.
 * Además, muestra u oculta los botones de acción según la selección de filas.
 * @param {Event} e - El evento de clic.
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
  * Asocia la función cerrarModal al botón de cancelar y a la "x" superior del modal de confirmación.
  * Esto garantiza que la función cerrarModal se llame cuando se hace clic en el botón de cancelar o en la "x" para cerrar el modal.
  */
       // Asociar la función cerrarModal al botón de cancelar y a la "x" superior
       $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
           cerrarModal();
       });
	    
	});
	
	/**
	 * Redirige a la página .jsp para realizar una nueva matriculación de un alumno con el rol de administrador.
	 */
	function nuevaMatriculacion() {
	    // Redirigir a tu página .jsp
	    window.location.href = "nuevaMatriculacionAlumnoRolAdmin.jsp";
	}

	/**
	 * Redirige a la página de edición de matriculación con información sobre la matriculación proporcionada.
	 * @param {string} id - El ID de la matriculación.
	 * @param {string} idAlu - El ID del alumno.
	 * @param {string} nomComp - El nombre completo del alumno.
	 * @param {string} email - El correo electrónico del alumno.
	 * @param {string} fechMatri - La fecha de matriculación.
	 * @param {string} modMatri - El módulo de matriculación.
	 * @param {string} activo - Estado de activación.
	 * @param {string} idEst - ID del establecimiento.
	 * @param {string} idMat - ID de la materia.
	 * @param {string} obsMatri - Observaciones sobre la matriculación.
	 */
	function editMatriculacionRolAdmin(id, idAlu, nomComp, email, fechMatri, modMatri, activo, idEst, idMat, obsMatri) {
    var queryString = "?idMatri=" + id +
        "&idAlu=" + idAlu +
        "&nomComp=" + nomComp +
        "&email=" + email +
        "&fechMatri=" + fechMatri +
        "&modMatri=" + modMatri +
        "&activo=" + activo +
        "&idEst=" + idEst +
        "&idMat=" + idMat +
        "&obsMatri=" + obsMatri;

    console.log(queryString);
    window.location.href = "editMatriculacionRolAdmin.jsp" + queryString;
}

	 /**
	  * Envía una solicitud al servidor para eliminar la matrícula con el ID proporcionado.
	  * @param {string} id - El ID de la matrícula a eliminar.
	  */
    
    function borrarMatricula(id) {
    	 // Enviar la solicitud al servidor para borrar el usuario con el id proporcionado
        console.log("idFila en enviarSolicitudBorrado  " + id);
        var tipoRol = "AL";
        var contextPath = "/SchoolGes_v1"
        var servletUrl = contextPath + "/SvBorrarMatricula?idMatri=" + id + "&tipoRol=" + tipoRol;

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
	   * Borra las matrículas seleccionadas.
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
                text: 'Esta acción borrará ' + (idsUsuarios.length > 1 ? 'todos las matriculas seleccionadas' : 'el usuario seleccionado'),
                showCancelButton: true,
                confirmButtonText: 'Sí, borrar' + (idsUsuarios.length > 1 ? ' todos' : ''),
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    idsUsuarios.forEach((id) => {
                        console.log('Borrando matricula con ID:', id);
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
     * Función para cerrar el modal de confirmación y realizar acciones adicionales.
     */
    	function cerrarModal() {
       	 $('#confirmModal').modal('hide');
            console.log('Modal cerrado');
       } 
   
    	
    /**
     * Función que se ejecuta cuando el documento HTML ha sido completamente cargado y analizado.
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
          * Función para manejar el clic en el botón de borrar dentro de la tabla.
          * @param {Event} e - El evento de clic.
          */
         $('#miTabla tbody').on('click', '.btn-borrar', function(e) {
             e.stopPropagation(); // Evitar la propagación del clic al tr

             // Obtener la fila correspondiente al botón de eliminar
             var fila = $(this).closest('tr');

             // Obtener el idMatri de la segunda columna de la fila
             var idMatri = fila.find('td:eq(1)').text(); // Ajusta el índice según la ubicación del idMatri en tu tabla

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
                     borrarMatricula(idMatri);

                     // Eliminar la fila del DataTables después de borrarla exitosamente
                     fila.remove();
                 }
             });
         });
     });
   


	
	</script>


</body>
</html>
