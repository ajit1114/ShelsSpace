package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.User;


public class UserDAOImpl implements UserDAO{
	
	
	private Connection conn;
	
	public UserDAOImpl (Connection conn)
	{
		super();
		this.conn=conn;
		
	}

	@Override
	public boolean userRegister(User user) {
	    boolean isRegistered = false;
	    String sql = "INSERT INTO users (name, email, phno, password) VALUES (?, ?, ?, ?)";

	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, user.getName());
	        ps.setString(2, user.getEmail());
	        ps.setString(3, user.getPhno());
	        ps.setString(4, user.getPassword());
	        int result = ps.executeUpdate(); // Execute the query

	        if (result > 0) {
	            isRegistered = true; // Registration successful
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Log any SQL exceptions
	    }

	    return isRegistered;
	}


	@Override
	public User login(String email, String password) {

	User us=null;
	try {
		String sql="select * from users where email=? and password=?";
		
		 PreparedStatement	ps=conn.prepareStatement(sql);
		 
		 ps.setString(1, email);
		 ps.setString(2,password);
		
		 
		 ResultSet rs=ps.executeQuery();
		 while(rs.next())
		 {
			 us=new User();
			 us.setId(rs.getInt(1));
			 us.setName(rs.getString(2));
			 us.setEmail(rs.getString(3));
			 us.setPhno(rs.getString(4));
			 us.setPassword(rs.getString(5));
			 us.setAddress(rs.getString(6));
			 us.setLandmark(rs.getString(7));
			 us.setCity(rs.getString(8));
			 us.setState(rs.getString(9));
			
			 
		 }
	
	
	
	}
	catch( Exception e)
	{
		
	}
		return us;
	}

	@Override
	public boolean checkPassword(int id, String pass) {
	    boolean isValid = false;

	    String sql = "SELECT 1 FROM users WHERE id = ? AND password = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, id);
	        ps.setString(2, pass);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                isValid = true; // If a row exists, the password is valid
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception for debugging
	    }

	    return isValid;
	}


	@Override
	public boolean updateProfile(User us) {
	    boolean isUpdated = false;

	    String sql = "UPDATE users SET name = ?, email = ?, phno = ? WHERE id = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, us.getName());
	        ps.setString(2, us.getEmail());
	        ps.setString(3, us.getPhno());
	        ps.setInt(4, us.getId()); // Corrected parameter index

	        int rowsAffected = ps.executeUpdate();
	        if (rowsAffected > 0) {
	            isUpdated = true; // Update successful
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception for debugging
	    }

	    return isUpdated;
	}

	@Override
	public boolean checkUser(String email) {
	    boolean exists = false; // Assume the email does not exist

	    String sql = "SELECT * FROM users WHERE email = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, email);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) { // If a record is found
	            exists = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the exception for debugging
	    }

	    return exists; // Return true if email exists, false otherwise
	}


}
