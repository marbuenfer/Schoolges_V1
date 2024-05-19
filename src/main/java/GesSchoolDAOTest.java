import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import com.dao.DaoAlumno;
import com.dao.DaoEstudio;
import com.logica.Alumno;
import com.logica.Estudio;
import com.logica.MateriaEnEstudio;
import com.logica.Matricula;

public class GesSchoolDAOTest {

	@Test
	public void testGetAllAlumnos() throws Exception {
		// Simular datos de prueba
		List<Alumno> listaAlumnosEsperada = new ArrayList<>();
		Alumno alumnoEsperado = new Alumno();
		alumnoEsperado.setIdUsu(1);
		alumnoEsperado.setDniUsu("12345678A");
		alumnoEsperado.setNomCompUsu("Juan Pérez");
		// Agregar más atributos según sea necesario
		listaAlumnosEsperada.add(alumnoEsperado);

		// Crear instancia de DaoAlumno
		DaoAlumno daoAlumno = new DaoAlumno();

		// Llamar al método bajo prueba
		List<Alumno> listaAlumnosObtenida = daoAlumno.getAllAlumnos();

		// Verificar que se devuelva una lista con al menos un alumno
		assertEquals(listaAlumnosEsperada.size(), listaAlumnosObtenida.size());

		// Verificar que los datos del primer alumno sean los esperados
		if (!listaAlumnosEsperada.isEmpty() && !listaAlumnosObtenida.isEmpty()) {
			Alumno alumnoObtenido = listaAlumnosObtenida.get(0);
			assertEquals(alumnoEsperado.getIdUsu(), alumnoObtenido.getIdUsu());
			assertEquals(alumnoEsperado.getDniUsu(), alumnoObtenido.getDniUsu());
			assertEquals(alumnoEsperado.getNomCompUsu(), alumnoObtenido.getNomCompUsu());
		}
	}

	@Test
	public void testGetAlumnoById() throws Exception {
		// Simular datos de prueba
		Alumno alumnoEsperado = new Alumno();
		alumnoEsperado.setIdUsu(1);
		alumnoEsperado.setDniUsu("12345678A");
		alumnoEsperado.setNomCompUsu("Juan Pérez");
		// Agregar más atributos según sea necesario

		// Crear instancia de DaoAlumno
		DaoAlumno daoAlumno = new DaoAlumno();

		// Llamar al método bajo prueba
		Alumno alumnoObtenido = daoAlumno.getAlumnoById(1); // Supongamos que queremos obtener el alumno con id 1

		// Verificar que el alumno obtenido sea el esperado
		assertEquals(alumnoEsperado.getIdUsu(), alumnoObtenido.getIdUsu());
		assertEquals(alumnoEsperado.getDniUsu(), alumnoObtenido.getDniUsu());
		assertEquals(alumnoEsperado.getNomCompUsu(), alumnoObtenido.getNomCompUsu());
	}

	@Test
	public void testGetAllAlumnosByEstudio() throws Exception {
		// Simular datos de prueba
		int idAlumno = 1; // ID de un alumno ficticio
		List<Alumno> listaAlumnosEsperada = new ArrayList<>();
		Alumno alumnoEsperado = new Alumno();
		alumnoEsperado.setIdUsu(1);
		alumnoEsperado.setNomCompUsu("Juan Pérez");
		alumnoEsperado.setEmailUsu("juan@example.com");
		alumnoEsperado.setNomEst("Estudio 1");
		// Agregar más atributos según sea necesario
		listaAlumnosEsperada.add(alumnoEsperado);

		// Crear instancia de DaoAlumno
		DaoAlumno daoAlumno = new DaoAlumno();

		// Llamar al método bajo prueba
		List<Alumno> listaAlumnosObtenida = daoAlumno.getAllAlumnosByEstudio(idAlumno);

		// Verificar que se devuelva una lista con al menos un alumno
		assertEquals(listaAlumnosEsperada.size(), listaAlumnosObtenida.size());

		// Verificar que los datos del primer alumno sean los esperados
		if (!listaAlumnosEsperada.isEmpty() && !listaAlumnosObtenida.isEmpty()) {
			Alumno alumnoObtenido = listaAlumnosObtenida.get(0);
			assertEquals(alumnoEsperado.getIdUsu(), alumnoObtenido.getIdUsu());
			assertEquals(alumnoEsperado.getNomCompUsu(), alumnoObtenido.getNomCompUsu());
			assertEquals(alumnoEsperado.getEmailUsu(), alumnoObtenido.getEmailUsu());
			assertEquals(alumnoEsperado.getNomEst(), alumnoObtenido.getNomEst());
		}
	}

