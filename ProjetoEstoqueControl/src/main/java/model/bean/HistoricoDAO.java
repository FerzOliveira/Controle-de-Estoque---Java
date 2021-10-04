/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.bean;

import connection.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Aluno
 */
public class HistoricoDAO {
    int i;
    
    public void create(Historico p){
     try{   
        Connection con =  ConnectionFactory.getConnection();
        PreparedStatement stmt = null;
        
        stmt = con.prepareStatement("INSERT INTO historico (idProduto, operacao,quantidade,data) VALUES (?,?,?,?)");
        
        stmt.setInt(1,p.getIdProduto());
        stmt.setString(2,p.getOperacao());
        stmt.setInt(3,p.getQuantidade());    
        stmt.setString(4,p.getData());
        
        stmt.execute();
        
    }catch(SQLException ex){
        Logger.getLogger(HistoricoDAO.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public List<Historico> read(){
        Connection con =  ConnectionFactory.getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        List<Historico> historicos = new ArrayList<>();
        
        try {
            stmt = con.prepareStatement("select idProduto, SUM(quantidade) as soma from ( select idProduto, quantidade from historico WHERE operacao = \"Entrada\" union select idProduto, (quantidade * -1) from historico WHERE operacao = \"Saida\" )AS somar GROUP BY idProduto;");
            rs = stmt.executeQuery();
            
            while(rs.next()){
                
                Historico historico = new Historico();
                historico.setIdProduto(rs.getInt("idProduto"));
                historico.setSoma(rs.getInt("soma"));
                historicos.add(historico);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(HistoricoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            ConnectionFactory.closeConnection(con);
        }
        
        return historicos;
    }
    
    public static int selectPegaSaldo(String codigo){
     try{
        Connection con = ConnectionFactory.getConnection(); 
        PreparedStatement stmt = null;
    
      stmt = con.prepareStatement("SELECT (SELECT SUM(quantidade) FROM historico WHERE operacao = \"Entrada\" AND idProduto = "+codigo+") - (SELECT SUM(quantidade) FROM historico WHERE operacao = \"Saida\" AND idProduto = "+codigo+") ");
      
      
      // trabalhar aqui
      
      ResultSet result =  stmt.executeQuery();
       
       
        result.next();
        return result.getInt(1);
       
    
        }
        catch(SQLException ex){
        Logger.getLogger(HistoricoDAO.class.getName()).log(Level.SEVERE, null, ex);
        
    }
    return 0;
    
    }
    
}
