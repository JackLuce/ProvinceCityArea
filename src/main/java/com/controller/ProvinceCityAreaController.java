package com.controller;

import com.entity.Area;
import com.entity.City;
import com.entity.Province;
import com.service.ProvinceCityAreaService;
import com.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 15:11
 * @Description:
 */
@Controller
@RequestMapping("/")
public class ProvinceCityAreaController {

    @Autowired
    private ProvinceCityAreaService service;

    /**
     * 获取所有省份
     * @param model
     * @return
     */
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String getAllProvince(Model model, HttpServletRequest request){
        List<Province> provinceList = service.findAllProvince();
        for (Province province: provinceList) {
            System.out.println("省---11111111---"+province);
        }
        model.addAttribute("provinceList",provinceList);
        return "index";
    }

    /**
     * 根据省id获取市
     * @param fatherId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getCityByProvinceId/{fatherId}",method = RequestMethod.GET)
    public JsonResult getCityByProvinceId(@PathVariable String fatherId){
        List<City> cityList = service.findCityByProvinceId(fatherId);
        if(cityList!=null){
            return new JsonResult(true,"success",cityList);
        }else {
            return new JsonResult(false,"fail",null);
        }
    }

    /**
     * 根据市id获取区县
     * @param fatherId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getAreaByCityId/{fatherId}",method = RequestMethod.GET)
    public JsonResult getAreaByCityId(@PathVariable String fatherId){
        List<Area> areaList = service.findAreaByCityId(fatherId);
        if(areaList!=null){
            return new JsonResult(true,"success",areaList);
        }
        return new JsonResult(false,"fail",null);
    }

}
