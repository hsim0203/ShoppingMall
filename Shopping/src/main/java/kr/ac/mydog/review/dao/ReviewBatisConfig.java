package kr.ac.mydog.review.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class ReviewBatisConfig {
    private SqlSessionFactory sqlSessionFactory;

    public ReviewBatisConfig() {
        try {
            String resource = "reviewbatis-config.xml";
            Reader reader = Resources.getResourceAsReader(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public SqlSession getInstance() {
        return sqlSessionFactory.openSession();
    }
}
