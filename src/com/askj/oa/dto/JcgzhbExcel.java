package com.askj.oa.dto;



import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;

import com.zzhdsoft.utils.SysmanageUtil;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

import java.util.*;



/**
 * Created by ce on 2018/5/22.
 */
public class JcgzhbExcel {
    /**
     *
     * 这个是单纯读取EXCEL数据
     * */
   /* public  void read() {
        StringBuffer sb = new StringBuffer();
        Workbook wb = null;
        try {
            File is = new File("e:\\ExcelTest\\try.xls");
            // 获取工作簿对象
            wb = Workbook.getWorkbook(is);
            if (wb != null) {
                // 获取工作簿对象就可以获取工作簿内的工作表对象
                Sheet[] sheets = wb.getSheets();
                if (sheets != null && sheets.length != 0) {
                    // 遍历工作簿内所有工作表
                    for (int i=0;i<sheets.length;i++) {
                        // 获取该工作表内的行数
                        int rows = sheets[i].getRows();
                        // 遍历行
                        for (int j=0;j<rows;j++) {
                            String cell ="";
                            // 获取当前行的所有单元格
                            Cell[] cells = sheets[i].getRow(j);
                            if (cells != null && cells.length != 0) {
                                // 遍历单元格
                                for (int k=0;k<cells.length;k++) {
                                    // 获取当前单元格的值
                                    if(!cells[k].getContents().equals("")){
                                        cell += cells[k].getContents();
                                    }
                                    // 缩进
                                    sb.append(cell + "\t");
                                }
                                System.out.println(cell);
                                sb.append("\t\n");
                            }
                        }
                        sb.append("\t\n");
                    }
                }
                System.out.println("成功读取了：" +is.getName()+ "\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //关闭
            wb.close();
        }
    }*/
    /**
     *
     * 这是单纯的写EXCEL表格
     * **/
   /* public void write(){
        WritableWorkbook wwb = null;
        Label label = null;
        String file ="e:\\ExcelTest\\3.xls";
        try {
            // 创建可写入的工作簿对象
            wwb = Workbook.createWorkbook(new File(file));
            if (wwb != null) {
                // 在工作簿里创建可写入的工作表，第一个参数为工作表名，第二个参数为该工作表的所在位置
                WritableSheet ws = wwb.createSheet("Sheet1", 2);
                if (ws != null) {
                    *//* 添加表结构 *//*
                    // 行
                    for (int i=0;i<5;i++) {
                        // 列
                        for (int j=0;j<5;j++) {
                            // Label构造器中有三个参数，第一个为列，第二个为行，第三个则为单元格填充的内容
                            label = new Label(j, i, "第"+(i+1)+"行，" + "第"+(j+1)+"列");
                            // 将被写入数据的单元格添加到工作表
                            ws.addCell(label);
                        }
                    }
                    // 从内存中写入到文件
                    wwb.write();
                }
                System.out.println("路径为：" + file + "的工作簿写入数据成功！");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                wwb.close();
            } catch (WriteException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }*/

    /**
     *
     * 这个是读取模板写入数据
     * **/
    public void readWriter(List<JcgzhbDTO> datalist,HttpServletRequest request, HttpServletResponse response){
       WritableWorkbook wwb=null;
        WritableSheet wws=null;
        FileOutputStream out =null;
        //获取要读取的EXCEL表格模板
        File is = new File(request.getSession().getServletContext()
                .getRealPath("/jsp/oa/moban/try.xls"));
        /*String filename="e:\\ExcelTest\\";*/
        //写入到新的表格里
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH )+1;
        int date = cal.get(Calendar.DATE);
        String filename="新稽查"+month+"月报汇总.xls";
        File f=new File(request.getSession().getServletContext()
                .getRealPath("/jsp/oa/moban/"), filename);
        try {
            //创建新文件
            f.createNewFile();
            out = new FileOutputStream(f);
            //获取工作簿对象
            Workbook wb = Workbook.getWorkbook(is);
            // 创建可写入的工作簿对象
            wwb = Workbook.createWorkbook(out, wb);
            //根据工作表名获取WritableSheet对象
            wws=wwb.getSheet("Sheet1");

            WritableCellFormat wcf=new WritableCellFormat();
            wcf.setAlignment(Alignment.CENTRE);//把水平对齐方式指定为居中
            wcf.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//把垂直对齐方式指定为居中
            //设置样式
         wcf.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);