	@Test
	public void testGetAllMatriculaciones() throws Exception {
		// Simular datos de prueba
		List<Matricula> matriculasEsperadas = new ArrayList<>();
		Matricula matriculaEsperada = new Matricula();
		matriculaEsperada.setIdAlu(1);
		matriculaEsperada.setNomCompAlu("Juan Pérez");
		matriculaEsperada.setIdEst(1);
		matriculaEsperada.setNomEst("Estudio A");
		// Agregar más atributos según sea necesario
		matriculasEsperadas.add(matriculaEsperada);

		// Crear instancia de DaoAlumno
		DaoAlumno daoAlumno = new DaoAlumno();

		// Llamar al método bajo prueba
		List<Matricula> matriculasObtenidas = daoAlumno.getAllMatriculaciones();

		// Verificar que la lista de matriculaciones obtenida no esté vacía
		assertFalse(matriculasObtenidas.isEmpty());

		// Verificar que los datos de la primera matrícula sean los esperados
		if (!matriculasEsperadas.isEmpty() && !matriculasObtenidas.isEmpty()) {
			Matricula matriculaObtenida = matriculasObtenidas.get(0);
			assertEquals(matriculaEsperada.getIdAlu(), matriculaObtenida.getIdAlu());
			assertEquals(matriculaEsperada.getNomCompAlu(), matriculaObtenida.getNomCompAlu());
			assertEquals(matriculaEsperada.getIdEst(), matriculaObtenida.getIdEst());
			assertEquals(matriculaEsperada.getNomEst(), matriculaObtenida.getNomEst());
		}
	}

	@Test
	public void testBorrarMatricula() throws Exception {
		// Simular un id de matrícula existente en la base de datos
		int idMatriculaExistente = 1;

		// Crear instancia de DaoAlumno
		DaoAlumno daoAlumno = new DaoAlumno();

		// Llamar al método bajo prueba para borrar una matrícula existente
		boolean borradoExitoso = daoAlumno.borrarMatricula(idMatriculaExistente);

		// Verificar que el borrado haya sido exitoso
		assertTrue(borradoExitoso);
	}

	@Test
	public void testGetEstudioById() throws Exception {
		// Simular un ID de estudio existente en la base de datos
		int idEstudioExistente = 1;

		// Crear instancia de DaoAlumno
		DaoEstudio daoEstudio = new DaoEstudio();

		// Llamar al método bajo prueba para obtener el estudio con el ID especificado
		Estudio estudioObtenido = daoEstudio.getEstudioById(idEstudioExistente);

		// Verificar que se obtenga un objeto de tipo Estudio
		assertNotNull(estudioObtenido);

		// Verificar que el ID del estudio obtenido sea el esperado
		assertEquals(idEstudioExistente, estudioObtenido.getIdEst());
	}

	@Test
	public void testGetAllEstudios() {
		DaoEstudio daoEstudio = new DaoEstudio();

		// Llamar al método para obtener la lista de estudios
		List<Estudio> listaEstudios = daoEstudio.getAllEstudios();

		// Verificar que la lista no sea nula
		assertNotNull(listaEstudios);

		// Verificar que la lista contenga al menos un estudio
		assertNotEquals(0, listaEstudios.size());

		// Verificar que los atributos de al menos un estudio sean los esperados
		for (Estudio estudio : listaEstudios) {
			assertNotNull(estudio.getIdEst());
			assertNotNull(estudio.getNomEst());
			assertNotNull(estudio.getEspeEst());
			assertNotNull(estudio.getHoraEst());
			assertNotNull(estudio.getObsEst());
		}
	}

	@Test
	public void testGetEstudioByMateria() {
		DaoEstudio daoEstudio = new DaoEstudio();

		// Definir una materia existente en la base de datos de prueba
		String idMateria = "ID_DE_LA_MATERIA"; // Reemplazar con el ID de una materia existente

		// Llamar al método para obtener el estudio asociado a la materia
		Estudio estudio = daoEstudio.getEstudioByMateria(idMateria);

		// Verificar que el estudio no sea nulo
		assertNotNull(estudio);

		// Verificar que los atributos del estudio sean los esperados
		assertNotNull(estudio.getIdEst());
		assertNotNull(estudio.getNomEst());
	}

	@Test
	public void testGetAllAsignacionesMateriaEstudios() {
		DaoEstudio daoEstudio = new DaoEstudio();

		// Llamar al método para obtener todas las asignaciones de materia a estudios
		List<MateriaEnEstudio> asignaciones = daoEstudio.getAllAsignacionesMateriaEstudios();

		// Verificar que la lista no sea nula
		assertNotNull(asignaciones);

		// Verificar que la lista no esté vacía
		assertFalse(asignaciones.isEmpty());

		// Verificar que cada asignación tenga los atributos esperados
		for (MateriaEnEstudio asignacion : asignaciones) {
			assertNotNull(asignacion.getIdEst());
			assertNotNull(asignacion.getNomEst());
			assertNotNull(asignacion.getIdMat());
			assertNotNull(asignacion.getNomMat());
			assertNotNull(asignacion.getObsMatEst());
		}
	}

}
