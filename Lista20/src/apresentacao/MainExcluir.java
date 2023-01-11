/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class MainExcluir {
    public static void main(String[] args) throws SQLException {
        new PessoaDAO().excluir(1);

    }
    
}
