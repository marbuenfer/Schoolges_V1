<%@page import="com.dao.DaoEstudio"%>
<%@page import="com.dao.DaoMateria"%>
<%@page import="java.util.List"%>
<%@page import="com.logica.*"%>
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
<!-- Agregar enlaces a Bootstrap y FontAwesome -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">
<!-- Agregar cualquier otro enlace a CSS adicional -->
<style>
/* Estilos para los botones de acción */
.action-btn {
	font-size: 10px; /* Tamaño del icono */
	padding: 5px; /* Espacio alrededor del icono */
}
</style>

</head>
<body>
	<%@include file="/resources/css/allcss.jsp"%>
	<%@include file="/componentes/navbar.jsp"%>
	<div class="container mt-5">
		<h2 class="mb-4 text-center">ASIGNACIÓN DE ACTIVIDAD A MATERIA</h2>
		<div class="row justify-content-center">
			<!-- Centra el contenido horizontalmente -->
			<div class="col-md-6">
				<div class="form-group">
					<label for="estudio" class="text-center d-block">Selecciona
						un Estudio:</label>
					<!-- Centra el texto horizontalmente -->
					<select name="idEst" id="idEst_id" class="form-control">
						<%
						DaoEstudio daoEstudio = new DaoEstudio(DbConexion.getConn());
						List<Estudio> listaEstudios = daoEstudio.getAllEstudios();
						for (Estudio est : listaEstudios) {
						%>
						<option value="<%=est.getIdEst()%>"><%=est.getIdEst()%> -
							<%=est.getNomEst()%></option>
						<%
						}
						%>
					</select>
				</div>
				<div class="form-group">
					<label for="idMat" class="text-center d-block">Selecciona
						una Materia:</label>
					<!-- Centra el texto horizontalmente -->
					<select name="idMat" id="idMat_id" class="form-control">
						<%
						DaoMateria daoMateria = new DaoMateria(DbConexion.getConn());
						List<Materia> listaMaterias = daoMateria.getAllMateria();
						for (Materia mat : listaMaterias) {
						%>
						<option value="<%=mat.getIdMat()%>"><%=mat.getIdMat()%> -
							<%=mat.getNomMat()%></option>
						<%
						}
						%>
					</select>
				</div>
				<button type="button" class="btn btn-primary btn-block"
					id="botonPrinGuardar">Guardar</button>
				<!-- Botón centrado horizontalmente -->
			</div>
		</div>
		<div class="row justify-content-center mt-4">
			<!-- Centra el contenido horizontalmente -->
			<div class="col-md-8">
				<div class="table-responsive">
					<!-- Agregar clase table-responsive para hacer la tabla responsive -->
					<table class="table table-striped table-responsive"
						id="tablaAsignaciones">
						<thead>
							<tr>
								<th>ID Estudio</th>
								<th class="col-md-2">Nombre Estudio</th>
								<th>ID Materia</th>
								<th class="col-md-2">Nombre Materia</th>
								<th class="col-md-4">Observaciones</th>
								<th>Acciones</th>
								<!-- Nueva columna para botones de acción -->
							</tr>
						</thead>
						<tbody id="tablaAsignacionesBody">
							<!-- Aquí se mostrarán dinámicamente las asignaciones -->
						</tbody>
					</table>


				</div>
			</div>
		</div>
	</div>


	<!-- Modal actualizar-->
	<div class="modal fade" id="modalAsignacionActualizar" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Edición de
						asignación de materia a estudio</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="observaciones">Observaciones:</label>
						<textarea class="form-control" id="obsMatEstActualizar_id"
							rows="3"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cerrar</button>
					<button type="button" class="btn btn-primary"
						id="botonModalActualizar">Guardar</button>
				</div>

			</div>
		</div>
	</div>


	<!-- Fin del modal actualizar -->

	<!-- Modal insertar-->
	<div class="modal fade" id="modalAsignacionInsertar" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Nueva
						Asignación de Materia a Estudio</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="observaciones">Observaciones:</label>
						<textarea class="form-control" id="obsMatEstInsertar_id" rows="3"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cerrar</button>
					<!-- Agrega un identificador único al botón "Guardar" del modal -->
					<button type="button" class="btn btn-primary"
						id="botonModalInsertar">Guardar</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Fin del modal insertar -->


	<script>
	  
   var contextPath = '${pageContext.request.contextPath}';
   var idEst=0 ;
   var idMat=0 ;
   var asignacionCreada = [];
   /**
    * Cuando el documento esté listo, obtiene el ID del primer estudio y carga las asignaciones correspondientes.
    */
        $(document).ready(function() {
            // Obtener el ID del primer Estudio y cargar las asignaciones correspondientes
            var primerIdEstudio = $('#idEst_id option:first').val();
            cargarAsignacionesPorEstudio(primerIdEstudio);
        });

        /**
         * Carga las asignaciones correspondientes al estudio con el ID especificado.
         * @param {string} idEst - El ID del estudio del cual se cargarán las asignaciones.
         */
         function cargarAsignacionesPorEstudio(idEst) {
            var servletUrl = contextPath + "/SvObtenerAsignacionesPorEstudio";
            var url = servletUrl + "?idEst=" + idEst;
            $
                    .ajax({
                        url : url, // URL del servlet o controlador que maneja la solicitud
                        type : 'GET',
                        dataType : 'json', // Esperamos datos JSON como respuesta
                        success : function(asignaciones) {
                            // Limpiar contenido actual de la tabla
                            $('#tablaAsignacionesBody').empty();
                            if (asignaciones.length === 0) {
                                // Si no hay asignaciones, mostrar un mensaje en la tabla
                                $('#tablaAsignacionesBody')
                                        .append(
                                                '<tr><td colspan="6" class="text-center">Sin asignaciones de materias</td></tr>');
                            } else {
                                // Agregar las nuevas asignaciones a la tabla

                            	$.each(asignaciones, function(index, asignacion) {
                            	    $('#tablaAsignacionesBody').append(
                            	        '<tr data-idMat="' + asignacion.idMat + '"><td>' + asignacion.idEst + '</td><td>' + asignacion.nomEst + '</td><td>' + asignacion.idMat + '</td><td>' + asignacion.nomMat + '</td><td>' + asignacion.obsMatEst + '</td><td class="text-right">' +
                            	        '<button type="button" class="btn-primary btn-sm mx-1" onclick="editarAsignacion(this)"><i class="fa fa-pencil" aria-hidden="true"></i></button>' +
                            	        '<button type="button" class="btn-danger btn-sm mx-1" onclick="borrarAsignacion(' + asignacion.idEst + ', ' + asignacion.idMat + ')">' +
                            	        '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            	        '</button>' +
                            	        '</td></tr>'
                            	    );
                            	});

                            }
                        },
                        error : function(xhr, status, error) {
                            console.error(xhr.responseText); // Manejar errores si es necesario
                        }
                    });
        }

         /**
          * Asocia una función para cargar las asignaciones por estudio cuando se cambia la opción seleccionada en el elemento con ID 'idEst_id'.
          * La función obtiene el ID del estudio seleccionado y llama a la función 'cargarAsignacionesPorEstudio' con ese ID para cargar las asignaciones correspondientes.
          */
       $('#idEst_id').change(function() {
       var idEstudioSeleccionado = $(this).val();
       cargarAsignacionesPorEstudio(idEstudioSeleccionado);
   });
         
         
       /**
        * Asocia una función para actualizar una asignación de materia a un estudio cuando se hace clic en el botón con ID 'botonModalActualizar'.
        * La función obtiene el valor ingresado por el usuario para 'obsMatEst', el cual representa la observación de la asignación.
        * Luego, obtiene la última asignación editada de la lista 'asignacionesEditadas' y extrae los valores de 'idEst' y 'idMat'.
        * Posteriormente, actualiza el valor de 'obsMatEst' en la asignación con el valor del modal.
        * Realiza una solicitud AJAX para insertar o actualizar el registro en la base de datos utilizando el servlet 'SvActualizarAsignacionMateriaAEstudio'.
        * Después de la actualización exitosa, muestra un mensaje de éxito con SweetAlert y recarga la página.
        */
