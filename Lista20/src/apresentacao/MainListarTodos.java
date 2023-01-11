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
public class MainListarTodos {
    public static void main(String[] args) throws SQLException {
                  ArrayList<Pessoa> vetPessoa = new PessoaDAO().listarTodos();
           for (int i = 0; i < vetPessoa.size(); i++) {
               Pessoa x = vetPessoa.get(i);
               System.out.println("Id:"+x.getId());
               System.out.println("Nome:"+x.getNome());
               System.out.println("Sobrenome:"+x.getSobrenome());
               ArrayList<Dependente> vetDependente = x.getDependentes();
               for (int j = 0; j < vetDependente.size(); j++) {
                   Dependente d = vetDependente.get(j);
                   System.out.println("nome:"+d.getNome());
               }
               System.out.println("======================");
        }
    
    }
 
}
