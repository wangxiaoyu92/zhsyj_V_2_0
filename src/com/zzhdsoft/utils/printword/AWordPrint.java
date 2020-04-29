package com.zzhdsoft.utils.printword;


import com.zzhdsoft.utils.FileUtil;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.xwpf.usermodel.*;

import java.io.*;
import java.util.*;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AWordPrint {

    /**
     *
     * @param filePath
     * @param regex 推荐传入正则表达式参数"\\$\\{[^{}]+\\}"
     * @return 返回Docx中需要替换的特殊字符，没有重复项
     */
    public ArrayList<String> getReplaceElementsInWord(String filePath,
                                                      String regex) {
        String[] p = filePath.split("\\.");
        if (p.length > 0) {// 判断文件有无扩展名
            // 比较文件扩展名
            if (p[p.length - 1].equalsIgnoreCase("doc")) {
                ArrayList<String> al = new ArrayList<String>();
                File file = new File(filePath);
                HWPFDocument document = null;
                try {
                    InputStream is = new FileInputStream(file);
                    document = new HWPFDocument(is);
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                Range range = document.getRange();
                String rangeText = range.text();
                CharSequence cs = rangeText.subSequence(0, rangeText.length());
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(cs);
                int startPosition = 0;
                while (matcher.find(startPosition)) {
                    if (!al.contains(matcher.group())) {
                        al.add(matcher.group());
                    }
                    startPosition = matcher.end();
                }
                return al;
            } else if (p[p.length - 1].equalsIgnoreCase("docx")) {
                ArrayList<String> al = new ArrayList<String>();
                XWPFDocument document = null;
                try {
                    document = new XWPFDocument(
                            POIXMLDocument.openPackage(filePath));
                } catch (IOException e) {
                    e.printStackTrace();
                }
                // 遍历段落
                Iterator<XWPFParagraph> itPara = document
                        .getParagraphsIterator();
                while (itPara.hasNext()) {
                    XWPFParagraph paragraph = (XWPFParagraph) itPara.next();
                    String paragraphString = paragraph.getText();
                    CharSequence cs = paragraphString.subSequence(0,
                                                                  paragraphString.length());
                    Pattern pattern = Pattern.compile(regex);
                    Matcher matcher = pattern.matcher(cs);
                    int startPosition = 0;
                    while (matcher.find(startPosition)) {
                        if (!al.contains(matcher.group())) {
                            al.add(matcher.group());
                        }
                        startPosition = matcher.end();
                    }
                }
                // 遍历表
                Iterator<XWPFTable> itTable = document.getTablesIterator();
                while (itTable.hasNext()) {
                    XWPFTable table = (XWPFTable) itTable.next();
                    int rcount = table.getNumberOfRows();
                    for (int i = 0; i < rcount; i++) {
                        XWPFTableRow row = table.getRow(i);
                        List<XWPFTableCell> cells = row.getTableCells();
                        for (XWPFTableCell cell : cells) {
                            String cellText = "";
                            cellText = cell.getText();
                            CharSequence cs = cellText.subSequence(0,
                                                                   cellText.length());
                            Pattern pattern = Pattern.compile(regex);
                            Matcher matcher = pattern.matcher(cs);
                            int startPosition = 0;
                            while (matcher.find(startPosition)) {
                                if (!al.contains(matcher.group())) {
                                    al.add(matcher.group());
                                }
                                startPosition = matcher.end();
                            }
                        }
                    }
                }
                return al;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    // 替换word中需要替换的特殊字符
    public static boolean replaceAndGenerateWord(String srcPath,
                                                 String destPath, Map<String, String> map) {
        String[] sp = srcPath.split("\\.");
        String[] dp = destPath.split("\\.");
        if ((sp.length > 0) && (dp.length > 0)) {// 判断文件有无扩展名
            // 比较文件扩展名
            if (sp[sp.length - 1].equalsIgnoreCase("docx")) {
                try {
                    CustomXWPFDocument document = new CustomXWPFDocument(
                            POIXMLDocument.openPackage(srcPath));
//                    // 替换段落中的指定文字
//                    Iterator<XWPFParagraph> itPara = document
//                            .getParagraphsIterator();
//                    while (itPara.hasNext()) {
//                        XWPFParagraph paragraph = (XWPFParagraph) itPara.next();
//                        List<XWPFRun> runs = paragraph.getRuns();
//                        for (int i = 0; i < runs.size(); i++) {
//                            String oneparaString = runs.get(i).getText(
//                                    runs.get(i).getTextPosition());
//                            for (Map.Entry<String, String> entry : map
//                                    .entrySet()) {
//                                oneparaString = oneparaString.replace(
//                                        entry.getKey(), entry.getValue());
//                            }
//                            runs.get(i).setText(oneparaString, 0);
//                        }
//                    }

                    // 替换表格中的指定文字
                    Iterator<XWPFTable> itTable = document.getTablesIterator();
                    while (itTable.hasNext()) {
                        XWPFTable table = (XWPFTable) itTable.next();
                        int rcount = table.getNumberOfRows();
                        for (int i = 0; i < rcount; i++) {
                            XWPFTableRow row = table.getRow(i);
                            List<XWPFTableCell> cells = row.getTableCells();
                            for (XWPFTableCell cell : cells) {
                                String cellTextString = cell.getText();
                                XWPFParagraph pargraph = null;
                                for (Entry<String, String> e : map.entrySet()) {
                                    if (cellTextString.contains(e.getKey())){
                                        if(e.getKey().indexOf("Img")>-1){
                                            File pic = new File(e.getValue());
                                            FileInputStream is = new FileInputStream(pic);
                                            cell.removeParagraph(0);
                                            pargraph = cell.addParagraph();
                                            String picId = document.addPictureData(is, XWPFDocument.PICTURE_TYPE_JPEG);
//                                            String ind = xwpf.addPictureData(is, XWPFDocument.PICTURE_TYPE_GIF);
//                                            int id =  xwpf.getNextPicNameNumber(XWPFDocument.PICTURE_TYPE_GIF);
//                                            xwpf.createPicture(ind, id, 80, 30,pargraph);
                                            document.createPicture(picId,document.getAllPictures().size()-1, 270, 30,pargraph);
                                            if(is != null){
                                                is.close();
                                            }
                                        }else{
                                            cellTextString = cellTextString
                                                    .replace(e.getKey(),
                                                            e.getValue());
                                            cell.removeParagraph(0);
                                            cell.setText(cellTextString);
                                        }

                                    }

                                }

                            }
                        }
                    }
                    FileOutputStream outStream = null;
//                    String strPath = "E:\\a\\aa\\aaa.txt";
//                    File file = new File(strPath);
//                    if(!file.exists())){
//                        file.file.mkdirs();
//                    }
                    File file=new File(destPath);
                    if (file.exists()){
                        file.delete();
                    }
                    File fileparent=file.getParentFile();
                    if (!fileparent.exists()){
                        fileparent.mkdirs();
                    }
                    file.createNewFile();

                    outStream = new FileOutputStream(destPath);
                    document.write(outStream);
                    outStream.close();
                    return true;
                } catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }

            } else
                // doc只能生成doc，如果生成docx会出错
                if ((sp[sp.length - 1].equalsIgnoreCase("doc"))
                        && (dp[dp.length - 1].equalsIgnoreCase("doc"))) {
                    HWPFDocument document = null;
                    try {
                        document = new HWPFDocument(new FileInputStream(srcPath));
                        Range range = document.getRange();
                        for (Entry<String, String> entry : map.entrySet()) {
                            range.replaceText(entry.getKey(), entry.getValue());
                        }
                        FileOutputStream outStream = null;
                        outStream = new FileOutputStream(destPath);
                        document.write(outStream);
                        outStream.close();
                        return true;
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                        return false;
                    } catch (IOException e) {
                        e.printStackTrace();
                        return false;
                    }
                } else {
                    return false;
                }
        } else {
            return false;
        }
    }

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        for(int i=0;i<10;i++) {
            String filepathString = "F:/ideawork/printmaven/src/main/4631.docx";
            String destpathString = "F:/ideawork/printmaven/src/main/4632.docx";
            long s = System.currentTimeMillis();
            Map<String, String> map = new HashMap<String, String>();
            map.put("${deal}", "检查全部合格");
            map.put("$reason", "上级指派");
            map.put("$pcompany", "河南安盛科技股份有限公司");
            map.put("$page", "1");
            map.put("$pageTatle", "2");
            map.put("$checkAddress", "郑州市化工路西三环");
            map.put("$lawPerson", "安青山");
            map.put("$type", "日常");
            //  map.put("$checkedPersonImg", "E:/other/poi/src/main/s.jpg");
            System.out.println(replaceAndGenerateWord(filepathString,
                                                      destpathString, map));
            System.out.println("耗时" + (System.currentTimeMillis() - s));
        }
    }
}