            /*Label label=null;*/
            Label labe2=null;
            Label labe3=null;
            Label labe4=null;
            Label labe5=null;
            Label labe6=null;
            Label labe7=null;
            Label labe8=null;
            Label labe9=null;
            Label labe10=null;
            Label labe11=null;
            Label labe12=null;
            Label labe13=null;
            Label labe14=null;
            Label labe15=null;
            Label labe16=null;
            Label label7=null;
            Label labe18=null;
            Label labe19=null;
            Label labe20=null;
            Label labe21=null;
            Label labe22=null;
            Label labe23=null;
            Label labe24=null;
            Label labe25=null;
            Label labe26=null;
            Label labe27=null;
            Label labe28=null;

            List<String> list=new ArrayList<String>();
            //创建label对象设置value值j相当于是X轴I是Y轴位置
                for(int j=0;j<datalist.size();j++) {
                    JcgzhbDTO dr=new JcgzhbDTO();
                    dr=datalist.get(j);
                    Label label = new Label(0, j+6, dr.getOrgname(), wcf);
                    labe2 = new Label(1, j+6, dr.getLaby(), wcf);
                    labe3 = new Label(2, j+6, dr.getLalj(), wcf);
                    labe4 = new Label(3, j+6, dr.getJaby(), wcf);
                    labe5 = new Label(4, j+6, dr.getJalj(), wcf);
                    labe6 = new Label(5, j+6, dr.getYssfby(), wcf);
                    labe7 = new Label(6, j+6, dr.getYssflj(), wcf);
                    labe8 = new Label(7, j+6, dr.getZxfkby(), wcf);
                    labe9 = new Label(8, j+6, dr.getZxfklj(), wcf);
                    labe10 = new Label(9, j+6, dr.getAjxxgsrw(), wcf);
                    labe11 = new Label(10, j+6, dr.getAjxxgsby(), wcf);
                    labe12 = new Label(11, j+6, dr.getAjxxgslj(), wcf);
                    labe13 = new Label(12, j+6, dr.getCyjjrw(), wcf);
                    labe14 = new Label(13, j+6, dr.getCyjjby(), wcf);
                    labe15 = new Label(14, j+6, dr.getCyjjlj(), wcf);
                    labe16 = new Label(15, j+6, dr.getCjxxgsrw(), wcf);
                    label7 = new Label(16, j+6, dr.getCjxxgsby(), wcf);
                    labe18 = new Label(17, j+6, dr.getCjxxgslj(), wcf);
                    labe19 = new Label(18, j+6, dr.getBdwsltsjbby(), wcf);
                    labe20 = new Label(19, j+6, dr.getBdwsltsjblj(), wcf);
                    labe21 = new Label(20, j+6, dr.getSjjbtsjbby(), wcf);
                    labe22 = new Label(21, j+6, dr.getSjjbtsjblj(), wcf);
                    labe23 = new Label(22, j+6, dr.getSjjbwthcczrw(), wcf);
                    labe24 = new Label(23, j+6, dr.getSjjbwthcczby(), wcf);
                    labe25 = new Label(24, j+6, dr.getSjjbwthcczlj(), wcf);
                    labe26 = new Label(25, j+6, dr.getXcblrw(), wcf);
                    labe27 = new Label(26, j+6, dr.getXcblby(), wcf);
                    labe28 = new Label(27, j+6, dr.getXcbllj(), wcf);
                    //添加到工作薄中
                    wws.addCell(label);
                    wws.addCell(labe2);
                    wws.addCell(labe3);
                    wws.addCell(labe4);
                    wws.addCell(labe5);
                    wws.addCell(labe6);
                    wws.addCell(labe7);
                    wws.addCell(labe8);
                    wws.addCell(labe9);
                    wws.addCell(labe10);
                    wws.addCell(labe11);
                    wws.addCell(labe12);
                    wws.addCell(labe13);
                    wws.addCell(labe14);
                    wws.addCell(labe15);
                    wws.addCell(labe16);
                    wws.addCell(label7);
                    wws.addCell(labe18);
                    wws.addCell(labe19);
                    wws.addCell(labe20);
                    wws.addCell(labe21);
                    wws.addCell(labe22);
                    wws.addCell(labe23);
                    wws.addCell(labe24);
                    wws.addCell(labe25);
                    wws.addCell(labe26);
                    wws.addCell(labe27);
                    wws.addCell(labe28);
                    wws.setRowView( j+6 , 600 );
            }
          WritableFont font1 =
                    new WritableFont(WritableFont.TIMES, 10 );

