<%--
  Created by IntelliJ IDEA.
  User: luominjie
  Date: 2019/4/26
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>百度地图</title>
    <%@include file="/common/head.jsp"%>
    <style type="text/css">
        html{height:100%}
        body{height:100%;margin:0px;padding:0px}
        #container{width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
        #up-map-div{
            width:75px;
            height:30px;
            top:30px;
            left:30px;
            position:absolute;
            z-index:9999;
            border:1px solid blue;
            background-color:#FFFF;
            opacity:0.5; filter:alpha(opacity=50);//半透明
        }
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=q68gYGu3UgYO4XSdQmkjeICD3T5CQFmM">
        //v2.0版本的引用方式：src="http://api.map.baidu.com/api?v=2.0&ak=您的密钥"
        //密钥：q68gYGu3UgYO4XSdQmkjeICD3T5CQFmM
    </script>
</head>
<body>
<div class="main">
    <div class="panel panel-default">
        <div class="panel-body">
            <div>
                <input id="up-map-div" style="color: red" type="button" value="当前位置" onclick="fixedPosition()">
            </div>
            <div id="search">
                <div class="form-group has-success col-md-1">
                </div>
                <div class="form-group has-success col-md-3">
                    <input type="text" id="start" placeholder="正在定位您的位置..."  class="form-control">
                </div>
                <div class="form-group has-success col-md-3">
                    <input type="text" id="end" placeholder="请选择终点" class="form-control" onchange="searchRoute()">
                </div>
                <div class="btn-group has-success col-md-1">
                    <button id="bus-search" class="form-control">公交</button>
                </div>
                <div class="btn-group has-success col-md-1">
                    <button id="driver-search" class="form-control">驾车</button>
                </div>
                <div class="btn-group has-success col-md-1">
                    <button id="walk-search" class="form-control">步行</button>
                </div>
            </div>
        </div>
        <%--<div class="panel-body">--%>
            <%--<div class="form-group has-warning col-md-3">--%>
                <%--<input type="text" id="ss" placeholder="正在定位您的位置..." style="border-bottom: 1px solid #DDD; " name="address" id="addressId" class="form-control">--%>
            <%--</div>--%>
        <%--</div>--%>
    </div>
