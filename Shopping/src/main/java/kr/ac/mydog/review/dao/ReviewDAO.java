package kr.ac.mydog.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.ac.mydog.review.vo.ReviewVO;

public class ReviewDAO {
    private SqlSession session;

    public ReviewDAO() {
        session = new ReviewBatisConfig().getInstance();
    }

    public List<ReviewVO> selectReByPCode(String productCode) {
        return session.selectList("review.dao.ReviewDAO.selectReByPCode", productCode);
    }
}