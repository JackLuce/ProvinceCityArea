package com.dao;

import com.entity.Area;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 14:31
 * @Description:
 */
@RunWith(SpringJUnit4ClassRunner.class)
//告诉junit spring配置文件
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class AreaDaoTest {

    @Autowired
    private AreaDao areaDao;
    @Test
    public void findAreaByCityId() {
        List<Area> areaList = areaDao.findAreaByCityId("110100");
        for (Area area:areaList) {
            System.out.println(area);
        }
    }
}