</div>
<div id="container">
</div>
<script type="text/javascript">
    window.start_point = "";
    window.end_point = "";

    var map = new BMap.Map("container");
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
    //添加地图类型控件
    map.addControl(new BMap.MapTypeControl({
        mapTypes:[
            BMAP_NORMAL_MAP,
            BMAP_HYBRID_MAP
        ]}));
    map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    //IP定位
    function myFun(result){
        var cityName = result.name;
        map.setCenter(cityName);
        alert("当前定位城市:"+cityName);
    }
    var myCity = new BMap.LocalCity();
    myCity.get(myFun);
    function fixedPosition() {
        var myCity = new BMap.LocalCity();
        myCity.get(myFun);
    }

    /**
     * 定位搜索以及路线规划
     */
    var geoc = new BMap.Geocoder();
    var geolocation = new BMap.Geolocation();
    var geolocation = new BMap.Geolocation();
    geolocation.getCurrentPosition(function(r){
        if(this.getStatus() == BMAP_STATUS_SUCCESS){
            window.start_point = r.point.lng+","+r.point.lat;


            // map = new BMap.Map("allmap");   // 创建Map实例
            var ep = window.start_point.split(",");


            function addMapControl(){
                //向地图中添加缩放控件
                var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_ZOOM});
                map.addControl(ctrl_nav);

                //向地图中添加比例尺控件
                var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,offset: new BMap.Size(10, 5)});
                map.addControl(ctrl_sca);

            }
            map.centerAndZoom(new BMap.Point(ep[0],ep[1]), 13);
            map.enableScrollWheelZoom(true);       //启用滚轮放大缩小
            var local = new BMap.LocalSearch(map, {
                renderOptions:{map: map}
            });
            local.search("图书馆");

            setLocation(r.point);

            addMapControl();
        }else {
            $("#start").attr("placeholder","请输入您的当前位置")
            alert('无法定位到您的当前位置，导航失败，请手动输入您的当前位置！'+this.getStatus());
        }
    },{enableHighAccuracy: true});

    function setLocation(point){
        geoc.getLocation(point, function(rs){
            var addComp = rs.addressComponents;
            var result = addComp.province + addComp.city + addComp.district;
            $("#start").val(result);

            //设置定位图标
            var new_point = new BMap.Point(rs.point.lng,rs.point.lat);
            var myIcon = new BMap.Icon("http://localhost:8080/ProvinceCityArea/images/myload.png", new BMap.Size(30,30),{
                anchor:new BMap.Size(13,15),
                imageOffset:new BMap.Size(0,0)
            });
            var marker = new BMap.Marker(new_point,{icon:myIcon,isOpen:true});
            map.addOverlay(marker);
            var opts = {
                width : 40,     // 信息窗口宽度
                height: 18,     // 信息窗口高度
                title : "我的位置" , // 信息窗口标题
                isOpen: 1,
            }
            var infoWindow = new BMap.InfoWindow("地址 : "+$("#start").val(), opts);  // 创建信息窗口对象
            marker.addEventListener("click", function(){
                map.openInfoWindow(infoWindow,new_point); //开启信息窗口
            });
            //设置监听，点选地图设终点，规划路线
            map.addEventListener("click",
                function(e) {
                    window.end_point = e.point.lng +","+ e.point.lat;
                    var local = new BMap.LocalSearch(map, {
                        renderOptions:{map: map}
                    });
                    searchRoute();
                });
        });
    }


    var type="bus";
    $("#bus-search,#driver-search,#walk-search").click(function(){
        var id = $(this).attr("id");
        $(".button").css("background-color","#fff");
        $("#"+id).css("background-color","#95B7EE");
        type = "bus";
        alert(id);
        if(id == "bus-search"){
            type = "bus";
        }else if(id == "driver-search"){
            type = "driver";
        }else if(id == "walk-search"){
            type = "walk";
        }
        searchRoute();
    });

    //搜索路线
    function searchRoute(){
        if($("#end").val().length!=0){
            var end = $("#end").val();
            $("#end").val("");
        }else{
            var pe = window.end_point.split(",");
            var end = new BMap.Point(pe[0],pe[1]);
        }
        var ps = window.start_point.split(",");
        var start = new BMap.Point(ps[0], ps[1]);
        var starIcon = new BMap.Icon("http://localhost:8080/ProvinceCityArea/images/start.png", new BMap.Size(22, 32));
        var endIcon = new BMap.Icon("http://localhost:8080/ProvinceCityArea/images/end.png", new BMap.Size(22,32));
        if(type == "bus"){
            var transit = new BMap.TransitRoute(map, {renderOptions: {map: map, panel: "r-result", autoViewport: false}});
            transit.search(start, end);
            transit.setMarkersSetCallback(function(result){
                result[0].marker.setIcon(starIcon);
                result[1].marker.setIcon(endIcon);
            });
        }else if(type == "driver"){
            var driving = new BMap.DrivingRoute(map, {renderOptions: {map: map, panel: "r-result", autoViewport: false}});
            driving.search(start, end);
            driving.setMarkersSetCallback(function(result){
                result[0].marker.setIcon(starIcon);
                result[1].marker.setIcon(endIcon);
            });
        }else if(type == "walk"){
            var walking = new BMap.WalkingRoute(map, {renderOptions: {map: map, panel: "r-result", autoViewport: false}});
            walking.search(start, end);
            walking.setMarkersSetCallback(function(result){
                result[0].marker.setIcon(starIcon);
                result[1].marker.setIcon(endIcon);
            });
            //walking.search("天坛公园","故宫");
        }
    }
</script>
</body>
</html>
