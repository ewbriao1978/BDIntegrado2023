/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import modelo.Endereco;
import modelo.Pessoa;

/**
 *
 * @author iapereira
 */
public class PessoaDAO {

    public Pessoa obter(int id) throws SQLException {
        Pessoa pessoa = null;
        Endereco endereco = null;
        String sqlSelect = "SELECT * FROM pessoa WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sqlSelect);
        preparedStatement.setInt(1, id);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            pessoa = new Pessoa();
            pessoa.setId(rs.getInt("id"));
            pessoa.setNome(rs.getString("nome"));
            pessoa.setSobrenome(rs.getString("sobrenome"));
            endereco = new Endereco();
            endereco.setBairro(rs.getString("bairro"));
            endereco.setComplemento(rs.getString("complemento"));
            endereco.setNumero(rs.getString("numero"));
            endereco.setRua(rs.getString("rua"));
            pessoa.setEndereco(endereco);
        }
        rs.close();
        connection.close();
        return pessoa;
    }

    public ArrayList<Pessoa> listarTodos() throws SQLException {
        String sqlSelect = "SELECT * FROM pessoa;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        ResultSet rs = connection.prepareStatement(sqlSelect).executeQuery();
        ArrayList<Pessoa> vetPessoa = new ArrayList();
        Pessoa pessoa = null;
        Endereco endereco = null;
        while (rs.next()) {

            pessoa = new Pessoa();
            pessoa.setId(rs.getInt("id"));
            pessoa.setNome(rs.getString("nome"));
            pessoa.setSobrenome(rs.getString("sobrenome"));
            endereco = new Endereco();
            endereco.setBairro(rs.getString("bairro"));
            endereco.setComplemento(rs.getString("complemento"));
            endereco.setNumero(rs.getString("numero"));
            endereco.setRua(rs.getString("rua"));
            pessoa.setEndereco(endereco);

            vetPessoa.add(pessoa);
        }
        rs.close();
        connection.close();
        return vetPessoa;
    }

    public boolean inserir(Pessoa pessoa) throws SQLException {
        boolean resultado = false;
        String sql = "INSERT INTO pessoa(nome, sobrenome, rua, complemento, bairro, numero) VALUES (?, ?, ?, ?, ?, ?) RETURNING id;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa.getNome());
        preparedStatement.setString(2, pessoa.getSobrenome());
        preparedStatement.setString(3, pessoa.getEndereco().getRua());
        preparedStatement.setString(4, pessoa.getEndereco().getComplemento());
        preparedStatement.setString(5, pessoa.getEndereco().getBairro());
        preparedStatement.setString(6, pessoa.getEndereco().getNumero());
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            pessoa.setId(rs.getInt("id"));
            resultado = true;
        }
        preparedStatement.close();
        connection.close();
        return resultado;
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM pessoa WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }

    public boolean atualizar(Pessoa pessoa) throws SQLException {
        String sql = "UPDATE pessoa SET nome = ?, sobrenome = ?, rua = ?, complemento = ?, bairro = ?, numero = ? WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa.getNome());
        preparedStatement.setString(2, pessoa.getSobrenome());
        preparedStatement.setString(3, pessoa.getEndereco().getRua());
        preparedStatement.setString(4, pessoa.getEndereco().getComplemento());
        preparedStatement.setString(5, pessoa.getEndereco().getBairro());
        preparedStatement.setString(6, pessoa.getEndereco().getNumero());
        preparedStatement.setInt(7, pessoa.getId());
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }
}
