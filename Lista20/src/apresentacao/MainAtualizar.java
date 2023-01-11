/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import modelo.Pessoa;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainAtualizar {
    public static void main(String[] args) throws SQLException {
        Pessoa p = new PessoaDAO().obter(4);
        p.setNome("igor");
        new PessoaDAO().atualizar(p);
    }
    
}
