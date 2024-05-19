/**
 * 
 */

//// Crear un elemento script
//var scriptElement = document.createElement('script');
//
//// Establecer el atributo src con la URL del script de SweetAlert
//scriptElement.src = 'https://cdn.jsdelivr.net/npm/sweetalert2@11';
//
//// Agregar el elemento script al final del cuerpo del documento
//document.body.appendChild(scriptElement);


var tabla;
//var materiasSeleccionadasGlobal = [];
var DatosMatricula = {}; // Declarar la variable fuera de la función
var datosMatriculaLista = [];



// Desactivar los botones al principio
//$("#btnMatricular").prop("disabled", true);
//$("#btnBorrarAll").prop("disabled", true);

function actualizarEstadoBotones() {

//	var cantidadFilas = $("#miTabla tbody tr").length;
//
//
//
//	// Activar o desactivar los botones según la cantidad de filas
	$("#btnMatricular").prop("enabled", cantidadFilas === 0);
//	$("#btnBorrarAll").prop("enabled", cantidadFilas === 0);
}


//function cerrarFormulario() {
//	window.location.href = 'crudAlumnos2.jsp';
//	console
//		.log("La función cerrarFormulario() se ha llamado correctamente.");
//}

function actualizarDatosMatriculaLista() {
	datosMatriculaLista = []; // Limpia el array
	$("#miTabla tbody tr").each(function() {
		var fila = $(this);
		var DatosMatricula = {
			idUsu: $("#idUsu_id").val().trim(),
			idEst: fila.find("td:eq(0)").text().trim(),
			idMat: fila.find("td:eq(1)").text().trim(),
			nomMat: fila.find("td:eq(2)").text().trim(),
			fechMatri: fila.find("td:eq(3)").text().trim(),
			modMatri: fila.find("td:eq(4)").text().trim(),
			obsMatri: fila.find("td:eq(5)").text().trim(),
		};
		datosMatriculaLista.push(DatosMatricula);
		console.log("Datos de la tabla datosMatriculaLista en función actualizarDatosMatriculaLista() " + datosMatriculaLista.toString);
	});
}
function cargarMateriasEnTablaForm() {
	// Crear y devolver una promesa
	return new Promise(function(resolve, reject) {
		// Verificar si se ha introducido la fecha, el estudio y la modalidad
		if (!$("#fechMatri_id").val() || !$("#idEst_id").val() || !$("#modMatri_id").val()) {
			// Si no están completos, muestra un mensaje de error usando SweetAlert
			MsgSwal("Matriculación", "Por favor, completa la fecha, el estudio y la modalidad antes de cargar las materias", "error", "#d33");
			reject(); // Rechazar la promesa si los campos no están completos
		} else {
			//Si los campos están completos, procede a cargar las materias en la tabla

			var idEstudioSeleccionado = $("#idEst_id").val();
			console.log("Valor de idEstudioSeleccionado:", idEstudioSeleccionado);
			// Definir la URL base de la aplicación
			var baseUrl = window.location.origin + '/SchoolGes_v1';

			// Construir la URL para el servlet SvDevolverDatosByAlumno
			var urlSvDevolverDatosByEstudio = baseUrl + "/SvDevolverMateriasByEstudio"
			$.ajax({
				url: urlSvDevolverDatosByEstudio,
				method: "GET",
				data: {
					idEst: idEstudioSeleccionado
				},
				dataType: "json",
				success: function(data) {
					if (data.length === 0) {
						// Si no hay registros, mostrar un mensaje dentro de la tabla
						$("#materiasTableBody").empty().append('<tr><td colspan="3">No hay registros en la tabla</td></tr>');
					} else {
						// Si hay registros, limpiar la tabla y cargar las materias
						$("#materiasTableBody").empty();
						$.each(data, function(index, materia) {
							var row = $('<tr>');
							row.append($('<td>').text(materia.idMat));
							row.append($('<td>').text(materia.nomMat));
							row.append($('<td>').html('<input type="checkbox" class="materiaCheckbox" value="' + materia.idMat + '" data-nombre="' + materia.nomMat + '">'));
							$("#materiasTableBody").append(row);
						});
					}
					resolve(); // Resolver la promesa después de cargar las materias
				},
				error: function() {
					console.error("Error al obtener las materias");
					reject(); // Rechazar la promesa en caso de error
				}
			});
		}
	});
}



