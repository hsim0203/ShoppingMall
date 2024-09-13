package kr.ac.mydog.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import kr.ac.mydog.order.vo.OrderVO;
import kr.ac.mydog.order.vo.OrderDetailVO;

public class OrderDAO {
    private SqlSession session;
    
    public OrderDAO() {
        session = new OrderBatisConfig().getInstance();
    }
    
    //주문번호 시퀀스를 생성하고 가져옴
    public String getNextOrderNo() {
        return session.selectOne("kr.ac.mydog.order.dao.OrderDAO.getNextOrderNo");
    }

    public void insertOrder(OrderVO order) {
        session.insert("kr.ac.mydog.order.dao.OrderDAO.insertOrder", order);
        session.commit();
    }

    public void insertOrderDetail(OrderDetailVO orderDetail) {
        session.insert("kr.ac.mydog.order.dao.OrderDAO.insertOrderDetail", orderDetail);
        session.commit();
    }

    public OrderVO getOrderByNo(String orderNo) {
        return session.selectOne("kr.ac.mydog.order.dao.OrderDAO.getOrderByNo", orderNo);
    }

    public List<OrderDetailVO> getOrderDetailsByOrderNo(String orderNo) {
        return session.selectList("kr.ac.mydog.order.dao.OrderDAO.getOrderDetailsByOrderNo", orderNo);
    }
    
    public void updateProductStock(Map<String, Object> params) {
        session.update("kr.ac.mydog.order.dao.OrderDAO.updateProductStock", params);
        session.commit();
    }
    
    public List<OrderVO> getOrderById(String userId) {
    	return session.selectList("kr.ac.mydog.order.dao.OrderDAO.getOrderById", userId);
    }
}
