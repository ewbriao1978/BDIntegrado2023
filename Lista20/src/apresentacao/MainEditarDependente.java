/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import modelo.Dependente;
import persistencia.DependenteDAO;

/**
 *
 * @author iapereira
 */
public class MainEditarDependente {

    public static void main(String[] args) throws SQLException {
        Dependente d = new DependenteDAO().obter(3);
        System.out.println("id:" + d.getId());
        System.out.println("nome:" + d.getNome());
        System.out.println("sobrenome:" + d.getSobrenome());
        System.out.println("dependente de quem:" + d.getPessoa().getNome());
        d.setNome("ciclano");
        new DependenteDAO().atualizar(d);

    }

}
