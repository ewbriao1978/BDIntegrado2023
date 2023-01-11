/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import java.util.ArrayList;
import modelo.Dependente;
import modelo.Pessoa;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainObter {
    public static void main(String[] args) throws SQLException {
        Pessoa p = new PessoaDAO().obter(2);
        System.out.println("titular.....");
        System.out.println(p.getId());
        System.out.println(p.getNome());
        System.out.println(p.getSobrenome());
        System.out.println("Dependentes....");
        ArrayList<Dependente> vetDependente = p.getDependentes();
        for (int i = 0; i < vetDependente.size(); i++) {
            Dependente d = vetDependente.get(i);
            System.out.println(d.getNome());            
        }
    }
    
}
