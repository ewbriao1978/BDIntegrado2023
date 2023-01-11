/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import java.util.ArrayList;
import modelo.Endereco;
import modelo.Pessoa;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class Main {

    public static void main(String[] args) throws SQLException {
//        Pessoa geraldo = new PessoaDAO().obter(1);
//        System.out.println(geraldo.getNome());
//        System.out.println(geraldo.getSobrenome());
//        System.out.println(geraldo.getEndereco().getRua());
//
//        Pessoa leandro = new Pessoa();
//        leandro.setNome("Leandro");
//        leandro.setSobrenome("Marone");
//        Endereco enderecoLeandro = new Endereco();
//        enderecoLeandro.setBairro("Parque Marinha");
//        enderecoLeandro.setComplemento("casa");
//        enderecoLeandro.setNumero("456");
//        enderecoLeandro.setRua("Bento Gonçalves");
//        leandro.setEndereco(enderecoLeandro);
//        boolean resultado = new PessoaDAO().inserir(leandro);
//        if (resultado) {
//            System.out.println("Id Leandro:"+leandro.getId());
//        }

//          new PessoaDAO().excluir(3);

           
        Pessoa geraldo = new PessoaDAO().obter(1);
        geraldo.setSobrenome("da Costa Santos Jr.");
        new PessoaDAO().atualizar(geraldo);
        
        
        System.out.println("Mostrando todos, até mesmo o Leandro recém foi adicionado...");

        ArrayList<Pessoa> vetPessoa = new PessoaDAO().listarTodos();
        for (int i = 0; i < vetPessoa.size(); i++) {
            Pessoa p = vetPessoa.get(i);
            System.out.println("id:"+p.getId());
            System.out.println(p.getNome() + " "+p.getSobrenome());
            System.out.println(p.getEndereco().getRua());
            System.out.println("===================");

        }

    }

}
