/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import data.ProductDAO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class Cart {
    private List<OrderDetails> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public Cart(List<OrderDetails> items) {
        this.items = items;
    }

    public List<OrderDetails> getItems() {
        return items;
    }

    public void setItems(List<OrderDetails> items) {
        this.items = items;
    }
    
    private OrderDetails getItemById(int id) {
        for (OrderDetails i : items) {
            if (i.getProduct().getProductID() == id) return i;
        }
        return null;
    }
    
    public double getTotalAmount(){
        double sum = 0 ;
        if (this.items!= null){
            for (OrderDetails orderDetails: items){
                sum+=orderDetails.getAmount();
            }
        }
        return sum;
    }
}