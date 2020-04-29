package com.zzhdsoft.utils.printword;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;

import java.io.File;

public class PDFUtil {
    private static final int wdFormatPDF = 17;  
    private static final int xlTypePDF = 0;  
    private static final int ppSaveAsPDF = 32;
    // 8 代表word保存成html
    public static final int WORD_HTML = 8;
  
    public static void main(String[] args) {
        for(int i=0;i<10;i++) {
            long s = System.currentTimeMillis();
            PDFUtil.word2PDF("E:/other/poi/src/main/4632.docx", "E:/other/poi/src/main/4633.pdf");
//            wordToHtml("E:/other/poi/src/main/4632.docx", "E:/other/poi/src/main/4633.html");
            System.out.println("转换完成！,耗时" + (System.currentTimeMillis() - s));
        }
    }  
    public boolean convert2PDF(String inputFile, String pdfFile) {
        String suffix = getFileSufix(inputFile);
        File file = new File(inputFile);
        if (!file.exists()) {  
            return false;  
        }  
        if (suffix.equals("pdf")) {  
            return false;  
        }  
        if (suffix.equals("doc") || suffix.equals("docx")  
                || suffix.equals("txt")) {  
            return word2PDF(inputFile, pdfFile);  
        } else if (suffix.equals("ppt") || suffix.equals("pptx")) {  
            return ppt2PDF(inputFile, pdfFile);  
        } else if (suffix.equals("xls") || suffix.equals("xlsx")) {  
            return excel2PDF(inputFile, pdfFile);  
        } else {  
            return false;  
        }  
    }  
    public static String getFileSufix(String fileName) {
        int splitIndex = fileName.lastIndexOf(".");  
        return fileName.substring(splitIndex + 1);  
    }  
    // word转换为pdf  
    public static boolean word2PDF(String inputFile, String pdfFile) {
        try {  
            // 打开word应用程序  
            ActiveXComponent app = new ActiveXComponent("Word.Application");
            // 设置word不可见  
            app.setProperty("Visible", false);  
            // 获得word中所有打开的文档,返回Documents对象  
            Dispatch docs = app.getProperty("Documents").toDispatch();
            // 调用Documents对象中Open方法打开文档，并返回打开的文档对象Document  
            Dispatch doc = Dispatch.call(docs, "Open", inputFile, false, true)  
                    .toDispatch();  
            // 调用Document对象的SaveAs方法，将文档保存为pdf格式  
            /* 
             * Dispatch.call(doc, "SaveAs", pdfFile, wdFormatPDF 
             * //word保存为pdf格式宏，值为17 ); 
             */  
            Dispatch.call(doc, "ExportAsFixedFormat", pdfFile, wdFormatPDF);// word保存为pdf格式宏，值为17  
            // 关闭文档  
            Dispatch.call(doc, "Close", false);  
            // 关闭word应用程序  
            app.invoke("Quit", 0);  
            return true;  
        } catch (Exception e) {
            return false;  
        }  
    }  
    // excel转换为pdf  
    public static boolean excel2PDF(String inputFile, String pdfFile) {
        try {  
            ActiveXComponent app = new ActiveXComponent("Excel.Application");  
            app.setProperty("Visible", false);  
            Dispatch excels = app.getProperty("Workbooks").toDispatch();  
            Dispatch excel = Dispatch.call(excels, "Open", inputFile, false,  
                    true).toDispatch();  
            Dispatch.call(excel, "ExportAsFixedFormat", xlTypePDF, pdfFile);  
            Dispatch.call(excel, "Close", false);  
            app.invoke("Quit");  
            return true;  
        } catch (Exception e) {
            return false;  
        }  
    }  
    // ppt转换为pdf  
    public static boolean ppt2PDF(String inputFile, String pdfFile) {
        try {  
            ActiveXComponent app = new ActiveXComponent(  
                    "PowerPoint.Application");  
            // app.setProperty("Visible", msofalse);  
            Dispatch ppts = app.getProperty("Presentations").toDispatch();  
  
            Dispatch ppt = Dispatch.call(ppts, "Open", inputFile, true,// ReadOnly  
                    true,// Untitled指定文件是否有标题  
                    false// WithWindow指定文件是否可见  
                    ).toDispatch();  
  
            Dispatch.call(ppt, "SaveAs", pdfFile, ppSaveAsPDF);  
  
            Dispatch.call(ppt, "Close");  
  
            app.invoke("Quit");  
            return true;  
        } catch (Exception e) {
            return false;  
        }  
    }

    
}  