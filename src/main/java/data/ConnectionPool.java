/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Admin
 */
public class ConnectionPool {
    // Khai báo connection Pool
    private static ConnectionPool pool=null; 
    private static DataSource dataSource=null;
    
    // Khởi tạo connection Pool 
    private ConnectionPool(){
        try{
            InitialContext ic=new InitialContext();
            dataSource =(DataSource)ic.lookup("java:/comp/env/jdbc/khoga");
        }catch(NamingException e){ 
            System.out.println(e);
            }
    }
    
    // Lấy connection pool
    public static synchronized ConnectionPool getInstance(){ 
        if(pool==null){
            pool= new ConnectionPool();
        }
        return pool;
    }
    
    // Lấy connection từ   pool
    public Connection getConnection(){ 
        try{
            return dataSource.getConnection();

            }catch(SQLException e){ System.out.println(e); return null;
        }
    }

    // Trả   connection lại vào pool
    public void freeConnection(Connection c){ 
        try{
            c.close();
        }catch(SQLException e){ 
            System.out.println(e);
        }

    }

}