$('#botonModalActualizar').click(function() {
    // Obtener el valor de obsMatEst ingresado por el usuario
    var obsMatEst = $('#obsMatEstActualizar_id').val();

    // Obtener la última asignación editada de la lista asignacionesEditadas
    var ultimaAsignacion = asignacionesEditadas[asignacionesEditadas.length - 1];
    
    // Obtener los valores de idEst, idMat de la última asignación editada
    var idEst = ultimaAsignacion.idEst;
    var idMat = ultimaAsignacion.idMat;
    
    // Actualizar el valor de obsMatEst en la asignación con el valor del modal
    ultimaAsignacion.obsMatEst = obsMatEst;

    // Realizar una solicitud AJAX para insertar o actualizar el registro en la base de datos
    var actualiUrl = contextPath + "/SvActualizarAsignacionMateriaAEstudio";
    fetch(actualiUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idEst: idEst,
            idMat: idMat,
            obsMatEst: obsMatEst
        })
    })
    .then(response => {
        // Verificar si la solicitud fue exitosa
        if (!response.ok) {
            // Resto del código en caso de error...
            throw new Error('No hay respuesta del servidor');

        }  
        return response.json();
    })
        .then(data => {
            // Mostrar mensaje de actualización exitosa con SweetAlert
            Swal.fire({
                icon: 'success',
                title: 'Éxito',
                text: 'La asignación se ha actualizado correctamente',
                confirmButtonText: 'Aceptar'
            }).then(() => {
                // Recargar la página después de actualizar la asignación
                window.location.reload();
            });
        })
    .catch(error => {
        // Resto del código en caso de error...
    	console.error('Error:', error);
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Error al guardar la asignación',
            confirmButtonText: 'Aceptar'
        });

    });
});

