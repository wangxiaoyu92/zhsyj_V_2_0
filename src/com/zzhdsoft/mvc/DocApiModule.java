package com.zzhdsoft.mvc;

import com.askj.app.module.SjbModule;
import com.askj.supervision.module.SupervisionApiModule;
import com.askj.train.module.TrainApiModule;
import com.zzhdsoft.mvc.workflow.WorkflowAPIModule;
import com.zzhdsoft.utils.document.Document;
import com.zzhdsoft.utils.document.DocumentInfo;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;

import javax.servlet.http.HttpServletRequest;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.*;

/**
 * Created by Elfy Suen on 2017/10/17.
 */
@At("api/doc/")
@IocBean
public class DocApiModule {
    @At("/")
    @Ok("jsp:/jsp/common/doc")
    public void index(HttpServletRequest request) {
        List<Object[]> classList = new ArrayList<Object[]>();
        classList.add(new Object[]{"平台公共api包",SjbModule.class});
        classList.add(new Object[]{"日常监管api包",SupervisionApiModule.class});
        classList.add(new Object[]{"考试培训api包",TrainApiModule.class});
        classList.add(new Object[]{"工作流api包",WorkflowAPIModule.class});
        StringBuffer itemdoc = new StringBuffer("");
        String enter = "</br>";
        for(Object[] clazz:classList ) {
            Annotation clazzAnnotation = ((Class)clazz[1]).getAnnotation(At.class);
            Method[] methods = ((Class)clazz[1]).getMethods();

            List<Document> documents = new ArrayList<Document>();
            for (Method method : methods) {
                DocumentInfo documentInfo = method.getAnnotation(DocumentInfo.class);
                if (documentInfo != null) {
                    documents.add(new Document(documentInfo));
                }

            }


            Collections.sort(documents);
            itemdoc.append("<li class='list-group-item'>");
            itemdoc.append("<div class='title alert alert-info' data-toggle='collapse'>"+clazz[0]+(documents.size()==0?"(暂未整理api)":("(有"+documents.size()+"个api点击展开查看)"))+"</div>");
            itemdoc.append("<ul class='list-group collapse'>");
            String atURI =  ((At) clazzAnnotation).value()[0];

            for (Document documetInfo : documents) {
                itemdoc.append("<li class='list-group-item'>");
                itemdoc.append("<div class='title  alert alert-warning'  data-toggle='collapse'><b>api名称：</b>" + documetInfo.getDesc() + "[点击查看]</div>");
                itemdoc.append("<ul class='list-group collapse'>");
                itemdoc.append("<li class='list-group-item'><b>接口路径：</b>" +atURI+ (atURI.lastIndexOf("/")==atURI.length()-1?"":"/")  + documetInfo.getName() + "</li>");
                itemdoc.append("<li class='list-group-item'><b>功能描述：</b>" + documetInfo.getFunctiondesc() + "</li>");
                itemdoc.append("<li class='list-group-item'><b>请求参数：</br></b>" + documetInfo.getParams().replaceAll("\\/", "</br>").replaceAll("必填","<span style='color:red'>必填</span>") + "</li>");
                itemdoc.append("<li class='list-group-item'><b>返回对象：</b></br>" + format(documetInfo.getReturndesc()) + "</li>");
//                itemdoc.append("<li class='list-group-item'><b>创建日期：</b>" + documetInfo.getDate() + "</li>");
                itemdoc.append("</ul>");
                itemdoc.append("</li>");
            }

            itemdoc.append("</ul>");
            itemdoc.append("</li>");
        }
        request.setAttribute("doc",itemdoc);
    }

    public static String format(String jsonStr) {
        int level = 0;
        StringBuffer jsonForMatStr = new StringBuffer();
        for(int i=0;i<jsonStr.length();i++){
            char c = jsonStr.charAt(i);
            if(level>0&&'\n'==jsonForMatStr.charAt(jsonForMatStr.length()-1)){
                jsonForMatStr.append(getLevelStr(level));
            }
            switch (c) {
                case '{':
                    jsonForMatStr.append(c+"</br>");
                    level++;
                    break;
                case '[':
                    jsonForMatStr.append(c+"</br>");
                    level++;
                    break;
                case ',':
                    jsonForMatStr.append(c+"</br>");
                    break;
                case '}':
                case ']':
                    jsonForMatStr.append("</br>");
                    level--;
                    jsonForMatStr.append(getLevelStr(level));
                    jsonForMatStr.append(c);
                    break;
                default:
                    jsonForMatStr.append(c);
                    break;
            }
        }

        return jsonForMatStr.toString();

    }

    private static String getLevelStr(int level){
        StringBuffer levelStr = new StringBuffer();
        for(int levelI = 0;levelI<level ; levelI++){
            levelStr.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        }
        return levelStr.toString();
    }
}
