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
public class ProdutoDAO {
    
    public void create(Produto p){
     try{   
        Connection con =  ConnectionFactory.getConnection();
        PreparedStatement stmt = null;
        
        stmt = con.prepareStatement("INSERT INTO produto (codProduto, descricaoProduto,precoProduto,idMarca,idCor) VALUES (?,?,?,?,?)");
        
        stmt.setInt(1,p.getCodProduto());
        stmt.setString(2,p.getDescricaoProduto());
        stmt.setDouble(3,p.getPrecoProduto());    
        stmt.setInt(4,p.getIdMarca());
        stmt.setInt(5,p.getIdCor());
        
        stmt.execute();
        
    }catch(SQLException ex){
        Logger.getLogger(ProdutoDAO.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
    public List<Produto> read(){
        Connection con =  ConnectionFactory.getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        List<Produto> produtos = new ArrayList<>();
        
        try {
            stmt = con.prepareStatement("Select * FROM produto");
            rs = stmt.executeQuery();
            
            while(rs.next()){
                
                Produto produto = new Produto();
                produto.setIdProduto(rs.getInt("idProduto"));
                produto.setCodProduto(rs.getInt("codProduto"));
                produto.setDescricaoProduto(rs.getString("descricaoProduto"));
                produto.setPrecoProduto(rs.getDouble("precoProduto"));
                produto.setIdMarca(rs.getInt("idMarca"));
                produto.setIdCor(rs.getInt("idCor"));
                produtos.add(produto);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProdutoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            ConnectionFactory.closeConnection(con);
        }
        
        return produtos;
    }
}
