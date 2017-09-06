<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<title>Insert title here</title>
</head>
<body>
<script>
function callback(result){
	var result2 = "<table border='1'>";
	for(var i=0,max=result.length; i<max; i++){
		var vender = result[i];
		result2 += "<tr>"
		result2 += "<td>" + vender.viNum + "</td>";
		result2 += "<td>" + vender.viName + "</td>";
		result2 += "<td>" + vender.viDesc + "</td>";
		result2 += "<td>" + vender.viAddress + "</td>";
		result2 += "<td>" + vender.viPhone + "</td>";
		result2 += "<td>" + vender.viDate + "</td>";
		result2 += "<td>" + vender.viTime + "</td>";
		result2 += "</tr>"
	}
	result2 += "</table>"
	$("#div").html(result2);
}
$(document).ready(function(){
	$("input[type='button']").click(function(){
		var au = new AjaxUtil("vender/list");
		au.setCallbackSuccess(callback);
		au.send();
	})
})
</script>
<br><p/><br><p/><br><p/>
<form action="${rootPath}/vender/list" method="post">
<input type="button" value="전송"/> 
</form>
<div id="div"></div>
</body>
</html>