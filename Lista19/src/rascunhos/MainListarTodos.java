/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package rascunhos;

import persistencia.ConexaoPostgreSQL;
import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;
import modelo.Pessoa;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainListarTodos {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {
        ArrayList<Pessoa> vetAutor = new PessoaDAO().listarTodos();
        for (int i = 0; i < vetAutor.size(); i++) {
            Pessoa a = vetAutor.get(i);
            System.out.println("---------------------");
            System.out.println("id:" + a.getId());
            System.out.println("nome:" + a.getNome());
            System.out.println("---------------------");

        }
    }
}
