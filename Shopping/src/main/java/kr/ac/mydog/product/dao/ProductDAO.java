package kr.ac.mydog.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import kr.ac.mydog.product.vo.ProductVO;

public class ProductDAO {
	
	private SqlSession session;
	
	public ProductDAO() {
		session = new ProdouctBatisConfig().getInstance();
	}
	
	/**
	 * 최신 등록상품 10가지 
	 * @return  List형 객체 list
	 */
	public List<ProductVO> mainRecAdd() {
		
		try {
			List<ProductVO> list = session.selectList("product.dao.ProductDAO.mainRecentlyAdd");
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 상품 디테일 페이지
	 * @param productCode
	 * @return ProductVO형 객체 productVO
	 */
	
	public ProductVO proudctDetail(String productCode) {		
		ProductVO productVo = new ProductVO();	
		try {
			productVo = session.selectOne("product.dao.ProductDAO.productDetail", productCode);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return productVo;
	}
	
	/**
	 * 상품 디테일 페이지 상세이미지
	 * @param productCode
	 * @return ProductVO형 객체 productVO
	 */
	public ProductVO proudctDetailImg(String productCode) {		
		ProductVO productVo = new ProductVO();	
		try {
			productVo = session.selectOne("product.dao.ProductDAO.productDetailImg", productCode);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return productVo;
	}
	
	/**
	 * 카테고리 검색
	 * @param categoriCode
	 * @return
	 */
	public List<ProductVO> productCategories(String categoriCode) {
		
		try {
			List<ProductVO> list = session.selectList("product.dao.ProductDAO.categories", categoriCode);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;			
		}		
	}
	
	/**
	 *  상품추가
	 */
    public void insertProduct(ProductVO product) {
        try {
            session.insert("product.dao.ProductDAO.insertProduct", product);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        }
    }
    
    /**
     * 상품 이미지 추가
     */
    public void insertProductImage(ProductVO product) {
        try {
            session.insert("product.dao.ProductDAO.insertProductImage", product);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        }
    }
	
}
