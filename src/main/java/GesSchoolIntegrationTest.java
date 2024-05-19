import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.dao.DaoAlumno;
import com.dao.DaoEstudio;
import com.logica.MateriaEnEstudio;

public class GesSchoolIntegrationTest {

    private static final String URL = "jdbc:mysql://localhost:3306/db_schoolges_v1";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";

    private static Connection connection;
    @BeforeClass
    public static void setUp() throws SQLException {
        // Establecer la conexión con la base de datos antes de ejecutar las pruebas
        connection = DriverManager.getConnection(URL, USER, PASSWORD);
        new DaoAlumno(connection);
    }

    @AfterClass
    public static void tearDown() throws SQLException {
        // Cerrar la conexión después de ejecutar todas las pruebas
        if (connection != null) {
            connection.close();
        }
    }

    @Test
    public void testGetAsignacionMateriaYEstudio() throws SQLException {
		DaoEstudio daoEstudio = new DaoEstudio();
		 

        // Definir los IDs de estudio y materia para buscar la asignación
        int idEst = 1;
        int idMat = 1;

        // Llamar al método para obtener la asignación de materia y estudio
        MateriaEnEstudio asignacion = daoEstudio.getAsignacionMateriaYEstudio(idEst, idMat);

        // Verificar que la asignación no sea nula
        assertNotNull(asignacion);

        // Verificar que los atributos de la asignación coincidan con los valores esperados
        assertEquals(idEst, asignacion.getIdEst());
        assertEquals(idMat, asignacion.getIdMat());
    }
}
