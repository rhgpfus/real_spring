<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page session="false" %>
<c:set var="dbTreeJsp" value="/WEB-INF/views/db/db_treeview.jsp" />
<c:set var="tableInfoJsp" value="/WEB-INF/views/db/table_info.jsp" />
<c:set var="tabJsp" value="/WEB-INF/views/db/tab.jsp" />
<!-- jsp를 바라볼땐  c:set으로 -->
<c:url var="tableInfoUrl" value="/db/table/info" />
<title>IOT SQL</title>
</head>
<script>
var treeview;

function onBound(){ 
	if(!treeview){
		treeview = $('#treeview').data('kendoTreeView');
	} 
	kendoConsole.log("onBound");
}
	
$(document).ready(function(){
	$("#query").keydown(function(e) {
		var keyCode = e.keyCode || e.which;
		if(keyCode==120){
			var sql;
			var sqls = "";
			if(e.ctrlKey && keyCode==120 && e.shiftKey){
				sql = this.value;
				var cursor = this.selectionStart;
				var startSql = sql.substr(0,cursor);
				var startSap = startSql.lastIndexOf(";");
				startSql = startSql.substr(startSap+1);
				var endSql = sql.substr(cursor);
				var endSap = endSql.indexOf(";");
				if(endSap==-1) {
					endSap=sql.length;
				}
				endSql = endSql.substr(0,endSap);
				sql = startSql + endSql;
			}else if(e.ctrlKey && keyCode==120){
				sql = this.value.substr(this.selectionStart, this.selectionEnd - this.selectionStart);
			}else if(keyCode==120){
				sql = this.value;
			}
			if(sql){
				sql = sql.trim();
				sqls = sql.split(";");
				sqls = sqls.filter(function(e){return e}); 
				if(sqls.length==1){
					var au = new AjaxUtil("db/run/sql");
					var param = {};
					param["sql"] = sql;
					au.param = JSON.stringify(param);
					au.setCallbackSuccess(callbackSql);
					au.send();
					return;
				}else if(sqls.length>1){
					var au = new AjaxUtil("db/run/sqls");
					var param = {};
					param["sqls"] = sqls;
					au.param = JSON.stringify(param);
					au.setCallbackSuccess(callbackSql);
					au.send();
					return;
				}
			}
		}
	});
})

function callbackSql(result){
	if(!result.error){
		var key = result.key;
		var obj = result[key];
		var gridData = "";
		var types = obj.type;
		var rows = obj.row;
		var tabName = obj.tabName;
		
		try{
// 			$('#resultGrid').kendoGrid('destroy').empty();
			var tabStrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
			kendoConsole.log(tabStrip.contentElement(0));
		}catch(e){}
		
		
		for(var i=0,max=types.length;i<max; i++){
			var type = types[i];
			if(type=="select"){
				gridData = obj.list;
				
				var tabStrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
			    tabStrip.append(
			        [{
			            text: tabName
			        }]
			    );
				
				var gridParam = {
					dataSource    : {
				        data: gridData,
				        pageSize: 5
				      },
				      editable: false,
				      sortable: true,
				      pageable:true
				}
				$("#resultGrid").kendoGrid(gridParam);
				
				kendoConsole.log(type + " 찾은 행: " + gridData.length);
				
			}else{
				kendoConsole.log(type + "<br>" + "/* Affected rows: " + rows + " 찾은 행: " + gridData.length);
			}		
		}
	}else{
		kendoConsole.log(result.error);
	}
}
	

function treeSelect(){
	window.selectedNode = treeview.select();
	var data = treeview.dataItem(window.selectedNode);
	if(data.database && !data.hasChildren){
	   var au = new AjaxUtil("db/table/list");
	   var param = {};
	   param["database"] = data.database;
	   au.param = JSON.stringify(param);
	   au.setCallbackSuccess(callbackForTreeItem2);
	   au.send();
	}else if (data.tableName){
		var ki = new KendoItem(treeview, $("#tableInfoGrid"), "${tableInfoUrl}","tableName");
		ki.send();
	}
}

function callbackForTreeItem2(result){
	if(result.error){
		alert(result.error);
		return;
	}
	for(var i=0, max=result.tableList.length;i<max;i++){
		var table = result.tableList[i];
		treeview.append({
			tableName: table.tableName
        }, treeview.select());
	}
}

