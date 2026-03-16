/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Product {
    private int productID;
    private String productName;
    private String description;
    private float price;
    private String productType;
    private String imgURL;
    private String status;

    public Product() {
    }

    public Product(int productID, String productName, String description, float price, String productType, String imgURL, String status) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.productType = productType;
        this.imgURL = imgURL;
        this.status = status;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public boolean getStatus() {
        // Luôn kiểm tra null trước khi thao tác với String
        if (status == null) return false;

        // So sánh trực tiếp với chuỗi đích
        return status.equalsIgnoreCase("Còn hàng");
    }

    
    
}
