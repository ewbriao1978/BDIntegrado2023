/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistencia;

import java.util.ArrayList;
import negocio.Pessoa;
import java.sql.*;

/**
 *
 * @author iapereira
 */
public class PessoaDAO {

    public ArrayList<Pessoa> listar() throws SQLException {
        ArrayList<Pessoa> vetPessoa = new ArrayList();
        String sql = "SELECT * FROM pessoa";
        Connection connection = new ConexaoPostgreSQL().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet rs = preparedStatement.executeQuery();
        Pessoa p = null;
        while (rs.next()) {
            p = new Pessoa();
            p.setId(rs.getInt("id"));
            p.setCpf(rs.getString("cpf"));
            p.setNome(rs.getString("nome"));
            vetPessoa.add(p);
        }
        preparedStatement.close();
        connection.close();
        return vetPessoa;
    }

    public void inserir(Pessoa p) throws SQLException {
        String sql = "INSERT INTO pessoa (cpf, nome) VALUES (?, ?);";
        Connection connection = new ConexaoPostgreSQL().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, p.getCpf());
        preparedStatement.setString(2, p.getNome());
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();
    }

    public void excluir(String cpf) throws SQLException {
        String sql = "DELETE FROM pessoa WHERE cpf = ?;";
        Connection connection = new ConexaoPostgreSQL().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, cpf);
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();
    }

    public void atualizar(Pessoa p) throws SQLException {
        String sql = "UPDATE pessoa SET nome = ? WHERE cpf = ?;";
        Connection connection = new ConexaoPostgreSQL().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, p.getNome());
        preparedStatement.setString(2, p.getCpf());
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();
    }
}