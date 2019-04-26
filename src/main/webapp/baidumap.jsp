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
    <style type="text/css">
        html{height:100%}
        body{height:100%;margin:0px;padding:0px}
        #container{height:100%}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=q68gYGu3UgYO4XSdQmkjeICD3T5CQFmM">
        //v2.0版本的引用方式：src="http://api.map.baidu.com/api?v=2.0&ak=您的密钥"
        //密钥：q68gYGu3UgYO4XSdQmkjeICD3T5CQFmM
    </script>
</head>

<body>
<div id="container"></div>
<script type="text/javascript">
    /*var map = new BMap.Map("container");
    // 创建地图实例
    var point = new BMap.Point(116.404, 39.915);
    // 创建点坐标
    map.centerAndZoom(point, 15);
    // 初始化地图，设置中心点坐标和地图级别*/
    var map = new BMap.Map("container");
    var point = new BMap.Point(116.331398,39.897445);
    map.centerAndZoom(point, 15);
    window.setTimeout(function(){
        map.panTo(new BMap.Point(116.331398,39.897445));
    }, 2000);
    //IP定位
    function myFun(result){
        var cityName = result.name;
        map.setCenter(cityName);
        alert("当前定位城市:"+cityName);
    }
    var myCity = new BMap.LocalCity();
    myCity.get(myFun);

</script>
</body>
</html>
