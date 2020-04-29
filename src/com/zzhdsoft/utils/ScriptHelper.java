package com.zzhdsoft.utils;

public class ScriptHelper {
	public ScriptHelper(){
		
	}
	public String Reload()
	{
		StringBuffer sb=new StringBuffer();
		sb.append("<script language=\"javascript\">\n");
		sb.append("window.location.href=window.location.href;");
		sb.append("\n");
		sb.append("</script>");
        return sb.toString();
	}
	
	public String Redirect(String url)
	{
		StringBuffer sb=new StringBuffer();
		sb.append("<script language='javascript'>");
		sb.append("window.location.href ='");
		sb.append(url);
		sb.append("';");
		sb.append("</script>");
		return sb.toString();
	}
	
	public String ShowMessage(String msgInfo,String url)
	{  
		String strMessage;
		strMessage="<script language='javascript'>";
		strMessage=strMessage + "alert('"+msgInfo+"')" + ";";
		if (url!="" && url!=null)
			strMessage=strMessage + "window.location.href='" + url + "'";

		strMessage=strMessage + "</script>";
		return strMessage;
	}
	
	
}
