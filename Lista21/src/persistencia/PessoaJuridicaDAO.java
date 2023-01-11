/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.PessoaJuridica;

/**
 *
 * @author iapereira
 */
public class PessoaJuridicaDAO {

    public PessoaJuridica obter(int id) throws SQLException {
        PessoaJuridica pessoa_juridica = null;
        String sqlSelect = "SELECT * FROM pessoa_juridica WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sqlSelect);
        preparedStatement.setInt(1, id);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            pessoa_juridica = new PessoaJuridica();
            pessoa_juridica.setId(rs.getInt("id"));
            pessoa_juridica.setNome(rs.getString("nome"));
            pessoa_juridica.setCnpj(rs.getString("cnpj"));
        }
        rs.close();
        connection.close();
        return pessoa_juridica;
    }

    public ArrayList<PessoaJuridica> listarTodos() throws SQLException {
        String sqlSelect = "SELECT * FROM pessoa_juridica;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        ResultSet rs = connection.prepareStatement(sqlSelect).executeQuery();
        ArrayList<PessoaJuridica> vetPessoaJuridica = new ArrayList();
        PessoaJuridica pessoa_juridica = null;
        while (rs.next()) {

            pessoa_juridica = new PessoaJuridica();
            pessoa_juridica.setId(rs.getInt("id"));
            pessoa_juridica.setNome(rs.getString("nome"));
            pessoa_juridica.setCnpj(rs.getString("cnpj"));

            vetPessoaJuridica.add(pessoa_juridica);
        }
        rs.close();
        connection.close();
        return vetPessoaJuridica;
    }

    public boolean inserir(PessoaJuridica pessoa_juridica) throws SQLException {
        boolean resultado = false;
        String sql = "INSERT INTO pessoa_juridica(nome, cnpj) VALUES (?, ?) RETURNING id;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa_juridica.getNome());
        preparedStatement.setString(2, pessoa_juridica.getCnpj());
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            pessoa_juridica.setId(rs.getInt("id"));
            resultado = true;
        }
        preparedStatement.close();
        connection.close();
        return resultado;
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM pessoa_juridica WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }

    public boolean atualizar(PessoaJuridica pessoa_juridica) throws SQLException {
        String sql = "UPDATE pessoa_juridica SET nome = ?, cnpj = ? WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa_juridica.getNome());
        preparedStatement.setString(2, pessoa_juridica.getCnpj());
        preparedStatement.setInt(3, pessoa_juridica.getId());
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }
}
