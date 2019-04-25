package com.dao;

import com.entity.City;
import com.entity.Province;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 14:40
 * @Description:
 */
@RunWith(SpringJUnit4ClassRunner.class)
//告诉junit spring配置文件
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class ProvinceDaoTest {

    @Autowired
    private ProvinceDao provinceDao;
    @Autowired
    private CityDao cityDao;
    @Test
    public void findAll() {
        List<Province> provinces = provinceDao.findAllProvince();
        for (Province province: provinces) {
            System.out.println("省------"+province);
            List<City> cityList = cityDao.findCityByProvinceId(province.getProvinceId());
            for (City city1: cityList) {
                System.out.println("市---------"+city1);
            }
        }
    }
}