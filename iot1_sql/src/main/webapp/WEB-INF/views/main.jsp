<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<title>Home</title>
<body>
	<div class="site-wrapper">
		<div class="site-wrapper-inner">
			<div class="cover-container">
				<div class="masthead clearfix">
            		<div class="inner">
             			<nav>
                			<ul class="nav masthead-nav"></ul>
              			</nav>
            		</div>
          		</div>
			<div class="inner cover">
            	<h1 class="cover-heading">${userid}님 어서옵쇼.</h1>
            	<p class="lead">spring page</p>
            	<p class="lead"></p>
         	</div>
			<div class="mastfoot">
            	<div class="inner">
              		<p>Cover template for <a href="http://getbootstrap.com">Bootstrap</a>, by <a href="https://twitter.com/mdo">@mdo</a>.</p>
            	</div>
          	</div>
			</div>
		</div>
	</div>
</body>
<script>
$(document).ready(function(){
	$("input[type='button']").click(function(){
		var url = this.getAttribute("data-url");
		if(url){
			location.href = url;
		}
	})
	
})
</script>