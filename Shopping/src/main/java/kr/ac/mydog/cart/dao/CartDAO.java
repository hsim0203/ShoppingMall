package kr.ac.mydog.cart.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import kr.ac.mydog.cart.vo.CartVO;

public class CartDAO {

    private SqlSession session;

    public CartDAO() {
        session = new CartBatisConfig().getInstance();
    }

    /**
     * 특정 사용자와 상품 코드로 장바구니 항목 조회
     * @param params 사용자 ID와 상품 코드
     * @return CartVO 객체
     */
    public CartVO selectCartProduct(Map<String, Object> params) {
        try {
            System.out.println("Selecting cart product with params: " + params); // 디버깅 메시지
            return session.selectOne("cart.dao.CartDAO.selectCartProduct", params);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 새로운 장바구니 항목 추가
     * @param cart 장바구니 항목
     */
    public void insertCart(CartVO cart) {
        try {
            System.out.println("Inserting cart: " + cart); // 디버깅 메시지
            session.insert("cart.dao.CartDAO.insertCart", cart);
            session.commit(); // 변경사항 커밋
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 기존 장바구니 항목 업데이트
     * @param cart 장바구니 항목
     */
    public void updateCart(CartVO cart) {
        try {
            System.out.println("Updating cart: " + cart); // 디버깅 메시지
            session.update("cart.dao.CartDAO.updateCart", cart);
            session.commit(); // 변경사항 커밋
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<CartVO> selectCartByUserId(String userId) {
    	try{ 		
    		return session.selectList("cart.dao.CartDAO.selectCartByUserId", userId);
    	}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    public void deleteCartProduct(String userId, String productCode) {
    	try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("productCode", productCode);
            session.delete("cart.dao.CartDAO.deleteCartProduct", params);
            session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

    public List<CartVO> getCartProductsByIds(String userId, String[] productIds) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("productIds", productIds);
        return session.selectList("cart.dao.CartDAO.selectCartProductsByIds", params);
    }
    
    public void deleteSelectedCartProducts(String userId, String[] productIds) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("productIds", productIds);
        session.delete("cart.dao.CartDAO.deleteSelectedCartProducts", params);
        session.commit();
    }

    public void clearCart(String userId) {
        session.delete("cart.dao.CartDAO.clearCart", userId);
        session.commit();
    }
}
