package kr.ac.mydog.cart.vo;

import java.util.Date;

public class CartVO {
    private int cartNo;
    private String userId;
    private String productCode;
    private int quantity;
    private Date cartRegDate;
    private int cartPrice;
    private String productName; // 추가
    private String productImage; // 추가

    public CartVO() { 
    }

    // getters and setters

    public int getCartNo() {
        return cartNo;
    }

    public void setCartNo(int cartNo) {
        this.cartNo = cartNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getCartRegDate() {
        return cartRegDate;
    }

    public void setCartRegDate(Date cartRegDate) {
        this.cartRegDate = cartRegDate;
    }

    public int getCartPrice() {
        return cartPrice;
    }

    public void setCartPrice(int cartPrice) {
        this.cartPrice = cartPrice;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    @Override
    public String toString() {
        return "CartVO [cartNo=" + cartNo + ", userId=" + userId + ", productCode=" + productCode + ", quantity="
                + quantity + ", cartRegDate=" + cartRegDate + ", cartPrice=" + cartPrice + ", productName=" + productName
                + ", productImage=" + productImage + "]";
    }
}