/**
 * Asocia una función para guardar una nueva asignación de materia a un estudio cuando se hace clic en el botón con ID 'botonPrinGuardar'.
 * La función obtiene los valores de 'idEst' y 'idMat' seleccionados por el usuario.
 * Luego, verifica si ya existe una asignación para el par 'idEst' e 'idMat'.
 * Si ya existe una asignación, se notifica al usuario y no se guarda.
 * Si no existe una asignación, se procede a guardar la nueva asignación con las observaciones ingresadas por el usuario.
 */
$('#botonPrinGuardar').click(function() {
    // Resto del código...
});
/**
 * Asocia una función para guardar una nueva asignación de materia a un estudio cuando se hace clic en el botón con ID 'botonPrinGuardar'.
 * La función obtiene los valores de 'idEst' y 'idMat' seleccionados por el usuario.
 * Luego, verifica si ya existe una asignación para el par 'idEst' e 'idMat'.
 * Si ya existe una asignación, se notifica al usuario y no se guarda.
 * Si no existe una asignación, se procede a guardar la nueva asignación.
 */
$('#botonPrinGuardar').click(function() {
    // Obtener el valor de obsMatEst ingresado por el usuario
    var idEst =  $('#idEst_id').val();
    var idMat =  $('#idMat_id').val();
    console.log("valor todos  " + idEst + "," +   idMat);
   //Se comprueba si el idEst e idMat ya está asignado, en este caso no se puede guardar por tanto
   //no se indica y no se puede añadir el campo observaciones.
   verificarAsignacionMateriaAEstudio(idEst, idMat);
});

/**
 * Asocia una función para insertar una nueva asignación de materia a un estudio cuando se hace clic en el botón con ID 'botonModalInsertar'.
 * La función obtiene los valores de 'idEst' y 'idMat' seleccionados por el usuario, así como la observación de materia ('obsMatEst').
 * Luego, llama a la función 'funcBotonModalInsertar' con estos parámetros para realizar la inserción de la nueva asignación.
 * @returns {void}
 */
