<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
<jsp:include page="../common/header_content.jsp"/>
<style>
  body{
    background: #f3f3f4;
    font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  }

.box {
	position: relative;
	background: #ffffff;
	margin-bottom: 20px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	width: 100%;
	box-shadow: 0px 0 3px 0px rgba(0, 0, 0, 0.1);
}
.box .box-footer {
	border-top: 1px solid #f4f4f4;
	-webkit-border-top-left-radius: 0;
	-webkit-border-top-right-radius: 0;
	-webkit-border-bottom-right-radius: 3px;
	-webkit-border-bottom-left-radius: 3px;
	-moz-border-radius-topleft: 0;
	-moz-border-radius-topright: 0;
	-moz-border-radius-bottomright: 3px;
	-moz-border-radius-bottomleft: 3px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
	border-bottom-right-radius: 3px;
	border-bottom-left-radius: 3px;
	padding: 10px;
	background-color: #ffffff;
}
.error-template {
	padding: 40px 15px 5px 15px;
	text-align: center;
	width: 500px!important;
	margin: 0 auto;
}
.shake {
	-webkit-animation-name: shake;
	animation-name: shake;
}
.animated {
	-webkit-animation-duration: 1s;
	animation-duration: 1s;
	-webkit-animation-fill-mode: both;
	animation-fill-mode: both;
}
.error-template h1 {
	font-size: 60px;
}
.error-template h2 {
	margin-bottom: 30px;
}
.btn.btn-primary:hover, .btn.btn-primary:active, .btn.btn-primary.hover {
	background-color: #1d364f;
}
.btn.btn-primary {
	background-color: #293c4e;
}
.error-actions .btn {
	margin-right: 20px;
}

</style>
</head>
<body>
<div class="container">
    <%
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        pageContext.setAttribute("statusCode", statusCode);

        String uri = (String) request.getAttribute("javax.servlet.error.request_uri");
        String queryString = request.getQueryString();
        String url = uri + (queryString == null || queryString.length() == 0 ? "" : "?" + queryString);
        pageContext.setAttribute("url", url);

        Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception");
        request.setAttribute("exception", exception);

    %>
    <c:if test="${statusCode==404}">
        <div class="row">
              <div class="col-md-12">
					<div class="box error-template animated shake">
						<i class="fa fa-rocket"></i>
						<h1>Oops!</h1>
						<h2>404 Not Found</h2>
						<div class="error-details alert alert-danger">
							Sorry, an error has occured, Requested page not found!<refresh><a href='${url}' class='btn btn-link'>Refresh to tray again</a></refresh>
						</div>
						<div class="box-footer">
						<div class="error-actions">
							<a href="javascript:window.top.location.href=${contextPath}/" class="btn btn-primary"><span class="glyphicon glyphicon-home"></span>Back to home </a>
							<a href="javascript:void(0);" class="btn btn-default"><span class="glyphicon glyphicon-envelope"></span> Contact Support </a>
						</div></div>
					</div>
			 </div>
       </div>
    </c:if>
    
    <c:if test="${statusCode!=404}">
	        <div class="row">
	              <div class="col-md-12">
						<div class="box error-template animated shake">
							<i class="fa fa-rocket"></i>
							<h1>Oops!</h1>
							<h2>Server Error</h2>
							<div class="error-details alert alert-danger">
								Sorry, an error has occured, please try again later or<refresh><a href='${url}' class='btn btn-link'> refresh to tray again</a></refresh>
							</div>
							<div class="box-footer">
							<div class="error-actions">
								<a href="javascript:window.top.location.href=${contextPath}/" class="btn btn-primary"><span class="glyphicon glyphicon-home"></span>Back to home </a>
								<a href="javascript:void(0);" class="btn btn-default"><span class="glyphicon glyphicon-envelope"></span> Contact Support </a>
							</div></div>
						</div>
				 </div>
	     </div>
         <c:if test="${not empty exception}">
            <%
                StringWriter stringWriter = new StringWriter();
                PrintWriter printWriter = new PrintWriter(stringWriter);
                exception.printStackTrace(printWriter);
                pageContext.setAttribute("stackTrace", stringWriter.toString());
            %>
            <%@include file="exceptionDetails.jsp"%>
        </c:if>
    </c:if>

</div>
</body>
</html>