function guardarSeleccionMaterias() {

	//Comprobar que las materias seleccionadas no hayan sido añadidas a la tabla
	var idMateriasSeleccionadas = obtenerIdMateriasSeleccionadas();

	//AQUI TENGO QUE COMPROBAR SI SE HA INTRODUCIDO LA FECHA, EL ESTUDIO Y LA MODALIDAD
	//var idEstudioSeleccionado = $("#idEst_id").val();
	var numMateriasRepetidas = comprobarMateriaEnTablaForm(idMateriasSeleccionadas);
	if (numMateriasRepetidas > 0) {
		//Ya hay materias en tabla no se pueden añadir
		//alert("Hay " + numMateriasRepetidas + " materia(s) ya seleccionada(s) en la tabla.");
		MsgSwal("Materias", "La selección ya ha sido añadida al listado", "error", "#d33");


	} else {

		//Llamada a función que comprueba que las materias seleccionadas no existan en la base de datos

		console.log("Guardando materias seleccionadas...");

		var idEstSelec = $("#idEst_id").val().trim();

		var materiasSeleccionadas = [];

		$(".materiaCheckbox:checked").each(function(i) {
			var idMat = $(this).val().trim();
			//		var nomMat = $(this).data('nombre'); // Asumiendo que tienes un atributo de datos 'nombre' en el checkbox

			DatosMatricula = {
				idUsu: $("#idUsu_id").val().trim(),
				idEst: idEstSelec,
				modMatri: $("#modMatri_id").val().trim(),
				fechMatri: $("#fechMatri_id").val(),
				obsMatri: $("#obsMatri_id").val().trim(),
				idMat: idMat,
				nomMat: $(this).data('nombre').trim(),
				// Puedes agregar más campos según sea necesario
			};

			// Crea una fila de la tabla con los datos del usuario y la materia
			var rowId = "fila_" + i; // Genera un ID único para cada fila
			var row = "<tr id='" + rowId + "'>" +
				"<td>" + DatosMatricula.idEst + "</td>" +
				"<td>" + DatosMatricula.idMat + "</td>" +
				"<td>" + DatosMatricula.nomMat + "</td>" +
				"<td>" + DatosMatricula.fechMatri + "</td>" +
				"<td>" + DatosMatricula.modMatri + "</td>" +
				"<td>" + DatosMatricula.obsMatri + "</td>" +
				"<td><button type='button' class='btn btn-danger btn-sm' onclick='confirmarEliminar(\"" + rowId + "\")'><i class='fa fa-trash' aria-hidden='true'></i></button></td>" +
				"</tr>";

			// Agrega la fila al array
			materiasSeleccionadas.push(row);

			datosMatriculaLista.push(DatosMatricula);
		});

		// Log para ver el contenido de materiasSeleccionadas
		console.log("Contenido de materiasSeleccionadas:", materiasSeleccionadas);

		// Agrega las filas a la tabla
		for (var i = 0; i < materiasSeleccionadas.length; i++) {
			$("#miTabla tbody").append(materiasSeleccionadas[i]);

			console.log("MAterias seleccionadas: " + materiasSeleccionadas[i])
		}
		// Muestra los datos en la consola
		for (var i = 0; i < datosMatriculaLista.length; i++) {

			console.log("elementos para el registro de matricula ", datosMatriculaLista[i]);
		}


		// Cierra el modal
		$('#materiasModalContent').modal('hide');
	}
}


function obtenerIdMateriasSeleccionadas() {
	// Obtener los valores de los checkboxes seleccionados
	var idMaterias = [];
	$(".materiaCheckbox:checked").each(function() {
		idMaterias.push($(this).val());
		console.log("idMaterias en funcion obtenerIdMaterisSeleccionadas" + idMaterias.toString)
	});

	if (idMaterias.length === 0) {
		// Manejar el caso en que no se haya seleccionado ninguna materia
		//alert("Por favor, selecciona al menos una materia");
		MsgSwal("Materias", "Debes seleccionar al menos una para guardar", "info", "#17a2b8");
	}

	return idMaterias;
}

function comprobarMateriaEnTablaForm(idMaterias) {
	// Verificar si al menos una de las materias ya está en la tabla
	var materiasRepetidas = 0;

	// Verificar en la tabla del formulario
	$("#miTabla tbody tr").each(function() {
		var idMateriaEnFormulario = $(this).find('td:nth-child(2)').text();

		// Utiliza includes para verificar si el idMateriaEnFormulario está en idMaterias
		if (idMaterias.includes(idMateriaEnFormulario)) {
			materiasRepetidas++;
		}
	});

	return materiasRepetidas;
}



function confirmarEliminar_Borrar(rowId) {
	// Muestra una confirmación o realiza la lógica de eliminación directamente
	var confirmacion = confirm("¿Estás seguro de que deseas eliminar esta fila?");
	if (confirmacion) {
		// Elimina la fila de la tabla
		console.log("Eliminando fila con rowId:", rowId);
		$("#" + rowId).remove();
	}
	window.location.reload(true);

	actualizarEstadoBotones();
}

