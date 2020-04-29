package com.zzhdsoft.utils;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.poi.hwpf.HWPFDocument;  
import org.apache.poi.hwpf.usermodel.Paragraph;  
import org.apache.poi.hwpf.usermodel.Range;  
import org.apache.poi.hwpf.usermodel.Table;  
import org.apache.poi.hwpf.usermodel.TableCell;  
import org.apache.poi.hwpf.usermodel.TableIterator;  
import org.apache.poi.hwpf.usermodel.TableRow; 
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public class POIWordUtil {
  /**
   * doc（2003）文档导入返回数组
   * @param sourceFile
   * @return
   * @throws Exception
   */
	public static List<Map>  poiWordTableInfo(String sourceFile) throws Exception{
		List<Map> list = new ArrayList<Map>();
		List<List<Map>> listmap = new ArrayList<List<Map>>();
		String itemname ="";
		try {
			FileInputStream in = new FileInputStream(sourceFile);// 载入文档
			POIFSFileSystem pfs = new POIFSFileSystem(in);
			HWPFDocument hwpf = new HWPFDocument(pfs);
			Range range = hwpf.getRange();// 得到文档的读取范围
			TableIterator it = new TableIterator(range);
			HashMap<String,String> map = new HashMap<String, String>();
			
			// 迭代文档中的表格
			while (it.hasNext()) {
				Table tb = (Table) it.next();
				
				String ss = "";
				String td0 = "";
				// 迭代行，默认从0开始
				for (int i = 0; i < tb.numRows(); i++) {
					TableRow tr = tb.getRow(i);
					// 迭代列，默认从0开始
					map = new HashMap<String, String>();

					for (int j = 0; j < tr.numCells(); j++) {
						TableCell td = tr.getCell(j);// 取得单元格
						// 取得单元格的内容
						for (int k = 0; k < td.numParagraphs(); k++) {
							Paragraph para = td.getParagraph(k);
							//单元格数据
							String s = para.text().replaceAll("", "").replaceAll("\n", "").replaceAll("\r", "");
//							if(j==0){
//								
//								if(s.replaceAll(" ", "").equals("")||s==null){
//									s=td0;
//								}else{
//									itemname = s;
//									
//									td0=s;
//								}
//							}
							map.put(""+j, s);
//							System.out.println(" key: "+j+ "   value:"+s);
						} // end for
					} // end for
					list.add(map);
				} // end for
			} // end while
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	  public static void main(String[] args) throws Exception  {  
		  String itemid = "2016072008503821562032502";
		  List<Map> list = POIWordUtil.poiWordTableInfo("G:\\药品生产企业监督检查主要内容模板.doc");
	  }
}  

