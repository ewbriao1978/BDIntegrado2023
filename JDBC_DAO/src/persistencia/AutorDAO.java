/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import modelo.Autor;

/**
 *
 * @author iapereira
 */
public class AutorDAO {
    
    
      public Autor obter(int id) throws SQLException {
        Autor autor = null;
        String sqlSelect = "SELECT * FROM autor WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sqlSelect);
        preparedStatement.setInt(1, id);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            autor = new Autor(rs.getInt("id"), rs.getString("nome"));
        }        
        rs.close();
        connection.close();
        return autor;
    }

    public ArrayList<Autor> listarTodos() throws SQLException {
        String sqlSelect = "SELECT * FROM autor;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        ResultSet rs = connection.prepareStatement(sqlSelect).executeQuery();
        ArrayList<Autor> vetAutor = new ArrayList();
        while (rs.next()) {
            vetAutor.add(new Autor(rs.getInt("id"), rs.getString("nome")));
        }        
        rs.close();
        connection.close();
        return vetAutor;
    }
    
    public boolean inserir(Autor a) throws SQLException {        
        String sql = "INSERT INTO autor (nome) VALUES (?);";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, a.getNome());
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM autor WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }

    public boolean atualizar(Autor a) throws SQLException {
         String sql = "UPDATE autor SET nome = ? WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, a.getNome());
        preparedStatement.setInt(2, a.getId());
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }
}