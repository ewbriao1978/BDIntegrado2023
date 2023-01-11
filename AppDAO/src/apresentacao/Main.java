package apresentacao;

import java.sql.SQLException;
import java.util.ArrayList;
import negocio.Pessoa;
import persistencia.ConexaoPostgreSQL;
import persistencia.PessoaDAO;

/**
 *
 * @author iapereira
 */
public class Main {
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {

//        new PessoaDAO().inserir(new Pessoa("555.555.555-55", "Cibele"));;

        new PessoaDAO().atualizar(new Pessoa("111.111.111-11", "Rafael Betito"));

        ArrayList<Pessoa> vetPessoa = new PessoaDAO().listar();               
        for (int i = 0; i < vetPessoa.size(); i++) {
            Pessoa p = vetPessoa.get(i);
            System.out.println("Nome:"+p.getNome());
            
        }
    }
    
}
