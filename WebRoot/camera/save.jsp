<%@ page contentType="text/plain;charset=UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ page import="java.util.Date" %> 
<%@ page import="java.io.FileOutputStream" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.io.BufferedInputStream" %> 
<%@ page import="java.io.ByteArrayOutputStream"%> 
<%@ page import="org.p3p.image.encrypt.JpegEncrypt"%>

<%
    response.setContentType("text/plain;charset=UTF-8");
    try{
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String cdStr = sdf.format(new Date());
		
    	String fileName = request.getParameter("fileName");
    	if (fileName==null || fileName=="") {
    		fileName = cdStr + ((int) (Math.random() * 100000 + 10000)) + ".jpg";;//设置拍照图片名称
    	}
    	String  rootpath = application.getRealPath("/");//绝对路径
    	String  ctxpath = request.getContextPath();//相对路径
	 
		int v = 0;
		BufferedInputStream inputStream = new BufferedInputStream(request.getInputStream());
		byte[] bytes = new byte[1024];
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		while ((v = inputStream.read(bytes)) > 0) {
			baos.write(bytes, 0, v);
		}
		inputStream.close();
		baos.close();
		
		//加入认证		
		byte[] tmp = baos.toByteArray();
		JpegEncrypt en = new JpegEncrypt();
		byte[] tmp1 = en.encrypt(cdStr + "采集照片",tmp);
		tmp = null;
		String oldFilePath = rootpath + "camera" + File.separator + "upload"  + File.separator + fileName; 
		
		File f1 = new File(oldFilePath);
		FileOutputStream fos = new FileOutputStream(f1);
		fos.write(tmp1);
		fos.close();
	 	//String keyword = en.decrypt(f1);
	 	//System.out.println("解密后：" + keyword);
		//读取加密信息
		//System.out.println("采集照片成功：" + fileName);
		fileName = ctxpath + "/camera/upload/" + fileName;
		response.getWriter().print("{'fileName':'"+fileName+"'}");
	}catch(Exception e){
	  e.printStackTrace();
	}
%>