function confirmarEliminar(rowId) {
	// Muestra una confirmación usando SweetAlert
	Swal.fire({
		title: '¿Estás seguro?',
		text: "¿Deseas eliminar esta fila?",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Sí, eliminar',
		cancelButtonText: 'Cancelar'
	}).then((result) => {
		if (result.isConfirmed) {
			// Si el usuario confirma la eliminación, elimina la fila de la tabla
			console.log("Eliminando fila con rowId:", rowId);
			$("#" + rowId).remove();

			// Actualiza el estado de los botones después de la eliminación
			actualizarEstadoBotones();

			// Muestra un mensaje de éxito usando SweetAlert
			Swal.fire(
				'Eliminada',
				'La fila ha sido eliminada correctamente.',
				'success'
			);
		}
	});
}

//este método se usa en menú alumnos-rol admin y en menu docentes-rol admin
function borrarAllMaterias() {
	// Muestra una confirmación utilizando SweetAlert
	Swal.fire({
		title: '¿Estás seguro?',
		text: '¿Estás seguro de que deseas eliminar todas las filas?',
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Sí, eliminar todas las filas',
		cancelButtonText: 'Cancelar'
	}).then((result) => {
		if (result.isConfirmed) {
			// Elimina todas las filas de la tabla
			$("#miTabla tbody").empty();
			// Actualiza el estado de los botones después de la eliminación


			actualizarEstadoBotones();
			// Muestra un mensaje de confirmación utilizando SweetAlert
			Swal.fire(
				'¡Listado matriculas!',
				'Todas las filas han sido eliminadas.',
				'success'
			);
		}
	});
}


function realizarMatriculacion() {
	// Verificar si se ha introducido la fecha, el estudio y la modalidad
	if (!$("#fechMatri_id").val() || !$("#idEst_id").val() || !$("#modMatri_id").val()) {
		console.log("Valor de fechMatri_id:", $("#fechMatri_id").val());
		console.log("Valor de idEst_id:", $("#idEst_id").val());
		console.log("Valor de idModMAtri_id:", $("#modMatri_id").val());

		// Muestra un mensaje de error usando SweetAlert
		Swal.fire({
			title: 'Matriculación',
			text: 'Por favor, completa la fecha, el estudio y la modalidad antes de realizar la matriculación',
			icon: 'error',
			confirmButtonColor: '#d33',
			confirmButtonText: 'Aceptar'
		});
	} else {
		// Realizar operación para cada registro en datosMatriculaLista
		for (var i = 0; i < datosMatriculaLista.length; i++) {
			var matriculaActual = datosMatriculaLista[i];


			var idEstudioSeleccionado = $("#idEst_id").val();
			console.log("Valor de idEstudioSeleccionado:", idEstudioSeleccionado);
			// Definir la URL base de la aplicación
			var baseUrl = window.location.origin + '/SchoolGes_v1';

			// Construir la URL para el servlet SvDevolverDatosByAlumno
			var urlSvGuardarMatricula = baseUrl + "/SvGuardarMatricula"
			// Realiza la llamada AJAX al servlet o controlador que maneje la lógica de inserción
			$.ajax({
				type: "POST",
				url: urlSvGuardarMatricula,
				data: matriculaActual, // Pasar el objeto matriculaActual como datos
				success: function(response) {
					if (response.success) {
						// La operación fue exitosa, muestra un SweetAlert con un mensaje de éxito
						Swal.fire({
							title: 'Matriculación',
							text: 'Operación realizada',
							icon: 'success',
							confirmButtonColor: '#28a745'
						});
					} else {
						// La matrícula ya existe, muestra un SweetAlert con un mensaje de error
						Swal.fire({
							title: 'Matriculación',
							text: response.message,
							icon: 'error',
							confirmButtonColor: '#d33',
							confirmButtonText: 'Aceptar'
						});
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					// Manejar errores de la llamada AJAX
					console.error("Error en la llamada AJAX:", textStatus, errorThrown);
					Swal.fire({
						title: 'Matriculación',
						text: 'Error en la llamada AJAX. Por favor, inténtalo de nuevo más tarde.',
						icon: 'error',
						confirmButtonColor: '#d33',
						confirmButtonText: 'Aceptar'
					});
				}
			});
		}
	}
}



function MsgSwal(titulo, mensaje, icono, color) {
	Swal.fire({
		title: titulo,
		text: mensaje,
		icon: icono,
		confirmButtonColor: color
	});
}


