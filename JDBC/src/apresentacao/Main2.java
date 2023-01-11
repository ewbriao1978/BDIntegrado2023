/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package apresentacao;

import java.sql.*;
import java.util.Scanner;
import javax.swing.JOptionPane;

/**
 *
 * @author iapereira
 */
public class Main2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {
        ConexaoPostgreSQL conexaoPostgreSQL = new ConexaoPostgreSQL();
//        Scanner entrada = new Scanner(System.in);
//        System.out.println("Insira o nome do novo aluno:");
        String nome = JOptionPane.showInputDialog(null, "Digite o nome:", "Igor corporation", JOptionPane.INFORMATION_MESSAGE);
        String sql = "INSERT INTO autor (nome) VALUES (?);";
        PreparedStatement preparedStatement = conexaoPostgreSQL.getConexao().prepareCall(sql);
        preparedStatement.setString(1, nome);
        int resultado = preparedStatement.executeUpdate();
        if (resultado == 1) {
            JOptionPane.showMessageDialog(null, "ok. sucesso", "Igor Corporation", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, "deu xabum", "Igor Corporation", JOptionPane.WARNING_MESSAGE);
        }

//        System.out.println("Insira o nome do novo:");
//        String nome = entrada.nextLine();
//        System.out.println("Insira o id do novo:");
//        int id = entrada.nextInt();
//        String sqlUpdate = "UPDATE autor SET nome = '"+nome+"' WHERE id = "+id;
//        conexaoPostgreSQL.getConexao().prepareStatement(sqlUpdate).execute();
//        System.out.println("Insira o id do novo:");
//        int id = entrada.nextInt();
//        String sqlDelete = "DELETE FROM autor WHERE id = "+id;
//        conexaoPostgreSQL.getConexao().prepareStatement(sqlDelete).execute();
//        String sqlSelect = "SELECT * FROM autor;";
//        ResultSet rs = conexaoPostgreSQL.getConexao().prepareStatement(sqlSelect).executeQuery();
//        while (rs.next()) {
//            System.out.println("---------------------");
//            System.out.println("id:" + rs.getInt("id"));
//            System.out.println("nome:" + rs.getString("nome"));
//            System.out.println("---------------------");
//        }
    }
}
