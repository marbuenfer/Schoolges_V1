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
		<h2 class="mb-4 text-center">ACTIVIDADES</h2>
		<div class="row justify-content-center">
			<!-- Centra el contenido horizontalmente -->
			<div class="col-md-6">
				<div class="form-group">
					<label for="estudio" class="text-center d-block">Selecciona
						un Estudio:</label>
					<!-- Centra el texto horizontalmente -->
					<select name="idEst" id="idEst_id" class="form-control">
						<%-- Añadido onchange para llamar a la función obtenerMateriasPorEstudio() cuando se cambie el valor --%>
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
						<!-- Las opciones de materias se llenarán dinámicamente después de seleccionar un estudio -->
					</select>
				</div>
				<button type="button" class="btn btn-primary btn-block"
					id="botonNuevaActividad">Nueva actividad</button>
				<!-- Botón centrado horizontalmente -->

			</div>

		</div>

		<div class="row justify-content-center mt-4">
			<!-- Centra el contenido horizontalmente -->
			<div class="col-md-10">
				<div class="table-responsive">
					<!-- Agregar clase table-responsive para hacer la tabla responsive -->
					<table class="table table-striped table-responsive"
						id="tablaAsignaciones">
						<thead>
							<tr>
								<th>ID Act.</th>
								<th>ID Materia</th>
								<th class="col-md-2">Nombre Mat.</th>
								<th class="col-md-4">Enunciado Act.</th>
								<th class="col-md-4">Observaciones</th>
								<th class="col-md-2">Acciones</th>
								<!-- Nueva columna para botones de acción -->
							</tr>
						</thead>
						<tbody id="tablaActividadesBody">
							<!-- Aquí se mostrarán dinámicamente las asignaciones -->
						</tbody>
					</table>


				</div>
			</div>
		</div>
	</div>


	<!-- Modal actualizar-->
	<div class="modal fade" id="modalActividadActualizar" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Edición de
						actividad de una materia</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="hidden" id="idActOculto_id" name="idActOculto">
					<!-- 					<div class="form-group"> -->
					<!-- 						<label for="idEstActualizar">ID Estudio:</label> <input type="text" -->
					<!-- 							class="form-control" id="idEstActualizar_id" readonly> -->
					<!-- 					</div> -->
					<div class="form-group">
						<label for="enuActActualizar">Enunciado:</label>
						<textarea class="form-control" name="enuActActualizar"
							id="enuActActualizar_id" rows="5"></textarea>
					</div>
					<!-- 					<div class="form-group"> -->
					<!-- 						<label for="notaActActualizar">Nota:</label> <input type="text" -->
					<!-- 							class="form-control" id="notaActActualizar_id" size="2" -->
					<!-- 							style="weight: 25px;"> -->
					<!-- 					</div> -->
					<div class="form-group">
						<label for="obsActActualizar">Observaciones:</label>
						<textarea class="form-control" name="obsActActualizar"
							id="obsActActualizar_id" rows="5"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						id="botonModalActualizarCerrar" data-dismiss="modal">Cerrar</button>
					<button type="button" class="btn btn-primary"
						id="botonModalActualizar">Guardar</button>
				</div>

			</div>
		</div>
	</div>


	<!-- Fin del modal actualizar -->

	<!-- Modal insertar-->
	<div class="modal fade" id="modalActividadInsertar" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Nueva actividad
						en materia</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="observaciones">Observaciones:</label>
						<textarea class="form-control" id="obsActMatInsertar_id" rows="3"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						id="botonModalInsertarCerrar" data-dismiss="modal">Cerrar</button>
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

   var actividadEditada = [];
   /**
    * Cuando el documento esté listo, obtiene el ID del primer estudio y carga las asignaciones correspondientes.
    */
        $(document).ready(function() {
            // Obtener el ID del primer Estudio y cargar las asignaciones correspondientes
            var primerIdEstudio = $('#idEst_id option:first').val();
            cargarActividadesMateria(primerIdEstudio);
        });
   
        $('#idEst_id').change(function() {
            var idEstudioSeleccionado = $(this).val();
            console.log("idEstudioSeleccionado---" + idEstudioSeleccionado);
            obtenerMateriasPorEstudio(idEstudioSeleccionado);
        });
        
        /**
         * Asocia una función para cargar las asignaciones por estudio cuando se cambia la opción seleccionada en el elemento con ID 'idEst_id'.
         * La función obtiene el ID del estudio seleccionado y llama a la función 'cargarActividadesMateria' con ese ID para cargar las asignaciones correspondientes.
         */
      $('#idMat_id').change(function() {
      var idMatSeleccionada = $(this).val();
      cargarActividadesMateria(idMatSeleccionada);
  });
      
        function obtenerMateriasPorEstudio(idEst) {
           
            var servletUrl = contextPath + "/SvObtenerAsignacionMateriaYEstudio";
            console.log("idEst  antes de pasarlo a servlet---" + idEst);

            var url = servletUrl + "?idEst=" + idEst;
            console.log("var url---" + url);

            $.ajax({
                type: "GET", // Tipo de solicitud
                url: url, // URL del servlet
                data: { idEst: idEst }, // Datos a enviar al servlet (ID del estudio)
                dataType: "json", // Tipo de datos esperados en la respuesta
                success: function(response) {
                    // Función a ejecutar cuando se recibe una respuesta exitosa
                    var selectMaterias = document.getElementById("idMat_id"); // Obtener el elemento select de materias
                    selectMaterias.innerHTML = ""; // Limpiar las opciones anteriores
                    response.forEach(function(materia) { // Iterar sobre la lista de materias en la respuesta
                        var opcion = document.createElement("option"); // Crear un elemento de opción
                        opcion.value = materia.idMat; // Establecer el valor de la opción como el ID de la materia
                        opcion.text = materia.idMat + " - " + materia.nomMat; // Establecer el texto de la opción
                        selectMaterias.appendChild(opcion); // Agregar la opción al select de materias
                    });
                },
                error: function(xhr, status, error) {
                    // Función a ejecutar en caso de error
                    console.error(xhr.responseText); // Mostrar el mensaje de error en la consola
                }
            });
        }
 
   
   
   		/**
         * Carga las asignaciones correspondientes al estudio con el ID especificado.
         * @param {string} idEst - El ID del estudio del cual se cargarán las asignaciones.
         */
         
         function cargarActividadesMateria(idMat) {
            var servletUrl = contextPath + "/SvObtenerActividadesByMateria";
            var url = servletUrl + "?idMat=" + idMat;
            $
                    .ajax({
                        url : url, // URL del servlet o controlador que maneja la solicitud
                        type : 'GET',
                        dataType : 'json', // Esperamos datos JSON como respuesta
                        success : function(actividades) {
                            // Limpiar contenido actual de la tabla
                            $('#tablaActividadesBody').empty();
                            if (actividades.length === 0) {
                                // Si no hay actividades, mostrar un mensaje en la tabla
                                $('#tablaActividadesBody')
                                        .append(
                                                '<tr><td colspan="10" class="text-center">Sin actividades</td></tr>');
                            } else {
                                // Agregar las nuevas actividades a la tabla

                            	$.each(actividades, function(index, actividad) {
                            	    $('#tablaActividadesBody').append(
                            	        '<tr data-idAct="' + actividad.idAct + '">' +
                            	        '<td>' + actividad.idAct + '</td>' +
                            	        '<td>' + actividad.idMat + '</td>' +
                            	        '<td>' + actividad.nomMat + '</td>' +
                            	        '<td>' + actividad.enuAct + '</td>' +
//                             	        '<td>' + actividad.notaAct + '</td>' +
                            	        '<td>' + actividad.obsAct + '</td>' +
                            	        '<td class="text-right">' +
                            	        '<button type="button" class="btn-primary btn-sm mx-1" onclick="editarActividad(this)"><i class="fa fa-pencil" aria-hidden="true"></i></button>' +
                            	        '<button type="button" class="btn-danger btn-sm mx-1" onclick="borrarActividad(' + actividad.idAct + ')"><i class="fa fa-trash" aria-hidden="true"></i></button>' +
                            	        '</td>' +
                            	        '</tr>'
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
        * Asocia una función para actualizar una actividad de materia cuando se hace clic en el botón con ID 'botonModalActualizar'.
        * La función obtiene el valor ingresado por el usuario para los campos, de la actividad.
        * Luego, obtiene la última asignación editada de la lista 'actividadesEditadas'  actualiza el valor de las actividades en el modal.
        * Realiza una solicitud AJAX para insertar o actualizar el registro en la base de datos utilizando el servlet 'SvActualizarActividadMateria'.
        * Después de la actualización exitosa, muestra un mensaje de éxito con SweetAlert y recarga la página.
        */
     // Listener para el botón "Guardar" del modal
        $('#botonModalActualizar').click(function() {
            // Realizar una solicitud AJAX para actualizar los datos en el servidor
            // Obtener los nuevos valores de los campos del modal
            idActOculto_id
            var idAct = $('#idActOculto_id').val();
			var nuevoEnuAct = $('#enuActActualizar_id').val();
// 			var nuevaNotaAct = $('#notaActActualizar_id').val();
			var nuevaObsAct = $('#obsActActualizar_id').val();
			
			// Asignar los nuevos valores a las propiedades correspondientes de actividadEditada
			actividadEditada.idAct = idAct;
			actividadEditada.enuAct = nuevoEnuAct;
    		actividadEditada.obsAct = nuevaObsAct;
            var actualiUrl = contextPath + "/SvActualizarActividadMateria";
            fetch(actualiUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(actividadEditada)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('No hay respuesta del servidor');
                }  
                return response.json();
            })
            .then(data => {
                // Mostrar mensaje de actualización exitosa con SweetAlert
                Swal.fire({
                    icon: 'success',
                    title: 'Éxito',
                    text: 'La actividad se ha actualizado correctamente',
                    confirmButtonText: 'Aceptar'
                }).then(() => {
                    // Recargar la página después de actualizar la asignación
                    window.location.reload();
                });
            })
            .catch(error => {
                console.error('Error:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error al guardar la actividad',
                    confirmButtonText: 'Aceptar'
                });
            });
        });
/**
 * Asocia una función para guardar una nueva asignación de materia a un estudio cuando se hace clic en el botón con ID 'botonNuevaActividad'.
 * La función obtiene los valores de 'idEst' y 'idMat' seleccionados por el usuario.
 * Luego, verifica si ya existe una asignación para el par 'idEst' e 'idMat'.
 * Si ya existe una asignación, se notifica al usuario y no se guarda.
 * Si no existe una asignación, se procede a guardar la nueva asignación.
 */
 $('#botonNuevaActividad').click(function() {
	    // Obtener el valor de idMat ingresado por el usuario
	    var idMat = $('#idMat_id').val();
	    var nomMat = $('#idMat_id option:selected').text();

	    console.log("Valor de idMat: " + idMat);
	    console.log("Valor de nomMat: " + nomMat);

	    // Definir el tipo de actividad (nuevo en este caso)
	    var tipo = 'nuevo';
	    
	    // Construir la URL con los parámetros de consulta
	    var url = contextPath + "/componentes/rolAdmin/menuMaterias/nuevaActividadRolAdmin.jsp";
	    url += "?tipo=" + tipo; // Añadir el parámetro tipo
	    url += "&idMat=" + idMat; 
	    
	    console.log("url  " + url);
	    // Redirigir a la nueva página con los parámetros de consulta
	    window.location.href = url;
	});



 
//Esta función se activa cuando se hace clic en el botón con el id 'botonModalActualizarCerrar'
 $('#botonModalActualizarCerrar').click(function() {
     $('#modalActividadActualizar').modal('hide');
	});
  
//Esta función se activa cuando se hace clic en el botón con el id 'botonModalInsertarCerrar'
 $('#botonModalInsertarCerrar').click(function() {
     $('#modalActividadInsertar').modal('hide');
	});


  /**
   * Función que se activa al hacer clic en el botón de edición de una asignación de una actividad
   * Recoge los datos de la actividad seleccionada y los muestra en un modal para su edición.
   * 
   * @param {HTMLButtonElement} button - El botón de edición que se ha clicado.
   * @returns {void}
   */
   function editarActividad(button) {
	    var obsAct = $(button).closest('tr').find('td:eq(4)').text(); // Obtener obsAct de la sexta celda de la fila
// 	    var notaAct = $(button).closest('tr').find('td:eq(4)').text(); // Obtener notaAct de la quinta celda de la fila
	    var enuAct = $(button).closest('tr').find('td:eq(3)').text(); // Obtener enuAct de la cuarta celda de la fila
	    var idMat = $(button).closest('tr').find('td:eq(1)').text(); // Obtener idMat de la segunda celda de la fila
	    var idAct = $(button).closest('tr').find('td:eq(0)').text(); // Obtener idAct de la primera celda de la fila
	      
	    console.log("idAct que recojo de la tabla: " + idAct);
	    console.log("idMat que recojo de la tabla: " + idMat);
	    console.log("enuAct que recojo de la tabla: " + enuAct);
// 	    console.log("notaAct que recojo de la tabla: " + notaAct);
	    console.log("obsAct que recojo de la tabla: " + obsAct);
	      
	    // Resto de la lógica para editar la asignación...
	    var actividad = {
	        idAct: idAct,
	        idMat: idMat,
	        enuAct: enuAct,
// 	        notaAct: notaAct,
	        obsAct: obsAct
	    };
	    
	    // Almacenar la actividad editada
	    actividadEditada = actividad;

	    // Mostrar el modal
	    $('#idActOculto_id').val(idAct);
	    $('#enuActActualizar_id').val(enuAct);
// 	    $('#notaActActualizar_id').val(notaAct);
	    $('#obsActActualizar_id').val(obsAct);
	    $('#modalActividadActualizar').modal('show');
	}


   /**
    * Función que se activa al confirmar la eliminación de actividad asignada a una materia.
    * Muestra un mensaje de confirmación antes de eliminar la actividad. Si el usuario confirma la acción,
    * realiza una solicitud AJAX para borrar la actividad del servidor. Después de la eliminación exitosa,
    * muestra un mensaje de éxito y actualiza la página.
    * 
    * @param {string} idAct - El ID de la actividad  a eliminar.
    * @returns {void}
    */
    function borrarActividad(idAct) {
    // Mostrar un mensaje de confirmación antes de borrar
    Swal.fire({
        title: '¿Estás seguro?',
        text: 'Esta acción eliminará el registro seleccionado. ¿Deseas continuar?',
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
		        idAct: idAct,
 		  	  };
            
            var url = contextPath + "/SvBorrarActividadMateria";
            $.ajax({
                url: url,
                type: 'DELETE',
                data: JSON.stringify(datos), // Convertir el objeto a JSON
                contentType: "application/json",
                success: function(response) {
                	// Mostrar un mensaje de éxito si la eliminación fue exitosa
                    Swal.fire({
                        title: '¡Eliminado!',
                        text: 'La actividad ha sido eliminada correctamente.',
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
                        'Hubo un problema al intentar eliminar la actividad. Por favor, inténtalo de nuevo más tarde.',
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






