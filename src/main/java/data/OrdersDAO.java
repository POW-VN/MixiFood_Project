/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Customer;
import model.OrderDetails;
import model.Orders;

/**
 *
 * @author Admin
 */
public class OrdersDAO {
    public static boolean updateOrderInfo(int id, String address, String note) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps =  null;
        String sql = "UPDATE Orders SET customerAddress = ?, note = ? WHERE orderID = ? AND status = 0";
        try  {
            ps = connection.prepareStatement(sql);
            ps.setNString(1, address);
            ps.setNString(2, note);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
        finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public static List<Orders> getOrdersCustomer(int customerID){
        List<Orders> ordersList = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Orders where customerID=?";
        PreparedStatement ps =  null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            
            while (rs.next()){
                int orderID = rs.getInt("orderID");
                LocalDateTime orderDate = rs.getObject("orderDate", LocalDateTime.class);
                Customer customer = CustomerDAO.getCustomer(customerID);
                String address = rs.getString("customerAddress");
                String note = rs.getString("note");
                int status = rs.getInt("status");
                
                Orders orders = new Orders(orderID, customer, orderDate, address, note, status);
                
                List<OrderDetails> orderDetailsList = OrderDetailsDAO.getOrderDetails(orderID);
                orders.setOrderDetailsList(orderDetailsList);
                
                ordersList.add(orders);
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return ordersList;
    }
    
    public static boolean updateStatus(int orderID, int newStatus) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        String sql = "UPDATE Orders SET status = ? WHERE orderID = ?";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql); 

            ps.setInt(1, newStatus);
            ps.setInt(2, orderID);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    public static void createOrder(Customer acc, Cart cart, String address, String note) {
        // Thêm address và note vào câu lệnh INSERT
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        String sqlOrder = "INSERT INTO Orders (customerID, orderDate, totalPrice, customerAddress, note) VALUES (?, GETDATE(), ?, ?, ?)";
        String sqlItem = "INSERT INTO OrderLineItem (orderID, productID, quantity, priceAtPurchase) VALUES (?, ?, ?, ?)";
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        try{
            connection.setAutoCommit(false);

            // 1. Lưu vào bảng Orders
            psOrder = connection.prepareStatement(sqlOrder,java.sql.Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, acc.getCustomerID());
            psOrder.setDouble(2, cart.getTotalAmount());
            psOrder.setNString(3, address); 
            psOrder.setNString(4, note);
            psOrder.executeUpdate();

            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) orderId = rs.getInt(1);

            // 2. Lưu chi tiết đơn hàng (giữ nguyên logic cũ)
            psItem = connection.prepareStatement(sqlItem);
            for (OrderDetails item : cart.getItems()) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getProduct().getProductID());
                psItem.setInt(3, item.getQuantity());
                psItem.setDouble(4, item.getProduct().getPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();

            connection.commit();
        } catch (Exception e) {
            try {
                if (connection != null) connection.rollback(); // Lỗi là hủy hết, không để lại rác
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            DBUtils.closePreparedStatement(psOrder);
            DBUtils.closePreparedStatement(psItem);
            pool.freeConnection(connection);
        }
    }
    
    public static List<Orders> getOrders(){
        List<Orders> ordersList = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Orders";
        PreparedStatement ps =  null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            rs = ps.executeQuery();
            
            while (rs.next()){
                int orderID = rs.getInt("orderID");
                LocalDateTime orderDate = rs.getObject("orderDate", LocalDateTime.class);
                int customerID = rs.getInt("customerID");
                Customer customer = CustomerDAO.getCustomer(customerID);
                String address = rs.getString("customerAddress");
                String note = rs.getString("note");
                int status = rs.getInt("status");
                
                Orders orders = new Orders(orderID, customer, orderDate, address, note, status);
                
                List<OrderDetails> orderDetailsList = OrderDetailsDAO.getOrderDetails(orderID);
                orders.setOrderDetailsList(orderDetailsList);
                
                ordersList.add(orders);
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return ordersList;
    }
    
    public static Orders getOrder(int code){
        Orders orders = null;
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Orders where orderID=?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, code);
            rs = ps.executeQuery();
            
            while (rs.next()){
                int customerID = rs.getInt("customerID");
                LocalDateTime orderDate = rs.getObject("orderDate", LocalDateTime.class);
                Customer customer = CustomerDAO.getCustomer(customerID);
                System.out.println("DEBUG: OrderID " + code + " - Customer: " + (customer != null ? customer.getCustomerName() : "NULL ROI"));
                String address = rs.getString("customerAddress");
                String note = rs.getString("note");
                int status = rs.getInt("status");
                
                orders = new Orders(code, customer, orderDate, address, note, status);
                
                List<OrderDetails> orderDetailsList = OrderDetailsDAO.getOrderDetails(code);
                orders.setOrderDetailsList(orderDetailsList);
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        
        return orders;
    }
}
