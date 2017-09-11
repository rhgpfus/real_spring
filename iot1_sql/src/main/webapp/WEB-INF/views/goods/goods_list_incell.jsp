<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<c:url var="readUrl" value="/goods/list"/>
<c:url var="createUrl" value="/goods/create"/>
<c:url var="updateUrl" value="/goods/update" />
<c:url var="deleteUrl" value="/goods/delete" />
<c:url var="eUrl" value="/goods/excel" />

<c:url var="venderComboUrl" value="/vender/combo" />
<title>Insert title here</title>
</head>
<body>

	<script>
	$(document).ready(function(){
		if(!"${venders}"){
			location.href="${venderComboUrl}";
		}
	})
	
	</script>
	<br>
	<p />
	<br>
	<p />
	<br>
	<p />
	<kendo:grid title="사원리스트" name="grid" pageable="true" sortable="true" scrollable="true"
height="450" navigatable="true">
		<kendo:grid-editable mode="incell"/>
		<kendo:grid-toolbar>
			<kendo:grid-toolbarItem name="create" text="생성"/>
			<kendo:grid-toolbarItem name="save" text="저장"/>
			<kendo:grid-toolbarItem name="excel" text="엑셀저장"/>
		</kendo:grid-toolbar>
		<kendo:grid-excel fileName="사원정보.xlsx" allPages="true" filterable="true" proxyURL="${eUrl}" />

		<kendo:grid-columns>
			<kendo:grid-column title="사원번호" field="giNum" />
			<kendo:grid-column title="사원이름" field="giName"/>
			<kendo:grid-column title="사원설명" field="giDesc"/>
			<kendo:grid-column title="회사번호" field="viNum">
            	<kendo:grid-column-values value="${venders}"/>
			</kendo:grid-column>
			<kendo:grid-column title="입사일자" field="giDate" format="{0:yyyy-MM-dd}"/>
			<kendo:grid-column title="입사시간" field="giTime"/>
            <kendo:grid-column command="destroy" title="삭제" />
		</kendo:grid-columns>
	
		<kendo:dataSource pageSize="20" batch="true">
			<kendo:dataSource-transport>
				<kendo:dataSource-transport-read url="${readUrl}" dataType="json" type="POST" contentType="application/json" />
				<!-- 실제 데이터를 로우식으로 그려주는 애 -->
				<kendo:dataSource-transport-create url="${createUrl}" dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-update url="${updateUrl}" dataType="json" type="POST" contentType="application/json" />
                <kendo:dataSource-transport-destroy url="${deleteUrl}" dataType="json" type="POST" contentType="application/json" />
                <kendo:dataSource-transport-parameterMap>
                	<script>
                	function parameterMap(options,type) { 
                		if(type==="read"){
                			return JSON.stringify(options);
                		} else {
                			var str = JSON.stringify(options.models);
                			return str;
                		}
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
						<kendo:dataSource-schema-model-field name="giDesc" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viNum" defaultValue="1" >
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