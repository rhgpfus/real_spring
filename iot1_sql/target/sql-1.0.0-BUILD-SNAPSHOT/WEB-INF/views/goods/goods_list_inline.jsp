<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<c:url var="cUrl" value="/goods/createone" />
<c:url var="rUrl" value="/goods/list" />
<c:url var="uUrl" value="/goods/updateone" />
<c:url var="dUrl" value="/goods/deleteone" />
<c:url var="eUrl" value="/goods/excel" />
<c:url var="vendorComboUrl" value="/vendor/combo" />
<title>Insert title here</title>
</head>
<body>

	<script>
	var grid;
	$(document).ready(function(){
		if(!"${vendors}"){
			location.href="${vendorComboUrl}";
		}
	})
	
	</script>
	<br>
	<p />
	<br>
	<p />
	<br>
	<p />
	<kendo:grid title="그리드" name="grid" pageable="true" sortable="true" scrollable="true"
height="450" navigatable="true" dataBound="onDataBound">
		<kendo:grid-editable mode="inline"/>
		
		<kendo:grid-toolbar>
			<kendo:grid-toolbarItem name="create" text="생성"/>
			<kendo:grid-toolbarItem name="excel" text="엑셀저장"/>
			<kendo:grid-toolbarItem name="reload" text="리로드" />
		</kendo:grid-toolbar>
		<kendo:grid-excel fileName="상품정보.xlsx" allPages="true" filterable="true" proxyURL="${eUrl}" />

		<kendo:grid-columns>
			<kendo:grid-column title="제품번호" field="giNum" />
			<kendo:grid-column title="제품이름" field="giName"/>
			<kendo:grid-column title="제품설명" field="giDesc"/>
			<kendo:grid-column title="회사번호" field="viNum">
            	<kendo:grid-column-values value="${vendors}"/>
			</kendo:grid-column>
			<kendo:grid-column title="생산일자" field="giCredat" format="{0:yyyy-MM-dd}"/>
			<kendo:grid-column title="생산시간" field="giCretim"/>
            <kendo:grid-column title="Command" >
            	<kendo:grid-column-command>
            		<kendo:grid-column-commandItem name="edit" text="수정"/>
            		<kendo:grid-column-commandItem name="destroy" text="삭제"/>
            	</kendo:grid-column-command>
            </kendo:grid-column>
		</kendo:grid-columns>
	
		<kendo:dataSource pageSize="20">
			<kendo:dataSource-transport>
				<kendo:dataSource-transport-read url="${rUrl}" dataType="json" type="POST" 
				contentType="application/json" />
				<kendo:dataSource-transport-create url="${cUrl}" dataType="json" type="POST" 
				contentType="application/json"/>
				<kendo:dataSource-transport-destroy url="${dUrl}" dataType="json" type="POST" 
				contentType="application/json" />
				<kendo:dataSource-transport-update url="${uUrl}" dataType="json" type="POST" 
				contentType="application/json" />
				<kendo:dataSource-transport-parameterMap>
                	<script>
                	function parameterMap(options,type) { 
               			var str = JSON.stringify(options);
               			return str;
                	}
                	</script>
                </kendo:dataSource-transport-parameterMap>
			</kendo:dataSource-transport>
			
			<kendo:dataSource-schema>
				<kendo:dataSource-schema-model id="giNum">
					<kendo:dataSource-schema-model-fields>
						<kendo:dataSource-schema-model-field name="giNum" type="number" editable="false"/>
						<kendo:dataSource-schema-model-field name="giName" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viNum" defaultValue="1" >
							<kendo:dataSource-schema-model-field-validation required="true" min="1"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giCredat" editable="true" type="date" >
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giCretim" editable="false">
						</kendo:dataSource-schema-model-field>
					</kendo:dataSource-schema-model-fields>
				</kendo:dataSource-schema-model>
			</kendo:dataSource-schema>
		</kendo:dataSource>
</kendo:grid>
<script>
var onDataBound = function(){
	var btn = $(".k-grid-reload");
	btn.click(function(){
		alert("이것이 리로드");
	})
}
</script>
</body>
</html>