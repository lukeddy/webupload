<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="text-center">
    <a class="btn btn-link btn-detail">
        Click here to view detail
    </a>
    <%--<a href="#" class="btn btn-link">&gt;&gt;报告给系统管理员</a>--%>
    <div class="prettyprint detail" style="display: none;">
        ${stackTrace}
    </div>
</div>
<script type="text/javascript">
    $(".btn-detail").click(function() {
        var a = $(this);
        a.find("i").toggleClass("icon-collapse-alt").toggleClass("icon-expand-alt");
        $(".detail").toggle();
    });
</script>