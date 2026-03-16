/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetails;
import model.Product;

/**
 *
 * @author Admin
 */
public class CartDAO {
    public static List<OrderDetails> getCart(int customerID){
        List<OrderDetails> list = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sql = "Select * from Cart where customerID = ?";
        
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            
            while (rs.next()){
                String id = rs.getString("productID");
                int productID = Integer.parseInt(id);
                String quan = rs.getString("quantity");
                int quantity = Integer.parseInt(quan);
                
                Product product = ProductDAO.getProduct(productID);
                OrderDetails order = new OrderDetails(product, quantity);
                list.add(order);
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        
        return list;
    }
    public static void addToCart(int customerID, int productID, int quantity) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        // Lệnh MERGE giúp tối ưu hiệu năng: 1 lần gọi DB xử lý được cả 2 trường hợp
        String sql = "MERGE INTO Cart AS target " +
                     "USING (SELECT ? AS cID, ? AS pID) AS source " +
                     "ON (target.customerID = source.cID AND target.productID = source.pID) " +
                     "WHEN MATCHED THEN " +
                     "    UPDATE SET target.quantity = target.quantity + ? " +
                     "WHEN NOT MATCHED THEN " +
                     "    INSERT (customerID, productID, quantity) VALUES (source.cID, source.pID, ?);";
        PreparedStatement ps = null;
        
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            ps.setInt(3, quantity);
            ps.setInt(4, quantity);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public static void updateQuantity(int customerID, int productID, int newQuantity) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sql = "UPDATE Cart SET quantity = ? WHERE customerID = ? AND productID = ?";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, newQuantity);
            ps.setInt(2, customerID);
            ps.setInt(3, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public static void deleteItem(int customerID, int productID) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        PreparedStatement ps = null;
        String sql = "DELETE FROM Cart WHERE customerID = ? AND productID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public static void clearCart(int customerID) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String sql = "DELETE FROM Cart WHERE customerID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
}
