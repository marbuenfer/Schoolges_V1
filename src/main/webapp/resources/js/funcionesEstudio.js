/**
 * 
 */

 function cargarMateriasAsignacionEnTablaForm() {
	// Crear y devolver una promesa
	return new Promise(function(resolve, reject) {
		// Verificar si se ha introducido la fecha, el estudio y la modalidad
		if ( !$("#idEst_id").val()) {
			// Si no se ha seleccionado un estudio se muestra un mensaje de error usando SweetAlert
			MsgSwal("Asignación de materias a estudios", "Por favor, selecciona el estudio antes de cargar las materias", "error", "#d33");
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
					$("#materiasTableBody").empty();

					$.each(data, function(index, materia) {
						var row = $('<tr>');
						row.append($('<td>').text(materia.idMat));
						row.append($('<td>').text(materia.nomMat));
						row.append($('<td>').html('<input type="checkbox" class="materiaCheckbox" value="' + materia.idMat + '" data-nombre="' + materia.nomMat + '">'));
						$("#materiasTableBody").append(row);
					});

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