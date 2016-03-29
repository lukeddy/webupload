<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags/alert" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="session"/>
<html>
<head>
    <meta charset="utf-8"/>
    <title>webuploader示例-V2</title>
    <link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/static/js/webuploader-0.1.5/webuploader.css"/>
    <link rel="stylesheet" href="${contextPath}/static/css/myuploader.css"/>
    <style>
        .uploaded-photo {
            display: inline-block;
            width: 50px;
            height: 50px;
            margin: 3px;
        }

        .copy-msg {
            font-size: 10px;
            font-weight: bold;
            display: inline-block;
            width: 66px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <!--自定义标记：消息提示-->
    <mytag:alert sucMsg="${suc_msg}" failMsg="${fail_msg}"/>
    <h3 class="text-center"><b>WebUploader上传示例[<a href="javascript:void(0);" data-value="zhankai"
                                                  id="btnToggleUploadBox">收起</a>]</b></h3>
    <div id="upload-container">
        <div class="row" style="border:1px dotted tomato;padding:20px;">
            <div id="upload_box" class="text-center">
                <div id="uploaderbox">
                    <div class="btns" id="webuploaddiv">
                        <div id="picker">点击选择图片</div>
                    </div>
                    <table style="max-height:160px;overflow-y: scroll;overflow-x: hidden;"
                           class="table table-striped text-center" id="thelist"></table>
                </div>
            </div>
            <span id="errormsg" style="margin-right:10px;color: red;font-weight:bold;"></span>
            <%--<button type="button" class="btn btn-default" id="uploadBtn">开始上传</button>--%>
        </div>
        <br/>
        <div class="row">
            <table class="table table-condensed" id="uploadedPhotoTable">
                <caption>上传图片回显区域</caption>
                <thead>
                <tr>
                    <th>地址</th>
                    <th>图片</th>
                    <th>拷贝地址</th>
                    <th>二维码</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${not empty uploadedImgList}">
                    <c:forEach items="${uploadedImgList}" var="imgURI">
                        <tr>
                            <td>${contextPath}${imgURI}</td>
                            <td><img src="${contextPath}${imgURI}" class="uploaded-photo"/></td>
                            <td>
                                <a href="javascript:void(0)" class="btn btn-success btn-copy-link"
                                   data-link="${contextPath}${imgURI}">
                                    <i class="glyphicon glyphicon-link"></i>点击拷贝地址
                                </a>
                                <span class="copy-msg"></span>
                            </td>
                            <td>
                                <a href="javascript:void(0);" class="btn btn-success btn-qrcode"  data-link="${contextPath}${imgURI}">
                                    <i class="glyphicon glyphicon-qrcode"></i>查看二维码
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="dialog-wrapper">
    <div class="modal fade" id="dialogQRcode">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><h3>扫描二维码看图片</h3></h4>
                </div>
                <div class="modal-body text-center">
                    <div class="thumbnail">
                        <p> <img id="previewImg"  style="display:inline-block;width:256px;height:256px;" src="" alt="预览大图"/>
                            <img id="qrimg"  style="display:inline-block;width:256px;height:256px;" src="http://qr.liantu.com/api.php?text=这里是二维码内容"/>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script src="${contextPath}/static/js/jquery-1.10.2.min.js"></script>
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="${contextPath}/static/js/webuploader-0.1.5/webuploader.min.js"></script>
<script src="${contextPath}/static/js/zeroclipboard-2.2.0/ZeroClipboard.min.js"></script>
<script src="${contextPath}/static/js/jquery.cookie.js"></script>
<script>
    //定义全局变量
    var BASE_URL = "${contextPath}",
            SERVER_UPLOAD_URL = "${contextPath}/doUploadPhoto",
            PARAM_NAME = "photoFile",
            PREVIEW_URL = "${contextPath}/preview",
            WEB_UPLOADER_PATH = "${contextPath}/static/js/webuploader-0.1.5",
            SWF_PATH = BASE_URL + "/static/js/webuploader-0.1.5/Uploader.swf",
            uploader,
            copyClient;

    //用来存放上传区域是展开还是隐藏的cookie名称
    var KEY_TOGGLE_BTN = "upload_area_showorhide_val";

    $(function () {
        //初始化上传组件
        initWebUploader(SWF_PATH, SERVER_UPLOAD_URL, PARAM_NAME);
        //初始化复制组件
        initZeroClipboard();

        //展开按钮事件
        //showOrHideBox();
        $('#btnToggleUploadBox').click(function () {
            var currDataValue = $(this).attr("data-value");
            if (currDataValue === "zhankai") {
                $.cookie(KEY_TOGGLE_BTN, "shouqi");
                showOrHideBox();
            }
            if (currDataValue === "shouqi") {
                $.cookie(KEY_TOGGLE_BTN, "zhankai");
                showOrHideBox();
            }
        });

        btnQrCodeBindEvent();
    });

    /**
     * 二维码按钮绑定事件
     * */
    function btnQrCodeBindEvent(){
        //查看二维码事件
        $('.btn-qrcode').on('click',function(){
            var currImgUrl=$(this).attr('data-link');
            console.log(currImgUrl);
            var qrcodeAPI="http://qr.liantu.com/api.php?text="+currImgUrl;
            $('#dialogQRcode').find('#previewImg').attr('src',currImgUrl);
            $('#dialogQRcode').find('#qrimg').attr('src',qrcodeAPI);
            $('#dialogQRcode').modal("show");
        });
    }

    /**
     *初始化上传组件
     */
    function initWebUploader(swf_url, server_upload_url, param_name) {
        if (!WebUploader.Uploader.support()) {
            alert('Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
            throw new Error('WebUploader does not support the browser you are using.');
        }

        uploader = WebUploader.create({
            auto: true,
            swf: swf_url,
            server: server_upload_url,
            pick: '#picker',
            resize: false,
            fileVal: param_name,
            fileNumLimit: 50,
            formData: null,
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            },
        });

        $("#picker .webuploader-pick").click(function () {
            $("#picker :file").click();
        });

        uploader.on('fileQueued', function (file) {
            var appendedHTML = '<tr id="photo-item' + file.id + '">';
            appendedHTML += '<td>' + file.name + '</td>';
            appendedHTML += '<td id="stateBox' + file.id + '">';
            appendedHTML += '<p class="state">等待上传...</p>';
            appendedHTML += '<p class="progress">';
            appendedHTML += '<span class="progress-bar"></span>';
            appendedHTML += '</p>';
            appendedHTML += '<span class="percentage"></span>%';
            appendedHTML += '</td>';
            appendedHTML += '</tr>';
            $('#thelist').append(appendedHTML);
        });

        uploader.on('uploadProgress', function (file, percentage) {
            var $photoItem = $('#photo-item' + file.id),
                    $percentBar = $photoItem.find('.progress .progress-bar'),
                    $percentage = $photoItem.find('.percentage');
            if (!$percentBar.length) {
                $percentBar = $('<div class="progress progress-striped active">' +
                        '<div class="progress-bar" role="progressbar" style="width: 0%"></div>' +
                        '</div>').appendTo($photoItem).find('.progress-bar');
            }
            $photoItem.find('p.state').text('正在上传...');
            $percentBar.css('width', percentage * 100 + '%');
            $percentage.html(percentage * 100);
        });
        uploader.on('uploadSuccess', function (file, response) {
            if (response.status) {
                console.log(response);
                //将服务器端返回图片地址放到已上传列表中
                var uploadedPhotoURL = BASE_URL + response.data;
                var html = '<tr>';
                html += '<td>' + uploadedPhotoURL + '</td>';
                html += '<td><img src="' + uploadedPhotoURL + '"  class="uploaded-photo"/></td>';
                html += ' <td>';
                html += ' <a href="javascript:void(0)" class="btn btn-success btn-copy-link"  data-link="' + uploadedPhotoURL + '">';
                html += '<i class="glyphicon glyphicon-link"></i>拷贝图片地址';
                html += '</a>';
                html += '<span class="copy-msg"></span>';
                html += '</td>';
                html +='<td>';
                html +='<a href="javascript:void(0);" class="btn btn-success btn-qrcode"  data-link="'+uploadedPhotoURL+'">';
                html +='<i class="glyphicon glyphicon-qrcode"></i>查看二维码';
                html +='</a>';
                html +='</td>';
                html += '</tr>';
                $('#uploadedPhotoTable').prepend(html);

                //移除已上传文件
                $('#thelist').find('#photo-item' + file.id).remove();
                //重新初始化拷贝组件
                initZeroClipboard();
                //重新绑定二维码按钮事件
                btnQrCodeBindEvent();
            } else {
                $("#errormsg").html(response.msg);
                $("#thelist").html("");
                uploader.reset();
            }
        });

        uploader.on('uploadError', function (file) {
            $('#' + file.id).find('p.state').text('上传出错了!');
        });

        uploader.on('uploadComplete', function (file) {
            $('#' + file.id).find('.progress').fadeOut();
        });

        //$("#uploadBtn").bind("click",function(){
        //    uploader.upload();
        //});
    }

    /**
     *初始化拷贝组件
     */
    function initZeroClipboard() {
        ZeroClipboard.config({swfPath: BASE_URL + "/static/js/zeroclipboard-2.2.0/ZeroClipboard.swf"});
        ZeroClipboard.destroy();
        copyClient = new ZeroClipboard($('.btn-copy-link'));
        copyClient.on("ready", function () {
            copyClient.on("copy", function (event) {
                //console.log(event.target);
                //alert("开始拷贝");
                $('.copy-msg').empty();
                copyClient.setData("text/plain", $(event.target).attr("data-link"));
            });
            copyClient.on("aftercopy", function (event) {
                //alert("拷贝完成");
                $(event.target).parent().find('.copy-msg').html("复制成功!");
            });
        });
        copyClient.on("error", function () {
            ZeroClipboard.destroy();
            $('.copy-msg').html("出错了，无法使用拷贝功能!");
        });
    }

    function showOrHideBox() {
        var currVal = $.cookie(KEY_TOGGLE_BTN);
        if (currVal === "shouqi") {
            $("#upload-container").hide();
            $('#btnToggleUploadBox').html("展开").attr("data-value", "shouqi");
        } else {
            $("#upload-container").show();
            $('#btnToggleUploadBox').html("收起").attr("data-value", "zhankai");
        }
    }
</script>