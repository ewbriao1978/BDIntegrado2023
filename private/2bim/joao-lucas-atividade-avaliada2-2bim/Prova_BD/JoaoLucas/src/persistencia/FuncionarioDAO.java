
package persistencia;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Funcionario;


public class FuncionarioDAO {

    public boolean inserir(Funcionario funcionario) throws SQLException {
        boolean resultado = false;
        String sql = "INSERT INTO funcionario (cpf, rg, nome, sexo, estado_civil, nacionalidade, telefone, endereco) VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING id;";

        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, funcionario.getCpf());
        preparedStatement.setString(2, funcionario.getRg());
        preparedStatement.setString(3, funcionario.getNome());
        preparedStatement.setString(4, funcionario.getSexo());
        preparedStatement.setString(5, funcionario.getEstadoCivil());
        preparedStatement.setString(6, funcionario.getNacionalidade());
        preparedStatement.setString(7, funcionario.getTelefone());
        preparedStatement.setString(8, funcionario.getEndereco());

        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            funcionario.setId(rs.getInt("id"));
            resultado = true;
        }
        preparedStatement.close();
        connection.close();
        return resultado;
    }
}
