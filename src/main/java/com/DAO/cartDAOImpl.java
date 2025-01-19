package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Cart;

public class cartDAOImpl implements cartDAO {

    private Connection conn;

    /**
     * Constructor to initialize DAO with a database connection.
     * @param conn The database connection object.
     */
    public cartDAOImpl(Connection conn) {
        this.conn = conn;
    }

    /**
     * Add a cart item to the database.
     * @param c The Cart object containing item details.
     * @return true if the item was successfully added, false otherwise.
     */
    @Override
    public boolean addCart(Cart c) {
        boolean success = false;
        String sql = "INSERT INTO cart(cid, bid, uid, book_name, author, price, total_price) VALUES(?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getCid());
            ps.setInt(2, c.getBid());
            ps.setInt(3, c.getUserid());
            ps.setString(4, c.getBookName());
            ps.setString(5, c.getAuthor());
            ps.setDouble(6, c.getPrice());
            ps.setDouble(7, c.getTotalPrice());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected == 1);
        } catch (Exception e) {
            e.printStackTrace(); // Replace with logger in production
        }

        return success;
    }

    /**
     * Retrieve all cart items for a given user.
     * @param userid The user ID.
     * @return A list of Cart objects.
     */
    @Override
    public List<Cart> getBookByUser(int userid) {
        List<Cart> list = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE uid=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userid);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cart c = new Cart();
                    c.setCid(rs.getInt(1));
                    c.setBid(rs.getInt(2));
                    c.setUserid(rs.getInt(3));
                    c.setBookName(rs.getString(4));
                    c.setAuthor(rs.getString(5));
                    c.setPrice(rs.getDouble(6));
                    c.setTotalPrice(rs.getDouble(7));
                    list.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Replace with logger in production
        }

        return list;
    }

    /**
     * Remove an item from the cart.
     * @param bid The book ID.
     * @param uid The user ID.
     * @param cid The cart ID.
     * @return true if the item was successfully removed, false otherwise.
     */
    @Override
    public boolean removeItem(int bid, int uid, int cid) {
        boolean success = false;
        String sql = "DELETE FROM cart WHERE bid=? AND uid=? AND cid=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bid);
            ps.setInt(2, uid);
            ps.setInt(3, cid);

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected == 1);
        } catch (Exception e) {
            e.printStackTrace(); // Replace with logger in production
        }

        return success;
    }
}
