
<%@page import="com.logica.Docente"%>
<%@page import="com.logica.Usuario"%>
<%@page import="com.logica.AsignacionDocente"%>
<%@page import="com.dao.DaoDocente"%>
<%@page import="com.dao.DaoUsuario"%>

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

<title>Listado de asignaciones de materias a docentes</title>

</head>

<body>
	<%@ include file="/resources/css/allcss.jsp"%>

	<%@include file="/componentes/navbar.jsp"%>

	<h2>ASIGNACIONES A DOCENTES</h2>

	<!-- Botones de acción -->
	<div>
		<button type="button" class="btn btn-primary" style="margin: 10px;"
			onclick="nuevaAsignación()">
			<i class="fa fa-plus" aria-hidden="true"></i> Nueva Asignación
		</button>
		<button type="button" class="btn btn-danger" style="margin: 10px;"
			onclick="borrarSeleccionados()">Borrar Seleccionados</button>
	</div>
	<%
/**
 * Esta tabla muestra una lista de asignaciones, cada una con su respectivo ID de asignación, ID de docente,
 * DNI, nombre completo, email, ID de materia, nombre de materia, fecha de inicio, fecha de fin, estado activo,
 * observaciones y acciones disponibles.
 */
%>
	 

	<table id="miTabla"
		class="table table-bordered table-striped table-border-top table-hover responsive table-custom-padding"
		style="width: 100%;">
		<!-- añadir para que salga tambien elcentro que lo recoge mi sql -->
		<thead>
			<tr>
				<th></th>
				<!-- Columna de selección -->
				<th>Id. Asig</th>
				<th>Id. Doc</th>
				<th>DNI</th>
				<th>Nombre Completo</th>
				<th>email</th>
				<th>Id. Mat</th>
				<th>Nombre materia</th>
				<th>Fech.Ini</th>
				<th>Fech.Fin</th>
				<th>Activo</th>
				<th>Observaciones</th>
				<th>Acciones</th>
			</tr>
		</thead>
		<tbody>
			<%
			//Usuario usu = new Usuario(DbConexion.getConn());
			DaoDocente daoDoc = new DaoDocente(DbConexion.getConn());
			List<AsignacionDocente> listaAsignacionesDocente = daoDoc.getAllAsignacionDocentes();

			for (AsignacionDocente asigDoc : listaAsignacionesDocente) {
				//Alumnos alu = new Alumnos();
				//alu = daoUsu.getUsuarioById(alu.getIdAlu());
			%>
			<tr class="<%=(asigDoc.getActivo() == 1) ? "" : "table-danger"%>">
				<td><input type="checkbox" class="seleccionar-fila"></td>
				<td><%=asigDoc.getIdAsg()%></td>
				<td><%=asigDoc.getIdDoc()%></td>
				<td><%=asigDoc.getDniUsu()%></td>
				<td><%=asigDoc.getNomCompUsu()%></td>
				<%-- 				<td><%=matri.getIdEst()%></td> --%>
				<%-- 				<td><%=matri.getNomEst()%></td> --%>
				<td><%=asigDoc.getEmailUsu()%></td>

				<td><%=asigDoc.getIdMat()%></td>
				<td><%=asigDoc.getNomMat()%></td>

				<%-- 				<td><%=matri.getIdDoc()%></td> --%>
				<%-- 				<td><%=asigDoc.getNomDoc()%></td> --%>

				<%-- 				<td><%=asigDoc.getModMatri()%></td> --%>
				<td><%=(asigDoc.getFechIniAsigDoc() != null) ? asigDoc.getFechIniAsigDoc() : "s/f"%></td>
				<td><%=(asigDoc.getFechFinAsigDoc() != null) ? asigDoc.getFechFinAsigDoc() : "s/f"%></td>


				<%-- 				<td><%=asigDoc.getIdCen()%></td> --%>
				<%-- 				<td><%=asigDoc.getNomCen()%></td> --%>
				<td>
					<div
						class="<%=(asigDoc.getActivo() == 1) ? "activo-verde" : "activo-rojo"%>"></div>
				</td>
				<td><%=asigDoc.getObsAsigDoc()%></td>
				<td><a
					href="editAsignacionByDocenteRolAdmin.jsp?idAsg=<%=asigDoc.getIdAsg()%>&idDoc=<%=asigDoc.getIdDoc()%>&nomCompUsu=<%=asigDoc.getNomCompUsu()%>&emailUsu=<%=asigDoc.getEmailUsu()%>&fechIniAsigDoc=<%=asigDoc.getFechIniAsigDoc()%>&fechFinAsigDoc=<%=asigDoc.getFechFinAsigDoc()%>&activo=<%=asigDoc.getActivo()%>&idMat=<%=asigDoc.getIdMat()%>&nomMatDoc=<%=asigDoc.getNomMat()%>">
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
	var tipoRol;
	/**
	 * Esta función inicializa la tabla '#miTabla' utilizando el plugin DataTables.
	 * La tabla tiene funcionalidades como paginación, selección múltiple, exportación a CSV, Excel, PDF e impresión.
	 * Además, se personaliza la exportación de Excel y PDF para resaltar el estado activo de las asignaciones.
	 * Se especifica el número de registros por página y se define la respuesta de la tabla como responsive.
	 * También se define el comportamiento de las columnas, permitiendo la selección y el ordenamiento.
	 */

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
                    extend: 'excel',
                    className: 'btn-outline-secondary',
                    filename: 'listadoAsignacionesDocentesAMaterias',
                    className: 'btn-exportar-excel',
                    customize: function (xlsx) {
                        var sheet = xlsx.xl.worksheets['listado de asignaciones docentes.xml'];
                        
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
	            { targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], orderable: true }
	        ],      
	    });
  

 	   /**
 * Esta función maneja el evento de clic en cualquier parte de una fila de la tabla '#miTabla'.
 * Si se hace clic en la casilla de verificación de la primera columna, cambia la selección de la fila.
 * Si se hace clic en cualquier otra parte de la fila, alterna la selección de la fila y la casilla de verificación.
 * Además, muestra u oculta los botones de acción dependiendo de la cantidad de filas seleccionadas.
 * 
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
  * Esta función asocia la acción de cerrar el modal al hacer clic en el botón de cancelar o en la "x" superior.
  * Cuando se hace clic en el botón de cancelar o en la "x", se llama a la función cerrarModal para cerrar el modal.
  */
       $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
           cerrarModal();
       });
	    
	});
	

	/**
	 * Esta función redirige al usuario a la página "nuevaAsignacionDocenteRolAdmin.jsp" cuando se llama.
	 */

	function nuevaAsignación() {
	    // Redirigir a tu página .jsp
	    window.location.href = "nuevaAsignacionByDocenteRolAdmin.jsp";
	}

	/**
	 * Esta función redirige al usuario a la página "editAsignacionByDocenteRolAdmin.jsp" con los parámetros proporcionados en la cadena de consulta cuando se llama.
	 * @param {string} id - El ID de la asignación.
	 * @param {string} idAlu - El ID del alumno.
	 * @param {string} nomComp - El nombre completo del alumno.
	 * @param {string} email - El correo electrónico del alumno.
	 * @param {string} fechMatri - La fecha de matriculación.
	 * @param {string} modMatri - La modalidad de matriculación.
	 * @param {string} activo - El estado activo.
	 * @param {string} idEst - El ID del establecimiento.
	 * @param {string} idMat - El ID de la materia.
	 * @param {string} obsMatri - Las observaciones de la matriculación.
	 */

	function editAsignacionByDocenteRolAdmin(id, idAlu, nomComp, email, fechMatri, modMatri, activo, idEst, idMat, obsMatri) {
    var queryString = "?idAsg=" + id +
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
    window.location.href = "editAsignacionByDocenteRolAdmin.jsp" + queryString;
}



	 /**
	  * Esta función envía una solicitud al servidor para borrar la asignación con el ID proporcionado.
	  * Después de borrar, recarga la página.
	  * @param {string} id - El ID de la asignación a borrar.
	  */
    function borrarAsignacion(id) {
        // Enviar la solicitud al servidor para borrar el usuario con el id proporcionado
        console.log("idFila en enviarSolicitudBorrado  " + id);
      
        var contextPath = "/SchoolGes_v1"
           var servletUrl = contextPath + "/SvBorrarAsignacionMateria?idAsg=" + id ;

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
	   * Esta función borra las asignaciones seleccionadas a partir de las casillas de verificación.
	   * Muestra una confirmación antes de realizar el borrado y recarga la página después de borrar.
	   */

    function borrarSeleccionados() {
        // Obtener las casillas de verificación seleccionadas en la primera columna
        var checkboxes = $('#miTabla tbody td:first-child input[type="checkbox"]:checked');

        // Obtener los IDs de los usuarios seleccionados a partir de las casillas de verificación
        var idsAsignaciones = checkboxes.map(function() {
            return $(this).closest('tr').find('td:eq(1)').text(); // Suponiendo que el ID esté en la segunda columna
        }).get();

        console.log('Estoy en función borrarSeleccionados asignaciones docentes:', idsAsignaciones);

        // Verificar si se seleccionó al menos un usuario
        if (idsAsignaciones.length > 0) {
            Swal.fire({
                icon: 'warning',
                title: '¿Estás seguro?',
                text: 'Esta acción borrará ' + (idsAsignaciones.length > 1 ? 'todos los registros seleccionados' : 'el registro seleccionado'),
                showCancelButton: true,
                confirmButtonText: 'Sí, borrar' + (idsAsignaciones.length > 1 ? ' todos' : ''),
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    idsAsignaciones.forEach((id) => {
                    	borrarAsignacion(id);
                    });
                }
            });
        } else { // Si no se seleccionó ningún usuario, mostrar mensaje de advertencia
            Swal.fire({
                icon: 'warning',
                title: 'Advertencia',
                text: 'No se ha seleccionado ningún registro para borrar',
                confirmButtonText: 'Aceptar'
            });
        }
    }

    /**
     * Esta función maneja el clic en cualquier parte de la fila de la tabla para seleccionarla.
     * Verifica si se hizo clic en la casilla de verificación o en cualquier parte de la fila.
     * Cambia la selección de la fila y la casilla de verificación correspondiente.
     * Muestra u oculta los botones de acción según la selección.
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
     * Esta función maneja el clic en el botón de eliminar sin afectar la selección de filas.
     * Evita la propagación del clic al tr para que no se active la selección de la fila.
     * Obtiene el idAsg de la segunda columna de la fila donde se encuentra el botón de eliminar.
     * Muestra una confirmación de borrado utilizando la librería Swal.
     * Llama a la función para borrar la fila solo si se confirma la acción.
     * Elimina la fila del DataTables después de borrarla exitosamente.
     */
    $('#miTabla tbody').on('click', '.btn-borrar', function(e) {
        e.stopPropagation(); // Evitar la propagación del clic al tr

        // Obtener la fila correspondiente al botón de eliminar
        var fila = $(this).closest('tr');

        // Obtener el idAsg de la segunda columna de la fila
        var idAsg = fila.find('td:eq(1)').text(); // Ajusta el índice según la ubicación del idAsg en tu tabla

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
                borrarAsignacion(idAsg);

                // Eliminar la fila del DataTables después de borrarla exitosamente
                fila.remove();
            }
        });
    });
});


/**
 * Esta función redirige a la página 'crudAlumnosMatriculas.jsp' cuando se invoca.
 */

	function matriculaciones() {
	    // Redirigir a tu página .jsp
	    window.location.href = 'crudAlumnosMatriculas.jsp';
	}

	/**
	 * Esta función cierra el modal con el ID 'confirmModal' y registra un mensaje en la consola indicando que el modal ha sido cerrado.
	 */

	function cerrarModal() {
   	 $('#confirmModal').modal('hide');

        // Realiza cualquier acción adicional al cerrar el modal
        console.log('Modal cerrado');
   }
	
	</script>


</body>
</html>
