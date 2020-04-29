package com.zzhdsoft.utils.hbthelper;

import java.util.Vector;
import java.util.Hashtable;

import com.zzhdsoft.utils.StringHelper;
import org.nutz.dao.entity.annotation.Readonly;

/**
 * 
 *  CreateAnnotationFileForMysql的中文名称：生成实体类（适用于MYSQL数据库）
 *
 *  CreateAnnotationFileForMysql的描述：
 *
 *  Written  by  : zjf
 */
public class CreateAnnotationFileForMysql {
	//static String javafilepack = "com.zzhdsoft.siweb.entity.zfba";//更改包路径
	//static String javafilepackPath = "./src/com/zzhdsoft/siweb/entity/zfba/";//更改类文件存放路径
	
	static String javafilepack = "com.zzhdsoft.siweb";//更改包路径
	static String javafilepackPath = "./src/com/zzhdsoft/siweb/";//更改类文件存放路径	
	static String db_name = "syjzhptty0316";//mysql数据库名
    public CreateAnnotationFileForMysql() {
    }
    /**
     * @param args
     */
    public static void main(String args[]){
    	String tablename = "tabk"; //更改此名称可以生成不同的表HBFile
        if (args!=null && args.length==1)
        {
            if (CreateHBFile(args[0]))
                System.out.println("成功创建或更新Annotation文件.");
        }
        else
        {
            if (CreateHBFile(tablename))
                System.out.println("成功创建或更新Annotation文件.");
        }
    }
    /**
     * @param tablename
     * @return
     */
    public static boolean CreateHBFile(String tablename){
        tablename = tablename.toUpperCase();

        //保存字段名,字段类型,字段长度信息
        Vector vecFieldNameTypeList = new Vector(); 
        TableCtrl db = new TableCtrl();
        Vector vec = db.open("select * from "+tablename+" where 0=1", false, 1, 0,0,vecFieldNameTypeList);

        Vector keylist = db.getPrimaryKeys(tablename); //取key

        if (db.error != null && !db.error.equals("")) {
        	System.err.println( "数据库错误:" + db.error);
        	return false;
        }


         //获取表注释
         String tablecomment = db.getFieldValue("select TABLE_COMMENT from INFORMATION_SCHEMA.TABLES where TABLE_NAME='"+tablename+"'");
       
         int spos = tablename.indexOf(".");

         //java类首字母大写
         String javaclassname = StringHelper.firstCharacterToUpper(StringHelper.replaceUnderlineAndfirstToUpper(tablename.toLowerCase(),"_"));
         String javatablename = tablename.toLowerCase();

         String thiscond;
         if (spos>-1) //查其它用户的
           thiscond = " (TABLE_NAME='" +tablename.substring(spos+1) + "'" + " and table_schema='"+ tablename.substring(0,spos)+"')";
         else
           thiscond = " (TABLE_NAME='" +tablename.substring(spos+1) + "'" + " and table_schema='"+ db_name +"')";

         
         //获取字段、字段注释
         String sql = "select COLUMN_NAME,COLUMN_COMMENT from INFORMATION_SCHEMA.COLUMNS where lower(COLUMN_NAME)<>'prseno' and "+thiscond;

        Vector vecComments = db.open(sql);
        boolean AutoGetFullComments = false;

        Hashtable displabel = new Hashtable();
        for (int i = 0; i < vecComments.size(); i++) {
            String[] co = (String[]) vecComments.elementAt(i);
            int pos = 0;
            if (!AutoGetFullComments && (pos = co[1].indexOf("|")) > 0) //带|符号的分隔注释
                co[1] = co[1].substring(pos + 1);
            displabel.put(co[0].toLowerCase(), co[1]);
        }
        StringBuffer xmlbuffer = new StringBuffer(1024); //xml buffer
        StringBuffer javabuffer = new StringBuffer(1024); //java dto buffer
        /*
        xmlbuffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        xmlbuffer.append("\r\n");
        //xmlbuffer.append("<!DOCTYPE hibernate-mapping PUBLIC \"-//Hibernate/Hibernate Mapping DTD 2.0//EN\" \"http://hibernate.sourceforge.net/hibernate-mapping-2.0.dtd\">");
        xmlbuffer.append("<!DOCTYPE hibernate-mapping SYSTEM \"http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd\">");
        xmlbuffer.append("\r\n");
        xmlbuffer.append("<hibernate-mapping>");
        xmlbuffer.append("\r\n");
        xmlbuffer.append("<class name=\""+javafilepack+"."+javaclassname+"\" table=\""+tablename+"\" lazy=\"false\"><!--"+tablecomment+"-->");
        xmlbuffer.append("\r\n");
         */
        Hashtable allfieldfulltype = new Hashtable(); //所有的字段类型
        Hashtable allfieldtype = new Hashtable(); //所有的字段类型
        
        for (int x = vecFieldNameTypeList.size() - 1; x >=0 ; x--) {
              Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                  elementAt(x);
              String fieldname = (String)hashFieldFnameTypeCol.get("fieldname");
              String fieldtype = (String)hashFieldFnameTypeCol.get("fieldtype");
              
              if (fieldname.equals("prseno")) {
            	  vecFieldNameTypeList.remove(x);
            	  continue;
              }             
             
//              String[] fieldtypefrom = {"i4","r8","date","dateTime","timeStamp","timestamp", "string", "boolean","l10","decimal"};
//              String[] fieldtypeto = {"java.lang.Integer","java.math.BigDecimal","java.sql.Date","java.sql.Timestamp","java.sql.Timestamp","java.sql.Timestamp", "java.lang.String", "java.lang.Boolean","java.lang.Long","java.lang.Long"};
//              for (int f=0; f<fieldtypefrom.length; f++){ //字段类型
//                  if (fieldtypefrom[f].equals(fieldtype))
//                  {
//                      fieldtype = fieldtypeto[f];
//                      allfieldfulltype.put(fieldname, fieldtype);
//                      allfieldtype.put(fieldname, fieldtype.substring(fieldtype.lastIndexOf(".") + 1));
//                  }
//              }
              
              //字段类型
              fieldtype = sqlType2JavaType(fieldtype); 
              allfieldfulltype.put(fieldname, fieldtype);
              allfieldtype.put(fieldname, fieldtype);
              
          }


        /*
        if (keylist.size()==1){ //单关键字
            String keyfieldname = (String)keylist.elementAt(0);
            xmlbuffer.append("<id column=\""+keyfieldname.toUpperCase()+"\" name=\""+keyfieldname+"\" type=\""+allfieldfulltype.get(keyfieldname)+"\">");
            xmlbuffer.append("\r\n");
            xmlbuffer.append("<generator class=\"assigned\"/>");
            xmlbuffer.append("\r\n");
            xmlbuffer.append("</id>");
            xmlbuffer.append("\r\n");
        }
        else
        if (keylist.size()>1) //组合关键字
        {
            xmlbuffer.append("<composite-id>");
            xmlbuffer.append("\r\n");

            for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
                  Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                      elementAt(x);
                  String fieldname = (String)hashFieldFnameTypeCol.get("fieldname");
                  if (keylist.indexOf(fieldname)<0) //不是key
                      continue;
                  Object fielddisplabel = displabel.get(fieldname);
                  if (fielddisplabel == null || fielddisplabel.equals(""))
                      fielddisplabel = "";
                  else
                      fielddisplabel = " desc=\"" + fielddisplabel + "\"";
                  String fieldlen = (String) hashFieldFnameTypeCol.get(
                          "fieldlenHbm");
                  if ("0".equals(fieldlen))
                      fieldlen = "8";
                  xmlbuffer.append(
                          "<key-property column=\"" + fieldname.toUpperCase() +
                          "\" name=\"" + fieldname.toLowerCase() + "\"" +
                        " type=\"" + allfieldfulltype.get(fieldname) + "\"" +
                          " length=\"" + fieldlen + "\"/><!-- " +
                          fielddisplabel +
                          "-->");
                  xmlbuffer.append("\r\n");
              }

            xmlbuffer.append("\r\n");
            xmlbuffer.append("</composite-id>");
            xmlbuffer.append("\r\n");
        }

        for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
              Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                  elementAt(x);
              String fieldname = (String)hashFieldFnameTypeCol.get("fieldname");
              if (keylist.indexOf(fieldname)>-1) //是key
                  continue;

              Object fielddisplabel = displabel.get(fieldname);
              if (fielddisplabel==null || fielddisplabel.equals(""))
                  fielddisplabel = "";
              else
                  fielddisplabel = "<!-- "+fielddisplabel+" -->";
              String fieldlen = (String)hashFieldFnameTypeCol.get("fieldlenHbm");
              if ("0".equals(fieldlen))
                  fieldlen = "8";
              xmlbuffer.append(
                  "<property column=\"" + fieldname.toUpperCase() +
                  "\" name=\"" + fieldname.toLowerCase() + "\"" +
                  " type=\"" + allfieldfulltype.get(fieldname) + "\"" +
                  " length=\""+fieldlen + "\"/>"+fielddisplabel);
              xmlbuffer.append("\r\n");
          }
          xmlbuffer.append("</class>");
          xmlbuffer.append("\r\n");
          xmlbuffer.append("</hibernate-mapping>");
          xmlbuffer.append("\r\n");

          */


          javabuffer.append("package "+javafilepack+";");
          javabuffer.append("\r\n");
          javabuffer.append("\r\n");
          javabuffer.append("import org.nutz.dao.entity.annotation.*;");
          javabuffer.append("\r\n");
          javabuffer.append("import org.nutz.dao.DB;");
          javabuffer.append("\r\n");
          javabuffer.append("import java.sql.Date;");
          javabuffer.append("\r\n");
          javabuffer.append("import java.sql.Timestamp;");
          javabuffer.append("\r\n");
          javabuffer.append("import java.math.BigDecimal;");
          //javabuffer.append("\r\n");
          //javabuffer.append("import org.apache.commons.lang.builder.*;");
          javabuffer.append("\r\n");
          javabuffer.append("\r\n");
          javabuffer.append("/**");
          javabuffer.append("\r\n");
          javabuffer.append(" * @Description  "+javaclassname+"的中文含义是: "+tablecomment);
          javabuffer.append("\r\n");
          javabuffer.append(" * @Creation     "+PubFunc.getNow());  
          javabuffer.append("\r\n");
          javabuffer.append(" * @Written      Create Tool By zjf ");
          javabuffer.append("\r\n");
          javabuffer.append(" **/");
          javabuffer.append("\r\n"); 
          javabuffer.append("@Table(value = \""+javatablename+"\")");
          javabuffer.append("\r\n"); 
          javabuffer.append("public class "+javaclassname+" ");
          //javabuffer.append("\r\n");
          //javabuffer.append(" implements Serializable");
          //javabuffer.append("\r\n");
          javabuffer.append("{\r\n\t");
          //javabuffer.append("private static final long serialVersionUID = 1L;");          
          //javabuffer.append("\r\n\t");

          //每个参数声明
          for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
                Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                    elementAt(x);
                String fieldname = (String)hashFieldFnameTypeCol.get("fieldname");
                String propertyname = StringHelper.replaceUnderlineAndfirstToUpper((String)hashFieldFnameTypeCol.get("fieldname"),"_");
                String fielddisplabel = PubFunc.toString(displabel.get(fieldname));
                javabuffer.append("/**");
                javabuffer.append("\r\n");
                javabuffer.append("\t * @Description "+propertyname+"的中文含义是： "+ fielddisplabel);
                javabuffer.append("\r\n");
                javabuffer.append("\t */");
                javabuffer.append("\r\n\t");
                javabuffer.append("@Column");
                if(fieldname.indexOf("_")!=-1){
                     javabuffer.append(" ( value = \""+ fieldname +"\" )");
                }
                javabuffer.append("\r\n\t");
                
                if (keylist.size()>0) //有key
                {
                	for (int y = 0; y < keylist.size(); y++){
                		if (fieldname.equals(keylist.get(y).toString()))
                		{
                			if("String".equals(allfieldtype.get(fieldname))){
                				javabuffer.append("@Name");               				
                			}else{
                				javabuffer.append("@Id(auto=false)");
                			}
                			               			
                			javabuffer.append("\r\n\t");
                			javabuffer.append("//@Prev(@SQL(db=DB.MYSQL,value=\"select nextval('sq_"+fieldname+"')\"))");
                			javabuffer.append("\r\n\t");
                			javabuffer.append("//@Prev(@SQL(db=DB.ORACLE,value=\"select sq_"+fieldname+".nextval from dual\"))");
                            javabuffer.append("\r\n\t");
                		}
                	}
                }
                
                javabuffer.append("private "+allfieldtype.get(fieldname)+" "+propertyname+";"); //"+fielddisplabel);
                javabuffer.append("\r\n");
                javabuffer.append("\r\n\t");
          }
          /*
          javabuffer.append("public "+javaclassname+"()"); //空参数构造函数
         javabuffer.append("\r\n\t");
         javabuffer.append("{");
         javabuffer.append("\r\n\t");
         javabuffer.append("}");
         javabuffer.append("\r\n");
         javabuffer.append("\r\n\t");

         //所有参数的构造函数
         javabuffer.append("public "+javaclassname+"(");
         javabuffer.append("\r\n\t\t");
         //参数声明
         for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
               Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                   elementAt(x);
               String fieldname = (String)hashFieldFnameTypeCol.get("fieldname");
               javabuffer.append(allfieldtype.get(fieldname));
               javabuffer.append(" ");
               javabuffer.append(fieldname);
               if (x<vecFieldNameTypeList.size()-1)
                   javabuffer.append(",");
               if (x>0 && x%6==0) //6个参数一换行
                   javabuffer.append("\r\n\t\t");

         }
         javabuffer.append("){");
         javabuffer.append("\r\n\t\t");
         //参数赋值
         for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
               Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                   elementAt(x);
               String fieldname = (String)hashFieldFnameTypeCol.get("fieldname");
               javabuffer.append("this."+fieldname+" = "+fieldname+";");
               javabuffer.append("\r\n\t");
               if (x<vecFieldNameTypeList.size()-1)
                   javabuffer.append("\t");
         }
         javabuffer.append("}");
         javabuffer.append("\r\n\t");

         // 关键字的构造函数
         if (keylist.size()>0) //有key
         {
             javabuffer.append("public "+javaclassname+"(");
             javabuffer.append("\r\n\t\t");
             //参数声明
             int keyorder = -1;
             for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
                 Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                                                   elementAt(x);
                 String fieldname = (String) hashFieldFnameTypeCol.get("fieldname");

                 if (keylist.indexOf(fieldname) < 0) //不是key
                     continue;
                 keyorder++;

                 if (keyorder>0)
                     javabuffer.append(",");

                 javabuffer.append(allfieldtype.get(fieldname));
                 javabuffer.append(" ");
                 javabuffer.append(fieldname);

             }
             javabuffer.append("){");
             javabuffer.append("\r\n\t\t");
             //key参数赋值
             for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
                 Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                                                   elementAt(x);
                 String fieldname = (String) hashFieldFnameTypeCol.get("fieldname");
                 if (keylist.indexOf(fieldname) < 0) //不是key
                     continue;
                 javabuffer.append("this." + fieldname + " = " + fieldname + ";");
                 javabuffer.append("\r\n\t\t");
             }
             javabuffer.append("\r\n\t");
             javabuffer.append("}");
             javabuffer.append("\r\n\t");
         }
         */

