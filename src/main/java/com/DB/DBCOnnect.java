package com.DB;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBCOnnect {

	private static Connection conn;
	public static Connection getConn()
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ebook-app","root","Ajit@2003");
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return conn;
	}
}
