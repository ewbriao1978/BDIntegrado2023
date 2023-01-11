/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package rascunhos;

import persistencia.ConexaoPostgreSQL;
import java.sql.*;
import java.util.Scanner;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainExcluir {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {
        boolean resultado = new PessoaDAO().excluir(14);
        System.out.println((resultado == true) ? "deu certo" : "deu xabum");

    }
}
