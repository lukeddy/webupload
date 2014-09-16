<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/taglibs.jsp"%>
<html>
  <head>
    <jsp:include page="common/header_content.jsp"/>
    <title>Data Support</title>
    <style>
        .dark {
            background-color: #0A0A0A;
            color: #CCC;
        }
        ul.big-number-container{
            list-style-type: none;
            display: block;
            max-width:1024px;
            margin:auto;
        }
        ul.big-number-container li{
            margin:20px 6px 20px 6px;
            display: inline-block;
            border:1px solid #C2C2C2;
            width:100%;
            height: 250px;
            position: relative;
        }
        ul.big-number-container li .header-box,ul.big-number-container li .number-box{
            position: absolute;
            height: 247px;
            margin:0px;
            padding:10px;
        }
        ul.big-number-container li .header-box{
            padding-top:86px;
            padding-bottom:10px;
            font-size: 60px;
            width:300px;
            left:0px;
            top:0px;
        }
        ul.big-number-container li .number-box{
           font-size:100px;
           padding-top:62px;
           left:300px;
           top:0px;
           width:655px;
        }
        ul.big-number-container .total-user-header{
           border-right: 6px solid #88BBC8;
        }
        ul.big-number-container .total-user-number{

        }
        ul.big-number-container .new-user-header{
           border-right:6px solid #ED8662;
        }
        ul.big-number-container .new-user-number{

        }
        ul.big-number-container .old-user-header{
           border-right: 6px solid #BEEB9F;
        }
        ul.big-number-container .old-user-number{

        }
    </style>
  </head>
  <body class="dark">
    <%--<jsp:include page="common/page_header.jsp"/>--%>
    <div class="wrapper">
        <div class="container">
            <div class="row text-center">
                <ul class="big-number-container">
                    <li>
                        <h3 class="header-box total-user-header text-center">总用户</h3>
                        <h2 class="number-box total-user-number text-center">1,102,562</h2>
                    </li>
                    <li>
                        <h3 class="header-box new-user-header text-center">新用户</h3>
                        <h2 class="number-box new-user-number text-center">810,613</h2>
                    </li>
                    <li>
                        <h3 class="header-box old-user-header text-center">老用户</h3>
                        <h2 class="number-box old-user-number text-center">291,953</h2>
                    </li>
                </ul>

            </div>
        </div>
    </div>
    <jsp:include page="common/page_footer.jsp"/>
  </body>
</html>