         //每个参数的set与get
         javabuffer.append("\r\n\t");
         for (int x = 0; x < vecFieldNameTypeList.size(); x++) {
               Hashtable hashFieldFnameTypeCol = (Hashtable) vecFieldNameTypeList.
                   elementAt(x);
               String fieldname = (String)hashFieldFnameTypeCol.get("fieldname");
               String propertyname = StringHelper.replaceUnderlineAndfirstToUpper((String)hashFieldFnameTypeCol.get("fieldname"),"_");
               String fieldtype = (String)allfieldtype.get(fieldname);
               String fieldnameFirstUpperCase = StringHelper.firstCharacterToUpper(propertyname);
               String fielddisplabel = PubFunc.toString(displabel.get(fieldname));
               
               javabuffer.append("\t/**");
               javabuffer.append("\r\n");
               javabuffer.append("\t * @Description "+propertyname+"的中文含义是： "+ fielddisplabel);
               javabuffer.append("\r\n");
               javabuffer.append("\t */");
               javabuffer.append("\r\n\t");
               
               javabuffer.append("public void set"+fieldnameFirstUpperCase+"("+fieldtype+" "+propertyname+"){ ");
               javabuffer.append("\r\n\t\t");
               javabuffer.append("this."+propertyname+" = "+propertyname+";");
               javabuffer.append("\r\n\t}");
               javabuffer.append("\r\n");
               
               javabuffer.append("\t/**");
               javabuffer.append("\r\n");
               javabuffer.append("\t * @Description "+propertyname+"的中文含义是： "+ fielddisplabel);
               javabuffer.append("\r\n");
               javabuffer.append("\t */");
               javabuffer.append("\r\n\t");
               
               javabuffer.append("public "+fieldtype+" get"+fieldnameFirstUpperCase+"(){");
               javabuffer.append("\r\n\t\t");
               javabuffer.append("return "+propertyname+";");
               javabuffer.append("\r\n\t}");
               javabuffer.append("\r\n");
         }


        

