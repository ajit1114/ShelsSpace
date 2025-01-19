package com.DAO;
import java.time.LocalDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Book_Order;

public class BookOrderImpl implements BookOrderDAO {

    private Connection Conn;
    LocalDate currentDate = LocalDate.now();

    public BookOrderImpl(Connection conn) {
        this.Conn = conn; // Initialize the connection provided to the constructor
    }

    @Override
    public int getOrderNo() {
        int i = 1;
        try {
            String sql = "SELECT * FROM book_order";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return i;
    }

    @Override
    public boolean saveOrder(List<Book_Order> blist) {
        boolean f = false;

        try {
            String sql = "INSERT INTO book_order(order_id, user_name, email, address, phone, book_name, author, price, payment,date) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
            Conn.setAutoCommit(false); // Use the instance variable 'Conn'

            try (PreparedStatement ps = Conn.prepareStatement(sql)) {
                for (Book_Order b : blist) {
                    ps.setString(1, b.getOrderId());
                    ps.setString(2, b.getUserName());
                    ps.setString(3, b.getEmail());
                    ps.setString(4, b.getFulladdr());
                    ps.setString(5, b.getPhno());
                    ps.setString(6, b.getBookName());
                    ps.setString(7, b.getAuthor());
                    ps.setString(8, b.getPrice());
                    ps.setString(9, b.getPayment());
                    ps.setTimestamp(10, java.sql.Timestamp.valueOf(currentDate.atStartOfDay()));

                    ps.addBatch(); // Add this batch to execute later
                }

                int[] count = ps.executeBatch(); // Execute all batched statements
                Conn.commit(); // Commit the transaction
                f = true;
            }
        } catch (Exception e) {
            try {
                if (Conn != null) {
                    Conn.rollback(); // Rollback the transaction in case of an error
                }
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace(); // Log rollback exception
            }
            e.printStackTrace(); // Log the exception
        } finally {
            try {
                if (Conn != null) {
                    Conn.setAutoCommit(true); // Reset auto-commit to default
                }
            } catch (Exception closeEx) {
                closeEx.printStackTrace(); // Log the exception
            }
        }

        return f;
    }


    @Override
    public List<Book_Order> getBook(String email) {
        List<Book_Order> list = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM book_order WHERE email=?";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Book_Order o = new Book_Order();
                o.setId(rs.getInt(1));
                o.setOrderId(rs.getString(2));
                o.setUserName(rs.getString(3));
                o.setEmail(rs.getString(4));
                o.setFulladdr(rs.getString(5));
                o.setPhno(rs.getString(6));
                o.setBookName(rs.getString(7));
                o.setAuthor(rs.getString(8));
                o.setPrice(rs.getString(9));
                o.setPayment(rs.getString(10));
                o.setDate(rs.getTimestamp(11)); // Retrieve as Timestamp
                list.add(o);
                System.out.println(o.getDate());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }


    @Override
    public List<Book_Order> getBook() {
        List<Book_Order> list = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM book_order";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Book_Order o = new Book_Order();
                o.setId(rs.getInt(1));
                o.setOrderId(rs.getString(2));
                o.setUserName(rs.getString(3));
                o.setEmail(rs.getString(4));
                o.setFulladdr(rs.getString(5));
                o.setPhno(rs.getString(6));
                o.setBookName(rs.getString(7));
                o.setAuthor(rs.getString(8));
                o.setPrice(rs.getString(9));
                o.setPayment(rs.getString(10));
                o.setDate(rs.getTimestamp(11)); 
                System.out.println(rs.getTimestamp(11));// Retrieve as Timestamp
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }

}
