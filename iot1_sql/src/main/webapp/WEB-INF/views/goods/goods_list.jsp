<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<c:url var="readUrl" value="/goods/list"/>
<c:url var="createUrl" value="/goods/create"/>
<c:url var="updateUrl" value="/goods/update" />
<c:url var="deleteUrl" value="/goods/delete" />
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
	<!-- 화면에 나오는 컬럼이름과 데이터값을 정의하는 부분 -->
	<kendo:grid title="그리드" name="grid" pageable="true" sortable="true"
		scrollable="true" height="450">
		<kendo:grid-editable mode="incell"/>
		<!-- text로 수정할수있게 바뀐다.  -->
		<kendo:grid-toolbar>
			<kendo:grid-toolbarItem name="create" text="생성 "/>
			<kendo:grid-toolbarItem name="save" text="저장 "/>
			
		</kendo:grid-toolbar>
		<kendo:grid-columns>
			<kendo:grid-column title="제품번호" field="giNum"/>
			<kendo:grid-column title="제품명" field="giName"/>
			<kendo:grid-column title="제품설명" field="giDesc"/>
			<kendo:grid-column title="회사번호" field="viNum"/>
			<kendo:grid-column title="생산일자" field="giDate" format="{0:yyyyMMdd}"/>
			<kendo:grid-column title="생산시간" field="giTime"/>
		</kendo:grid-columns>
		
		
		<!-- 데이터가 왔다갔다하는 부분을 정의해주는 부분 -->
		<kendo:dataSource pageSize="20" batch="true">
			<kendo:dataSource-transport>
				<kendo:dataSource-transport-read url="${readUrl}" dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-create url="${createUrl}" dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-update url="${updateUrl}" dataType="json" type="POST" contentType="application/json" />
                <kendo:dataSource-transport-destroy url="${deleteUrl}" dataType="json" type="POST" contentType="application/json" />
                <kendo:dataSource-transport-parameterMap>
                	<script>
                	function parameterMap(options,type) { 
                		if(type==="read"){
                			return JSON.stringify(options);
                		} else {
                			return JSON.stringify(options.models);
                		}
                	}
                	</script>
                </kendo:dataSource-transport-parameterMap>
			</kendo:dataSource-transport>
			
			
			
			<!-- 입력받는걸 정리하는 부분 -->
			<kendo:dataSource-schema>
				<kendo:dataSource-schema-model id="giNum"> <!-- 기본 키 -->
					<kendo:dataSource-schema-model-fields>
						<kendo:dataSource-schema-model-field name="giName" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giDesc" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viNum" type="number">
							<kendo:dataSource-schema-model-field-validation required="true" min="1"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giDate" editable="true" type="date" >
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giTime" editable="false">
						</kendo:dataSource-schema-model-field>
					</kendo:dataSource-schema-model-fields>
				</kendo:dataSource-schema-model>
			</kendo:dataSource-schema>
		</kendo:dataSource>
	</kendo:grid>
</body>
</html>