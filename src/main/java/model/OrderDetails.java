/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class OrderDetails {
    private Orders orders;
    private Product product;
    private int quantity;
    private float unitPrice;

    public OrderDetails() {
    }

    public OrderDetails(Orders orders, Product product, int quantity, float unitPrice) {
        this.orders = orders;
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public OrderDetails(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = this.product.getPrice();
    }

    public Orders getOrders() {
        return orders;
    }

    public void setOrders(Orders orders) {
        this.orders = orders;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    public double getAmount(){
        return this.quantity*this.unitPrice;
    }
}
