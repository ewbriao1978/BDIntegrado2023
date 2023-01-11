/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistencia;

/**
 *
 * @author iapereira
 */

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConexaoPostgreSQL {
    private String host;
    private String port;
    private String username;
    private String password;
    private String database;
    
    public ConexaoPostgreSQL(){
        this.host = "localhost";
        this.port = "5432";
        this.username = "postgres";
        this.password = "postgres";
        this.database = "dao";
    }
    
    public Connection getConnection(){
        String url = "jdbc:postgresql://"+this.host+":"+this.port+"/"+this.database;              
        try {
//            System.out.println("Tudo ok!");
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException ex) {
            System.out.println("Deu xabum!!");
            Logger.getLogger(ConexaoPostgreSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
