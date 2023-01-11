/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package rascunhos;

import java.sql.*;
import java.util.Scanner;
import modelo.Pessoa;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainInserir {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {
        System.out.println("Insira o nome do novo:");
        Scanner entrada = new Scanner(System.in);
        String nome = entrada.nextLine();
        boolean resultado = new PessoaDAO().inserir(new Pessoa(nome));
        System.out.println((resultado == true) ? "deu certo" : "deu xabum");
        
    }
}
