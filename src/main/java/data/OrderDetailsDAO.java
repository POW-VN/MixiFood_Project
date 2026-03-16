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
public class OrderDetailsDAO {
    public static List<OrderDetails> getOrderDetails(int orderID){
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from OrderLineItem where orderID=?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, orderID);
            rs = ps.executeQuery();
            
            while (rs.next()){
                int productCode = rs.getInt("productID");
                int quantity = rs.getInt("quantity");
                
                Product product = ProductDAO.getProduct(productCode);
                OrderDetails orderDetails = new OrderDetails(product,quantity);
                orderDetailsList.add(orderDetails);
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        
        return orderDetailsList;
    }
}
