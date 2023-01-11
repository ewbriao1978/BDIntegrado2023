/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import java.util.ArrayList;
import modelo.PessoaFisica;
import modelo.PessoaJuridica;
import persistencia.PessoaFisicaDAO;
import persistencia.PessoaJuridicaDAO;

/**
 *
 * @author iapereira
 */
public class Main {
    public static void main(String[] args) throws SQLException {
//        new PessoaFisicaFisicaDAO().inserir(new PessoaFisica("rafael", "01786868686"));
//        
//        ArrayList<PessoaFisica> vetPessoaFisica = new PessoaFisicaDAO().listarTodos();
//        for (int i = 0; i < vetPessoaFisica.size(); i++) {
//            PessoaFisica pf = vetPessoaFisica.get(i);
//            System.out.println(pf.toString());
//            
//        }


        new PessoaJuridicaDAO().inserir(new PessoaJuridica("snow ltda", "21975680000139"));
        
        ArrayList<PessoaJuridica> vetPessoaJuridica = new PessoaJuridicaDAO().listarTodos();
        for (int i = 0; i < vetPessoaJuridica.size(); i++) {
            PessoaJuridica pj = vetPessoaJuridica.get(i);
            System.out.println(pj.toString());
            
        }
      
        
    }
    
}
