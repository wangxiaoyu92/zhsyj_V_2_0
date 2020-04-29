package com.zzhdsoft.utils.hbthelper;

import java.io.File;

/** 
 * @author ������ E-mail:����kaioct@qq.com 
 * @version ����ʱ�䣺2013-11-28 ����05:08:27 
 * ��˵���� 
 */
public class ConvertStr2Camel {

	/**
     * ���շ�ʽ������ַ�ת��Ϊ�»��ߴ�д��ʽ�����ת��ǰ���շ�ʽ������ַ�Ϊ�գ��򷵻ؿ��ַ�</br>
     * ���磺HelloWorld->HELLO_WORLD
     * @param name ת��ǰ���շ�ʽ������ַ�
     * @return ת�����»��ߴ�д��ʽ������ַ�
     */
    public static String underscoreName(String name) {
        StringBuilder result = new StringBuilder();
        if (name != null && name.length() > 0) {
            // ����һ���ַ���ɴ�д
            result.append(name.substring(0, 1).toUpperCase());
            // ѭ�����������ַ�
            for (int i = 1; i < name.length(); i++) {
                String s = name.substring(i, i + 1);
                // �ڴ�д��ĸǰ����»���
                if (s.equals(s.toUpperCase()) && !Character.isDigit(s.charAt(0))) {
                    result.append("_");
                }
                // �����ַ�ֱ��ת�ɴ�д
                result.append(s.toUpperCase());
            }
        }
        return result.toString();
    }

    /**
     * ���»��ߴ�д��ʽ������ַ�ת��Ϊ�շ�ʽ�����ת��ǰ���»��ߴ�д��ʽ������ַ�Ϊ�գ��򷵻ؿ��ַ�</br>
     * ���磺HELLO_WORLD->HelloWorld
     * @param name ת��ǰ���»��ߴ�д��ʽ������ַ�
     * @param firstLetterIsUpper ����ĸ�Ƿ�Ҫת���ɴ�д
     * @return ת������շ�ʽ������ַ�
     */
    public static String convertStr2CamelName(String name,boolean firstLetterIsUpper) {
        StringBuilder result = new StringBuilder();
        // ���ټ��
        if (name == null || "".equals(name)) {// Ϊ��ʱ��ת��
            return "";
        } else if (!name.contains("_")) {// �����»��ߣ����ת�����أ���������ĸ��Сд
        	name=name.toLowerCase();
        	if(firstLetterIsUpper){
        		return name.substring(0, 1).toUpperCase() + name.substring(1);//firstLetterUpper(name);
        	}else{
        		return name.substring(0, 1).toLowerCase() + name.substring(1);//return toLowerCaseFirstOne(name);
        	}
            
        }
		
        
        // ���»��߽�ԭʼ�ַ�ָ�
        String camels[] = name.split("_");
        for (String camel :  camels) {
            // ���ԭʼ�ַ��п�ͷ����β���»��߻�˫���»���
            if ("".equals(camel)) {
                continue;
            }
            // ����������շ�Ƭ��
            if (result.length() == 0) {
                // ��һ���շ�Ƭ�Σ����ת�����أ���������ĸ��Сд
            	if(firstLetterIsUpper){
            		result.append(firstLetterUpper(camel));
                }else{
                	result.append(camel.toLowerCase());
                }
            } else {
                // ������շ�Ƭ�Σ�����ĸ��д
                result.append(camel.substring(0, 1).toUpperCase());
                result.append(camel.substring(1).toLowerCase());
            }
        }
        return result.toString();
    }
    
    /** 
     * �������ַ������ĸ�ĳɴ�д 
     * @param str 
     * @return 
     */  
     private static String firstLetterUpper(String str) {  
         char[] ch = str.toCharArray();  
         if (ch[0] >= 'a' && ch[0] <= 'z') {  
             ch[0] = (char) (ch[0]-32);  
         }  
         //gu20141015��һ����ĸ��д�󣬺���Ķ�ת��ΪСд
         String v_xiaoxie=str.substring(1).toLowerCase();
         return new String(ch[0]+v_xiaoxie);  
     }
     
     
     /*
      * ����ĸתСд
      */
     public static String toLowerCaseFirstOne(String s){
         if(Character.isLowerCase(s.charAt(0)))
             return s;
         else
             return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
     }
     /*
      * ����ĸת��д
      */
     public static String toUpperCaseFirstOne(String s){
         if(Character.isUpperCase(s.charAt(0)))
             return s;
         else
             return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
     }
    
     public void createPack(String packName){
    		packName=packName.replace(".","/");
    		System.out.println(packName);
    		File file = new File(packName);
    		File parent = file.getParentFile();
//    		if(parent!=null && !parent.exists()){
    			parent.mkdirs();
    			file.getParentFile().mkdirs();  
    			System.out.println("11");
//    		}
//    		try {
//				file.createNewFile();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
    	}
     
	public static void main(String[] args) {
		System.out.println(convertStr2CamelName("bt_user",true));//����һ������ĸ��д
		System.out.println(convertStr2CamelName("bt_user_chinse",true));//����һ������ĸ��д
		
		System.out.println(convertStr2CamelName("user_name",false));//�ֶ���
		System.out.println(convertStr2CamelName("user_name_chinese",false));//�ֶ���
		
		System.out.println(convertStr2CamelName("user",false));//�ֶ���
		
		
//		new ConvertStr2Camel().createPack("org.a");
	}

}
