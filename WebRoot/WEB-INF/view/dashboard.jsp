<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="common/taglibs.jsp" %>
<html>
<head>
    <jsp:include page="common/header_content.jsp"/>
    <!--引入webuploader CSS-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/js/webuploader/webuploader.css">
    <!--引入webuploader JS-->
    <script type="text/javascript" src="${contextPath}/js/webuploader/webuploader.js"></script>
    <title>File Upload</title>
    <style>
        /*#picker{*/
            /*posotion:relative;*/
        /*}*/
    </style>
</head>
<body class="dark">
<div class="wrapper">
    <div class="row text-center" id="msgBox" style="font-size:16px;"></div>
    <div class="container text-center" style="margin-top:20px;">
        <div class="row page-header">
            使用<a class="btn" href="http://fex.baidu.com/webuploader/getting-started.html"   target="_blank">WEB uploader</a>上传文件
        </div>
        <div>
            <a href="javascript:void(0);" class="btn btn-primary" id="btnShowUploadDialog">Upload</a>
        </div>



        <div class="modal fade" id="dialogUpload">
            <div class="modal-dialog">
                <form role="form" id="delForm" name="delForm" method="post" action="">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h6 class="modal-title">
                                Upload File
                            </h6>
                        </div>
                        <div class="modal-body" id="modal-body">
                            <div id="upload_box" class="row text-center">
                                <div class="row">
                                    <div id="uploaderbox">
                                        <!--用来存放文件信息-->
                                        <table class="table table-striped text-center" id="thelist">
                                            <tr><td>文件名</td><td>状态</td></tr>
                                        </table>
                                        <div class="row text-center">
                                            <a href="javascript:void(0);" id="picker">浏览文件</a>
                                        </div>
                                        <div class="row" id="previewBox">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <fieldset id="delFormField">
                                <div class="row" id="uploadTest_box">
                                    <input type="text" name="uploadTest" id="uploadTest" disabled/>
                                    <p id="uploadTest_value"></p>
                                </div>
                                <div class="form-group">
                                    <a href="javascript:void(0);" id="uploadBtn" class="btn btn-default btn-block">开始上传</a>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var BASE_URL="${contextPath}";
    var UPLOAD_URL="${contextPath}/doupload";
    var fileSuffixs='gif,jpg,jpeg,bmp,png';

    $(function () {

        listenShowUploadBtn();

    });


    /**
     * 监听显示上传对话框按钮
     * */
    function listenShowUploadBtn(){
        $('#btnShowUploadDialog').bind('click',function(){
            $('#dialogUpload').modal('show');
            initWebUploader("uploadTest",fileSuffixs,'1','previewBox','预览图',false);
            //解决webuploader 在弹出框中浏览文件按钮不起作用的bug，一定要放在web uploader初始化之后
            $("#picker .webuploader-pick").click(function(){
                $("#picker :file").click();
            });
        });
    }


    /**
    *
    * @param uploadPrefix
    * @param fileSuffixs  example: 'gif,jpg,jpeg,bmp,png'
    * @param imageType
    * @param previewBoxID
    * @param previewTxt
    * @param isHtml
     */
    function initWebUploader(uploadPrefix,fileSuffixs,imageType,previewBoxID,previewTxt,isHtml){

        var uploader = WebUploader.create({
            // swf文件路径
            swf: BASE_URL + '/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: UPLOAD_URL,
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#picker',
            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false,
            fileVal:'thumbFile',
            formData:{imageType:imageType},
            accept:{
                extensions:fileSuffixs
            }

        });

        // 当有文件被添加进队列的时候
        uploader.on( 'fileQueued', function( file ) {
            $('#thelist').append(' <tr id="'+file.id+'"><td>'+file.name+'</td><td><p class="state">等待上传...</p><p class="progress"><span class="progress-bar"></span></p><span class="percentage"></span></td></tr>');
        });

        // 文件上传过程中创建进度条实时显示。
        uploader.on( 'uploadProgress', function( file, percentage ) {
            var $li = $( '#'+file.id ),
                $percentBar = $li.find('.progress .progress-bar'),
                $percentage=$li.find('.percentage');

            // 避免重复创建
            if ( !$percentBar.length ) {
                $percentBar = $('<div class="progress progress-striped active">' +
                        '<div class="progress-bar" role="progressbar" style="width: 0%">' +
                        '</div>' +
                        '</div>').appendTo( $li ).find('.progress-bar');
            }

            $li.find('p.state').text('上传中');

            $percentBar.css( 'width', percentage * 100 + '%' );
            $percentage.html(percentage * 100 + '%');
        });

        uploader.on( 'uploadSuccess', function( file,response) {
            $( '#'+file.id ).find('p.state').text('已上传');
            console.log(response);
            if (response != '') {
                //d就是服务器输出的内容。
                var obj=response;//$.parseJSON(response);
                $("#"+uploadPrefix).val(obj.data.imagePath);
                $("#"+uploadPrefix+"_value").empty().html(obj.data.imagePath);
                var previewID=uploadPrefix+"_preview";
                var imgURL="http://"+obj.data.image;
                if(!isHtml){
                    if($("#"+previewID).attr("src")){
                        $("#"+previewID).attr("src",imgURL);
                    }else{
                        $("#"+previewBoxID).append("<div class='col-sm-6 col-md-4'><div class='thumbnail' ><img id='"+previewID+"' src='"+imgURL+"'/><div class='caption'><h5 class='text-center'>"+previewTxt+"</h5></div></div></div>");
                    }
                }else{
                    $("#"+previewBoxID).append("<div class='col-sm-6 col-md-4'><div class='thumbnail text-center' ><a id='"+previewID+"' href='"+imgURL+"' target='_blank'>View</a><div class='caption'><h5 class='text-center'>"+previewTxt+"</h5></div></div></div>");
                }
                $("#"+uploadPrefix+"_msgbox").empty();
            }
        });

        uploader.on( 'uploadError', function( file ) {
            $( '#'+file.id ).find('p.state').text('上传出错');
        });

        uploader.on( 'uploadComplete', function( file ) {
            $( '#'+file.id ).find('.progress').fadeOut();
        });

        listenUploadBtn(uploader);
    }

    function listenUploadBtn(uploader){
        $('#uploadBtn').bind("click",function(){
            uploader.upload();
        });
    }
</script>
