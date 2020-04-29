package com.zzhdsoft.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.w3c.dom.Document;

/**
 * poi完美word转html(表格、图片、样式)  
 * @author xml
 *
 */
public class Word2Html {
	//如果出现错误Exception in thread "main" java.lang.NoSuchMethodError: org.apache.poi.poifs.filesystem.POIFSFileSystem.getRoot()Lorg/apache/poi/poifs/filesystem/DirectoryNode;
	//请将JAR包中的poi-3.0.1-FINAL-20070705.jar，放在poi-3.8的包下面，否则会以poi-3.2-FINAL-20081019.jar为准，而认不到pio-3.7.jar，
	//或者直接将把poi的包移到最上面
	public static void main(String[] argv) {
		try {
			//System.out.println(convert2Html("D:\\新的行政处罚文书\\2 立案审批表.doc","D:\\新的行政处罚文书\\2 立案审批表.html"));
			System.out.println(convert2Html("E:\\新的行政处罚文书\\3 案件移送书.doc","E:\\新的行政处罚文书\\3 案件移送书.html"));
			System.out.println(convert2Html("E:\\新的行政处罚文书\\4 涉嫌犯罪案件移送审批表.doc","E:\\新的行政处罚文书\\4 涉嫌犯罪案件移送审批表.html"));
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 把WORD转换成HTML
	 * @param fileName
	 * @param outPutFile
	 * @return
	 */
	public static boolean convert2Html(String wordFilePath, String htmlSavePath){
		boolean convertFlag=false; 
		try {
			String saveDir=wordFilePath.substring(0,wordFilePath.lastIndexOf(SeparatorUtil.getFileSeparator())+1);
			HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(wordFilePath));//WordToHtmlUtils.loadDoc(new FileInputStream(inputFile));  
			WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());  
			wordToHtmlConverter.setPicturesManager(new PicturesManager() {
				public String savePicture(byte[] content, PictureType pictureType,
						String suggestedName, float widthInches, float heightInches) {
					//html 中  图片标签中 显示的图片路路径  <img src="d:/test/0.jpg"/>  
					return suggestedName;//"test/" + suggestedName;
				}
			});
			wordToHtmlConverter.processDocument(wordDocument);
			//生成WORD中的图片
			List pics = wordDocument.getPicturesTable().getAllPictures();
			if (pics != null) {
				for (int i = 0; i < pics.size(); i++) {
					Picture pic = (Picture) pics.get(i);
					try {
						//word中图片的存储路径
						pic.writeImageContent(new FileOutputStream(saveDir+ pic.suggestFullFileName()));
					} catch (FileNotFoundException e) {
						e.printStackTrace();
					}
				}
			}
			Document htmlDocument = wordToHtmlConverter.getDocument();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			DOMSource domSource = new DOMSource(htmlDocument);
			StreamResult streamResult = new StreamResult(out);

			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer serializer = tf.newTransformer();
			serializer.setOutputProperty("encoding", "GB2312");//一定要改成“GB2312”
			serializer.setOutputProperty("indent", "yes");
			serializer.setOutputProperty("method", "html");
			serializer.transform(domSource, streamResult);
			out.close();
			writeFile(new String(out.toByteArray()), htmlSavePath);
			
			convertFlag=true;
		} catch (Exception e) {
			e.printStackTrace();
			convertFlag=false;
		} 
		return convertFlag;
	}
	
	/**
	 * 把内容写进文件
	 * @param content
	 * @param saveFilePath
	 */
	public static void writeFile(String content, String saveFilePath) {
		FileOutputStream fos = null;
		BufferedWriter bw = null;
		try {
			File file = new File(saveFilePath);
			fos = new FileOutputStream(file);
			bw = new BufferedWriter(new OutputStreamWriter(fos, "GB2312"));//一定要改成“GB2312”
			bw.write(content);
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
			try {
				if (bw != null) {
					bw.close();
				}
				if (fos != null) {
					fos.close();
				}
			} catch (IOException localIOException1) {
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
			try {
				if (bw != null) {
					bw.close();
				}
				if (fos != null) {
					fos.close();
				}
			} catch (IOException localIOException2) {
			}
		} finally {
			try {
				if (bw != null) {
					bw.close();
				}
				if (fos != null) {
					fos.close();
				}
			} catch (IOException localIOException3) {
			}
		}
	}

	
}
