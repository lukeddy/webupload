<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="taglibs.jsp"%>

<!-- 顶部导航开始 -->
<div class="navbar navbar-default navbar-fixed-top" role="navigation" style="height:60px;">
    <div class="container">
        <div class="logo-brand">
		   <a href="${contextPath}/main" class="logo"><img src="${contextPath}/images/logo.png" alt="Sentir logo"></a>
		</div>
        <div class="top-nav-content">
		<div class="navbar-collapse collapse">
		    <c:if test="${not empty app}">
		    <ul class="nav navbar-nav navbar-left">
		        <li><a class="page-title" href="javascript:;" style="text-decoration:none;cursor:text;">APP:${app.appname}</a></li>
		        <c:if test="${app.available!=1}">
                 <li><a href="javascript:void(0);" style="font-size: 20px;font-weight: bolder;margin-top: 4px;" data-href="${contextPath}/releaseApp" data-title="release" data-appname="${app.appname}" id="btnRelease" >Release Me</a></li>
                </c:if>
                <c:if test="${app.available==1}">
                 <li><a href="javascript:void(0);" style="font-size: 20px;font-weight: bolder;margin-top: 4px;" data-href="${contextPath}/unReleaseApp" data-title="unrelease" data-appname="${app.appname}" id="btnUnrelease">Unrelease Me</a></li>
                </c:if>
            </ul>
            </c:if>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="${contextPath}/main">Home</a></li>
                <li><a href="${contextPath}/chooseAppPage">Change App</a></li>
                <li><a href="${contextPath}/rechooseModule?appkey=${appkey}">Change Module</a></li>
                
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Hi,<b>${user.userName}</b> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="${contextPath}/pageChangePwd">Profile</a></li>
                        <li><a href="${contextPath}/logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
		</div>
    </div>
</div>
<!-- 顶部导航结束 -->

<!-- 对话框开始 -->
<div class="modal fade" id="dialogReleaseOrUnrelease">
     <div class="modal-dialog">
        <form role="form" id="dialogForm" name="dialogForm" method="post" action=""> 
         <div class="modal-content">
             <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal">&times;</button>
                 <h6 class="modal-title">Manage App</h6>
             </div>
             <div class="modal-body" id="modal-body">
			  <div id="release_box" class="row text-center">
			     <h4 id="releaseMsgBox"><b>Are you sure you want to <span id="txtTitle">release</span> app <b>'<span id="txtAppName"></span>'</b>?</h4>
			  </div>
			  </div>
			  <div class="modal-footer">
			    <fieldset id="delFormField">
			      <div class="form-group">
			         <button type="button" class="btn btn-default" id="btnYes">Yes</button>
			         <button type="button" class="btn btn-default" id="btnNo"  data-dismiss="modal">No</button>
			     </div>
			   </fieldset>      
            </div>
         </div>
         </form>
     </div>
 </div>
<!-- 对话框结束 -->
<script>
  $(function(){
    listenBtnRelease();
    listenBtnUnrelease();
    
    listenBtnYes();
  });
  
  /**
  *发布按钮事件
  **/
  function listenBtnRelease(){
    $('#btnRelease').click(function(){
      showDialog($(this));
    });
  }
  
  /**
  *不发布
  **/
  function listenBtnUnrelease(){
    $('#btnUnrelease').click(function(){
       showDialog($(this));
    });
  }
  /**
  *显示对话框
  **/
  function showDialog(e){
      $('#dialogReleaseOrUnrelease').modal('show');
      console.log(e);
      $('#dialogForm').attr('action',$(e).attr('data-href'));
      $('#txtTitle').html($(e).attr('data-title'));
      $('#txtAppName').html($(e).attr('data-appname'));
  }
  
  /**
  *对话框Yes按钮事件
  **/
  function listenBtnYes(){
    $('#btnYes').click(function(){
      dialogForm.submit();
    });
  }
</script>