            /*WritableCellFormat format1 = new WritableCellFormat(font1);*/
            WritableCellFormat wcf1=new WritableCellFormat(font1);
            wcf1.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//把垂直对齐方式指定为居中
            wcf1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
            Label labea= new Label(0, datalist.size()+6, "备注：该表仅供内部参考,抽检、投诉举报、不合格处置、公示的数据以省局平台数据为准。", wcf1);
            Label labeb = new Label(27, datalist.size()+6, "", wcf);
            wws.mergeCells(0,datalist.size()+6,27,datalist.size()+6);
           wws.addCell(labea);
            //将新建立的工作薄写入到磁盘
            WritableFont font2 =
                    new WritableFont(WritableFont.TIMES, 10 ,WritableFont.BOLD);
            WritableCellFormat wcf2=new WritableCellFormat(font2);
            wcf2.setAlignment(Alignment.CENTRE);//把水平对齐方式指定为居中
            wcf2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//把垂直对齐方式指定为居中
            wcf2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
            String s="稽查工作"+year+"年"+" "+month+" "+"月汇总表";
            Label labec= new Label(0, 0, s, wcf2);
            wws.setRowView( datalist.size()+6 , 600 );
            wws.addCell(labec);
            Sysuser vSysUser = SysmanageUtil.getSysuser();
            String orgname=vSysUser.getOrgname();
            String username=vSysUser.getDescription();
            String telphone=vSysUser.getTelephone();
            if(telphone==null){
                telphone="";
            }
            String time=year+"."+month+"."+date;
            String s2="填报单位:"+" "+orgname+"                                                           "+"填报人:"+" "+username+"                                                    "+"联系电话:"+" "+telphone+"                                                      "+"填报日期:"+""+time;
            Label labed= new Label(0, 1, s2, wcf1);
            wws.addCell(labed);
            wwb.write();
            } catch (Exception e) {
            e.printStackTrace();
        } finally{
            //关闭流
            try {
                wwb.close();
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }







    /**
     *
     * 这个是读取模板写入数据
     * **/
    public void readWriters(List<InformationDTO> datalist,HttpServletRequest request, HttpServletResponse response){


        WritableWorkbook wwb=null;
        WritableSheet wws=null;
        FileOutputStream out =null;
        //获取要读取的EXCEL表格模板
        File is = new File(request.getSession().getServletContext()
                .getRealPath("/jsp/oa/moban/info.xls"));
        /*String filename="e:\\ExcelTest\\";*/
        //写入到新的表格里
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH )+1;
        int date = cal.get(Calendar.DATE);
        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, year);
        a.set(Calendar.MONTH, month - 1);
        a.set(Calendar.DATE, 1);//把日期设置为当月第一天
        a.roll(Calendar.DATE, -1);//日期回滚一天，也就是最后一天
        int maxDate = a.get(Calendar.DATE);
        String filename="安阳市食品药品监督管理局"+month+"月份信息报送统计-览表.xls";
        File f=new File(request.getSession().getServletContext()
                .getRealPath("/jsp/oa/moban/"), filename);
        try {
            //创建新文件
            f.createNewFile();
            out = new FileOutputStream(f);
            //获取工作簿对象
            Workbook wb = Workbook.getWorkbook(is);
            // 创建可写入的工作簿对象
            wwb = Workbook.createWorkbook(out, wb);
            //根据工作表名获取WritableSheet对象
            wws=wwb.getSheet("Sheet1");

            WritableCellFormat wcf=new WritableCellFormat();
            wcf.setAlignment(Alignment.CENTRE);//把水平对齐方式指定为居中
            wcf.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//把垂直对齐方式指定为居中
            //设置样式
            wcf.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);

            /*Label label=null;*/
            Label labe2=null;
            Label labe3=null;
            Label labe4=null;
            Label labe5=null;
            Label labe6=null;
            Label labe7=null;
            Label labe8=null;
            Label labe9=null;
            List<String> list=new ArrayList<String>();
            //创建label对象设置value值j相当于是X轴I是Y轴位置
            for(int j=0;j<datalist.size();j++) {
                InformationDTO dr=new InformationDTO();
                dr=datalist.get(j);
                Label label = new Label(0, j+3, dr.getOrgname(), wcf);
                labe2 = new Label(1, j+3, dr.getYearnumber(), wcf);
                labe3 = new Label(2, j+3, dr.getMonthnumber(), wcf);
                labe4 = new Label(3, j+3, dr.getLjsb(), wcf);
                labe5 = new Label(4, j+3, dr.getBenyue(), wcf);
                labe6 = new Label(5, j+3, dr.getJuliang(), wcf);
                labe7 = new Label(6, j+3, dr.getYueliang(), wcf);
                labe8 = new Label(7, j+3, dr.getShengliang(), wcf);
                labe9 = new Label(8, j+3, dr.getYueshengliang(), wcf);

                //添加到工作薄中
                wws.addCell(label);
                wws.addCell(labe2);
                wws.addCell(labe3);
                wws.addCell(labe4);
                wws.addCell(labe5);
                wws.addCell(labe6);
                wws.addCell(labe7);
                wws.addCell(labe8);
                wws.addCell(labe9);
                wws.setRowView( j+3 , 600 );
            }
            WritableFont font1 =
                    new WritableFont(WritableFont.TIMES, 10 );

            /*WritableCellFormat format1 = new WritableCellFormat(font1);*/
            WritableCellFormat wcf1=new WritableCellFormat(font1);
            wcf1.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//把垂直对齐方式指定为居中
            wcf1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
            Label labea= new Label(0, datalist.size()+3, "备注：表中所有数据统计截止为"+month+"月"+maxDate+"日", wcf1);
            Label labeb = new Label(27, datalist.size()+3, "", wcf);
            wws.mergeCells(0,datalist.size()+3,8,datalist.size()+3);
            wws.addCell(labea);
            //将新建立的工作薄写入到磁盘
            WritableFont font2 =
                    new WritableFont(WritableFont.TIMES, 10 ,WritableFont.BOLD);
            WritableCellFormat wcf2=new WritableCellFormat(font2);
            wcf2.setAlignment(Alignment.CENTRE);//把水平对齐方式指定为居中
            wcf2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//把垂直对齐方式指定为居中
            wcf2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
            String s="安阳市食品药品监督管理局"+month+"月份信息报送统计-览表";
            Label labec= new Label(0, 0, s, wcf2);
            wws.setRowView( datalist.size()+3 , 600 );
            wws.addCell(labec);
            wwb.write();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            //关闭流
            try {
                wwb.close();
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

}
