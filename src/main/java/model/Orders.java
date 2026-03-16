/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import data.ProductDAO;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class Orders {
    private int orderID;
    private Customer customer;
    private LocalDateTime orderDate;
    private String address;
    private String note;
    private int status;
    
    private List<OrderDetails> orderDetailsList;
    
    public Orders() {
        orderDetailsList = new ArrayList<>();
    }

    public Orders(int orderID, Customer customer, LocalDateTime orderDate, String address, String note, int status) {
        this.orderID = orderID;
        this.customer = customer;
        this.orderDate = orderDate;
        this.address = address;
        this.note = note;
        this.status = status;
    }

    public Orders(int orderID, Customer customer, LocalDateTime orderDate, String address, String note) {
        this.orderID = orderID;
        this.customer = customer;
        this.orderDate = orderDate;
        this.address = address;
        this.note = note;
    }

    public Orders(int orderID, Customer customer, LocalDateTime orderDate) {
        this.orderID = orderID;
        this.customer = customer;
        this.orderDate = orderDate;
    }

    public Orders(List<OrderDetails> orderDetailsList) {
        this.orderDetailsList = orderDetailsList;
    }

    public Orders(int orderID, Customer customer, LocalDateTime orderDate, String address, String note, List<OrderDetails> orderDetailsList) {
        this.orderID = orderID;
        this.customer = customer;
        this.orderDate = orderDate;
        this.address = address;
        this.note = note;
        this.orderDetailsList = orderDetailsList;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public List<OrderDetails> getOrderDetailsList() {
        return orderDetailsList;
    }

    public void setOrderDetailsList(List<OrderDetails> orderDetailsList) {
        this.orderDetailsList = orderDetailsList;
    }

    

    public double getTotalAmount(){
        double sum = 0 ;
        if (this.orderDetailsList!= null){
            for (OrderDetails orderDetails: orderDetailsList){
                sum+=orderDetails.getAmount();
            }
        }
        return sum;
    }
    public String getFormattedDate() {
    if (this.orderDate != null) {
        return this.orderDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
    return "";
}
}
