<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="common/taglibs.jsp" %>
<html>
<head>
<jsp:include page="common/header_content.jsp"/>
<!--引入webuploader CSS-->
<link rel="stylesheet" type="text/css" href="${contextPath}/js/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${contextPath}/css/upload.css">
<!--引入webuploader JS-->
<script type="text/javascript" src="${contextPath}/js/webuploader/webuploader.js"></script>
<title>File Upload</title>

</head>
<body>
    <div id="wrapper">
        <div id="container">
            <!--头部，相册选择和格式选择-->

            <div id="uploader">
                <div class="queueList">
                    <div id="dndArea" class="placeholder">
                        <div id="filePicker"></div>
                        <p>或将照片拖到这里，单次最多可选300张</p>
                    </div>
                </div>
                <div class="statusBar" style="display:none;">
                    <div class="progress">
                        <span class="text">0%</span>
                        <span class="percentage"></span>
                    </div><div class="info"></div>
                    <div class="btns">
                        <div id="filePicker2"></div><div class="uploadBtn">开始上传</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script>
var BASE_URL="${contextPath}";
var UPLOAD_URL="${contextPath}/doupload";
var PREVIEW_URL="${contextPath}/preview";
var WEB_UPLOADER_PATH="${contextPath}/js/webuploader"
</script>
<script type="text/javascript" src="${contextPath}/js/pages/upload.js"></script>