package kr.ac.mydog.review.vo;

public class ReviewVO {

    private int reviewNo;
    private String productCode;
    private String userId;
    private int rating;
    private String rComment;
    private String rRegDate;
    
    public ReviewVO() {
    	
    }

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getrComment() {
		return rComment;
	}

	public void setrComment(String rComment) {
		this.rComment = rComment;
	}

	public String getrRegDate() {
		return rRegDate;
	}

	public void setrRegDate(String rRegDate) {
		this.rRegDate = rRegDate;
	}

	@Override
	public String toString() {
		return "ReviewVO [reviewNo=" + reviewNo + ", productCode=" + productCode + ", userId=" + userId + ", rating="
				+ rating + ", rComment=" + rComment + ", rRegDate=" + rRegDate + "]";
	}
    
    
}
