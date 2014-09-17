<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/taglibs.jsp"%>
<html>
  <head>
    <jsp:include page="common/header_content.jsp"/>
    <title>Data Support</title>
  </head>
  <body>
    <jsp:include page="common/page_header.jsp"/>
      <div class="wrapper">
          <div class="container">
              <!-- Nav tabs -->
              <ul class="nav nav-tabs" role="tablist" style="margin-top:100px;">
                  <li class="active"><a href="#normalUpload" role="tab" data-toggle="tab">普通上传</a></li>
                  <li><a href="#dialogUpload" role="tab" data-toggle="tab">弹出框上传</a></li>
                  <li><a href="#dragUpload" role="tab" data-toggle="tab">拖拽上传</a></li>
              </ul>
              <!-- Tab panes -->
              <div class="tab-content">
                  <div class="tab-pane active text-center" id="normalUpload">
                      <iframe src="${contextPath}/normal_upload" width="100%" height="100%" frameborder="0" scrolling="no">
                          您的浏览器不支持框架，请升级您的浏览器以便正常访问脚本之家。
                      </iframe>
                  </div>
                  <div class="tab-pane text-center" id="dialogUpload">
                      <iframe src="${contextPath}/dialog_upload" width="100%" height="100%" frameborder="0" scrolling="no">
                          您的浏览器不支持框架，请升级您的浏览器以便正常访问脚本之家。
                      </iframe>
                  </div>
                  <div class="tab-pane text-center" id="dragUpload">
                      <iframe src="${contextPath}/drag_upload" width="100%" height="100%" frameborder="0" scrolling="no">
                          您的浏览器不支持框架，请升级您的浏览器以便正常访问脚本之家。
                      </iframe>
                  </div>
              </div>
          </div>
      </div>
    <jsp:include page="common/page_footer.jsp"/>
  </body>
</html>
