/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Customer;

/**
 *
 * @author Admin
 */
public class CustomerDAO {
    public static boolean updateCustomer(Customer customer) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sql = "UPDATE Customer SET customerName = ?, customerPhone = ?, username = ?, password = ? WHERE customerID = ?";
        PreparedStatement ps = null;
        
        // Sử dụng try-with-resources để tự động đóng connection
        try {
            ps = connection.prepareStatement(sql);
            ps.setNString(1, customer.getCustomerName());
            ps.setString(2, customer.getCustomerPhone());
            ps.setString(3, customer.getUsername());
            ps.setString(4, customer.getPassword());
            ps.setInt(5, customer.getCustomerID());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Lỗi updateCustomer: " + e.getMessage());
            return false;
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public static boolean register(String name, String phone, String user, String pass){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "INSERT INTO Customer (customerName, customerPhone, username, password, role) VALUES (?, ?, ?, ?, 0)";
        PreparedStatement ps = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setString(1, name);
            ps.setString(2,phone);
            ps.setString(3, user);
            ps.setString(4, pass);
            int row = ps.executeUpdate();
            return row>0;
        } catch (SQLException e){
            System.err.println("SQL Error: " + e.getMessage()); 
            e.printStackTrace();
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        
        return false;
    }
    public static Customer checkLogin(String username, String password){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Customer where username=? and password=?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try{
            ps = connection.prepareStatement(sqlString);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            while (rs.next()){
                int id = rs.getInt("customerID");
                String user = rs.getString("username");
                String pass = rs.getString("password");
                String name = rs.getString("customerName");
                String phone = rs.getString("customerPhone");
                int role = rs.getInt("role");
                return new Customer(id,name,phone,user,pass,role);
            }
        }catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        
        return null;
    }
    public static Customer getCustomer(int code){
        Customer customer = null;
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Customer where customerID=?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, code);
            rs = ps.executeQuery();
            
            while (rs.next()){
                String name = rs.getString("customerName");
                String phone = rs.getString("customerPhone");
                String user = rs.getString("username");
                String pass = rs.getString("password");
                
                customer = new Customer(code,name,phone,user,pass);
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        
        return customer;
    }
}
