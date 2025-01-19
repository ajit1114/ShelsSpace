package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.entity.BookDtls;
import com.mysql.cj.xdevapi.PreparableStatement;

public class BookDAOImp implements BookDAO {

    private Connection conn;

    public BookDAOImp(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean addBook(BookDtls b) {
        boolean f = false;

        try {
            String sql = "INSERT INTO book_dtls (bookName, author, price, bookCategory, status, photoName, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, b.getBookName());
            ps.setString(2, b.getAuthor());
            ps.setString(3, b.getPrice());
            ps.setString(4, b.getBookCategory());
            ps.setString(5, b.getStatus());
            ps.setString(6, b.getPhotoName());
            ps.setString(7, b.getEmail());

            System.out.println("Executing SQL: " + ps.toString()); // Debug SQL
            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
                System.out.println("Book added successfully to the database.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public List<BookDtls> getAllBooks() {
        List<BookDtls> list = new ArrayList<>();
        BookDtls b = null; // Declare the variable as null initially
        try {
            String sql = "SELECT * FROM book_dtls";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Initialize using the parameterized constructor
                b = new BookDtls(
                    rs.getString(2), // bookName
                    rs.getString(3), // author
                    rs.getString(4), // price
                    rs.getString(5), // bookCategory
                    rs.getString(6), // status
                    rs.getString(7), // photoName
                    rs.getString(8)  // email
                );
                // Set the bookId separately
                b.setBookId(rs.getInt(1));
                // Add the object to the list
                list.add(b);
            }
        } catch (Exception e) {
            System.out.println("Error while fetching books: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

	@Override
	public BookDtls getBookById(int id) {
	    BookDtls b = null; // Initialize as null
	    try {
	        String sql = "SELECT * FROM book_dtls WHERE id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) { // Only create BookDtls object if record is found
	            b = new BookDtls(sql, sql, sql, sql, sql, sql, sql); // Initialize the object
	            b.setBookId(rs.getInt(1));
	            b.setBookName(rs.getString(2));
	            b.setAuthor(rs.getString(3));
	            b.setPrice(rs.getString(4));
	            b.setBookCategory(rs.getString(5));
	            b.setStatus(rs.getString(6));
	            b.setPhotoName(rs.getString(7));
	            b.setEmail(rs.getString(8));
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Print the stack trace for debugging
	    }
	    return b; // Return null if no record is found
	}

	@Override
	public boolean updateBook(BookDtls b) {
	    boolean f = false;
	    try {
	        String sql = "UPDATE book_dtls SET bookName=?, author=?, price=?, status=? WHERE id=?";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ps.setString(1, b.getBookName());
	        ps.setString(2, b.getAuthor());
	        ps.setString(3, b.getPrice());
	        ps.setString(4, b.getStatus());
	        ps.setInt(5, b.getBookId());

	        int i = ps.executeUpdate();

	        if (i == 1) {
	            f = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the error for debugging
	    }

	    return f;
	}

	@Override
	public boolean deleteBooks(int id) {
		boolean f=false;
		try {
			String sql="delete from book_dtls  where id=?";
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ps.setInt(1,id);
			int i= ps.executeUpdate();
			if(i!=0)
			{
				f=true;
				
			}
			
		}
		catch(Exception e)
		{
			
		}
		
		return f;
	}

	@Override
	public List<BookDtls> getNewBook() {
	    List<BookDtls> list = new ArrayList<>();
	    try {
	        String sql = "SELECT * FROM book_dtls WHERE bookCategory = ? AND status = ? order by id DESC";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, "New" );
	        ps.setString(2, "Available");
	        ResultSet rs = ps.executeQuery();
	        
	        int i = 0; // Counter to limit results to 4
	        while (rs.next() && i < 4) {
	            // Use the parameterized constructor
	            BookDtls b = new BookDtls(
	                rs.getString("bookName"),
	                rs.getString("author"),
	                rs.getString("price"),
	                rs.getString("bookCategory"),
	                rs.getString("status"),
	                rs.getString("photoName"),
	                rs.getString("email")
	            );
	            
	            b.setBookId(rs.getInt(1));
	            b.setBookName(rs.getString(2));
	            b.setAuthor(rs.getString(3));
	            b.setPrice(rs.getString(4));
	            b.setBookCategory(rs.getString(5));
	            b.setStatus(rs.getString(6));
	            b.setPhotoName(rs.getString(7));
	            b.setEmail(rs.getString(8));
	            list.add(b);
	          
	          
	            i++;
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the error for debugging
	    }
	    return list;
	}

	@Override
	public List<BookDtls> getRecentBook() {
	    List<BookDtls> list1 = new ArrayList<>();
	    try {
	        String sql = "SELECT * FROM book_dtls WHERE status = ? ";
	        PreparedStatement ps1 = conn.prepareStatement(sql);
	        ps1.setString(1, "Available");
	        
	        ResultSet rs = ps1.executeQuery();
	        
	        int i = 0; // Counter to limit results to 4
	        while (rs.next() && i < 4) {
	            // Use the parameterized constructor
	            BookDtls b = new BookDtls(
	                rs.getString("bookName"),
	                rs.getString("author"),
	                rs.getString("price"),
	                rs.getString("bookCategory"),
	                rs.getString("status"),
	                rs.getString("photoName"),
	                rs.getString("email")
	            );
	            b.setBookId(rs.getInt(1));
	            b.setBookName(rs.getString(2));
	            b.setAuthor(rs.getString(3));
	            b.setPrice(rs.getString(4));
	            b.setBookCategory(rs.getString(5));
	            b.setStatus(rs.getString(6));
	            b.setPhotoName(rs.getString(7));
	            b.setEmail(rs.getString(8));
	            
	            list1.add(b); // Add the book only once
	            i++;
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Log the error for debugging
	    }
	    return list1;
	}


	@Override
	public List<BookDtls> getOldBook() {
		 List<BookDtls> list = new ArrayList<>();
		    try {
		        String sql = "SELECT * FROM book_dtls WHERE bookCategory = ? AND status = ? order by id DESC";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setString(1, "old" );
		        ps.setString(2, "Available");
		        ResultSet rs = ps.executeQuery();
		        
		        int i = 0; // Counter to limit results to 4
		        while (rs.next() && i < 4) {
		            // Use the parameterized constructor
		        	  BookDtls b = new BookDtls(sql, sql, sql, sql, sql, sql, sql);
		            b.setBookId(rs.getInt(1));
		            b.setBookName(rs.getString(2));
		            b.setAuthor(rs.getString(3));
		            b.setPrice(rs.getString(4));
		            b.setBookCategory(rs.getString(5));
		            b.setStatus(rs.getString(6));
		            b.setPhotoName(rs.getString(7));
		            b.setEmail(rs.getString(8));
		            list.add(b);
		          
		            
		            i++;
		        }
		    } catch (Exception e) {
		        e.printStackTrace(); // Log the error for debugging
		    }
		    return list;
		
	}

	@Override
	public List<BookDtls> getAllRecentBook() {
		
		 List<BookDtls> list1 = new ArrayList<>();
		    try {
		        String sql = "SELECT * FROM book_dtls WHERE status = ? ";
		        PreparedStatement ps1 = conn.prepareStatement(sql);
		        ps1.setString(1, "Available" );
		        
		        ResultSet rs = ps1.executeQuery();
		        
		        int i = 0; // Counter to limit results to 4
		        while (rs.next()) {
		            // Use the parameterized constructor
		            BookDtls b = new BookDtls(sql, sql, sql, sql, sql, sql, sql);
		            b.setBookId(rs.getInt(1));
		            b.setBookName(rs.getString(2));
		            b.setAuthor(rs.getString(3));
		            b.setPrice(rs.getString(4));
		            b.setBookCategory(rs.getString(5));
		            b.setStatus(rs.getString(6));
		            b.setPhotoName(rs.getString(7));
		            b.setEmail(rs.getString(8));
		            list1.add(b);
		          
		           
		        }
		    } catch (Exception e) {
		        e.printStackTrace(); // Log the error for debugging
		    }
		    return list1;
	}

	@Override
	public List<BookDtls> getAllNewBook() {
		 List<BookDtls> list = new ArrayList<>();
		    try {
		        String sql = "SELECT * FROM book_dtls WHERE bookCategory = ? AND status = ? order by id DESC";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setString(1, "New" );
		        ps.setString(2, "Available");
		        ResultSet rs = ps.executeQuery();
		        
		    
		        while (rs.next()) {
		            // Use the parameterized constructor
		            BookDtls b = new BookDtls(sql, sql, sql, sql, sql, sql, sql);
		            b.setBookId(rs.getInt(1));
		            b.setBookName(rs.getString(2));
		            b.setAuthor(rs.getString(3));
		            b.setPrice(rs.getString(4));
		            b.setBookCategory(rs.getString(5));
		            b.setStatus(rs.getString(6));
		            b.setPhotoName(rs.getString(7));
		            b.setEmail(rs.getString(8));
		            list.add(b);
		          
		           
		        }
		    } catch (Exception e) {
		        e.printStackTrace(); // Log the error for debugging
		    }
		    return list;
	}

	@Override
	public List<BookDtls> getAllOldBook() {
		 List<BookDtls> list = new ArrayList<>();
		    try {
		        String sql = "SELECT * FROM book_dtls WHERE bookCategory = ? AND status = ? order by id DESC";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setString(1, "old" );
		        ps.setString(2, "Available");
		        ResultSet rs = ps.executeQuery();
		        
		        int i = 0; // Counter to limit results to 4
		        while (rs.next()) {
		            // Use the parameterized constructor
		            BookDtls b = new BookDtls(sql, sql, sql, sql, sql, sql, sql);
		            b.setBookId(rs.getInt(1));
		            b.setBookName(rs.getString(2));
		            b.setAuthor(rs.getString(3));
		            b.setPrice(rs.getString(4));
		            b.setBookCategory(rs.getString(5));
		            b.setStatus(rs.getString(6));
		            b.setPhotoName(rs.getString(7));
		            b.setEmail(rs.getString(8));
		            list.add(b);
		          
		           
		        }
		    } catch (Exception e) {
		        e.printStackTrace(); // Log the error for debugging
		    }
		    return list;
	}

	@Override
	public List<BookDtls> getBookByOld(String mail , String cate) {
		
		List<BookDtls> list=new ArrayList<BookDtls>();
		BookDtls b=null;
		
		try
		{
			String sql="select * from book_dtls where bookCategory=? and email=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setString(1, cate);
			ps.setString(2, mail);
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next())
			{
				 BookDtls b1 = new BookDtls(sql, sql, sql, sql, sql, sql, sql);
		            b1.setBookId(rs.getInt(1));
		            b1.setBookName(rs.getString(2));
		            b1.setAuthor(rs.getString(3));
		            b1.setPrice(rs.getString(4));
		            b1.setBookCategory(rs.getString(5));
		            b1.setStatus(rs.getString(6));
		            b1.setPhotoName(rs.getString(7));
		            b1.setEmail(rs.getString(8));
		            list.add(b1);
				
				
			}
		}
		catch(Exception e)
		{
			
		}
		return list;
	}

	@Override
	public boolean oldBookDelete(String mail, String category ,int Bid) {
	boolean f=false;
	
	try
	{
		String sql="delete from book_dtls where bookCategory=? and email=?";
		PreparedStatement ps=conn.prepareStatement(sql);
		ps.setString(1, category);
		ps.setString(2, mail);
	//	ps.setInt(3, id);
		
		int i =ps.executeUpdate();// rs=ps.executeQuery();
		
		
		if(i==1)
		{
			f=true;
		}
	}
	catch(Exception e)
	{
		
	}
	
		return f;
	}

	@Override
	public List<BookDtls> getBookBySearch(String sh) {
		List<BookDtls> list=new ArrayList<BookDtls>();
		BookDtls b=null;
		
		try
		{
			String sql="select * from book_dtls where bookName like ? or author like ? or bookCategory like ? and status=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setString(1, "%"+sh+"%");
			ps.setString(2, "%"+sh+"%" );
			ps.setString(3, "%"+sh+"%" );
			ps.setString(4, "Active" );
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next())
			{
				 BookDtls b1 = new BookDtls(sql, sql, sql, sql, sql, sql, sql);
		            b1.setBookId(rs.getInt(1));
		            b1.setBookName(rs.getString(2));
		            b1.setAuthor(rs.getString(3));
		            b1.setPrice(rs.getString(4));
		            b1.setBookCategory(rs.getString(5));
		            b1.setStatus(rs.getString(6));
		            b1.setPhotoName(rs.getString(7));
		            b1.setEmail(rs.getString(8));
		            list.add(b1);
				
				
			}
		}
		catch(Exception e)
		{
			
		}
		return list;
	}
	
	
	



}
