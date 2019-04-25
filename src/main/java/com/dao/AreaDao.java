package com.dao;

import com.entity.Area;

import java.util.List;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 13:52
 * @Description:
 */
public interface AreaDao {

    /**
     * 根据市id查找对应的市下的区县
     * @param fatherId
     * @return
     */
    public List<Area> findAreaByCityId(String fatherId);
}
