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
				<td><a
					href="editMatriculacionRolAdmin.jsp?idMatri=<%=matri.getIdMatri()%>&idAlu=<%=matri.getIdAlu()%>&nomComp=<%=matri.getNomCompAlu()%>&email=<%=matri.getEmail()%>&fechMatri=<%=matri.getFechMatri()%>&modMatri=<%=matri.getModMatri()%>&activo=<%=matri.getActivo()%>&idEst=<%=matri.getIdEst()%>&idMat=<%=matri.getIdMat()%>&obsMatri=<%=matri.getObsMatri()%>">
						<button type="button" class="btn btn-primary btn-sm">
							<i class="fa fa-pencil" aria-hidden="true"></i>
						</button>
				</a> <!-- este hay que modificarlo para borrar-->
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
	/**
	 * Función que se ejecuta cuando el documento está completamente cargado y listo para ser manipulado.
	 */
	$(document).ready(function() {
		 /**
	     * Inicialización de la tabla utilizando el plugin DataTables.
	     */
	     tabla = $('#miTabla').DataTable({
	         // Configuración para el desplazamiento vertical automático
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
                    	// Personalización del documento PDF
                        // Lógica para modificar el contenido del PDF
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



            ], // Aquí va la coma faltante
	        responsive:true,
	        columnDefs: [
	            { orderable: false, className: 'select-checkbox', targets: 0 },
	            { targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], orderable: true }
	        ],      
	    });
  

	    // Agregar un manejador de clic a las filas de la tabla para seleccionar/deseleccionar
	   /**
 		* Función que maneja el evento clic en las filas de la tabla.
		* Cambia la selección de la fila y la casilla de verificación asociada.
 		* Además, muestra u oculta los botones de acción según la selección.
 		* @param e El evento de clic.
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

       // Asociar la función cerrarModal al botón de cancelar y a la "x" superior
       $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
           cerrarModal();
       });
	    
	});
	

	function nuevaMatriculacion() {
	    // Redirigir a tu página .jsp
	    window.location.href = "nuevaMatriculacionAlumnoRolAdmin.jsp";
	}


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


// //Define la función para seleccionar la fila y llamar a borrarSeleccionados
// function botonEliminar((id) {
     
//     borrarSeleccionados();
// }

// 	function matriculaciones() {
// 	    // Redirigir a tu página .jsp
// 	    window.location.href = 'crudAlumnosMatriculas.jsp';
// 	}


	function cerrarModal() {
   	 $('#confirmModal').modal('hide');

        // Realiza cualquier acción adicional al cerrar el modal
        console.log('Modal cerrado');
   }
	
	</script>


</body>
</html>
