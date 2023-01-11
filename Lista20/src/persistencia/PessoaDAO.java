/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Dependente;
import modelo.Pessoa;


/**
 *
 * @author iapereira
 */
public class PessoaDAO {

    public Pessoa obter(int id) throws SQLException {
        String sqlSelect = "select pessoa.id as pessoa_id, pessoa.nome as pessoa_nome, pessoa.sobrenome as pessoa_sobrenome, dependente.id as dependente_id, dependente.nome as dependente_nome, dependente.sobrenome as dependente_sobrenome  from pessoa left join dependente on (pessoa.id = dependente.pessoa_id) where pessoa.id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sqlSelect);
        preparedStatement.setInt(1, id);
        ResultSet rs = preparedStatement.executeQuery();
        Pessoa pessoa = new Pessoa();
        ArrayList<Dependente> vetDependente = new ArrayList();
        while (rs.next()) {
            pessoa.setId(rs.getInt("pessoa_id"));
            pessoa.setNome(rs.getString("pessoa_nome"));
            pessoa.setSobrenome(rs.getString("pessoa_sobrenome"));
            if (rs.getInt("dependente_id") > 0) {
                Dependente dependente = new Dependente(rs.getInt("dependente_id"), rs.getString("dependente_nome"), rs.getString("dependente_sobrenome"));
                dependente.setPessoa(pessoa);
                vetDependente.add(dependente);
            }
        }
        rs.close();
        connection.close();
        pessoa.setDependentes(vetDependente);
        return pessoa;
    }

    
    public ArrayList<Pessoa> listarTodos() throws SQLException {
        String sqlSelect = "SELECT * FROM pessoa;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        ResultSet rs = connection.prepareStatement(sqlSelect).executeQuery();
        ArrayList<Pessoa> vetPessoa = new ArrayList();
        Pessoa pessoa = null;
        while (rs.next()) {
            pessoa = new Pessoa();
            pessoa.setId(rs.getInt("id"));
            pessoa.setNome(rs.getString("nome"));
            pessoa.setSobrenome(rs.getString("sobrenome"));
            vetPessoa.add(pessoa);
        }
        rs.close();
        connection.close();
        
        for (int i = 0; i < vetPessoa.size(); i++) {
            vetPessoa.get(i).setDependentes(new DependenteDAO().listarPorPessoa(vetPessoa.get(i)));
        }
        
        return vetPessoa;
    }

    
    public boolean inserir(Pessoa pessoa) throws SQLException {
        boolean resultado = false;
        String sql = "INSERT INTO pessoa(nome, sobrenome) VALUES (?, ?) RETURNING id;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa.getNome());
        preparedStatement.setString(2, pessoa.getSobrenome());
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
        String sql = "UPDATE pessoa SET nome = ?, sobrenome = ? WHERE id = ?;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, pessoa.getNome());
        preparedStatement.setString(2, pessoa.getSobrenome());
        preparedStatement.setInt(3, pessoa.getId());
        int resultado = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return (resultado == 1);
    }
}