function callbackForTreeItem(result){
	if(result.error){
		alert(result.error);
		return;
	}
	for(var i=0, max=result.databaseList.length;i<max;i++){
		var database = result.databaseList[i];
		treeview.append({
			database: database.database
        }, treeview.select());
	}
	$("#btnConnect").text("접속해제");
}
function toolbarEvent(e){
	if($("#btnConnect").text()=="접속해제"){
		treeview.dataSource.read();
		$("#btnConnect").text("접속");
		return;
	}
	var data = treeview.dataItem(window.selectedNode);
	if(data && data.diNum){
		//$('#treeview>.k-group>.k-item>.k-group').remove();
		//treeview.dataSource.read();
		var au = new AjaxUtil("db/connecte");
		var param = {};
		param["diNum"] = data.diNum;
		au.param = JSON.stringify(param);
		au.setCallbackSuccess(callbackForTreeItem);
		au.send();
	}else{
		alert("접속하실 데이터베이스를 선택해주세요");
	}
}

</script>
<body>
<br><br><br>
<%@ include file="/WEB-INF/views/common/top_menu.jsp" %>
<kendo:splitter name="vertical" orientation="vertical">
    <kendo:splitter-panes>
        <kendo:splitter-pane id="top-pane" collapsible="false">
            <kendo:splitter-pane-content>
                <kendo:splitter name="horizontal" style="height: 100%; width: 100%;">
				    <kendo:splitter-panes>
				        <kendo:splitter-pane id="left-pane" collapsible="true" size="220px">
				            <kendo:splitter-pane-content >
				                <div class="pane-content">
				                	<c:import url="${dbTreeJsp}"/>
                                </div>
				            </kendo:splitter-pane-content>
				        </kendo:splitter-pane>
				        <kendo:splitter-pane id="center-pane" collapsible="false">
				            <kendo:splitter-pane-content>
								<kendo:splitter name="vertical1" orientation="vertical" style="height: 100%; width: 100%;">
				   					<kendo:splitter-panes>
		       							<kendo:splitter-pane id="top-pane" collapsible="false" >
							                <div class="pane-content">
						                		<c:import url="${tabJsp}"/>
			                                </div>
		       							</kendo:splitter-pane>
		       							<kendo:splitter-pane id="middle-pane" collapsible="true" >
							                
							                <kendo:tabStrip name="middle-tabStrip" >
							                		<div id="tabstrip">
														<div id="resultGrid" style="width:100%"></div>
													</div>
											</kendo:tabStrip>
		       							</kendo:splitter-pane>
	       							</kendo:splitter-panes>
       							</kendo:splitter>
				            </kendo:splitter-pane-content>
				        </kendo:splitter-pane>
				    </kendo:splitter-panes>
				</kendo:splitter>
            </kendo:splitter-pane-content>
        </kendo:splitter-pane>
        <kendo:splitter-pane id="middle-pane" collapsible="false" size="100px">
            <kendo:splitter-pane-content>
                <div class="pane-content" id="gridLog" style="width: 100%;">
	               <div class="console"></div>
                </div>
            </kendo:splitter-pane-content>
        </kendo:splitter-pane>
        <kendo:splitter-pane id="bottom-pane" collapsible="false" resizable="false" size="20px" scrollable="false">
            <kendo:splitter-pane-content>
	                <b>MySql Tool For Web</b>
            </kendo:splitter-pane-content>
        </kendo:splitter-pane>
    </kendo:splitter-panes>
