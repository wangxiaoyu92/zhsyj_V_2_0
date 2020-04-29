package com.zzhdsoft.mvc.workflow.util;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import com.zzhdsoft.mvc.workflow.Activity;
import com.zzhdsoft.mvc.workflow.Transition;
import com.zzhdsoft.mvc.workflow.WorkflowProcess;

public class WorkflowProcessSaxUtil extends DefaultHandler {
	private List<Activity> activityList = null;
	private List<Transition> transitionList = null;

	private Transition trans = null;
	private Activity activity = null;
	private String preTag = null;// 作用是记录解析时的上一个节点名称

	public List<Activity> getActivities() {
		return activityList;
	}

	public List<Transition> getTransitions() {
		return transitionList;
	}

	public static void main(String[] args) {
		try {
			// 加载资源文件 转化为一个输入流 book.xml需要放在src根目录下
			InputStream is = WorkflowProcessSaxUtil.class.getClassLoader()
					.getResourceAsStream(
							"com/zzhdsoft/mvc/workflow/员工请假申请流程.xml");
			WorkflowProcess workflowProcess = getWorkflowProcessData(is);
			List<Activity> activityList = null;
			List<Transition> transList = null;
			if (null != workflowProcess) {
				activityList = workflowProcess.getActivityList();
				transList = workflowProcess.getTransitionList();
				System.out.println("Activitie info=====");
				for (Activity act : activityList) {
					System.out.println("id:" + act.getId() + " type:"
							+ act.getType() + " name:" + act.getName()
							+ " xCoordinate:" + act.getXCoordinate()
							+ " yCoordinate:" + act.getYCoordinate()
							+ " width:" + act.getWidth() + " height:"
							+ act.getHeight());
				}
				System.out.println("Transition info=====");
				for (Transition trans : transList) {
					System.out.println("id:" + trans.getId() + " name:"
							+ trans.getName() + " from:" + trans.getFrom()
							+ " to:" + trans.getTo());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * getWorkflowProcessData的中文名称：解析读取工作流XML文件的数据
	 * 
	 * getWorkflowProcessData的概要说明：
	 * 
	 * @param xmlStream
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static WorkflowProcess getWorkflowProcessData(InputStream xmlStream)
			throws Exception {
		WorkflowProcess bean = null;
		List tmpList = null;
		List tmpList2 = null;
		SAXParserFactory factory = SAXParserFactory.newInstance();
		SAXParser parser = factory.newSAXParser();

		WorkflowProcessSaxUtil service = new WorkflowProcessSaxUtil();
		parser.parse(xmlStream, service);// 解析

		tmpList = service.getActivities();
		tmpList2 = service.getTransitions();
		if (null != tmpList && tmpList.size() > 0 && null != tmpList2
				&& tmpList2.size() > 0) {
			bean = new WorkflowProcess();
			bean.setActivityList(tmpList);
			bean.setTransitionList(tmpList2);
		}
		return bean;
	}

	@Override
	public void startDocument() throws SAXException {
		activityList = new ArrayList<Activity>();
		transitionList = new ArrayList<Transition>();
	}

	@Override
	public void startElement(String uri, String localName, String qName,
			Attributes attributes) throws SAXException {
		if ("Activitie".equals(qName)) {
			activity = new Activity();
			// <Activitie id="1" type="START_NODE"
			// name="员工请假" xCoordinate="22"
			// yCoordinate="39" width="80"
			// height="30"></Activitie>
			activity.setId(attributes.getValue(0));
			activity.setType(attributes.getValue(1));
			activity.setName(attributes.getValue(2));
			activity.setXCoordinate(attributes.getValue(3));
			activity.setYCoordinate(attributes.getValue(4));
			activity.setWidth(attributes.getValue(5));
			activity.setHeight(attributes.getValue(6));
		}
		if ("Transition".equals(qName)) {
			trans = new Transition();
			// <Transition id="8" name="请假发起" from="1"
			// to="2"></Transition>
			trans.setId(attributes.getValue(0));// 也可用attributes.getValue("id"));
			trans.setName(attributes.getValue(1));
			trans.setFrom(attributes.getValue(2));
			trans.setTo(attributes.getValue(3));
		}
		preTag = qName;// 将正在解析的节点名称赋给preTag
	}

	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {
		if ("Activitie".equals(qName)) {
			activityList.add(activity);
			activity = null;
		}
		if ("Transition".equals(qName)) {
			transitionList.add(trans);
			trans = null;
		}
		preTag = null;
		/**
		 * 当解析结束时置为空。这里很重要，例如，当图中画3的位置结束后，会调用这个方法
		 * ，如果这里不把preTag置为null，根据startElement(....)方法，preTag的值还是book，当文档顺序读到图
		 * 中标记4的位置时，会执行characters(char[] ch, int start, int
		 * length)这个方法，而characters(....)方
		 * 法判断preTag!=null，会执行if判断的代码，这样就会把空值赋值给book，这不是我们想要的。
		 */
	}

	@Override
	public void characters(char[] ch, int start, int length)
			throws SAXException {
		// if(preTag!=null){
		// String content = new String(ch,start,length);
		// if("name".equals(preTag)){
		// book.setName(content);
		// }else if("price".equals(preTag)){
		// book.setPrice(Float.parseFloat(content));
		// }
		// }
	}

	/**
	 * SAX解析器解析到结束文档节点时调用的方法
	 */
	public void endDocument() throws SAXException {
		// System.out.println("endDocument()。。。。。。。。。");
	}
}
