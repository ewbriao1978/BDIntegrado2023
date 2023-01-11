/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.*;

/**
 *
 * @author iapereira
 */
public class ConexaoPostgreSQL {
    private String username;
    private String password;
    private String host;
    private String port;
    private String dbname;
    
    public ConexaoPostgreSQL(){
        this.username = "postgres";
        this.password = "postgres";
        this.host = "localhost";
        this.port = "5432";
        this.dbname = "gravadora";
    }
    
    public Connection getConexao() throws SQLException {        
        String url = "jdbc:postgresql://"+this.host+":"+this.port+"/"+this.dbname;
        return DriverManager.getConnection(url, this.username, this.password);
    }
    
}
