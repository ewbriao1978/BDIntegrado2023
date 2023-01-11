package apresentacao;
import java.sql.SQLException;
import modelo.Funcionario;
import persistencia.FuncionarioDAO;

public class Inserir {

    public static void main(String[] args) throws SQLException {
        Funcionario f = new Funcionario();
        f.setCpf("01763917037");
        f.setRg("0176391703");
        f.setNome("igor igor");
        f.setSexo("M");
        f.setEstadoCivil("Solteiro");
        f.setNacionalidade("Brasileiro");
        f.setTelefone("(53) 99478-4575");
        f.setEndereco("Avenida Portugal Nº: 119");
        boolean resultado = new FuncionarioDAO().inserir(f);
        System.out.println(resultado);
    }
}