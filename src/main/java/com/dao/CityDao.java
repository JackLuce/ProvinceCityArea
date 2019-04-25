package com.dao;

import com.entity.City;

import java.util.List;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 13:55
 * @Description:
 */
public interface CityDao {

    /**
     * 根据省id查找省下的市
     * @param fatherId
     * @return
     */
    public List<City> findCityByProvinceId(String fatherId);
}
