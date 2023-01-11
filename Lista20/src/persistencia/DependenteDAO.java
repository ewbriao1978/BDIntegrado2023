/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import modelo.Dependente;
import modelo.Dependente;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Pessoa;

/**
 *
 * @author iapereira
 */
public class DependenteDAO {

    public Dependente obter(int id) throws SQLException {
        String sqlSelect = "select pessoa.id as pessoa_id, pessoa.nome as pessoa_nome, pessoa.sobrenome as pessoa_sobrenome, dependente.id as dependente_id, dependente.nome as dependente_nome, dependente.sobrenome as dependente_sobrenome  from pessoa left join dependente on (pessoa.id = dependente.pessoa_id) where dependente.id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sqlSelect);
        preparedStatement.setInt(1, id);
        ResultSet rs = preparedStatement.executeQuery();
        Dependente dependente = null;
        Pessoa pessoa = null;
        if (rs.next()) {
            pessoa = new Pessoa();
            pessoa.setId(rs.getInt("pessoa_id"));
            pessoa.setNome(rs.getString("pessoa_nome"));
            pessoa.setSobrenome(rs.getString("pessoa_sobrenome"));
            dependente = new Dependente(rs.getInt("dependente_id"), rs.getString("dependente_nome"), rs.getString("dependente_sobrenome"));
            dependente.setPessoa(pessoa);
        }
        rs.close();
        connection.close();
        return dependente;
    }

    public ArrayList<Dependente> listarPorPessoa(Pessoa pessoa) throws SQLException {
        String sqlSelect = "SELECT * FROM dependente WHERE pessoa_id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();

        PreparedStatement preparedStatement = connection.prepareStatement(sqlSelect);
        preparedStatement.setInt(1, pessoa.getId());
        ResultSet rs = preparedStatement.executeQuery();
        ArrayList<Dependente> vetDependente = new ArrayList();
        Dependente dependente = null;
        while (rs.next()) {
            dependente = new Dependente();
            dependente.setId(rs.getInt("id"));
            dependente.setNome(rs.getString("nome"));
            dependente.setPessoa(pessoa);
            vetDependente.add(dependente);
        }
        rs.close();
        connection.close();
        return vetDependente;
    }

    public boolean inserir(Dependente dependente) throws SQLException {
        boolean resultado = false;
        String sql = "INSERT INTO dependente (nome, sobrenome, pessoa_id) VALUES (?, ?, ?) RETURNING id;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, dependente.getNome());
        preparedStatement.setString(2, dependente.getSobrenome());
        preparedStatement.setInt(3, dependente.getPessoa().getId());
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            dependente.setId(rs.getInt("id"));
            resultado = true;
        }
        preparedStatement.close();
        connection.close();
        return resultado;
    }

    public boolean atualizar(Dependente depedendente) throws SQLException {
        String sql = "UPDATE dependente SET nome = ?, sobrenome = ?, pessoa_id = ? WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, depedendente.getNome());
        preparedStatement.setString(2, depedendente.getSobrenome());
        preparedStatement.setInt(3, depedendente.getPessoa().getId());
        preparedStatement.setInt(4, depedendente.getId());
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM dependente WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }

}
