package com.zzhdsoft.siweb.service.sysmanager;

import com.lbs.commons.GlobalNameS;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.HttpUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.httpclient.Header;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.util.Calendar;
import java.util.Map;

/**
 * 
 * SysEasemobService 的中文名称：环信用户管理service
 * 
 * SysEasemobService 的描述：
 * 
 * Written by : zjf
 */
public class SysEasemobService {
	protected final Logger logger = Logger.getLogger(SysEasemobService.class);
	private static final String URL_Easemob = "http://a1.easemob.com/"+SysmanageUtil.getAa01("EASE_ORGNAME").getAaa005()+"/"+SysmanageUtil.getAa01("EASE_APPNAME").getAaa005()+"/";
	private static String contentType = "application/x-www-form-urlencoded";
	private static String charset = "UTF-8";
	private static JSONObject token = null;
	private static Calendar tokenExpiresIn = null;

	public SysEasemobService(){

	}
	private static SysEasemobService sysEasemobService;

	public static SysEasemobService getInstance(){
		if (sysEasemobService == null){
			sysEasemobService = new SysEasemobService();
		}
		return sysEasemobService;
	}

	/**
	 *
	 * getEasemobToken 的中文名称：获取tocken
	 *
	 * getEasemobToken 的概要说明:
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	private static void getEasemobToken(){

		if (token==null) {
			getToken();
		}else{
			if(token.containsKey("expires_in")){

				Calendar now = Calendar.getInstance();
				if(now.after(tokenExpiresIn)){
					getToken();
				}
			}
		}
	}

	private static void getToken(){
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("grant_type", "client_credentials");
		jsonObject.put("client_id", SysmanageUtil.getAa01("EASE_CLIENT_ID").getAaa005());
		jsonObject.put("client_secret", SysmanageUtil.getAa01("EASE_CLIENT_SECRET").getAaa005());
		Map map = HttpUtil.postXmlRequest(URL_Easemob + "token", jsonObject.toString(), contentType, charset);

		if (map.get("statusCode").toString().equals("200")) {
			token = JSONObject.fromObject(map.get("bodyContent"));
			Calendar tokenExpiresIn = Calendar.getInstance();
			int expiresIn =token.getInt("expires_in");
			tokenExpiresIn.add(Calendar.SECOND,expiresIn-20);
		}
	}

	/**
	 *
	 * querySysuserByUsername的中文名称：查询用户
	 *
	 * querySysuserByUsername的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	public static boolean addSysuserToEasemob(Sysuser dto){
		getInstance().getToken();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("username",dto.getUserid());
		//gu20180804 jsonObject.put("password", dto.getPasswd()); 默认为123456
		jsonObject.put("password", "e10adc3949ba59abbe56e057f20f883e");
		JSONArray userArray = new JSONArray();
		userArray.add(jsonObject);
		Header header = new Header();
		header.setName("Authorization");
		header.setValue("Bearer "+token.getString("access_token"));
		Map map = HttpUtil.postXmlRequestWithHeader(URL_Easemob+"users",header,userArray.toString(),contentType,charset);

		if(map.get("statusCode").toString().equals("200")){
			System.out.println(JSONObject.fromObject(map.get("bodyContent")).toString());
			return updNicknameToEasemob(dto);
		};
		return false;

	}



	/**
	 *
	 * querySysuserByUsername的中文名称：查询用户
	 *
	 * querySysuserByUsername的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	public boolean delSysuserFromEasemob(Sysuser dto){
		getInstance().getToken();
		Header header = new Header();
		header.setName("Authorization");
		header.setValue("Bearer "+token.getString("access_token"));
		Map map = HttpUtil.httpDeleteWithHeader(URL_Easemob+"users/"+dto.getUserid(),header,contentType,charset);

		if(map.get("statusCode").toString().equals("200")){
			System.out.println(JSONObject.fromObject(map.get("bodyContent")).toString());
			return true;
		}
        return false;
	}

	/**
	 *
	 * querySysuserByUsername的中文名称：查询用户
	 *
	 * querySysuserByUsername的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	public static boolean updNicknameToEasemob(Sysuser dto){
		getInstance().getToken();
		JSONObject userObject = new JSONObject();
		userObject.put("nickname",dto.getDescription());
		Header header = new Header();
		header.setName("Authorization");
		header.setValue("Bearer "+token.getString("access_token"));
		Map map = HttpUtil.postXmlRequestWithHeader(URL_Easemob+"users/"+dto.getUserid(),header,userObject.toString(),contentType,charset);
		if(map.get("statusCode").toString().equals("200")){
			System.out.println(JSONObject.fromObject(map.get("bodyContent")).toString());
			return true;
		};
		return  false;

	}

	/**
	 *
	 * querySysuserByUsername的中文名称：查询用户
	 *
	 * querySysuserByUsername的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	public void resetSysuserPasswordToEasemob(Sysuser dto){
		getInstance().getToken();
		JSONObject userObject = new JSONObject();
		//gu20180803 userObject.put("newpassword",dto.getPasswd());
		userObject.put("newpassword","e10adc3949ba59abbe56e057f20f883e");
		Header header = new Header();
		header.setName("Authorization");
		header.setValue("Bearer "+token.getString("access_token"));
		Map map = HttpUtil.postXmlRequestWithHeader(URL_Easemob+"users/"+dto.getUserid()+"/password",header,userObject.toString(),contentType,charset);
		if(map.get("statusCode").toString().equals("200")){
			System.out.println(JSONObject.fromObject(map.get("bodyContent")).toString());
		}
	}


	/**
	 *
	 * querySysuserByUsername的中文名称：查询用户
	 *
	 * querySysuserByUsername的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	public boolean addSysuserEasemobFriend(Sysuser dto){
		getInstance().getToken();
		JSONObject userObject = new JSONObject();
		//userObject.put("nickname",dto.getDescription());
		Header header = new Header();
		header.setName("Authorization");
		header.setValue("Bearer "+token.getString("access_token"));
		Map map = HttpUtil.postXmlRequestWithHeader(URL_Easemob+"users/"+dto.getUserid()+"/contacts/users/"+dto.getEasemobfriend(),header,userObject.toString(),contentType,charset);
		if(map.get("statusCode").toString().equals("200")){
			System.out.println(JSONObject.fromObject(map.get("bodyContent")).toString());
			return true;
		}
        return false;
	}


	/**
	 *
	 * delEasemobFriend的中文名称：删除环信好友
	 *
	 * delEasemobFriend的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	public boolean delEasemobFriend(Sysuser dto){
		getInstance().getToken();
		JSONObject userObject = new JSONObject();
		//userObject.put("nickname",dto.getDescription());
		Header header = new Header();
		header.setName("Authorization");
		header.setValue("Bearer "+token.getString("access_token"));
		//Map map = HttpUtil.httpDeleteWithHeader(URL_Easemob+"users/"+dto.getUserid(),header,contentType,charset);
		Map map = HttpUtil.httpDeleteWithHeader(URL_Easemob+"users/"+dto.getUserid()+"/contacts/users/"+dto.getEasemobfriend(),header,contentType,charset);
		if(map.get("statusCode").toString().equals("200")){
			System.out.println(JSONObject.fromObject(map.get("bodyContent")).toString());
			return true;
		}
        return false;
	}



	private static void main(String[] args){
		try {
			Sysuser sysuserDTO = new Sysuser();
//			sysuserDTO.setPasswd("15f9cb78d3eb6b8bdc6846cf82468408");
//			sysuserDTO.setUsername("2016072715441672476751578");
//			getInstance().delSysuserFromEasemob(sysuserDTO);

//			sysuserDTO.setUsername("2018061412062200057270495");
//			sysuserDTO.setPasswd("c8837b23ff8aaa8a2dde915473ce0991");
//			addSysuserToEasemob(sysuserDTO);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


}