         javabuffer.append("\r\n\t");

         /*
         javabuffer.append("public String toString()");
         javabuffer.append("\r\n\t");
         javabuffer.append("{");
         javabuffer.append("\r\n\t");
         javabuffer.append("    return (new ToStringBuilder(this))");
         for (int i=0; i<keylist.size(); i++)
         {
             String keyfield = (String)keylist.elementAt(i);
             javabuffer.append(".append(\"" + keyfield + "\", get" +getFieldProp(keyfield)+"())");
         }
         javabuffer.append(".toString();");
         javabuffer.append("\r\n\t");
         javabuffer.append("}");
         javabuffer.append("\r\n\t");
         javabuffer.append("\r\n\t");
         
         javabuffer.append("public boolean equals(Object other)"); //按关键字
         javabuffer.append("\r\n\t");
         javabuffer.append("{");
         javabuffer.append("\r\n\t");
         javabuffer.append("    if(!(other instanceof "+javaclassname+"))");
         javabuffer.append("\r\n\t");
         javabuffer.append("    {");
         javabuffer.append("\r\n\t");
         javabuffer.append("        return false;");
         javabuffer.append("\r\n\t");
         javabuffer.append("    } else");
         javabuffer.append("\r\n\t");
         javabuffer.append("    {");
         javabuffer.append("\r\n\t");
         javabuffer.append("        "+javaclassname+" castOther = ("+javaclassname+")other;");
         javabuffer.append("\r\n\t");
         javabuffer.append("        return (new EqualsBuilder())");
         for (int i=0; i<keylist.size(); i++)
         {
             String keyfield = (String)keylist.elementAt(i);
             String a = "get" +getFieldProp(keyfield)+"()";
             javabuffer.append(".append("+a+", castOther."+a+")");
         }
         javabuffer.append(".isEquals();");
         javabuffer.append("\r\n\t");
         javabuffer.append("    }");
         javabuffer.append("\r\n\t");
         javabuffer.append("}");
         javabuffer.append("\r\n\t");

         javabuffer.append("\r\n\t");
         javabuffer.append("public int hashCode()");
         javabuffer.append("\r\n\t");
         javabuffer.append("{");
         javabuffer.append("\r\n\t");
         javabuffer.append("    return (new HashCodeBuilder())");
         for (int i=0; i<keylist.size(); i++)
         {
             String keyfield = (String)keylist.elementAt(i);
             String a = "get" +getFieldProp(keyfield)+"()";
             javabuffer.append(".append("+a+")");
         }
         javabuffer.append(".toHashCode();");

         javabuffer.append("\r\n\t");
         javabuffer.append("}");
         javabuffer.append("\r\n\t");
			*/

	

