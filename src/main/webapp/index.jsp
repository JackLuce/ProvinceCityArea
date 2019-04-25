<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 引入jstl --%>
<%@include file="/common/tag.jsp"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>省市区地址</title>
    <%@include file="/common/head.jsp"%>
    <script type="text/javascript">
        /*页面加载就开始执行*/
        $(document).ready(function () {//引入jquery js文件
            /**
             * 根据省id列出对应市
             */
            $("#provinceId").change(function () {
                var provinceId = $("#provinceId").val();
                $.get("getCityByProvinceId/"+provinceId,{},function(result){
                    if(result.status){
                        var options = "<option>选择城市</option>";//有选择城市这一项
                        // var options = "";//直接就是对应省下的市
                        $.each(result.obj,function(n,value){
                            options +="<option value='"+value.cityId+"'>"+value.city+"</option>";
                        });
                        $("#cityId").html('');
                        $("#cityId").append(options);
                    }
                });
                /*//获取select下拉框的值
                var provinceOptions = $("#provinceId option:selected");
                var firstAddress = provinceOptions.text();//option的text
                // alert(provinceOptions.val());//option的value
                $("#addressId").val(firstAddress);*/
                var firstAddress = $("#provinceId option:selected").text();
                $("#addressId").val(firstAddress);
            });
            /**
             * 根据市id列出对应县区
             */
            $("#cityId").change(function () {
                var cityId = $("#cityId").val();
                $.get("getAreaByCityId/"+cityId,{},function(result){
                    if(result.status){
                        var options = "<option>选择区域</option>";
                        // var options = "";
                        $.each(result.obj,function(n,value){
                            options +="<option value='"+value.areaId+"'>"+value.area+"</option>";
                        });
                        $("#areaId").html('');
                        $("#areaId").append(options);
                    }
                });
                var firstAddress = $("#provinceId option:selected").text();
                var secondAddress = $("#cityId option:selected").text();
                var address = firstAddress+secondAddress;
                $("#addressId").val(address);
            });

            $("#areaId").change(function () {
                getLastAddress();
            });
            $("#detailAddressId").change(function () {
                getLastAddress();
            });
            function getLastAddress() {
                var firstAddress = $("#provinceId option:selected").text();
                var secondAddress = $("#cityId option:selected").text();
                var thirdAddress = $("#areaId option:selected").text();
                var detailAddress = $("#detailAddressId").val();
                var address = firstAddress+secondAddress+thirdAddress+detailAddress;
                $("#addressId").val(address);
            }
        });
    </script>
</head>
<body>
<%-- 页面显示部分 --%>
<div class="container">
    <div class="panel panel-default">
        <div class="panel panel-heading text-center">
            <h2>选择省市区地址</h2>
        </div>
        <div class="panel-body">
            <form role="form" action="<%=request.getContextPath()%>/admin/schoolAdd" method="post">
                <thead>
                    <tr>
                    </tr>
                </thead>
                <tbody>
                    <div class="form-group has-success col-md-2">
                        <label for="provinceId">选择省份:</label>
                        <select data-placeholder="省份" id="provinceId" name="province" class="form-control" data-rel="chosen">
                            <option>选择省份</option>
                            <c:if test="${!empty provinceList}">
                                <c:forEach items="${provinceList}" var="PL">
                                    <option id="province" value="${PL.provinceId}">${PL.province}</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </div>
                    <div class="form-group has-success col-md-2">
                        <label for="cityId">选择城市:</label>
                        <select data-placeholder="城市" name="city" id="cityId" class="form-control" data-rel="chosen">
                            <option>选择城市</option>
                        </select>
                    </div>
                    <div class="form-group has-success col-md-2" >
                        <label for="areaId">选择区域:</label>
                        <select data-placeholder="区域" name="area" id="areaId" class="form-control" data-rel="chosen">
                            <option>选择区域</option>
                        </select>
                    </div>
                    <div class="form-group has-success col-md-2" >
                        <label for="detailAddressId">具体地址:</label>
                        <input type="text" data-placeholder="具体地址" name="detailAddress" id="detailAddressId" class="form-control">
                    </div>
                </tbody>
                <div class="form-group has-warning col-md-8">
                    <label for="addressId">您选择的地址:</label>
                    <input type="text" data-placeholder="您的地址" name="address" id="addressId" class="form-control">
                </div>
                <div class="form-group has-error col-md-1">
                    <label for="do"></label>
                    <input type="button" value="确定" id="do" class="form-control">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
