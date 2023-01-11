/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import modelo.Dependente;
import modelo.Pessoa;
import persistencia.DependenteDAO;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainAdicionarDependente {

    public static void main(String[] args) throws SQLException {
        Pessoa p = new PessoaDAO().obter(4);
        Dependente dependenteP = new Dependente("fulano", "leivas otero");
        dependenteP.setPessoa(p);
        p.getDependentes().add(dependenteP);
        new DependenteDAO().inserir(dependenteP);
    }

}
