<%--
  Created by IntelliJ IDEA.
  User: luominjie
  Date: 2019/4/29
  Time: 9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
     <style type="text/css">
         body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
     </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=q68gYGu3UgYO4XSdQmkjeICD3T5CQFmM"></script>
    <title>定位</title>
</head>
<body>
<div id="allmap"></div>
</body>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(116.331398,39.897445);
    map.centerAndZoom(point,12);
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    //IP定位
    function myFun(result){
        var cityName = result.name;
        map.setCenter(cityName);
        alert("当前城市:"+cityName);
        map.setCurrentCity(cityName);
    }
    var myCity = new BMap.LocalCity();
    myCity.get(myFun);

    var geolocation = new BMap.Geolocation();
    // 开启SDK辅助定位
    geolocation.enableSDKLocation();
    geolocation.getCurrentPosition(function(r){
        if(this.getStatus() == BMAP_STATUS_SUCCESS){
            var mk = new BMap.Marker(r.point);
            map.addOverlay(mk);
            map.panTo(r.point);
            alert('您的位置：'+r.point.lng+','+r.point.lat);
            //以指定的经度与纬度创建一个坐标点
            var pt = new BMap.Point(r.point.lng,r.point.lat);
            //创建一个地理位置解析器
            var gc = new BMap.Geocoder();
            /**
             * 省市区街号
             */
            var pt = r.point;
            gc.getLocation(pt, function (rs) {//解析格式：城市，区县，街道,街道号
                console.log(rs);
                var addComp = rs.addressComponents;
                alert(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
            });
        } else {
           alert('failed'+this.getStatus());
         }
     },{enableHighAccuracy: true})
    //关于状态码
    //BMAP_STATUS_SUCCESS    检索成功。对应数值“0”。
    //BMAP_STATUS_CITY_LIST    城市列表。对应数值“1”。
    //BMAP_STATUS_UNKNOWN_LOCATION    位置结果未知。对应数值“2”。
    //BMAP_STATUS_UNKNOWN_ROUTE    导航结果未知。对应数值“3”。
    //BMAP_STATUS_INVALID_KEY    非法密钥。对应数值“4”。
    //BMAP_STATUS_INVALID_REQUEST    非法请求。对应数值“5”。
    //BMAP_STATUS_PERMISSION_DENIED    没有权限。对应数值“6”。(自 1.1 新增)
    //BMAP_STATUS_SERVICE_UNAVAILABLE    服务不可用。对应数值“7”。(自 1.1 新增)
    //BMAP_STATUS_TIMEOUT    超时。对应数值“8”。(自 1.1 新增)
</script>
</html>
