package com.service;

import com.dao.AreaDao;
import com.dao.CityDao;
import com.dao.ProvinceDao;
import com.entity.Area;
import com.entity.City;
import com.entity.Province;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 14:51
 * @Description:
 */
@Service
public class ProvinceCityAreaService {

    @Autowired
    private AreaDao areaDao;
    @Autowired
    private CityDao cityDao;
    @Autowired
    private ProvinceDao provinceDao;

    /**
     * 查找省
     */
    public List<Province> findAllProvince(){
        List<Province> allProvince = provinceDao.findAllProvince();
        return allProvince;
    }

    /**
     * 查找市
     */
    public List<City> findCityByProvinceId(String fatherId){
        return cityDao.findCityByProvinceId(fatherId);
    }

    /**
     * 查找区县
     */
    public List<Area> findAreaByCityId(String fatherId){
        return areaDao.findAreaByCityId(fatherId);
    }

}
