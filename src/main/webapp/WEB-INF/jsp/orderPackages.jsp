<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style type="text/css">
	.songgray12{
		font-size: 12px;
		color: #666666;
		font-family: "宋体", "仿宋_GB2312", "黑体"
	; line-height: 24px
	; font-weight: bolder
	}
	.songgray24{
		font-size: 14px;
		color: #000000;
	; line-height: 24px
	}
	.songgray2412{
		font-size: 14px;
		color: #000000;
		background-color:lightblue;
		font-family: "宋体", "仿宋_GB2312", "黑体"
	; line-height: 24px
	; font-weight: bolder
	}
	.songgray12{
		font-size: 12px;
		color: #000000;
		font-family: "宋体", "仿宋_GB2312", "黑体"
	; line-height: 24px
	; font-weight: bolder
	}
	.ttable{ width: 80%; min-height: 25px; line-height: 25px; text-align: center; border-collapse: collapse; padding:2px;}
	.ttable1{ width: 40%; min-height: 25px; line-height: 25px; text-align: center; border-collapse: collapse; padding:2px;}
	.ttr { border:1px solid #0094ff; }
	.ttd { border:1px solid #0094ff; }
	.demo-input{padding-left: 10px; height: 38px; min-width: 262px; line-height: 38px; border: 1px solid #e6e6e6;  background-color: #fff;  border-radius: 2px;}
	.demo-input1{padding-left: 10px; height: 38px; min-width: 262px; line-height: 38px; border: 1px solid #e6e6e6;  background-color: #e6e6e6;  border-radius: 2px;}
	.demo-footer{padding: 50px 0; color: #999; font-size: 14px;}
	.demo-footer a{padding: 0 5px; color: #01AAED;}
</style>

<script src="<%=request.getContextPath() %>/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/laydate.js" ></script>
<script type="text/javascript">

    lay('#version').html('-v'+ laydate.v);

    //执行一个laydate实例
    laydate.render({
        elem: '#createTime' //指定元素
    });

    //执行一个laydate实例
    laydate.render({
        elem: '#endTime' //指定元素
    });


    var hdnContextPath = $("#hdnContextPath").val();
    //加载购买套餐记录信息
    function loadstu(){
        $.ajax({
            url:"<%=request.getContextPath() %>/alipay/orderPackagesByUserId",
            type:"POST",
            dataType:"json",
            success:function(data){

                var str=null;

                $.each(data.rows, function (index, item) {
                    str+="<tr class=\"songgray12 ttr\">";
                    str+="<td class=\"ttd\">"+item.orderPriceSystemId+"</td>";
                    str+="<td class=\"ttd\">"+item.name+"</td>";
                    str+="<td class=\"ttd\">"+item.total+"</td>";
                    str+="<td class=\"ttd\">"+item.quantityUsed+"</td>";
                    str+="<td class=\"ttd\">"+item.surplusQuentity+"</td>";
                    str+="<td class=\"ttd\">"+item.price+"</td>";
                    str+="<td class=\"ttd\">"+item.createTime+"</td>";
                    /*
                    str+="<td>"+data[i].name+"</td>";
                    str+="<td>"+data[i].sex+"</td>";
                    str+="<td>"+data[i].age+"</td>";
                    str+="<td>"+data[i].classid+"</td>";
                    str+="<td><a href=\"javascript:void(0);\" onclick='doDel("+item.id+",this)'>删除</a></td>";
                    */
                    str+="</tr>" ;


                    //循环获取数据
                    var id = item.id;
                   /*
                    var peopleid = item.peopleid;
                    var peoplename = item.peoplename;
                    var servicestatusid = item.servicestatusid;
                    var feespecialid = item.feespecialid;
                    var chargefee = item.chargefee;
                    var periodicalid = item.periodicalid;
                    var startdate = item.startdate;
                    var enddate = item.enddate;
                    var isfeeflagid = item.isfeeflagid;
                    var remark = item.remark;*/

                });

/*
                for(var i=0;i<data.length;i++){
                    str+="<tr>";
                    str+="<td>"+data[i].id+"</td>";

                    str+="<td>"+data[i].name+"</td>";
                    str+="<td>"+data[i].sex+"</td>";
                    str+="<td>"+data[i].age+"</td>";
                    str+="<td>"+data[i].classid+"</td>";
                    str+="<td><a href=\"javascript:void(0);\" onclick='doDel("+data[i].id+",this)'>删除</a></td>";
                    str+="</tr>";

                }*/
                $("#stuid tbody").empty();
                $("#stuid tbody").append(str);
            },
            error : function() {
                alert("数据访问错误");
            }

        });
    }

    function CreateTable(rowCount,cellCount)
    {
        //document.getElementById("typediv1").style.display="none";//隐藏
        document.getElementById("addOne").style.display="";//显示

        var table=$("<table border=\"0\" class=\"ttable\">");
        table.appendTo($("#createtable"));
        for(var i=0;i<rowCount;i++)
        {
            var tr=$("<tr class=\"songgray24 ttr\"></tr>");
            tr.appendTo(table);
            for(var j=0;j<cellCount;j++)
            {
                var td=$("<td class=\"ttd\">"+i*j+"</td>");
                if(j==cellCount-1){
                    td=$("<td class=\"ttd\"><a  href=\"javascript:void(0)\" style=\"text-decoration: none;\"  onclick=\"subgo1()\">新增</a></td>");
				}
                td.appendTo(tr);
            }
        }
        trend.appendTo(table);
        $("#createtable").append("</table>");
    }
    function CreateTableDiv(id,price,total,name,describe,createTimes,endTimes,type)
    {

        //document.getElementById("typediv1").style.display="none";//隐藏
        if(type==2){//取消
            document.getElementById("tianjia").style.display="";// 新增按钮 -- 显示
            document.getElementById("quxiao").style.display="none";//取消按钮 -- 隐藏
            document.getElementById("baocun").style.display="none";//保存按钮 -- 隐藏

            document.getElementById("addOne_id").value = "";
            document.getElementById("addOne_name").value = "";
            document.getElementById("addOne_describe").value = "";
            document.getElementById("addOne_price").value = "";
            document.getElementById("addOne_total").value = "";
            document.getElementById("createTime").value = "";
            document.getElementById("endTime").value = "";
            document.getElementById("addOne").style.display="none";//隐藏
        }
		else if(type==1){//新增
            document.getElementById("tianjia").style.display="none";// 新增按钮 -- 隐藏
            document.getElementById("quxiao").style.display="";//取消按钮 -- 显示
            document.getElementById("baocun").style.display="";//保存按钮 -- 显示


            document.getElementById("addOne").style.display="";//显示
            document.getElementById("addOne_id").value = "自动生成";
            document.getElementById("addOne_name").value = "";
            document.getElementById("addOne_describe").value = "";
            document.getElementById("addOne_price").value = "";
            document.getElementById("addOne_total").value = "";
            document.getElementById("createTime").value = "自动生成";
            document.getElementById("endTime").value = "";
		}
        else if(type==3){//保存
            document.getElementById("addOne").style.display="";//显示

            //alert($("#addOne_describe").val());

            var orderPriceSystem = {
                id:$("#addOne_id").val(),
                name:$("#addOne_name").val(),
                describe:$("#addOne_describe").val(),
                price:$("#addOne_price").val(),
                total:$("#addOne_total").val(),
                delet:"0",
                sort:4,
                createTimes:$("#createTime").val(),
                endTimes:$("#endTime").val()
            };
            $.ajax({
                url: $("#hdnContextPath").val() + "/alipay/addOrUpdateOrderPackages.action",
                type: "POST",
                data: JSON.stringify(orderPriceSystem),
                dataType: "json",
                contentType:"application/json",
                success: function(data) {
                    if(data.status == true && data.message == "OK") {
                        // 提交订单成功后, 进入购买页面
                        window.location.href = $("#hdnContextPath").val() + "/alipay/orderPackages.action";
                    } else {
                        console.log(JSON.stringify(data));
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // 状态码
                    console.log(XMLHttpRequest.status);
                    // 状态
                    console.log(XMLHttpRequest.readyState);
                    // 错误信息
                    console.log(textStatus);
                }
            });

        }else{//更新

            document.getElementById("tianjia").style.display="none";// 新增按钮 -- 隐藏
            document.getElementById("quxiao").style.display="";//取消按钮 -- 显示
            document.getElementById("baocun").style.display="";//保存按钮 -- 显示


            document.getElementById("addOne").style.display="";//显示
            document.getElementById("addOne_id").value = id;
            document.getElementById("addOne_name").value = name;
            document.getElementById("addOne_describe").value = describe;
            document.getElementById("addOne_price").value = price;
            document.getElementById("addOne_total").value = total;
            document.getElementById("createTime").value = createTimes;
            document.getElementById("endTime").value = endTimes;
		}


    }



    function createOrder() {
        /*   var rl =  hdnContextPath + "/alipay/createOrder.action";
           alert(rl);*/
        $.ajax({
            url: hdnContextPath + "/alipay/createOrder.action",
            type: "POST",
            data: {"productId": $("#productId").val(),"orderAmount":$("#price").val(), "buyCounts": $("#buyCounts").val()},
            dataType: "json",
            success: function(data) {
                //alert(data);
                //window.location.href = hdnContextPath + "/alipay/goPay.action?orderId=" + data.data;
                if(data.status == true && data.message == "OK") {
                    //alert("11data.status:"+data.status+";hdnContextPath:"+hdnContextPath);

                    //debugger;
                    // 提交订单成功后, 进入购买页面
                    window.location.href = hdnContextPath + "/alipay/goPay.action?orderId=" + data.data;
                } else {
                    //alert("22data.status:"+data.status+";hdnContextPath:"+hdnContextPath);
                    //alert(data.msg);
                    console.log(JSON.stringify(data));
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                // 状态码
                console.log(XMLHttpRequest.status);
                // 状态
                console.log(XMLHttpRequest.readyState);
                // 错误信息
                console.log(textStatus);
            }
        });
    }

</script>


<html>

    <head>
        
    </head>
    
    <body style="margin:0px;">
	<div align="center">
		<%@ include file="head.jsp"%>

		<br>
        <table border="0" class="ttable">

			<tr class="songgray24 ttr" style="height: 84px">
				<td colspan="8" align="center">价格体系管理</td>
			</tr>
        	<tr class="songgray2412 ttr">
        		<td class="ttd"> 产品编号 </td>
        		<td class="ttd"> 名称 </td>
				<td class="ttd" style="width:40%"> 描述说明 </td>
        		<td class="ttd"> 价格（元） </td>
				<td class="ttd"> 个数 </td>
				<td class="ttd"> 起始时间 </td>
				<td class="ttd"> 截止时间 </td>
        		<td class="ttd"> 操作 </td>
        	</tr>
			<c:forEach items="${pList }" var="p">
			<tr class="songgray24 ttr">
				<td class="ttd"> ${p.id } </td>
				<td class="ttd"> ${p.name } </td>
				<td class="ttd" align="left"> ${p.describe } </td>
				<td class="ttd"> ${p.price } </td>
				<td class="ttd"> ${p.total } </td>
				<td class="ttd"> ${p.createTimes } </td>
				<td class="ttd"> ${p.endTimes } </td>
				<td class="ttd">
					<c:choose>
						<c:when test="${p.name== '首次加入费'}">
							<a  href="javascript:void(0)" style="text-decoration: none;" onclick="CreateTableDiv('${p.id }',${p.price},${p.total},'${p.name }','${p.describe }','${p.createTimes }','${p.endTimes }',0)"><span style="size: 9px">修改</span></a>
						</c:when>
						<c:otherwise>
							<%--<a href="<%=request.getContextPath() %>/alipay/goConfirm.action?productId=${p.id }">购买</a>--%>
							<a  href="javascript:void(0)" style="text-decoration: none;" onclick="CreateTableDiv('${p.id }',${p.price},${p.total},'${p.name }','${p.describe }','${p.createTimes }','${p.endTimes }',0)"><span style="size: 9px">修改</span></a>
							<%--<a  href="javascript:void(0)" style="text-decoration: none;"  onclick="subgo1()">删除</a>--%>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>

		</c:forEach>
        </table>


		<table id="stuid" border="0" class="ttable">
			<thead>


			</thead>
			<tbody>

			</tbody>
		</table>


		<input type="hidden" id="hdnContextPath" name="hdnContextPath" value="<%=request.getContextPath() %>"/>

<%--
		<input type="button" value="添加表格" onClick="CreateTable(5,6)" >--%>
		<input id="tianjia" type="button" value="添加一条" onClick="CreateTableDiv(1,6,1,1,1,1,1,1)" >
		<input id="quxiao" style="display: none" type="button" value="取消" onClick="CreateTableDiv(1,6,1,1,1,1,1,2)" >
		<input id="baocun" style="display: none" type="button" value="保存" onClick="CreateTableDiv(1,6,1,1,1,1,1,3)" >

		<div id="createtable"></div>
		<div id="createrow"></div>

		<div id="addOne" style="display:none;">
			<table class="ttable1">
				<tr>
					<td align="right">编号：</td>
					<td align="left"><input type="text" class="demo-input1" style="width:100%";  id="addOne_id" disabled="disabled" style="background:#CCCCCC"/></td>
				</tr>
				<tr>
					<td align="right">名称：</td>
					<td align="left"><input type="text" class="demo-input" style="width:100%";  id="addOne_name" /></td>
				</tr>
				<tr>
					<td align="right">描述：</td>
					<td align="left"><textarea style="width: 100%; height: 100px"  id="addOne_describe" ></textarea></td>
				</tr>

				<tr>
				<td align="right">价格：</td>
				<td align="left"><input type="text" class="demo-input" style="width:100%";  id="addOne_price" /></td>
			    </tr>
				<tr>
					<td align="right">数量：</td>
					<td align="left"><input type="text" class="demo-input"  style="width:100%";  id="addOne_total" /></td>
				</tr>
				<tr>
					<td align="right">起始日期：</td>
					<td align="left"><input type="text" class="demo-input1" style="width:100%";  placeholder="请选择日期" id="createTime"  disabled="disabled" style="background:#CCCCCC"></td>
				</tr>
				<tr>
					<td align="right">截止日期：</td>
					<td align="left"><input type="text" class="demo-input" style="width:100%";  placeholder="请选择日期" id="endTime"></td>
				</tr>



			</table>
		</div>
	<br>
	<br>
	<br>
	<br>
	<%@ include file="foot.jsp"%>
	</div>
    </body>
    
</html>


<script type="text/javascript">
	$(document).ready(function() {
		var hdnContextPath = $("#hdnContextPath").val();
	});
</script>