$('#botonModalInsertar').click(function() {
    // Obtener el valor de obsMatEst ingresado por el usuario
    var idEst =  $('#idEst_id').val();
    var idMat =  $('#idMat_id').val();
    var obsMatEst = $('#obsMatEstInsertar_id').val();

  	console.log("valor todos  " + idEst + "," +   idMat +  "," + obsMatEst);
	funcBotonModalInsertar(idEst, idMat,obsMatEst );
});

 /**
  * Función para insertar una nueva asignación de materia a un estudio.
  * 
  * @param {string} idEst - El ID del estudio al que se asignará la materia.
  * @param {string} idMat - El ID de la materia a asignar.
  * @param {string} obsMatEst - Observaciones de la asignación de materia.
  * @returns {void}
  */
function funcBotonModalInsertar(idEst, idMat, obsMatEst) {
 // Crear un objeto con los valores a enviar al servlet
 var datos = {
     idEst: idEst,
     idMat: idMat,
     obsMatEst: obsMatEst
 };

 /**
  * Realiza una solicitud AJAX para verificar y guardar una nueva asignación de materia a un estudio.
  * 
  * @param {Object} datos - Objeto que contiene los datos de la asignación a guardar.
  * @param {string} datos.idEst - El ID del estudio al que se asignará la materia.
  * @param {string} datos.idMat - El ID de la materia a asignar.
  * @param {string} datos.obsMatEst - Observaciones de la asignación de materia.
  * @returns {void}
  */ var verificarUrl = contextPath + "/SvGuardarAsignacionMateriaAEstudio";
 $.ajax({
     url: verificarUrl,
     type: "POST",
     data: JSON.stringify(datos), // Convertir el objeto a JSON
     contentType: "application/json",
     success: function(response) {
         console.log("La asignación ha sido insertada correctamente");
         // Se puede insertar la asignación porque no existe
         $('#modalAsignacionInsertar').modal('hide');
         // Recargar la página después de actualizar la asignación
         Swal.fire({
             icon: 'success',
             title: 'Éxito',
             text: 'La asignación se ha guardado correctamente',
             confirmButtonColor: '#3085d6',
             confirmButtonText: 'Aceptar'
         }).then((result) => {
             if (result.isConfirmed) {
                 window.location.reload();
             }
         });
     },
     error: function(xhr, status, error) {
         console.error("La asignación no ha podido insertarse: ", error);
         // Mostrar un mensaje de error con Swal.fire
         Swal.fire({
             icon: 'error',
             title: 'Error',
             text: 'La asignación no ha podido insertarse',
             confirmButtonColor: '#d33',
             confirmButtonText: 'Aceptar'
         });
     }
 });
}

  /**
   * Realiza una solicitud AJAX para verificar si ya existe una asignación de materia a un estudio.
   * Si la asignación no existe, muestra un modal para insertarla.
   * Si la asignación ya existe, muestra un mensaje de error.
   * 
   * @param {string} idEst - El ID del estudio.
   * @param {string} idMat - El ID de la materia.
   * @returns {void}
   */function verificarAsignacionMateriaAEstudio(idEst, idMat) {
    // Crear un objeto con los valores a enviar al servlet
    var datos = {
        idEst: idEst,
        idMat: idMat
    };

    // Realizar una solicitud AJAX para verificar si el registro ya existe
    var verificarUrl = contextPath + "/SvVerificarAsignacionMateriaAEstudio";
    $.ajax({
        url: verificarUrl,
        type: "POST",
        data: JSON.stringify(datos), // Convertir el objeto a JSON
        contentType: "application/json",
        success: function(response) {
            console.log("La asignación no existe, se puede insertar");
            // Se puede insertar la asignación porque no existe
            $('#modalAsignacionInsertar').modal('show');
        },
        error: function(xhr, status, error) {
            console.error("La asignación ya existe: ", error);
            // Mostrar un mensaje de error con Swal.fire
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'La asignación ya existe',
                confirmButtonColor: '#d33',
                confirmButtonText: 'Aceptar'
            });
        }
    });
}


  var asignacionesEditadas = [];
  /**
   * Función que se activa al hacer clic en el botón de edición de una asignación de materia a un estudio.
   * Recoge los datos de la asignación seleccionada, incluyendo el ID del estudio, el ID de la materia
   * y las observaciones de la materia, y los muestra en un modal para su edición.
   * 
   * @param {HTMLButtonElement} button - El botón de edición que se ha clicado.
   * @returns {void}
   */
  function editarAsignacion(button) {
      var idMat = $(button).closest('tr').find('td:eq(2)').text(); // Obtener idMat de la tercera celda de la fila
      var idEst = $(button).closest('tr').find('td:eq(0)').text(); // Obtener idEst de la primera celda de la fila
      var obsMatEst = $(button).closest('tr').find('td:eq(4)').text(); // Obtener obsMatEst de la quinta celda de la fila
      console.log("idMat que recogo de la tabla: " + idMat);
      console.log("idEst que recogo de la tabla: " + idEst);
      console.log("obsMatEst que recogo de la tabla: " + obsMatEst);
      // Resto de la lógica para editar la asignación...
      var asignacion = {
              idEst: idEst,
              idMat: idMat,
              obsMatEst: obsMatEst
          };
          asignacionesEditadas.push(asignacion);

          // Imprimir en consola para verificar
          console.log("Asignación editada guardada:");
          console.log(asignacion);

          // Mostrar el modal y establecer el valor del campo obsMatEst
 			$('#obsMatEstActualizar_id').val(obsMatEst);
          $('#modalAsignacionActualizar').modal('show');
  } 

   /**
    * Función que se activa al confirmar la eliminación de una asignación de materia a un estudio.
    * Muestra un mensaje de confirmación antes de eliminar la asignación. Si el usuario confirma la acción,
    * realiza una solicitud AJAX para borrar la asignación del servidor. Después de la eliminación exitosa,
    * muestra un mensaje de éxito y actualiza la página.
    * 
    * @param {string} idEst - El ID del estudio de la asignación a eliminar.
    * @param {string} idMat - El ID de la materia de la asignación a eliminar.
    * @returns {void}
    */
    function borrarAsignacion(idEst, idMat) {
    // Mostrar un mensaje de confirmación antes de borrar
    Swal.fire({
        title: '¿Estás seguro?',
        text: 'Esta acción eliminará la asignación. ¿Deseas continuar?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            // Realizar la solicitud AJAX para borrar la asignación
             var datos = {
		        idEst: idEst,
		        idMat: idMat
		  	  };
            
            var url = contextPath + "/SvBorrarAsignacionMateriaAEstudio";
            $.ajax({
                url: url,
                type: 'DELETE',
                data: JSON.stringify(datos), // Convertir el objeto a JSON
                contentType: "application/json",
                success: function(response) {
                    // Mostrar un mensaje de éxito si la eliminación fue exitosa
                	// Mostrar un mensaje de éxito si la eliminación fue exitosa
                    Swal.fire({
                        title: '¡Eliminado!',
                        text: 'La asignación ha sido eliminada correctamente.',
                        icon: 'success',
                        willClose: () => {
                            // Actualizar la página después de que se cierre el mensaje de éxito
                            window.location.reload();
                        }
                    });
                },
                error: function(xhr, status, error) {
                    // Mostrar un mensaje de error si hay algún problema con la eliminación
                    Swal.fire(
                        'Error',
                        'Hubo un problema al intentar eliminar la asignación. Por favor, inténtalo de nuevo más tarde.',
                        'error'
                    );
                }
            });
        }
    });
}

    </script>
</body>
</html>






