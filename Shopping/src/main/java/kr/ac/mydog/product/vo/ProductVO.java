package kr.ac.mydog.product.vo;

public class ProductVO {
	
	private String productCode;
	private String productName;
	private int productPrice;
	private int productStock;
	private String productRegDate;
	private String productDetail;
	private String categoriCode;
	private String categoriName;	
	private int imgNo;
	private String imgLink;
	private String imgType;

	
	public ProductVO() {
		
	}


	public String getProductCode() {
		return productCode;
	}


	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}


	public int getProductStock() {
		return productStock;
	}


	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}


	public String getProductRegDate() {
		return productRegDate;
	}


	public void setProductRegDate(String productRegDate) {
		this.productRegDate = productRegDate;
	}


	public String getProductDetail() {
		return productDetail;
	}


	public void setProductDetail(String productDetail) {
		this.productDetail = productDetail;
	}


	public String getCategoriCode() {
		return categoriCode;
	}


	public void setCategoriCode(String categoriCode) {
		this.categoriCode = categoriCode;
	}


	public String getCategoriName() {
		return categoriName;
	}


	public void setCategoriName(String categoriName) {
		this.categoriName = categoriName;
	}


	public int getImgNo() {
		return imgNo;
	}


	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}


	public String getImgLink() {
		return imgLink;
	}


	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
	}


	public String getImgType() {
		return imgType;
	}


	public void setImgType(String imgType) {
		this.imgType = imgType;
	}


	@Override
	public String toString() {
		return "ProductVO [productCode=" + productCode + ", productName=" + productName + ", productPrice="
				+ productPrice + ", productStock=" + productStock + ", productRegDate=" + productRegDate
				+ ", productDetail=" + productDetail + ", categoriCode=" + categoriCode + ", categoriName="
				+ categoriName + ", imgNo=" + imgNo + ", imgLink=" + imgLink + ", imgType=" + imgType + "]";
	}
	
	
}
