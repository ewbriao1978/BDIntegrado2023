/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apresentacao;

import java.sql.SQLException;
import modelo.Autor;
import persistencia.AutorDAO;

/**
 *
 * @author iapereira
 */
public class MainUpdate {
    public static void main(String[] args) throws SQLException {
        Autor a = new AutorDAO().obter(13);
        System.out.println(a.getNome());
        
        a.setNome("marcio josue ramos torres");
        
        new AutorDAO().atualizar(a);
    }
    
}
