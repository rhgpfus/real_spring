<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<c:url var="g_r_Url" value="/goods/list"/>
<c:url var="g_c_Url" value="/goods/create"/>
<c:url var="g_u_Url" value="/goods/update"/>
<c:url var="g_d_Url" value="/goods/delete"/>
<c:url var="eUrl" value="/goods/excel"/>

<c:url var="v_r_Url" value="/vender/list"/>
<c:url var="v_c_Url" value="/vender/create"/>
<c:url var="v_u_Url" value="/vender/update"/>
<c:url var="v_d_Url" value="/vender/delete"/>

<c:url var="venderComboUrl" value="/vender/combo"/>

<title>Insert title here</title>
</head>
<body>
	<style>
		.k-link, tr {
             text-align : center;
         }
	</style>
	<script>
		var goodsGrid;
		$(document).ready(function(){
			if(!"${venders}"){
				location.href="${venderComboUrl}";
			}
			goodsGrid = $("#goodsGrid");
		})
		function onChange(arg) {
			//this는 무조건 변경없음
			//goodsGrid 타겟 그리드 즉 데이터가 변경이 되어야 하는 그리드
			//kendo의 name속성에 준 값으로 jquery를 사용해 그리드 객채를 만들어서
			//넘기면됨.
			goodsGrid = $("#goodsGrid");
			//"${readUrl}"은 타겟 그리드가 실제로 갔다와야 하는 컨트롤러의 매핑 값
			//"viNum"은 헤더에서의 키값
			var ki = new KendoItem(this, goodsGrid, "${g_r_Url}", "viNum");
			ki.send();
		}

		function onDataBound(arg) {
			console.log("Grid data bound");
			//컬럼정보가 다 들어간 후의 시점.
		}

		function onDataBinding(arg) {
			console.log("Grid data binding");
		}

		function onSorting(arg) {
			console.log("Sorting on field: " + arg.sort.field + ", direction:"
					+ (arg.sort.dir || "none"));
		}

		function onFiltering(arg) {
			console.log("Filter on " + kendo.stringify(arg.filter));
		}

		function onPaging(arg) {
			console.log("Paging to page index:" + arg.page);
		}

		function onGrouping(arg) {
			console.log("Group on " + kendo.stringify(arg.groups));
		}
	</script>

	<br><p/><br><p/><br><p/>
	${readUrl}
	
	<kendo:grid title="회사리스트" name="venderGrid" height="320px" pageable="true" sortable="true" selectable="true" filterable="true"
		groupable="true" change="onChange" dataBound="onDataBound" dataBinding="onDataBinding" sort="onSorting" filter="onFiltering"
		page="onPaging" group="onGrouping">
		<kendo:grid-editable mode="incell"/>
		<!-- text로 수정할수있게 바뀐다.  -->
		<kendo:grid-toolbar>
			<kendo:grid-toolbarItem name="create" text="생성 "/>
			<kendo:grid-toolbarItem name="save" text="저장 "/>
			<kendo:grid-toolbarItem name="excel" text="엑셀저장" />
		</kendo:grid-toolbar>
		
		<kendo:grid-excel fileName="회사정보.xlsx" allPages="true"
			filterable="true" proxyURL="${eUrl}" />
		
		<kendo:grid-columns>
			<kendo:grid-column title="회사번호" field="viNum"/>
			<kendo:grid-column title="회사명" field="viName"/>
			<kendo:grid-column title="회사설명" field="viDesc"/>
			<kendo:grid-column title="회사주소" field="viAddress"/>
			<kendo:grid-column title="회사전화번호" field="viPhone"/>
			<kendo:grid-column title="생산일자" field="viDate" format="{0:yyyy-MM-dd}"/>
			<kendo:grid-column title="생산시간" field="viTime" />
			<kendo:grid-column command="destroy" title="삭제" />
		</kendo:grid-columns>
		
		
		<!-- 데이터가 왔다갔다하는 부분을 정의해주는 부분 -->
		<kendo:dataSource pageSize="20" batch="true">
			<kendo:dataSource-transport>
				<!-- 실제 데이터를 로우식으로 그려주는 애 -->
				<kendo:dataSource-transport-read url="${v_r_Url}" dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-create url="${v_c_Url}" dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-update url="${v_u_Url}" dataType="json" type="POST" contentType="application/json" />
                <kendo:dataSource-transport-destroy url="${v_d_Url}" dataType="json" type="POST" contentType="application/json" />
                
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
			
			
			
			<!-- 입력받는걸 정리하는 부분 -->
			<kendo:dataSource-schema>
				<kendo:dataSource-schema-model id="viNum"> <!-- 기본 키 --> 
					<kendo:dataSource-schema-model-fields>
						<kendo:dataSource-schema-model-field name="viNum" type="number" editable="false"/>
						<kendo:dataSource-schema-model-field name="viName" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viDesc" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viAddress" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viPhone" />
						<kendo:dataSource-schema-model-field name="viDate" editable="true" type="date" >
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viTime" editable="false">
						</kendo:dataSource-schema-model-field>
					</kendo:dataSource-schema-model-fields>
				</kendo:dataSource-schema-model>
			</kendo:dataSource-schema>
		</kendo:dataSource>
	</kendo:grid>
	
	<!-- 화면에 나오는 컬럼이름과 데이터값을 정의하는 부분 -->
	<kendo:grid title="사원리스트" name="goodsGrid" pageable="true"
		sortable="true" scrollable="true" height="450" navigatable="true">
		<kendo:grid-editable mode="incell"/>
		<!-- text로 수정할수있게 바뀐다.  -->
		<kendo:grid-toolbar>
			<kendo:grid-toolbarItem name="create" text="생성 "/>
			<kendo:grid-toolbarItem name="save" text="저장 "/>
			<kendo:grid-toolbarItem name="excel" text="엑셀저장" />
		</kendo:grid-toolbar>
		<kendo:grid-excel fileName="사원정보.xlsx" allPages="true" filterable="true" proxyURL="${eUrl}" />
		<kendo:grid-columns>
			<kendo:grid-column title="사원번호" field="giNum"/>
			<kendo:grid-column title="사원이름" field="giName"/>
			<kendo:grid-column title="사원설명" field="giDesc"/>
			<kendo:grid-column title="회사" field="viNum">
				<kendo:grid-column-values value="${venders}"/>
			</kendo:grid-column>
			<kendo:grid-column title="입사일자" field="giDate" format="{0:yyyy-MM-dd}"/>
			<kendo:grid-column title="입사시간" field="giTime"/>
			<kendo:grid-column command="destroy" title="삭제" />
		</kendo:grid-columns>
		
		
		<!-- 데이터가 왔다갔다하는 부분을 정의해주는 부분 -->
		<kendo:dataSource pageSize="20" batch="true">
			<kendo:dataSource-transport>
				<kendo:dataSource-transport-read url="${g_r_Url}" dataType="json" type="POST" contentType="application/json" />
				<!-- 실제 데이터를 로우식으로 그려주는 애 -->
				<kendo:dataSource-transport-create url="${g_c_Url}" dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-update url="${g_u_Url}" dataType="json" type="POST" contentType="application/json" />
                <kendo:dataSource-transport-destroy url="${g_d_Url}" dataType="json" type="POST" contentType="application/json" />
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
			
			
			
			<!-- 입력받는걸 정리하는 부분 -->
			<kendo:dataSource-schema>
				<kendo:dataSource-schema-model id="giNum"> <!-- 기본 키 --> 
					<kendo:dataSource-schema-model-fields>
						<kendo:dataSource-schema-model-field name="giNum" type="number" editable="false"/>
						<kendo:dataSource-schema-model-field name="giName" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giDesc" type="string">
							<kendo:dataSource-schema-model-field-validation required="true"/>
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viNum" defaultValue="1">
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