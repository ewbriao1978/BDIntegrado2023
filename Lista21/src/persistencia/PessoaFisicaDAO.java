/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.PessoaFisica;

/**
 *
 * @author iapereira
 */
public class PessoaFisicaDAO {

    public PessoaFisica obter(int id) throws SQLException {
        PessoaFisica pessoa_fisica = null;
        String sqlSelect = "SELECT * FROM pessoa_fisica WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sqlSelect);
        preparedStatement.setInt(1, id);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            pessoa_fisica = new PessoaFisica();
            pessoa_fisica.setId(rs.getInt("id"));
            pessoa_fisica.setNome(rs.getString("nome"));
            pessoa_fisica.setCpf(rs.getString("cpf"));
        }
        rs.close();
        connection.close();
        return pessoa_fisica;
    }

    public ArrayList<PessoaFisica> listarTodos() throws SQLException {
        String sqlSelect = "SELECT * FROM pessoa_fisica;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        ResultSet rs = connection.prepareStatement(sqlSelect).executeQuery();
        ArrayList<PessoaFisica> vetPessoaFisica = new ArrayList();
        PessoaFisica pessoa_fisica = null;
        while (rs.next()) {

            pessoa_fisica = new PessoaFisica();
            pessoa_fisica.setId(rs.getInt("id"));
            pessoa_fisica.setNome(rs.getString("nome"));
            pessoa_fisica.setCpf(rs.getString("cpf"));

            vetPessoaFisica.add(pessoa_fisica);
        }
        rs.close();
        connection.close();
        return vetPessoaFisica;
    }

    public boolean inserir(PessoaFisica pessoa_fisica) throws SQLException {
        boolean resultado = false;
        String sql = "INSERT INTO pessoa_fisica(nome, cpf) VALUES (?, ?) RETURNING id;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa_fisica.getNome());
        preparedStatement.setString(2, pessoa_fisica.getCpf());
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            pessoa_fisica.setId(rs.getInt("id"));
            resultado = true;
        }
        preparedStatement.close();
        connection.close();
        return resultado;
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM pessoa_fisica WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }

    public boolean atualizar(PessoaFisica pessoa_fisica) throws SQLException {
        String sql = "UPDATE pessoa_fisica SET nome = ?, cpf = ? WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa_fisica.getNome());
        preparedStatement.setString(2, pessoa_fisica.getCpf());
        preparedStatement.setInt(3, pessoa_fisica.getId());
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }
}
