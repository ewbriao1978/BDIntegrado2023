/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package apresentacao;

import java.sql.*;
import java.util.Scanner;

/**
 *
 * @author iapereira
 */
public class MainRoots {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {
        ConexaoPostgreSQL conexaoPostgreSQL = new ConexaoPostgreSQL();
        Scanner entrada = new Scanner(System.in);
        System.out.println("Insira o nome da nova tabela.");
        String nomeTable = entrada.nextLine();
        String sql  = "CREATE TABLE "+nomeTable+" (nome text);";
        conexaoPostgreSQL.getConexao().prepareStatement(sql).execute();

    }
}
