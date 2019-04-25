package com.dao;

import com.entity.Province;

import java.util.List;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 13:56
 * @Description:
 */
public interface ProvinceDao {

    /**
     * 查询所有省
     * @return
     */
    public List<Province> findAllProvince();
}
