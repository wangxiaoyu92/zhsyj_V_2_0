package com.zzhdsoft.mvc.workflow.util;

import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom.*;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.jdom.input.SAXBuilder;

/**
 * XML文档的工作作坊，提供一些基本的对xml的操作
 */
public class SimpleXMLWorkShop {
	/**
	 * 将磁盘文件解析成Document对象
	 * 
	 * @param filePath
	 *            String：磁盘文件路径,URI for the input
	 * @return Document
	 */
	public static Document file2Doc(String filePath) throws IOException,
			JDOMException {
		File file = new File(filePath);
		return file2Doc(file);
	}

	/**
	 * 将磁盘文件解析成Document对象
	 * 
	 * @param file
	 *            File：磁盘文件
	 * @return Document
	 */
	public static Document file2Doc(File file) throws IOException,
			JDOMException {
		SAXBuilder saxBuilder = new SAXBuilder();
		Document doc = saxBuilder.build(file);
		return doc;

	}

	/**
	 * 从xml脚本解析成Document对象
	 * 
	 * @param xmlStr
	 *            String
	 * @return Document
	 */
	public static Document str2Doc(String xmlStr) throws IOException,
			JDOMException {
		InputStream inputStream = new ByteArrayInputStream(xmlStr
				.getBytes(encoding));
		SAXBuilder saxBuilder = new SAXBuilder();
		Document doc = saxBuilder.build(inputStream);
		return doc;
	}

	/**
	 * 将Docment对象解析成脚本格式， 返回的是中文编码脚本
	 * 
	 * @param doc
	 *            Document
	 * @return String
	 */
	public static String doc2Str(Document doc) {
		if (doc == null) {
			return null;
		}

		Format format = Format.getPrettyFormat();
		format.setExpandEmptyElements(true);
		format.setEncoding(encoding);
		return doc2Str(doc, format);
	}

	public static String doc2Str(Document doc, Format format) {
		if (doc == null) {
			log.error("xml文档为空");
			return null;
		}

		XMLOutputter outputter = new XMLOutputter(format);
		String str = outputter.outputString(doc);

		return str;
	}

	/**
	 * 把Document写到指定路径的xml文件
	 * 
	 * @param doc
	 *            Document：要输出的Document对象
	 * @param filePath
	 *            String：输出的文件路径
	 */
	public static void outputXML(Document doc, String filePath)
			throws FileNotFoundException, IOException {
		outputXML(doc, new File(filePath));
	}

	public static void outputXML(Document doc, String filePath, Format format)
			throws FileNotFoundException, IOException {
		outputXML(doc, new File(filePath), format);
	}

	/**
	 * 把Document写到指定路径的xml文件
	 * 
	 * @param doc
	 *            Document：要输出的Document对象
	 * @param file
	 *            File：输出的文件路径
	 */
	public static void outputXML(Document doc, File file)
			throws FileNotFoundException, IOException {
		outputXML(doc, new FileOutputStream(file));
	}

	public static void outputXML(Document doc, File file, Format format)
			throws FileNotFoundException, IOException {
		outputXML(doc, new FileOutputStream(file), format);
	}

	/**
	 * 将Document 文档内容 写入到硬盘xml文件
	 * 
	 * @param doc
	 * @param outputStream
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void outputXML(Document doc, OutputStream outputStream)
			throws FileNotFoundException, IOException {
		if (doc == null) {
			log.error("输出时,xml文档为空,未进行输出操作");
			return;
		}

		Format format = Format.getPrettyFormat();
		format.setEncoding(encoding);
		format.setExpandEmptyElements(true);

		XMLOutputter outputter = new XMLOutputter(format);
		outputter.output(doc, outputStream);
		outputStream.close();
	}

	/**
	 * 将Document 文档内容 写入到硬盘xml文件,并返回结果
	 * 
	 * @param doc
	 * @param outputStream
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static boolean outputXMLWithResult(Document doc,
			OutputStream outputStream) {
		boolean saveOkFlag = false;
		try {
			if (doc == null) {
				log.error("输出时,xml文档为空,未进行输出操作");
			} else {
				Format format = Format.getPrettyFormat();
				format.setEncoding(encoding);
				format.setExpandEmptyElements(true);

				XMLOutputter outputter = new XMLOutputter(format);
				outputter.output(doc, outputStream);
				outputStream.close();
				saveOkFlag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return saveOkFlag;
	}

	public static void outputXML(Document doc, OutputStream outputStream,
			Format format) throws FileNotFoundException, IOException {
		if (doc == null) {
			log.error("输出时,xml文档为空,未进行输出操作");
			return;
		}

		XMLOutputter outputter = new XMLOutputter(format);
		outputter.output(doc, outputStream);
	}

	/**
	 * xml文件根据xsl样式表文件生成html文件
	 * 
	 * @param xmlFile
	 *            File
	 * @param htmlFile
	 *            File
	 * @param xslFile
	 *            File
	 */
	public static void xmlToHtml(File xmlFile, File htmlFile, File xslFile)
			throws TransformerConfigurationException, FileNotFoundException,
			TransformerException {
		TransformerFactory tFactory = TransformerFactory.newInstance();

		Transformer transformer = tFactory.newTransformer(new StreamSource(
				new FileInputStream(xslFile)));

		transformer.transform(new StreamSource(new FileInputStream(xmlFile)),
				new StreamResult(new FileOutputStream(htmlFile)));
	}

	/**
	 * Document根据xsl样式表文件生成html文件
	 * 
	 * @param doc
	 *            Document
	 * @param htmlFile
	 *            File
	 * @param xslFile
	 *            File
	 */
	public static void xmlToHtml(Document doc, File htmlFile, File xslFile)
			throws TransformerConfigurationException, FileNotFoundException,
			TransformerException {
		if (doc == null) {
			log.error("输出时,xml文档为空,未进行输出操作");
			return;
		}

		String xmlStr = doc2Str(doc);
		InputStream inputStream = new ByteArrayInputStream(xmlStr.getBytes());

		TransformerFactory tFactory = TransformerFactory.newInstance();
		Transformer transformer = tFactory.newTransformer(new StreamSource(
				new FileInputStream(xslFile)));

		transformer.transform(new StreamSource(inputStream), new StreamResult(
				new FileOutputStream(htmlFile)));
	}

	/**
	 * 改变编码格式
	 * 
	 * @param charactorSet
	 */
	public static void setEndocing(String charactorSet) {
		encoding = charactorSet;
	}

	/**
	 * @return Returns the encoding.
	 */
	public static String getEncoding() {
		return encoding;
	}

	// 日志记录器
	private static Log log = LogFactory.getLog(SimpleXMLWorkShop.class);

	// 默认编码方式
	private static String encoding = "UTF-8";

}