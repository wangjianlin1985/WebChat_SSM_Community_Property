<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/6
  Time: 0:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/getQueryString.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="layui-unselect lau-sign-body" style="padding-top: 0px " >
    <form  class="layui-form">
        <div>
            <label class="layui-form-label">调查标题：</label>
            <div class="layui-input-block">
                <select lay-filter="survey_id" id="survey_id">
                </select>
            </div>
        </div>
        <div>
            <label class="layui-form-label">问题内容：</label>
            <div class="layui-input-block">
                <select lay-filter="question_id" id="question_id">
                </select>
            </div>
        </div>
        <div class="layui-form-item lau-sign-other" style="margin-top: 20px;text-align:center">
            <button type="button" class="layui-btn layui-btn-normal" lay-submit="" lay-filter="updateSur_Que" style="margin-right: 100px">提交</button>
        </div>
    </form>
</body>
<script>
    var survey_id,question_id
    var id =  getQueryString("id")
    layui.use(['upload','form'], function(){
        var form=layui.form;
        form.on('submit(updateSur_Que)', function(result) {
            console.log("result.field:"+typeof (result.field))//object
            res = result.field
            res.id = id;
            res.su_id = survey_id
            res.qid = question_id
            data = JSON.stringify(res)//把js对象转换成json字符串,string
            console.log("data:"+typeof (data))
            $.ajax({
                url : '${pageContext.request.contextPath}/updateSur_QueById',
                data : data,
                type:'POST',
                dataType:'text',
                contentType : 'application/json',
                success:function(data){
                    if(data=="success"){
                        layer.msg("成功！",function(){

                        });
                    }else{
                        layer.msg("失败！",function(){

                        });
                    }
                },
                error:function(args){
                    layer.msg("失败！",function(){

                    });
                }
            });
        });
        form.on('select(survey_id)', function(data){
            survey_id = data.value;
            console.log(survey_id)
        });
        form.on('select(question_id)', function(data){
            question_id = data.value;
            console.log(question_id)
        });
    })
    $(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/findAllSurvey',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                console.log(data)
                $('#survey_id').html('')
                $('#survey_id').append(new Option('请选择调查标题','请选择调查标题'))
                $.each(data, function (index, item) {
                    $('#survey_id').append(new Option(item.title, item.id));// 下拉菜单里添加元素
                });
                layui.form.render("select");
            }
        });
        setTimeout(function(){
            $.ajax({
                url:"${pageContext.request.contextPath}/findAllQuestions",
                dataType:"json",
                type: 'post',
                success: function (data) {
                    console.log("content:"+data[0].content)
                    $('#question_id').html('')
                    $('#question_id').append(new Option('请选择问题','请选择问题'))
                    $.each(data, function (index, item) {
                        console.log("content:"+item)
                        $('#question_id').append(new Option(item.content, item.id));// 下拉菜单里添加元素
                    });
                    layui.form.render("select");
                }
            });
        },500);
    })
</script>
</html>
