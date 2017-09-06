<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<c:url var="readUrl" value="/goods/list"/>
<title>Insert title here</title>
</head>
<body>
	<!-- 
<script>
function callback(result){
	var result2 = "<table border='1'>";
	for(var i=0,max=result.length; i<max; i++){
		var goods = result[i];
		result2 += "<tr>"
		result2 += "<td>" + goods.giNum + "</td>";
		result2 += "<td>" + goods.giName + "</td>";
		result2 += "<td>" + goods.giDesc + "</td>";
		result2 += "<td>" + goods.viNum + "</td>";
		result2 += "<td>" + goods.giDate + "</td>";
		result2 += "<td>" + goods.giTime + "</td>";
		result2 += "</tr>"
	}
	result2 += "</table>"
	$("#div").html(result2);
}
$(document).ready(function(){
	$("input[type='button']").click(function(){
		var au = new AjaxUtil("goods/list");
		au.setCallbackSuccess(callback);
		au.send();
	})
})
</script>

<form action="${rootPath}/goods/list" method="post">
<input type="button" value="전송"/> 
</form>
-->
	<br><p/><br><p/><br><p/>
	${readUrl}
	<kendo:grid title="그리드" name="grid" pageable="true" sortable="true"
		scrollable="true" height="450">
		<kendo:grid-columns>
			<kendo:grid-column title="제품번호" field="giNum"/>
			<kendo:grid-column title="제품명" field="giName"/>
			<kendo:grid-column title="제품설명" field="giDesc"/>
			<kendo:grid-column title="회사번호" field="viNum"/>
			<kendo:grid-column title="생산일자" field="giDate"/>
			<kendo:grid-column title="생산시간" field="giTime"/>
		</kendo:grid-columns>
		
		<kendo:dataSource pageSize="20" batch="true">
			<kendo:dataSource-transport>
				<kendo:dataSource-transport-read url="${readUrl}" dataType="json" type="POST" contentType="application/json" />
			</kendo:dataSource-transport>
		</kendo:dataSource>
	</kendo:grid>
</body>
</html>