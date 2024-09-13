package kr.ac.mydog.order.vo;

public class OrderVO {
    private String orderNo;
    private String userId;
    private String orderRegDate;
    private String orderAddress;
    private String paymentMethod;
    private double totalAmount;
    private String status;
    
    
    public OrderVO() {
    	
    }

    // Getter and Setter methods

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOrderRegDate() {
        return orderRegDate;
    }

    public void setOrderRegDate(String orderRegDate) {
        this.orderRegDate = orderRegDate;
    }

    public String getOrderAddress() {
        return orderAddress;
    }

    public void setOrderAddress(String orderAddress) {
        this.orderAddress = orderAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

	@Override
	public String toString() {
		return "OrderVO [orderNo=" + orderNo + ", userId=" + userId + ", orderRegDate=" + orderRegDate
				+ ", orderAddress=" + orderAddress + ", paymentMethod=" + paymentMethod + ", totalAmount=" + totalAmount
				+ ", status=" + status + "]";
	}
    
    
}