</kendo:splitter>
</body>
<style>
	@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
	*{margin:0; padding:0; border:none;}
	#tabstrip-parent,
    #tabstrip {
      height: 100%;
      margin: 0;
      padding: 0;
      border-width: 0;
    }
	body{font-family: 'Jeju Gothic', serif;}
	nav{
		position:relative;
		width:100%;
		height:61px;
		border-bottom:0;
	}	
	nav.navbar{
		margin-bottom:0;		
	}
	.navbar-nav{
		float:right;	
	}	
	.container{
		width:100%;
		height:61px;
		background-color:#333;
		border-bottom:2px solid #3f9d8f;
	}		
	#navbar ul li:last-child{
		position:absolute;
		right:0;
	}
	#navbar ul li a{
		font-size:15px;
	}
	#navbar ul li a:hover{
		transition:0.3s;
		color:#3f9d8f;		
	}
	 
	.navbar-brand {
		background:url("${imgUrl}home_1.png")no-repeat center;
		text-indent:-9999px;
		width:50px;		
	}
	.navbar-brand:hover{
		background:url("${imgUrl}home_2.png")no-repeat center;				
	}
	p{
		width:0;
		height:0;
	}	
    #vertical {
    	position:relative;
    	width:100%;
        height: 893px;       
    }
    .k-splitbar{
    	 background-color:#3f9d8f;
    	 border-color:#3f9d8f;
    }
    #middle-pane { 
        color: #000; background-color: #fff; 
    }

    #bottom-pane { 
        color: #000; background-color: #fff; 
    }
    #left-pane{
    	width:233px;
    }
    #left-pane .pane-content {
    	width:100%; 
    	border:none;
    }
    #toolbar {
        width:100%;
        background-color:#3f9d8f;
    }
    .k-button.k-state-active:hover, .k-button:active:hover{
    	background-color:#42372e;
    	box-shadow:inset 0 0 3px 1px #3b2f2a;
    }
    .k-button:focus:active:not(.k-state-disabled):not([disabled]){
    	background-color:#42372e;
    	box-shadow:inset 0 0 3px 1px #3b2f2a;
    	
    }
    .k-state-selected.k-state-focused{
    	background-color:#3f9d8f;
    	box-shadow:inset 0 0 3px 1px #3d8b97;
    	-webkit-box-shadow:inset 0 0 3px 1px #3d8b97;
    	
    } 
    .k-state-selected{
    	background-color:#3f9d8f;
    	box-shadow:0 0 3px 1px  #3d8b97;
    	-webkit-box-shadow:0 0 3px 1px #3d8b97;
    }
    .k-header.k-state-focused{
    	background-color:#3d8b97;
    	color:#fff;
    }
    .k-header .k-sorted .k-state-focused{
    	border-color:#3d8b97;
    }    
    #btnConnect{
    	position:relative;
    	margin:6px 0 0 8px;
    } 
    
   
    .k-state-selected{
    	border-color:#3d8b97;
    }
    .user-image {
        margin: 0 .5em;
    }
    #example {
        height: 500px;
    }
    #example .box p {
        padding-bottom: 5px;
    }
    .k-grid-content{
    	overflow:auto;
    }
    #content .demo-section {
        margin: 0;
        padding: 10px;
        border-width: 0 0 1px 0;
    }
    #content .demo-section label {
        display: inline-block;
        width: 40px;
        text-align: right;
        line-height: 2.5em;
        vertical-align: middle;
    }   
    #middle-pane>.pane-content >h3{
    	margin:10px 0 0 10px;
    }    
    #middle-pane>.pane-content >p{
    	margin:10px 0 0 10px;
    }    
	#bottom-pane.k-pane{		
		background:#3f9d8f;			
		color:#fff;
		text-align:center;		
		border:none;
		font-size:12px;
		line-height:20px;
	}		
	.k-splitter .k-scrollable{
		overflow:hidden;
	}	
	#tabStrip > ul >li:last-child span{
		background:url("${imgUrl}pen.png")no-repeat center;
		text-indent:-9999px;
	}
	@media screen and (min-width: 768px){
		.navbar-nav{float:left;}
	}
	.k-tabstrip>.k-content{
		padding:0;
	}
	#tabStrip{
		background:#3f9d8f;		
		background-image:none,-webkit-gradient(linear,left top,left bottom,from(rgba(255,255,255,.6)),to(rgba(255,255,255,0)));
		background-image:none,linear-gradient(to bottom,rgba(255,255,255,.6) 0,rgba(255,255,255,0) 100%);
	}
	.k-grid-header th.k-header{
		background:#3f9d8f;		
	}
	
	#tabStrip-1{
		height:90%;
	}
	#tabStrip-2{
		height:90%;
	}
	.pane-content{
		height:100%;
	}
	.k-tabstrip-wrapper{
		height:100%;
	}
	.k-grid-content{
		overflow-x: auto;
   		overflow-y: scroll;
	}
	.k-tabstrip>.k-content{
		overflow:hidden;
	}
	.weather{
		position:relative;
		width:100%;
		height:100%;
	}
	#tableInfoGrid{
		height:100%;
	}
	#btnRun{
		position:absolute;
		left:5px;		
		top:7px;
	}
	#queryToolbar{
		position:relative;
	}
	#query{
		position:absolute;
		left:0;	
		margin:10px;		
		width:98%;
		height:80%;
	}
	
	
</style>
</html>