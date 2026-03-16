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
import model.Product;

/**
 *
 * @author Admin
 */
public class ProductDAO {
    
    public void updateStatus(int orderID, int status) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sql = "UPDATE Orders SET status = ? WHERE orderID = ?";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql); 
            ps.setInt(1, status);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public static List<Product> getProductByType(String type){
        List<Product> productList = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Product where productType=?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setString(1, type);
            rs = ps.executeQuery();
            
            while (rs.next()){
                int id = rs.getInt("productID");
                String productName = rs.getString("productName");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                String imgURL = rs.getString("imgURL");
                int s = rs.getInt("status");
                String status = "Còn hàng";
                if (s==0) status = "Hết hàng";
                
                productList.add(new Product(id,productName,description,price,type,imgURL,status)) ;
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return productList;
    }
    
    public static List<String> getAllProductTypes(){
        List<String> types = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select distinct productType from Product";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            rs = ps.executeQuery();
            while (rs.next()){
                types.add(rs.getString("productType"));
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        
        return types;
    }
    
    public static List<Product> searchName(String name){
        List<Product> productList = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Product where productName LIKE ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setString(1, "%"+name+"%");
            rs = ps.executeQuery();
            
            while (rs.next()){
                int id = rs.getInt("productID");
                String productName = rs.getString("productName");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                String type = rs.getString("productType");
                String imgURL = rs.getString("imgURL");
                int s = rs.getInt("status");
                String status = "Còn hàng";
                if (s==0) status = "Hết hàng";
                
                productList.add(new Product(id,productName,description,price,type,imgURL,status)) ;
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return productList;
    }
    public static Product getProduct(int code){
        Product product = null;
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Product where productID=?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            ps.setInt(1, code);
            rs = ps.executeQuery();
            
            while (rs.next()){
                String name = rs.getString("productName");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                String type = rs.getString("productType");
                String imgURL = rs.getString("imgURL");
                int s = rs.getInt("status");
                String status = "Còn hàng";
                if (s==0) status = "Hết hàng";
                
                product = new Product(code,name,description,price,type,imgURL,status);
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return product;
    }
    
    public static List<Product> getProducts(){
        List<Product> products = new ArrayList<>();
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        String sqlString = "Select * from Product";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = connection.prepareStatement(sqlString);
            rs = ps.executeQuery();
            
            while (rs.next()){
                int productID = rs.getInt("productID");
                String name = rs.getString("productName");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                String type = rs.getString("productType");
                String imgURL = rs.getString("imgURL");
                int s = rs.getInt("status");
                String status = "Còn hàng";
                if (s==0) status = "Hết hàng";
                
                products.add(new Product(productID,name,description,price,type,imgURL,status)); 
            }
        } catch (SQLException e){
            System.out.println(e);
        } finally {
            DBUtils.closeResultSet(rs);
            DBUtils.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
        return products;
    }
}
