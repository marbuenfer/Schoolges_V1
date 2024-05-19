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


<style>
/* Estilos adicionales pueden ir aquí si es necesario */
</style>

</head>

<body>

	<%@include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>

	<h2>MATRICULACIONES DE ALUMNOS</h2>

	<!-- Botones de acción -->
	<div>
		<button type="button" class="btn btn-primary" style="margin: 10px;"
			onclick="nuevaMatriculacion()">
			<i class="fa fa-plus" aria-hidden="true"></i> Nueva matriculación
		</button>
		<button type="button" class="btn btn-danger" style="margin: 10px;"
			onclick="borrarSeleccionados();">Borrar Seleccionados</button>
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
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>



<script>
$(document).ready(function() {
    var tabla = $('#miTabla').DataTable({
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

                    $('row', sheet).each(function (index) {
                        var row = $(this);
                        var rowClass = row.attr('class');
                        var activoIndex = 15;

                        var table = $('#miTabla').DataTable();
                        var activoValueInTable = table.cell(index, activoIndex).data(); 

                        var cell = row.find('c[r="' + activoIndex + '"]');

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
                    var table = $('#miTabla').DataTable();
                    var data = table.rows().data();

                    var activoIndex = table.column(':contains("Activo")').index();

                    data.each(function (value, index) {
                        var activoValue = value[activoIndex];

                        var rowNode = table.row(index).node();
                        var isActiveGreen = $(rowNode).find('.activo-verde').length > 0;
                        var isActiveRed = $(rowNode).find('.activo-rojo').length > 0;

                        if (isActiveGreen) {
                            activoValue = 'Sí';
                            doc.content[1].table.body[index + 1][activoIndex].fillColor = '#28a745';
                        } else if (isActiveRed) {
                            activoValue = 'No';
                            doc.content[1].table.body[index + 1][activoIndex].fillColor = '#dc3545';
                        }

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
                        var table = $('#miTabla').DataTable();
                        var data = table.rows().data();

                        var headers = table.columns().header().toArray().map(function (th) {
                            return $(th).text();
                        });

                        var activoIndex = table.column(':contains("Activo")').index();

                        var html = '<table border="1" cellpadding="5" cellspacing="0"><thead><tr>';

                        headers.forEach(function (header) {
                            html += '<th>' + header + '</th>';
                        });

                        html += '</tr></thead><tbody>';

                        data.each(function (value, index) {
                            html += '<tr>';

                            value.each(function (cellValue, i) {
                                if (i === activoIndex) {
                                    var rowNode = table.row(index).node();
                                    var isActiveGreen = $(rowNode).find('.activo-verde').length > 0;
                                    var isActiveRed = $(rowNode).find('.activo-rojo').length > 0;

                                    if (isActiveGreen) {
                                        cellValue = 'Sí';
                                        html += '<td style="background-color: #28a745;">' + cellValue + '</td>';
                                    } else if (isActiveRed) {
                                        cellValue = 'No';
                                        html += '<td style="background-color: #dc3545;">' + cellValue + '</td>';
                                    }
                                } else {
                                    html += '<td>' + cellValue + '</td>';
                                }
                            });

                            html += '</tr>';
                        });

                        html += '</tbody></table>';

                        $(win.document.body).html(html);
                    }, 100);
                }
            }
        ],
        responsive:true,
        columnDefs: [
            { orderable: false, className: 'select-checkbox', targets: 0 },
            { targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], orderable: true }
        ]
    });
 
   

    $('#miTabla tbody').on('click', 'tr', function(e) {
        var checkbox = $(this).find('.seleccionar-fila');
        if ($(e.target).is('td:first-child input:checkbox')) {
            checkbox.prop('checked', !checkbox.prop('checked'));
        } else {
            $(this).toggleClass('selected');
            checkbox.prop('checked', !checkbox.prop('checked'));
        }

        var selectedRows = tabla.rows('.selected').count();
        $('.accion-buttons').toggle(selectedRows > 0);
    });
  
    $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
        cerrarModal();
    });
});

    $('#miTabla tbody').on('click', '.btn-borrar', function(e) {
        e.stopPropagation();
        var fila = $(this).closest('tr');
        var idMatri = fila.find('td:eq(1)').text();
        Swal.fire({
            icon: 'warning',
            title: '¿Estás seguro?',
            text: 'Esta acción borrará el registro seleccionado',
            showCancelButton: true,
            confirmButtonText: 'Sí, borrar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                borrarMatricula(idMatri);
                fila.remove();
            }
        });
    });
 

function cerrarModal() {
    $('#confirmModal').modal('hide');
    console.log('Modal cerrado');
}

function nuevaMatriculacion() {
    window.location.href = "nuevaMatriculacionAlumnoRolAdmin.jsp";
}

function editMatriculacionRolAdmin(id, idAlu, nomComp, email, fechMatri, modMatri, activo, idEst, idMat, obsMatri) {
    var queryString = '?idMatri=' + id + '&idAlu=' + idAlu + '&nomComp=' + nomComp + '&email=' + email + '&fechMatri=' + fechMatri + '&modMatri=' + modMatri + '&activo=' + activo + '&idEst=' + idEst + '&idMat=' + idMat + '&obsMatri=' + obsMatri;
    window.location.href = "editMatriculacionRolAdmin.jsp" + queryString;
}
 
function borrarSeleccionados() {
    var selectedRows = $('#miTabla').DataTable().rows('.selected').data().toArray();
    var ids = selectedRows.map(row => row[1]);
    if (ids.length > 0) {
        Swal.fire({
            icon: 'warning',
            title: '¿Estás seguro?',
            text: 'Esta acción borrará los registros seleccionados',
            showCancelButton: true,
            confirmButtonText: 'Sí, borrar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                ids.forEach(id => borrarMatricula(id));
                $('#miTabla').DataTable().rows('.selected').remove().draw(false);
                $('.accion-buttons').hide();
            }
        });
    } else {
        Swal.fire({
            icon: 'info',
            title: 'Nada seleccionado',
            text: 'Por favor, selecciona al menos una matriculación para borrar'
        });
    }
}

function borrarMatricula(idMatri) {
	 // Enviar la solicitud al servidor para borrar el usuario con el id proporcionado
    console.log("idFila en enviarSolicitudBorrado  " + idMatri);
    var tipoRol = "AL";
    var contextPath = "/SchoolGes_v1"
    var servletUrl = contextPath + "/SvBorrarMatricula?idMatri=" + idMatri + "&tipoRol=" + tipoRol;

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




</script>

</body>
</html>
