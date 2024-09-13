package kr.ac.mydog.member.dao;

import org.apache.ibatis.session.SqlSession;
import kr.ac.mydog.member.vo.MemberVO;
import java.util.HashMap;
import java.util.Map;

public class MemberDAO {
    private SqlSession session;

    public MemberDAO() {
        session = new MemberBatisConfig().getInstance();
    }

    public MemberVO selectMember(String id, String password) {
        Map<String, String> params = new HashMap<>();
        params.put("id", id);
        params.put("password", password);
        return session.selectOne("member.dao.MemberDAO.selectMember", params);
    }
    
    //쿠키 로그인
    public MemberVO findById(String id) {
    	return session.selectOne("member.dao.MemberDAO.findById", id);
    }

    public boolean insertMember(MemberVO member) {
        int result = session.insert("member.dao.MemberDAO.insertMember", member);
        session.commit();
        return result > 0;
    }

    public boolean checkUserId(String userId) {
        int count = session.selectOne("member.dao.MemberDAO.checkUserId", userId);
        return count == 0;
    }
    //장바구니에서 주문창으로 이동시 유저정보
    public MemberVO getMemberById(String userId) {
        return session.selectOne("member.dao.MemberDAO.selectMemberById", userId);
    }
}
