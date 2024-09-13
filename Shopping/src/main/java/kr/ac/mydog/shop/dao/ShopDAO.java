package kr.ac.mydog.shop.dao;

import org.apache.ibatis.session.SqlSession;

import kr.ac.mydog.member.dao.MemberBatisConfig;

public class ShopDAO {
	
	private SqlSession session;
	
	public ShopDAO() {
		session = new MemberBatisConfig().getInstance();
	}
	
	
}
