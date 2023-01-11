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
public class MainInserir {

    public static void main(String[] args) throws SQLException {
        Pessoa p = new Pessoa();
        p.setNome("marcos");
        p.setSobrenome("leivas otero");
        boolean resultado = new PessoaDAO().inserir(p);
        System.out.println("Deu certo?"+resultado);
        System.out.println("Qual id:"+p.getId());
       
    }

}
