/**
 * 
 */

var DatosAsignacionDocentes = {}; // Declarar la variable fuera de la función
var datosAsignacionLista = [];

function actualizarDatosAsignacionLista() {
	datosAsignacionLista = []; // Limpia el array
	$("#miTabla tbody tr").each(function() {
		var fila = $(this);
		var DatosAsignacionDocentes = {
			idUsu: $("#idUsu_id").val().trim(),
			idEst: fila.find("td:eq(0)").text().trim(),
			idMat: fila.find("td:eq(1)").text().trim(),
			nomMat: fila.find("td:eq(2)").text().trim(),
			fechIniAsigDoc: fila.find("td:eq(3)").text().trim(),
			fechFinAsigDoc: fila.find("td:eq(4)").text().trim(),
			obsAsigDoc: fila.find("td:eq(5)").text().trim(),
		};
		datosAsignacionLista.push(DatosAsignacionDocentes);
		console.log("Datos de la tabla datosAsignacionLista en función actualizarDatosMatriculaLista() " + datosAsignacionLista.toString);
	});
}
function cargarMateriasAsignacionEnTablaFormEstudio() {
	// Crear y devolver una promesa
	return new Promise(function(resolve, reject) {
		// Verificar si se ha introducido la fecha, el estudio y la modalidad
		if (!$("#fechIniAsigDoc_id").val() || !$("#idEst_id").val()) {
			// Si no están completos, muestra un mensaje de error usando SweetAlert
			MsgSwal("Matriculación", "Por favor, completa la fecha y el estudio ", "error", "#d33");
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
					if (data.message === "No hay materias registradas para este estudio") {
						// Si recibimos el mensaje de que no hay registros, mostramos el mensaje dentro de la tabla
						$("#materiasTableBody").empty().append('<tr><td colspan="3">No hay materias registradas para este estudio</td></tr>');
					} else {
						// Si hay registros, limpiamos la tabla y cargamos las materias
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



function guardarSeleccionMateriasAsignadasDocente() {

	//Comprobar que las materias seleccionadas no hayan sido añadidas a la tabla
	var idMateriasSeleccionadas = obtenerIdMateriasSeleccionadas();

	var numMateriasRepetidas = comprobarMateriaEnTablaForm(idMateriasSeleccionadas);
	if (numMateriasRepetidas > 0) {
		//Ya hay materias en tabla no se pueden añadir
		//alert("Hay " + numMateriasRepetidas + " materia(s) ya seleccionada(s) en la tabla.");
		MsgSwal("Materias", "La selección ya ha sido añadida al listado", "error", "#d33");


	} else {

		//Llamada a función que comprueba que las materias seleccionadas no existan en la base de datos

		console.log("Asignando materias seleccionadas...");

		var idEstSelec = $("#idEst_id").val().trim();

		var materiasSeleccionadas = [];

		$(".materiaCheckbox:checked").each(function(i) {
			var idMat = $(this).val().trim();
			var nomMat = $(this).data('nombre'); // Asumiendo que tienes un atributo de datos 'nombre' en el checkbox

			DatosAsignacionDocentes = {
				idUsu: $("#idUsu_id").val().trim(),
				idEst: idEstSelec,
				//modMatri: $("#modMatri_id").val().trim(),
				fechIniAsigDoc: $("#fechIniAsigDoc_id").val(),
				fechFinAsigDoc: $("#fechFinAsigDoc_id").val(),

				obsAsigDoc: $("#obsAsigDoc_id").val().trim(),
				idMat: idMat,
				nomMat: $(this).data('nombre').trim(),
				// Puedes agregar más campos según sea necesario
			};

			// Crea una fila de la tabla con los datos del usuario y la materia
			var rowId = "fila_" + i; // Genera un ID único para cada fila
			var row = "<tr id='" + rowId + "'>" +
				"<td>" + DatosAsignacionDocentes.idEst + "</td>" +
				"<td>" + DatosAsignacionDocentes.idMat + "</td>" +
				"<td>" + DatosAsignacionDocentes.nomMat + "</td>" +
				"<td>" + DatosAsignacionDocentes.fechIniAsigDoc + "</td>" +
				"<td>" + DatosAsignacionDocentes.fechFinAsigDoc + "</td>" +
				"<td>" + DatosAsignacionDocentes.obsAsigDoc + "</td>" +
				"<td><button type='button' class='btn btn-danger btn-sm' onclick='confirmarEliminar(\"" + rowId + "\")'><i class='fa fa-trash' aria-hidden='true'></i></button></td>" +
				"</tr>";

			// Agrega la fila al array
			materiasSeleccionadas.push(row);

			datosAsignacionLista.push(DatosAsignacionDocentes);
		});

		// Log para ver el contenido de materiasSeleccionadas
		console.log("Contenido de materiasSeleccionadas:", materiasSeleccionadas);

		// Agrega las filas a la tabla
		for (var i = 0; i < materiasSeleccionadas.length; i++) {
			$("#miTabla tbody").append(materiasSeleccionadas[i]);

			console.log("MAterias seleccionadas: " + materiasSeleccionadas[i])
		}
		// Muestra los datos en la consola
		for (var i = 0; i < datosAsignacionLista.length; i++) {

			console.log("elementos para el registro de matricula ", datosAsignacionLista[i]);
		}


		// Cierra el modal
		$('#materiasModalContent').modal('hide');
	}
}


function realizarAsignacionDocente() {
	// Verificar si se ha introducido la fecha, el estudio y la modalidad
	// if (!$("#fechIniAsigDoc_id").val() || !$("#idEst_id").val() || !$("#fechFinAsigDoc_id").val()) {
	if (!$("#fechIniAsigDoc_id").val() || !$("#idEst_id").val()) {

		console.log("Valor de fechIniAsigDoc_id:", $("#fechFinAsigDoc_id").val());
		console.log("Valor de idEst_id:", $("#idEst_id").val());
		//console.log("Valor de fechFinAsigDoc_id:", $("#fechFinAsigDoc_id").val());

		// Muestra un mensaje de error usando SweetAlert
		Swal.fire({
			title: 'Asignación de materias',
			text: 'Por favor, completa la fecha y el estudio antes de realizar la asignación',
			icon: 'error',
			confirmButtonColor: '#d33',
			confirmButtonText: 'Aceptar'
		});
	} else {
		// Realizar operación para cada registro en DatosAsignacionLista
		console.log("asignacionMAteriasACtual");

		// Construir la URL para el servlet SvDevolverDatosByAlumno


		for (var i = 0; i < datosAsignacionLista.length; i++) {
			var asignacionMateriasActual = datosAsignacionLista[i];
			var baseUrl = window.location.origin + '/SchoolGes_v1';
			var urlSvGuardarAsignación = baseUrl + "/SvGuardarAsignacionDocente";
			// Realiza la llamada AJAX al servlet o controlador que maneje la lógica de inserción
			$.ajax({
				type: "POST",
				url: urlSvGuardarAsignación,
				data: asignacionMateriasActual, // Pasar el objeto asignacionMateriasActual como datos
				success: function(response) {
					if (response.success) {
						// La operación fue exitosa, muestra un SweetAlert con un mensaje de éxito
						Swal.fire({
							title: 'Asignación de materias',
							text: 'Operación realizada',
							icon: 'success',
							confirmButtonColor: '#28a745'
						});
					} else {
						// La asignación ya existe, muestra un SweetAlert con un mensaje de error
						Swal.fire({
							title: 'Asignación de materias',
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
						title: 'Asignación de materias',
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

//este método se usa en menú alumnos-rol admin y en menu docentes-rol admin
function borrarAllAsignaciones() {
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
				'¡Listado asignaciones!',
				'Todas las filas han sido eliminadas.',
				'success'
			);
		}
	});
}


//Se llama desde confirmarEliminar pero este método todavía no lo incluido

function actualizarEstadoBotonesAsignarMateria() {

	var cantidadFilas = $("#miTabla tbody tr").length;



	// Activar o desactivar los botones según la cantidad de filas
	$("#btnAsignarMateria").prop("disabled", cantidadFilas === 0);
	$("#btnBorrarAll").prop("disabled", cantidadFilas === 0);
}
