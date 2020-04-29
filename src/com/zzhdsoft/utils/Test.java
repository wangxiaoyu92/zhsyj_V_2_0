package com.zzhdsoft.utils;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import org.codehaus.xfire.client.Client;
import org.nutz.json.Json;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.zzhdsoft.utils.db.PubFunc;

public class Test {
	public static void main(String[] args) {
		try {
			// xfire方式调用
			// Client client = new Client(new URL(SignUtil.tmserverUrl));
			// Object[] results = client.invoke("QRDdzt", new
			// String[]{"XD1509150075","40","0"});
			// Document d = (Document)results[0];
			// System.out.println(d.getFirstChild());
			// NodeList nl = d.getElementsByTagName("QRDdztResponse");
			// NodeList n2 = nl.item(0).getChildNodes();
			// System.out.println(n2.getLength());
			// for (int i=0;i<n2.getLength();i++){
			// System.out.println(n2.item(i).getNodeName()+"::"+n2.item(i).getTextContent());
			// }

			// Client client2 = new Client(new
			// URL("http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx?wsdl"));
			// Object[] results2 = client2.invoke("qqCheckOnline", new
			// String[]{"35934591"});
			// System.out.println(results2[0]);
			//
			// Client client3 = new Client(new
			// URL("http://61.158.232.27/hhwl/services/PubService?wsdl"));
			// Object[] results3 = client3.invoke("execSQL", new
			// String[]{"sql","select * from aa01",""});
			// System.out.println(results3[0]);

			// axis方式调用
			Service service = new Service();
			Call call = null;
			call = (Call) service.createCall();// 定义service对象
			call.setTargetEndpointAddress(new URL(SignUtil.tmserverUrl));
			call.setOperationName(new QName("http://tempuri.org/", "QRDdzt"));// 接口方法：QRDdzt
			call.addParameter(new QName("http://tempuri.org/", "yhbh"),
					XMLType.SOAP_STRING, ParameterMode.IN);// 接口入参
			call.addParameter(new QName("http://tempuri.org/", "qdid"),
					XMLType.SOAP_STRING, ParameterMode.IN);// 接口入参
			call.addParameter(new QName("http://tempuri.org/", "sjzt"),
					XMLType.SOAP_STRING, ParameterMode.IN);// 接口入参
			call.setReturnType(XMLType.SOAP_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI("http://tempuri.org/QRDdzt");

			String retStr = PubFunc.toString(call.invoke(new Object[] {
					"XD1509150075", "40", "0" }));
			System.out.println("条码系统接口返回结果：" + retStr);
			Map map = (Map) Json.fromJson(retStr);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
