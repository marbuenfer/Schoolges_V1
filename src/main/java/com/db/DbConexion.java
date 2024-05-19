package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConexion {
	private static Connection conn;

	static {
		// Este bloque estático se ejecuta solo una vez cuando se carga la clase
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//conexión con servidor local(como siempre)
			// conn =
			// DriverManager.getConnection("jdbc:mysql://localhost:3306/db_schoolges_v1",	 "root", "123456");
			
			 DriverManager.getConnection("jdbc:mysql:https://appschoolges.azurewebsites.net/db_schoolges_v1", "iniciosesionschoolgesv1", "cabum-50");
			
			//para conexiones internas
			// conn =
			// DriverManager.getConnection("jdbc:mysql://10.100.62.1:3306/db_schoolges_v1",
			// "root", "123456");
			
			// para conexiones externas
			//conn = DriverManager.getConnection(	"jdbc:mysql://node183825-schoolgesv1.jelastic.saveincloud.net:14035/db_schoolges_v1", "root",	"VEZcve01427");
			
			//conn = DriverManager.getConnection("jdbc:mysql://node183825-schoolgesv1.jelastic.saveincloud.net:3306"
			//		+ "/db_schoolges_v1", "root",	"VEZcve01427");
			
			// Para conectarnos con nuestra aplicación interna

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error al establecer la conexión a la base de datos", e);
		}
	}

	public static Connection getConn() {
		return conn;
	}

	public static void closeConnection() {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}