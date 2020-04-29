package com.zzhdsoft.utils;
import java.util.Properties;

public class SeparatorUtil {
//	File.separatorChar 返回一个字符，表示当前系统默认的文件名分隔符，在Windows中为"/",unix中为"/"。
//	File.separator 与前者相同，但将分隔符作为字符串类型返回。
//	pathSeparatorChar 返回一个字符，表示当前系统默认的路径名分隔符，在Windows中为";",unix中为":"。
//	File.pathSeparator 与前者相同，但将分隔符作为字符串类型返回。
	
//	不同系统平台下的行分隔符、路径分隔符等常常不同。如
	
//	行分隔符在windows 下是 \r\n，在Linux下面是 \n， 在Mac下是 \r 在 UNIX 系统中是/n
//	路径分隔符在windows下是 \ ，在LInux下是 /  在 UNIX 系统中是:
//	文件分隔符（winodw是\  linux是/  在 UNIX 系统中是“/”）
	 public static void main (String[] args){
	        System.out.println("行分隔符是" + SeparatorUtil.getLineSeparator());
	        System.out.println("路径分隔符是" + SeparatorUtil.getPathSeparator());
	        System.out.println("文件分隔符是" + SeparatorUtil.getFileSeparator());
	 }
	 
    /* system properties to get separators */
    static final Properties PROPERTIES = new Properties(System.getProperties());

    /**
     * 获取当前平台的 文件分隔符
     * @return line separator
     */
    public static String getFileSeparator(){
        return PROPERTIES.getProperty("file.separator");
    }
    
    /**
     * 获取当前平台的 行分隔符
     * @return line separator
     */
    public static String getLineSeparator(){
        return PROPERTIES.getProperty("line.separator");
    }

    /**
     * 获取当前平台的 路径分隔符
     * @return path separator
     */
    public static String getPathSeparator(){
        return PROPERTIES.getProperty("path.separator");
    }
    
//    其他能得到的属性：
//
//    java.version
//     Java 运行时环境版本
//     
//    java.vendor
//     Java 运行时环境供应商
//     
//    java.vendor.url
//     Java 供应商的 URL
//     
//    java.home
//     Java 安装目录
//     
//    java.vm.specification.version
//     Java 虚拟机规范版本
//     
//    java.vm.specification.vendor
//     Java 虚拟机规范供应商
//     
//    java.vm.specification.name
//     Java 虚拟机规范名称
//     
//    java.vm.version
//     Java 虚拟机实现版本
//     
//    java.vm.vendor
//     Java 虚拟机实现供应商
//     
//    java.vm.name
//     Java 虚拟机实现名称
//     
//    java.specification.version
//     Java 运行时环境规范版本
//     
//    java.specification.vendor
//     Java 运行时环境规范供应商
//     
//    java.specification.name
//     Java 运行时环境规范名称
//     
//    java.class.version
//     Java 类格式版本号
//     
//    java.class.path
//     Java 类路径
//     
//    java.library.path
//     加载库时搜索的路径列表
//     
//    java.io.tmpdir
//     默认的临时文件路径
//     
//    java.compiler
//     要使用的 JIT 编译器的名称
//     
//    java.ext.dirs
//     一个或多个扩展目录的路径
//     
//    os.name
//     操作系统的名称
//     
//    os.arch
//     操作系统的架构
//     
//    os.version
//     操作系统的版本
//     
//    file.separator
//     文件分隔符（在 UNIX 系统中是“/”）
//     
//    path.separator
//     路径分隔符（在 UNIX 系统中是“:”）
//     
//    line.separator
//     行分隔符（在 UNIX 系统中是“/n”）
//     
//    user.name
//     用户的账户名称
//     
//    user.home
//     用户的主目录
//     
//    user.dir
//     用户的当前工作目录
     

}

