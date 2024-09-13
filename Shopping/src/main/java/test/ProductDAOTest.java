package test;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;


import kr.ac.mydog.product.dao.ProductDAO;
import kr.ac.mydog.product.vo.ProductVO;

public class ProductDAOTest {

	
	private ProductDAO productDao = new ProductDAO();
	
	
	@Test
	public void 최근등록상품() throws Exception {
		List<ProductVO> product = productDao.mainRecAdd();
		
		assertNotNull(product);
	}
	
}
