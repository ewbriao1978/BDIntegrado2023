/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package rascunhos;

import java.sql.SQLException;
import modelo.Pessoa;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainUpdate {
    public static void main(String[] args) throws SQLException {
        Pessoa a = new PessoaDAO().obter(13);
        System.out.println(a.getNome());
        
        a.setNome("marcio josue ramos torres");
        
        new PessoaDAO().atualizar(a);
    }
    
}
