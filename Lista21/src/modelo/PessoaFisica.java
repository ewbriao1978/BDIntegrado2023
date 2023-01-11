/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author iapereira
 */
public class PessoaFisica extends Pessoa {
    private String cpf;
    
    public PessoaFisica(){
        super();
    }

    public PessoaFisica(String nome, String cpf) {
        super();
        super.nome = nome;
        this.cpf = cpf;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    
    @Override
    public String toString(){
        return super.id + ";" + this.cpf + ";" + this.nome;
    }
    
    
    
}
 