          javabuffer.append("\r\n");
          javabuffer.append("}");//java结束了

          db.freeConn();

        System.out.println(javabuffer.toString());

//          if (PubFunc.writeFile("./"+javaclassname+".hbm.xml", xmlbuffer.toString(), "UTF-8"))
//              System.out.println("成功创建hbm.xml文件:"+tablename+".hbm.xml");
          if (PubFunc.writeFile(javafilepackPath+javaclassname+".java", javabuffer.toString()))
          //这里直接生成到目录下有个问题：如果里面有自己手工添加的其他属性，重新生成会被覆盖掉【zjf】,请慎重操作。
          //不要改  目前能直接生成到相应目录下          
//          if (PubFunc.writeFile("./"+javaclassname+".java", javabuffer.toString()))
              System.out.println("成功创建java文件:"+javaclassname+".java");
          return true;
    }
    
    private static String sqlType2JavaType(String sqlType) {
        if (sqlType.equalsIgnoreCase("bit")) {  
            return "Boolean";  
        } else if (sqlType.equalsIgnoreCase("tinyint")) {  
            return "Byte";  
        } else if (sqlType.equalsIgnoreCase("smallint")) {  
            return "Short";  
        } else if (sqlType.equalsIgnoreCase("int")) {  
            return "Integer";  
        } else if (sqlType.equalsIgnoreCase("bigint")) {  
            return "Long";  
        } else if (sqlType.equalsIgnoreCase("number")) {//oralce nubmer
            return "Long";  
        } else if (sqlType.equalsIgnoreCase("float")) {  
            return "Float";  
        } else if (sqlType.equalsIgnoreCase("decimal")  
                || sqlType.equalsIgnoreCase("numeric")  
                || sqlType.equalsIgnoreCase("real")) {  
            return "BigDecimal";  
        } else if (sqlType.equalsIgnoreCase("money")  
                || sqlType.equalsIgnoreCase("smallmoney")) {  
            return "Double";  
        } else if (sqlType.equalsIgnoreCase("varchar2")  
                || sqlType.equalsIgnoreCase("varchar")  
                || sqlType.equalsIgnoreCase("char")  
                || sqlType.equalsIgnoreCase("nvarchar")  
                || sqlType.equalsIgnoreCase("nchar")) {  
            return "String";  
        } else if (sqlType.equalsIgnoreCase("date")) {  
            return "Date";  
        }else if (sqlType.equalsIgnoreCase("datetime")
        		|| sqlType.equalsIgnoreCase("timestamp")) {  
            return "Timestamp";  
        }else if (sqlType.equalsIgnoreCase("image")) {  
            return "Blob";  
        } else if (sqlType.equalsIgnoreCase("text")
        		||sqlType.equalsIgnoreCase("longtext")) {   
            return "String";  
        }else if (sqlType.equalsIgnoreCase("blob")
        		||sqlType.equalsIgnoreCase("longblob")) {    
            return "InputStream";  
        }else if (sqlType.equalsIgnoreCase("clob")
        		||sqlType.equalsIgnoreCase("longclob")) {    
            return "String";  
        }else if(sqlType.equalsIgnoreCase("integer")){
        	return "String";
        }
        return "String";  
    }      
}

