/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Admin
 */
public class DBUtils {
    // Đóng câu lệnh PreparedStatement khi dùng xong
    public static void closePreparedStatement(Statement ps){ 
        try{
            if(ps!=null){
                ps.close();
            }
        }catch(SQLException e){ 
            System.out.println(e);
        }
    }
    
    // Đóng resultset khi không cần dùng
    public static void closeResultSet(ResultSet rs){ 
        try{
            if(rs!=null){
                rs.close();
            }
        }catch(SQLException e){ 
            System.out.println(e);
        }
    }


}
