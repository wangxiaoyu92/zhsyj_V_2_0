<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>选择图标</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        $(function(){
            $('li').on('click',function(){
                var text = $(this).find('div').eq(1).html();
                text = text.substring(5, text.length);
                sy.setWinRet("&" + text);
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            });
        });
    </script>
</head>
<style>
    .layui-icon{font-size: 30px;}
    .site-doc-icon {
        margin-bottom: 50px;
        font-size: 0;
    }
    .site-doc-icon li{
        display: inline-block;
        vertical-align: middle;
        width: 127px;
        line-height: 25px;
        padding: 20px 0;
        margin-right: -1px;
        margin-bottom: -1px;
        border: 1px solid #e2e2e2;
        font-size: 14px;
        text-align: center;
        color: #666;
        transition: all .3s;
        -webkit-transition: all .3s;
    }
</style>
<body>

<ul class="site-doc-icon">
    <li>
        <i class="layui-icon"></i>
        <div class="name">主页</div>
        <div class="code">&amp;#xe68e;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">赞</div>
        <div class="code">&amp;#xe6c6;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">踩</div>
        <div class="code">&amp;#xe6c5;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">男</div>
        <div class="code">&amp;#xe662;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">女</div>
        <div class="code">&amp;#xe661;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">相机-空心</div>
        <div class="code">&amp;#xe660;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">相机-实心</div>
        <div class="code">&amp;#xe65d;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">菜单-水平</div>
        <div class="code">&amp;#xe65f;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">菜单-竖直</div>
        <div class="code">&amp;#xe671;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">返回</div>
        <div class="code">&amp;#xe65c;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">Hot</div>
        <div class="code">&amp;#xe756;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">等级</div>
        <div class="code">&amp;#xe735;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">金额-人民币</div>
        <div class="code">&amp;#xe65e;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">金额-美元</div>
        <div class="code">&amp;#xe659;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">位置</div>
        <div class="code">&amp;#xe715;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">文档</div>
        <div class="code">&amp;#xe705;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">检验</div>
        <div class="code">&amp;#xe6b2;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">笑脸</div>
        <div class="code">&amp;#xe6af;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">哭脸</div>
        <div class="code">&amp;#xe69c;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">购物车1</div>
        <div class="code">&amp;#xe698;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">购物车2</div>
        <div class="code">&amp;#xe657;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">星级</div>
        <div class="code">&amp;#xe658;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">上一页</div>
        <div class="code">&amp;#xe65a;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">下一页</div>
        <div class="code">&amp;#xe65b;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">上传-空心</div>
        <div class="code">&amp;#xe681;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">上传-实心</div>
        <div class="code">&amp;#xe67c;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">文件夹</div>
        <div class="code">&amp;#xe7a0;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">应用</div>
        <div class="code">&amp;#xe857;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">播放</div>
        <div class="code">&amp;#xe652;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">播放暂停</div>
        <div class="code">&amp;#xe651;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">音乐</div>
        <div class="code">&amp;#xe6fc;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">视频</div>
        <div class="code">&amp;#xe6ed;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">语音</div>
        <div class="code">&amp;#xe688;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">喇叭</div>
        <div class="code">&amp;#xe645;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">对话</div>
        <div class="code">&amp;#xe611;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">设置</div>
        <div class="code">&amp;#xe614;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">隐身-im</div>
        <div class="code">&amp;#xe60f;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">搜索</div>
        <div class="code">&amp;#xe615;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">分享</div>
        <div class="code">&amp;#xe641;</div>
    </li>

    <li>
        <i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop">ဂ</i>
        <div class="name">刷新</div>
        <div class="code">&amp;#x1002;</div>
    </li>

    <li>
        <i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop"></i>
        <div class="name">loading</div>
        <div class="code">&amp;#xe63d;</div>
    </li>

    <li>
        <i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop"></i>
        <div class="name">loading</div>
        <div class="code">&amp;#xe63e;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">设置</div>
        <div class="code">&amp;#xe620;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">引擎</div>
        <div class="code">&amp;#xe628;</div>
    </li>
    <li>
        <i class="layui-icon">ဆ</i>
        <div class="name">阅卷错号</div>
        <div class="code">&amp;#x1006;</div>
    </li>
    <li>
        <i class="layui-icon">ဇ</i>
        <div class="name">错-</div>
        <div class="code">&amp;#x1007;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">报表</div>
        <div class="code">&amp;#xe629;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">star</div>
        <div class="code">&amp;#xe600;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">圆点</div>
        <div class="code">&amp;#xe617;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">客服</div>
        <div class="code">&amp;#xe606;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">发布</div>
        <div class="code">&amp;#xe609;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">21cake_list</div>
        <div class="code">&amp;#xe60a;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">图表</div>
        <div class="code">&amp;#xe62c;</div>
    </li>
    <li>
        <i class="layui-icon">စ</i>
        <div class="name">正确</div>
        <div class="code">&amp;#x1005;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">换肤2</div>
        <div class="code">&amp;#xe61b;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">在线</div>
        <div class="code">&amp;#xe610;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">右右</div>
        <div class="code">&amp;#xe602;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">左左</div>
        <div class="code">&amp;#xe603;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">表格</div>
        <div class="code">&amp;#xe62d;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">icon_树</div>
        <div class="code">&amp;#xe62e;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">上传</div>
        <div class="code">&amp;#xe62f;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">添加</div>
        <div class="code">&amp;#xe61f;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">下载</div>
        <div class="code">&amp;#xe601;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">选择模版48</div>
        <div class="code">&amp;#xe630;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">工具</div>
        <div class="code">&amp;#xe631;</div>
    </li>

    <li>
        <i class="layui-icon"></i>
        <div class="name">添加</div>
        <div class="code">&amp;#xe654;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">编辑</div>
        <div class="code">&amp;#xe642;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">删除</div>
        <div class="code">&amp;#xe640;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">向下</div>
        <div class="code">&amp;#xe61a;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">文件</div>
        <div class="code">&amp;#xe621;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">布局</div>
        <div class="code">&amp;#xe632;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">对勾</div>
        <div class="code">&amp;#xe618;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">添加</div>
        <div class="code">&amp;#xe608;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">么么直播－翻页</div>
        <div class="code">&amp;#xe633;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">404</div>
        <div class="code">&amp;#xe61c;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">轮播组图</div>
        <div class="code">&amp;#xe634;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">help</div>
        <div class="code">&amp;#xe607;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">代码1</div>
        <div class="code">&amp;#xe635;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">进水</div>
        <div class="code">&amp;#xe636;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">关于</div>
        <div class="code">&amp;#xe60b;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">向上</div>
        <div class="code">&amp;#xe619;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">日期</div>
        <div class="code">&amp;#xe637;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">文件</div>
        <div class="code">&amp;#xe61d;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">top</div>
        <div class="code">&amp;#xe604;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">好友请求</div>
        <div class="code">&amp;#xe612;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">对</div>
        <div class="code">&amp;#xe605;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">窗口</div>
        <div class="code">&amp;#xe638;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">表情</div>
        <div class="code">&amp;#xe60c;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">正确</div>
        <div class="code">&amp;#xe616;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">我的好友</div>
        <div class="code">&amp;#xe613;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">文件下载</div>
        <div class="code">&amp;#xe61e;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">图片</div>
        <div class="code">&amp;#xe60d;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">链接</div>
        <div class="code">&amp;#xe64c;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">记录</div>
        <div class="code">&amp;#xe60e;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">文件夹</div>
        <div class="code">&amp;#xe622;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">font-strikethrough</div>
        <div class="code">&amp;#xe64f;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">unlink</div>
        <div class="code">&amp;#xe64d;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">编辑_文字</div>
        <div class="code">&amp;#xe639;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">三角</div>
        <div class="code">&amp;#xe623;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">单选框-候选</div>
        <div class="code">&amp;#xe63f;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">单选框-选中</div>
        <div class="code">&amp;#xe643;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">居中对齐</div>
        <div class="code">&amp;#xe647;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">右对齐</div>
        <div class="code">&amp;#xe648;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">左对齐</div>
        <div class="code">&amp;#xe649;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">勾选框（未打勾）</div>
        <div class="code">&amp;#xe626;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">勾选框（已打勾）</div>
        <div class="code">&amp;#xe627;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">加粗</div>
        <div class="code">&amp;#xe62b;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">聊天 对话 IM 沟通</div>
        <div class="code">&amp;#xe63a;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">文件夹_反</div>
        <div class="code">&amp;#xe624;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">手机</div>
        <div class="code">&amp;#xe63b;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">表情</div>
        <div class="code">&amp;#xe650;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">html</div>
        <div class="code">&amp;#xe64b;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">表单</div>
        <div class="code">&amp;#xe63c;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">tab</div>
        <div class="code">&amp;#xe62a;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">emw_代码</div>
        <div class="code">&amp;#xe64e;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">字体-下划线</div>
        <div class="code">&amp;#xe646;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">三角</div>
        <div class="code">&amp;#xe625;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">图片</div>
        <div class="code">&amp;#xe64a;</div>
    </li>
    <li>
        <i class="layui-icon"></i>
        <div class="name">斜体</div>
        <div class="code">&amp;#xe644;</div>
    </li>
</ul>
</body>
</html>