package com.askj.baseinfo.service;

import com.alibaba.fastjson.JSONObject;
import com.askj.baseinfo.dto.*;
import com.askj.baseinfo.entity.*;
import com.askj.baseinfo.service.pub.PubService;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.validate.ValidateData;
import com.lbs.util.StringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Aa26;
import com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog;
import com.zzhdsoft.siweb.entity.sysmanager.Sysorg;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuserrole;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.*;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 企业基本信息 业务逻辑层
 * 
 * @author CatchU
 * 
 */
@IocBean
public class PcompanyService extends BaseService {

	protected final Logger logger = Logger.getLogger(PcompanyService.class);

	@Inject
	private Dao dao;
	@Inject
	private PubService pubService;		
//	private BeanCopyUtil beanCopyUtil=new BeanCopyUtil();


	/**
	 * 添加企业信息 完成的是注册功能
	 * @throws Exception 
	 */
	public void savePcompany(HttpServletRequest request, final PcompanyDTO dto) throws Exception {
		//String qyid=null;
		//try {
			//qyid=savePcompanyImpl(request, dto);
		savePcompanyImpl(request, dto);
		//} catch (Exception e) {
		//	return Lang.wrapThrow(e).getMessage();
		//}
		//return qyid;
	}

	/**
	 * 保存企业信息的实现方法 使用事务控制
	 * 
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	@Aop( { "trans" })
	public void  savePcompanyImpl(HttpServletRequest request, PcompanyDTO dto) throws Exception {
		// 声明企业代码是全局变量,因为企业表和企业附件表均用到了
		//String qyid=null;
		String v_orgid ="";
		if(dto.getOrgid()!=null && !"".equals(dto.getOrgid())){
			 v_orgid = dto.getOrgid();//gu20160823 手机传的有
		}else{
			 v_orgid = SysmanageUtil.getSysuser().getOrgid();//gu20160823
		}
		
		String v_comdm = "";
		if (null == dto.getComid() || "".equals(dto.getComid())) {// 生成企业代码
			v_comdm = SysmanageUtil.getComdm();
		} else {// 获取企业代码
			v_comdm = dto.getComdm();
		}
		String v_syqylx=SysmanageUtil.getComsyqylx(dto.getComdalei());
		
		//gu20170919 手机传的重新获取操作员信息begin
		Sysuser v_Sysuser=null;
		if (dto.getSjordnbz()!=null && "2".equals(dto.getSjordnbz())){
			v_Sysuser=SysmanageUtil.g_getGlobalSysUser(dto.getUserid());
		}else{
			v_Sysuser= (Sysuser)SysmanageUtil.getSysuser();
		};
		//gu20170919end
		
		//gu20161025 手机号码可以作为企业用的登录账号，所以限制唯一性
//gu20161228		if (dto.getComyddh()!=null && !"".equals(dto.getComyddh())){
//			String v_mysql="select a.comid from pcompany a where a.comyddh='"+
//		      dto.getComyddh()+"' and a.comid<>'"+dto.getComid()+"'";
//			List<Pcompany> v_mycomlist = (List<Pcompany>)DbUtils.getDataList(v_mysql, Pcompany.class);
//			if (v_mycomlist.size()>0){
//				throw new BusinessException("保存失败：手机号码已经存在");
//			}
//		}

		// 首先判断用户是更新还是添加操作
		if (null != dto.getComid() && !"".equals(dto.getComid())) {// 更新，通过id找到本条数据而后跟新
			Pcompany pcompany = dao.fetch(Pcompany.class, dto.getComid());
			//手机号变了，要更换登录用户手机号
			String v_oldComyddh=pcompany.getComyddh();
			if (dto.getComyddh()!=null && !"".equals(dto.getComyddh()) && v_oldComyddh!=null && !v_oldComyddh.equals(dto.getComyddh())){
				String v_exesql="update sysuser a set a.mobile='"+dto.getComyddh()+
						 "' where userid='"+dto.getComid()+"'";
				Sql myesql = Sqls.create(v_exesql);
				dao.execute(myesql);				
			}
			//try{
			    new BeanCopyUtil().copyProperties(dto,pcompany , BeanCopyUtil.ONLY_CHANGE);
			//}catch(Exception e){
			//	e.printStackTrace();
			//}
//			BeanHelper.copyProperties(dto, pcompany); // 拷贝对应的从前台传来的数据
			
			pcompany.setComsyqylx(v_syqylx);
			//企业名称拼音
			pcompany.setCommcjc(PinYinUtil.GetChineseSpell(pcompany.getCommc()));
			//gu20171123 如果经纬度为空，但地址不为空自动填充经纬度
			if (StringUtils.isEmpty(pcompany.getComjdzb()) && !StringUtils.isEmpty(pcompany.getComdz())){
				getLngLatFromAddress(pcompany);
			}	
			dao.update(pcompany);
			saveComdalei(dto.getComdalei(),dto.getComid());
			saveComxiaolei(dto.getComxiaolei(),dto.getComid());
			
			//gu20170916 手机端传过来的没有企业大类名称，但目前企业表采用的冗余设计，
			//需要有企业大类名称,所以再更新下
			if (StringUtils.isEmpty(dto.getComdaleiname())){
				updateComleibieMc(dto.getComid());
			};
			
			//gu20170425 往主体信息表同步数据 
			HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(dto.getComid());
			v_HviewjgztDTO.setDokind("update");
			v_HviewjgztDTO.setTablemc("pcompany");
			HviewjgztManage(v_HviewjgztDTO);
			
		} else {// 添加
			//根据企业名称 判断企业是否存在
/*20171123临时去了			String v_sql="select comdm from pcompany where commc='"+
			   dto.getCommc() +"'";
			
		    List v_comlist=DbUtils.getDataList(v_sql,Pcompany.class);
		    if (v_comlist!=null && v_comlist.size()>0){
		    	throw new BusinessException("该单位名称已经存在！");
		    }*/
		    
			String comid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
			Pcompany pcompany = new Pcompany();
			new BeanCopyUtil().copyProperties(dto,pcompany , BeanCopyUtil.ONLY_CHANGE);
			pcompany.setComid(comid);
			pcompany.setComdm(v_comdm);
			pcompany.setComshbz("1"); // 先默认为已审核
			pcompany.setComdzcsj(v_dbtime);
			pcompany.setComsyqylx(v_syqylx);
			pcompany.setComfwnfww("0");//0:范围内，1:范围外
			pcompany.setOrgid(v_orgid);
			String v_orderno=v_comdm.substring(1);
			Long l=Long.parseLong(v_orderno)*10;
			v_orderno=l.toString();
			pcompany.setOrderno(v_orderno);
			//企业名称拼音
			pcompany.setCommcjc(PinYinUtil.GetChineseSpell(pcompany.getCommc()));
			//gu20171123 如果经纬度为空，但地址不为空自动填充经纬度
			if (StringUtils.isEmpty(pcompany.getComjdzb()) && !StringUtils.isEmpty(pcompany.getComdz())){
				getLngLatFromAddress(pcompany);
			}			
			dao.insert(pcompany);
			//qyid=comid;
			dto.setComid(comid);
			
			saveComdalei(dto.getComdalei(),dto.getComid());
			saveComxiaolei(dto.getComxiaolei(),dto.getComid());
			//gu20170916 手机端传过来的没有企业大类名称，但目前企业表采用的冗余设计，
			//需要有企业大类名称,所以再更新下
			if (StringUtils.isEmpty(dto.getComdaleiname())){
				updateComleibieMc(dto.getComid());
			};
			
			//保存企业门头照 图片
			FjDTO v_fjdto=new FjDTO();			
			v_fjdto.setFjwid(comid);	
			v_fjdto.setFolderName("company");
			
			v_fjdto.setFjpath(dto.getQymtzpath());
			v_fjdto.setFjname(dto.getQymtzname());
			v_fjdto.setFjtype("4");
			pubService.saveFjWuzhuti(request,v_fjdto);
            //gu20180601 检测机构自动生成个机构，机构归属当前操作员orgid，这样就要求增加检测机构用系统默认的系统管理员添加
			String v_new_orgid = DbUtils.getSequenceStr();
			String v_jigouleixing="a";
			if (dto.getComdalei().indexOf("106001")!=-1) {//106001 检验检测机构
				v_jigouleixing="jiancejigou";
				Sysorg sysorg = new Sysorg();
				v_new_orgid = DbUtils.getSequenceStr();
				sysorg.setOrgid(v_new_orgid);
				sysorg.setParent(v_Sysuser.getOrgid());
				sysorg.setOrgname(dto.getCommc());
				sysorg.setShortname(dto.getCommcjc());
				sysorg.setOrgdesc(dto.getCommc());
				//gu20160818add机构编码后台自动生成
				Sysorg v_sysorg=dao.fetch(Sysorg.class, Cnd.where("orgid","=",v_Sysuser.getOrgid()));
				String v_neworgcode=SysmanageUtil.fun_getOrgCode(v_sysorg.getOrgcode(),v_Sysuser.getOrgid());
				sysorg.setOrgcode(v_neworgcode);
				dao.insert(sysorg);
			};
			
			// gu20160621企业新增后往sysuser表插入一条
			if ("1".equals(SysmanageUtil.g_ADDCOMCREATEUSER)){
				Sysuser v_newSysuser = new Sysuser();
				v_newSysuser.setUserid(comid);
				v_newSysuser.setUsername(v_comdm);
				v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
				if (!"jiancejigou".equals(v_jigouleixing)){
					v_newSysuser.setUserkind("6");
				}else{
					v_newSysuser.setUserkind("20");
				}

				v_newSysuser.setDescription(pcompany.getCommc());
				v_newSysuser.setAaa027(dto.getAaa027());
				if (!"jiancejigou".equals(v_jigouleixing)){
					v_newSysuser.setOrgid("2016062217255064055994870");
				}else{
					v_newSysuser.setOrgid(v_new_orgid);
				}

				v_newSysuser.setMobile(dto.getComyddh());//gu20161020add
				v_newSysuser.setAaz001(comid);//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
				v_newSysuser.setSelfcomflag("0");
				v_newSysuser.setUserjc(PinYinUtil.GetChineseSpell(pcompany.getCommc()));
				v_newSysuser.setUsercomid(comid);//gu20180519
				
				Sysuserrole v_Sysuserrole=new Sysuserrole();
				String v_USERROLEID = DbUtils.getSequenceStr();
				v_Sysuserrole.setUserroleid(v_USERROLEID);
				v_Sysuserrole.setUserid(comid);
				v_Sysuserrole.setRoleid("2016062216563315846077196");//食品溯源企业角色
				//如果检验检测标志位1
				//gu20170507改为根据企业大类判断				if (dto.getComjyjcbz()!=null && !"".equals(dto.getComjyjcbz())
				//						&& "1".equals(dto.getComjyjcbz())){
				//					v_Sysuserrole.setRoleid("2016102114210245464588122");
				//				}
				if (dto.getComdalei().indexOf("106001")!=-1){ //106001检验检测机构
					v_Sysuserrole.setRoleid("2016102114210245464588122");//检验检测企业角色
				}	
				
				//gu20170517 2017050808505220967617753 生产企业角色
				if (dto.getComdalei().indexOf("101101")!=-1){ //101101食品生产企业
					v_Sysuserrole.setRoleid("2017050808505220967617753");//生产企业角色
				}
				
				dao.insert(v_newSysuser);
				dao.insert(v_Sysuserrole);
			}
//			if(null!=dto.getComxkzbh() && !"".equals(dto.getComxkzbh())) {
//				String comXkzJson = "[{'comxkzid':'" + DbUtils.getSequenceStr() + "','comid':'" + dto.getComid() + "','comxkzbh':'" + dto.getComxkzbh() + "','comxkfw':'" 
//			     + dto.getComxkfw() + "','comxkyxqq':'" + dto.getComxkyxqq() 
//			     + "','comxkyxqz':'" + dto.getComxkyxqz() + "'}]";
//				addXkz(comXkzJson, dto.getComid());
//			}
			
			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(comid);
			v_HviewjgztDTO.setDokind("add");
			v_HviewjgztDTO.setTablemc("pcompany");
			HviewjgztManage(v_HviewjgztDTO);
		}///add end
		
		//gu20161020add 单位资质证明
		if (dto.getSjordnbz()!=null && "2".equals(dto.getSjordnbz())){
			addXkz(dto.getComzzzmlist(), dto.getComid()); // 插入许可证
		}
		//gu20180622 手机端扫描二位码，增加企业时，传的是两个日常监督管理人员名称
		if (StringUtils.isEmpty(dto.getComrcjdglryid())&&(StringUtils.isNotEmpty(dto.getComrcjdglrymc()))){
			String v_comrcjdglryid=getRcjdglryid(v_Sysuser.getAaa027(),v_Sysuser.getOrgid(),dto.getComrcjdglrymc());
			dto.setComrcjdglryid(v_comrcjdglryid);
		}
		//gu20170413 增加企业日常监督管理人员
		addComRcjdglry(dto.getComrcjdglryid(),dto.getComid(),v_Sysuser);
	};

	//置顶
	public String sort(HttpServletRequest request,@Param("..") PcompanyDTO dto,String i) throws Exception {
		//String v_sql="select max(orderno)+1 orderno from pcompany where comdalei = "+dto.getComdalei();
		String v_sql="select max(orderno)+1 orderno from pcompany ";
        String v_orderno= DbUtils.getOneValue(dao,v_sql);
        Sql v_exesql=Sqls.create("update pcompany set orderno='"+v_orderno+"' where comid='"+dto.getComid()+"'");
		dao.execute(v_exesql);
        return v_orderno;
		//List<PcompanyDTO> dalei=(List<PcompanyDTO>)DbUtils.getDataList(v_sql,PcompanyDTO.class);

//		if(dalei.size()>0){
//			Long l=Long.parseLong(dalei.get(0).getOrderno());
//			l+=1;
//			return l.toString();
//		}else{
//			return null;
//		}
	}

	//置底
	public String bottom(HttpServletRequest request,@Param("..") PcompanyDTO dto,String i) throws Exception {
/*		String v_sql="select min(orderno+0) orderno from pcompany where comdalei = "+dto.getComdalei();

		List<PcompanyDTO> dalei=(List<PcompanyDTO>)DbUtils.getDataList(v_sql,PcompanyDTO.class);

		if(dalei.size()>0){
			Long l=Long.parseLong(dalei.get(0).getOrderno());
			l-=1;
			return l.toString();
		}else{
			return null;
		}*/

		String v_sql="select min(orderno)-1 orderno from pcompany ";
		String v_orderno= DbUtils.getOneValue(dao,v_sql);
		Sql v_exesql=Sqls.create("update pcompany set orderno='"+v_orderno+"' where comid='"+dto.getComid()+"'");
		dao.execute(v_exesql);
		return v_orderno;

	}

	@SuppressWarnings("rawtypes")
	public void getLngLatFromAddress(Pcompany Pcombean) throws Exception {
		String address = StringHelper.showNull2Empty(Pcombean.getComdz());
		if (!"".equals(address)) {
			try{
			Map ssMap = GaodeUtil.getMapLngAndLat(address);
			//Pcompany pcompany = dao.fetch(Pcompany.class, dto.getComid());
			if (ssMap!=null && !ssMap.isEmpty()){
				Pcombean.setComjdzb(ssMap.get("lng").toString());
				Pcombean.setComwdzb(ssMap.get("lat").toString());				
			}
			}catch(Exception e){
				e.printStackTrace();
			}

			//dao.update(pcompany);
		}
	}	
	
	/**
	 *
	 * updateComleibieMc的中文名称：更新企业类别名称
	 *
	 * updateComleibieMc的概要说明：
	 *
	 * @return Written by : sunyifeng
	 * @throws Exception 
	 *
	 */
	public void updateComleibieMc(String comid) throws Exception {
	    Pcompany v_pcom=dao.fetch(Pcompany.class, comid);
		String v_sql="select a.comdalei,b.aaa103 as comdaleiname "+
		  " from pcompanycomdalei a,viewcomdalei b "+
		  " where a.comdalei=b.aaa102 "+
		  " and a.comid='"+comid+"' ";
		
		List<PcompanyComdalei> v_daleilist=(List<PcompanyComdalei>)DbUtils.getDataList(v_sql, PcompanyComdalei.class);
	    String v_comdaleimc="";
	    for (PcompanyComdalei v_da:v_daleilist){
	    	if ("".equals(v_comdaleimc)){
	    		v_comdaleimc=v_da.getComdaleiname();
	    	}else{
	    		v_comdaleimc=v_comdaleimc+"|"+v_da.getComdaleiname();
	    	}
	    };
		v_sql="select a.comxiaolei,b.aaa103 as comxiaoleiname "+
				  " from Pcomxiaolei a,viewcomxiaolei b "+
				  " where a.comxiaolei=b.aaa102 "+
				  " and a.comid='"+comid+"' ";
		
		List<Pcomxiaolei> v_xiaoleilist=(List<Pcomxiaolei>)DbUtils.getDataList(v_sql, Pcomxiaolei.class);
	    String v_comxiaoleimc="";
	    for (Pcomxiaolei v_xiao:v_xiaoleilist){
	    	if ("".equals(v_comxiaoleimc)){
	    		v_comxiaoleimc=v_xiao.getComxiaoleiname();
	    	}else{
	    		v_comxiaoleimc=v_comxiaoleimc+"|"+v_xiao.getComxiaoleiname();
	    	}
	    };	  
	    
	    v_pcom.setComdaleiname(v_comdaleimc);
	    v_pcom.setComxiaoleiname(v_comxiaoleimc);
	    dao.update(v_pcom);
	}	
	
	/**
	public void  savePcompanyImplback(HttpServletRequest request, PcompanyDTO dto) throws Exception {
		// 声明企业代码是全局变量,因为企业表和企业附件表均用到了
		//String qyid=null;
		String v_orgid ="";
		if(dto.getOrgid()!=null && !"".equals(dto.getOrgid())){
			 v_orgid = dto.getOrgid();//gu20160823 手机传的有
		}else{
			 v_orgid = SysmanageUtil.getSysuser().getOrgid();//gu20160823
		}
		
		String v_comdm = "";
		if (null == dto.getComid() || "".equals(dto.getComid())) {// 生成企业代码
			v_comdm = SysmanageUtil.getComdm();
		} else {// 获取企业代码
			v_comdm = dto.getComdm();
		}
		String v_syqylx=SysmanageUtil.getComsyqylx(dto.getComdalei());
		//gu20161025 手机号码可以作为企业用的登录账号，所以限制唯一性
//gu20161228		if (dto.getComyddh()!=null && !"".equals(dto.getComyddh())){
//			String v_mysql="select a.comid from pcompany a where a.comyddh='"+
//		      dto.getComyddh()+"' and a.comid<>'"+dto.getComid()+"'";
//			List<Pcompany> v_mycomlist = (List<Pcompany>)DbUtils.getDataList(v_mysql, Pcompany.class);
//			if (v_mycomlist.size()>0){
//				throw new BusinessException("保存失败：手机号码已经存在");
//			}
//		}
		
		
		// 首先判断用户是更新还是添加操作
		if (null != dto.getComid() && !"".equals(dto.getComid())) {// 更新，通过id找到本条数据而后跟新
			Pcompany pcompany = dao.fetch(Pcompany.class, dto.getComid());
			//手机号变了，要更换登录用户手机号
			String v_oldComyddh=pcompany.getComyddh();
			if (dto.getComyddh()!=null && !"".equals(dto.getComyddh()) && !v_oldComyddh.equals(dto.getComyddh())){
				String v_exesql="update sysuser a set a.mobile='"+dto.getComyddh()+
						 "' where userid='"+dto.getComid()+"'";
				Sql myesql = Sqls.create(v_exesql);
				dao.execute(myesql);				
			};
			//beanCopyUtil.copyProperties(pcompany, dto, true);
			
			BeanHelper.copyProperties(dto, pcompany); // 拷贝对应的从前台传来的数据
			
			////pcompany.setCommc(dto.getCommc());
			////pcompany.setComdalei(dto.getComdalei());
			////saveComdalei(dto.getComdalei(),dto.getComid());
			////pcompany.setComxkzbh(dto.getComxkzbh());
			////pcompany.setComfrhyz(dto.getComfrhyz());
			////pcompany.setComfrsfzh(dto.getComfrsfzh());
			////pcompany.setComfrxb(dto.getComfrxb());
			////pcompany.setComfrzw(dto.getComfrzw());
			////pcompany.setComfzr(dto.getComfzr());
			////pcompany.setComgddh(dto.getComgddh());
			////pcompany.setComyddh(dto.getComyddh());
			////pcompany.setComdz(dto.getComdz());
			////pcompany.setComqq(dto.getComqq());
			////pcompany.setComemail(dto.getComemail());
			////pcompany.setComyzbm(dto.getComyzbm());
			////pcompany.setComwz(dto.getComwz());
			////pcompany.setComxkfw(dto.getComxkfw());
			// pcompany.setComxkyxqq(dto.getComxkyxqq());
			// pcompany.setComxkyxqz(dto.getComxkyxqz());
			// 厨房面积
			////pcompany.setComcfmj(dto.getComcfmj());	
			// 餐厅面积
			////pcompany.setComctmj(dto.getComctmj());
			// 总面积
			////pcompany.setComzmj(dto.getComzmj());

			// 下面这种方法在后台插入时间时仍存在问题（可以删除），前端使用easyui校验
			// 许可有效期始
			////pcompany.setComxkyxqq(dto.getComxkyxqq());
			// 许可有效期止
			////pcompany.setComxkyxqz(dto.getComxkyxqz());
			// 企业成立日期
			////pcompany.setComclrq(dto.getComclrq());

			////pcompany.setComjcrs(dto.getComjcrs());
			////pcompany.setComcyrs(dto.getComcyrs());
			////pcompany.setComcjkzrs(dto.getComcjkzrs());
			////pcompany.setComzjzglrs(dto.getComzjzglrs());
			////pcompany.setComxiaolei(dto.getComxiaolei());
			////pcompany.setComdmlx(dto.getComdmlx());
			////pcompany.setComshengdm(dto.getComshengdm());
			////pcompany.setComshengmc(dto.getComshengmc());
			////pcompany.setComshidm(dto.getComshidm());
			////pcompany.setComshimc(dto.getComshimc());
			////pcompany.setComxiandm(dto.getComxiandm());
			////pcompany.setComxianmc(dto.getComxianmc());
			////pcompany.setComxiangdm(dto.getComxiangdm());
			////pcompany.setComxiangmc(dto.getComxiangmc());
			////pcompany.setComcundm(dto.getComcundm());
			////pcompany.setComcunmc(dto.getComcunmc());
			////pcompany.setComtscx(dto.getComtscx());
			////pcompany.setComtsc(dto.getComtsc());
			////pcompany.setComzzzm(dto.getComzzzm());
			////pcompany.setComzzzmbh(dto.getComzzzmbh());
			////pcompany.setComzzjgdm(dto.getComzzjgdm());
			////pcompany.setComzczj(dto.getComzczj());
			////pcompany.setComzclb(dto.getComzclb());
			////pcompany.setComjianjie(dto.getComjianjie());
			////pcompany.setComqyxz(dto.getComqyxz());
			////pcompany.setComjyjcbz(dto.getComjyjcbz());
			////pcompany.setComjdzb(dto.getComjdzb());
			////pcompany.setComwdzb(dto.getComwdzb());
			////pcompany.setAaa027(dto.getAaa027());
			pcompany.setComsyqylx(v_syqylx);
			//企业名称拼音
			pcompany.setCommcjc(PinYinUtil.GetChineseSpell(pcompany.getCommc()));
			dao.update(pcompany);
			saveComdalei(dto.getComdalei(),dto.getComid());
			saveComxiaolei(dto.getComxiaolei(),dto.getComid());
			
		} else {// 添加
			//根据企业名称 判断企业是否存在
			String v_sql="select comdm from pcompany where commc='"+
			   dto.getCommc() +"'";
			
		    List v_comlist=DbUtils.getDataList(v_sql,Pcompany.class);
		    if (v_comlist!=null && v_comlist.size()>0){
		    	throw new BusinessException("该单位名称已经存在！");
		    }
		    
			String comid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
			Pcompany pcompany = new Pcompany();
			BeanHelper.copyProperties(dto, pcompany); // 拷贝对应的从前台传来的数据
			pcompany.setComid(comid);
			pcompany.setComdm(v_comdm);
			pcompany.setComshbz("1"); // 先默认为已审核
			pcompany.setComdzcsj(v_dbtime);
			pcompany.setComsyqylx(v_syqylx);
			pcompany.setComfwnfww("0");//0:范围内，1:范围外
			pcompany.setOrgid(v_orgid);
			//企业名称拼音
			pcompany.setCommcjc(PinYinUtil.GetChineseSpell(pcompany.getCommc()));			
			dao.insert(pcompany);
			//qyid=comid;
			dto.setComid(comid);
			
			saveComdalei(dto.getComdalei(),dto.getComid());
			saveComxiaolei(dto.getComxiaolei(),dto.getComid());
			
			//保存企业门头照 图片
			FjDTO v_fjdto=new FjDTO();			
			v_fjdto.setFjwid(comid);	
			v_fjdto.setFolderName("company");
			
			v_fjdto.setFjpath(dto.getQymtzpath());
			v_fjdto.setFjname(dto.getQymtzname());
			v_fjdto.setFjtype("4");
			pubService.saveFjWuzhuti(request,v_fjdto);
			
			// gu20160621企业新增后往sysuser表插入一条
			if ("1".equals(SysmanageUtil.g_ADDCOMCREATEUSER)){
				Sysuser v_newSysuser = new Sysuser();
				v_newSysuser.setUserid(comid);
				v_newSysuser.setUsername(v_comdm);
				v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
				v_newSysuser.setUserkind("6");
				v_newSysuser.setDescription(pcompany.getCommc());
				v_newSysuser.setAaa027(dto.getAaa027());
				v_newSysuser.setOrgid("2016062217255064055994870");
				v_newSysuser.setMobile(dto.getComyddh());//gu20161020add
				v_newSysuser.setAaz001(comid);//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
				
				Sysuserrole v_Sysuserrole=new Sysuserrole();
				String v_USERROLEID = DbUtils.getSequenceStr();
				v_Sysuserrole.setUserroleid(v_USERROLEID);
				v_Sysuserrole.setUserid(comid);
				v_Sysuserrole.setRoleid("2016062216563315846077196");
				//如果检验检测标志位1
				if (dto.getComjyjcbz()!=null && !"".equals(dto.getComjyjcbz())
						&& "1".equals(dto.getComjyjcbz())){
					v_Sysuserrole.setRoleid("2016102114210245464588122");
				}
				dao.insert(v_newSysuser);
				dao.insert(v_Sysuserrole);
			}
			if(null!=dto.getComxkzbh() && !"".equals(dto.getComxkzbh())) {
				String comXkzJson = "[{'comxkzid':'" + DbUtils.getSequenceStr() + "','comid':'" + dto.getComid() + "','comxkzbh':'" + dto.getComxkzbh() + "','comxkfw':'" + dto.getComxkfw() + "','comxkyxqq':'" + dto.getComxkyxqq() + "','comxkyxqz':'" + dto.getComxkyxqz() + "'}]";
				addXkz(comXkzJson, dto.getComid());
			}
			//qyid=comid;
		}
		
		//gu20161020add 单位资质证明
		if (dto.getSjordnbz()!=null && "2".equals(dto.getSjordnbz())){
			addXkz(dto.getComzzzmlist(), dto.getComid()); // 插入许可证
		}
		//return qyid;
		
		//gu20170413 增加企业日常监督管理人员
		addComRcjdglry(dto.getComrcjdglryid(),dto.getComid());
	} */
	
	
	/**
	 *
	 * addComRcjdglry的中文名称：添加 日常监督管理人员
	 *
	 * addComRcjdglry的概要说明：
	 *
	 * @return Written by : gjf
	 *
	 */
	public void addComRcjdglry(String prm_rcjdglry,String prm_comid,Sysuser v_sysuser) throws Exception{
		if (!StringUtils.isEmpty(prm_rcjdglry)){
			dao.clear(Pcomrcjdglry.class,Cnd.where("comid", "=", prm_comid));
			
			String[] v_useridarr=prm_rcjdglry.split(",");
			String v_pcomrcjdglryid ="";
			//Sysuser v_sysuser = (Sysuser)SysmanageUtil.getSysuser();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
			for (int i=0;i<v_useridarr.length;i++){
				Pcomrcjdglry v_newPcomrcjdglry=new Pcomrcjdglry();
				v_pcomrcjdglryid = DbUtils.getSequenceStr();
				v_newPcomrcjdglry.setPcomrcjdglryid(v_pcomrcjdglryid);
				v_newPcomrcjdglry.setUserid(v_useridarr[i]);
				v_newPcomrcjdglry.setComid(prm_comid);
				v_newPcomrcjdglry.setAae011("sys");
				v_newPcomrcjdglry.setAae036(v_dbtime);
				dao.insert(v_newPcomrcjdglry);
			}
				
				
		}
	}	


	/**
	 * 查询出所有的企业信息，并分页显示
	 *
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCompany(HttpServletRequest request, PcompanyDTO dto, PagesDTO pd) throws Exception {
		Sysuser v_sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		Date date = new Date();
		sb.append(" select pcom.*, pcom.comdalei aae140,");
		sb.append(" (select lhfjndpddj from pcompanynddtpj where comid = pcom.comid and pdyear = '"+sdf.format(date)+"') lhfjndpddj,");
		sb.append(" (select aaa129 from Aa13 where aaa027 = pcom.aaa027) aaa027name,");
		sb.append(" (select t.fjpath from fj t where t.fjwid=pcom.comid and fjtype='4') as qymtzpath, ");
		sb.append("(select GROUP_CONCAT(t2.DESCRIPTION)  from pcomrcjdglry t1,sysuser t2 where t1.userid=t2.userid and t1.comid=pcom.comid group by t1.comid) as  comrcjdglry,");
		sb.append("(select GROUP_CONCAT(t1.userid)  from pcomrcjdglry t1,sysuser t2 where t1.userid=t2.userid and t1.comid=pcom.comid group by t1.comid) as  comrcjdglryid,");
		sb.append("(select GROUP_CONCAT(t.comxkzbh) from pcompanyxkz t where comid=pcom.comid and comxkzlx<>'1') as comxkzbhall,");
		//gu20180528 用这个函数引起慢 sb.append("fun_getcomdalei('1',pcom.comid) as comdaleistr ");
		sb.append("(SELECT GROUP_CONCAT(t2.aaa103) FROM pcompanycomdalei t1,viewcomdalei t2 WHERE t1.comid=pcom.comid AND t1.comdalei=t2.AAA102) as  comdaleistr ");
		sb.append(" from Pcompany pcom ");
		sb.append(" where 1=1 ");
		sb.append(" and pcom.comid = :comid ");
		if(!"".equals(StringHelper.showNull2Empty(dto.getComdalei()))){
			sb.append(" and find_in_set('").append(dto.getComdalei()).append("',pcom.comdalei) ");
		}
		if(!"".equals(StringHelper.showNull2Empty(dto.getComxiaolei()))){
			sb.append(" and find_in_set('").append(dto.getComxiaolei()).append("',pcom.comxiaolei) ");
		}
		if (StringUtils.isNotEmpty(dto.getCommc())){
			sb.append(" and (pcom.commc like '%"+dto.getCommc()+"%' or pcom.commcjc like '%"+dto.getCommc()+"%' or pcom.comid like '%"+dto.getCommc()+"%' or pcom.comfrhyz like '%"+dto.getCommc()+"%' or pcom.comfzr like '%"+dto.getCommc()+"%' ");
			sb.append(" or exists (select 1 from pcompanyxkz tt where tt.comid=pcom.comid and tt.comxkzbh like '%"+dto.getCommc()+"%' ))");
		}

		sb.append(" and pcom.comshbz = :comshbz ");
		sb.append(" and pcom.aaa027 like :aaa027 ");
		sb.append(" and pcom.comjyjcbz = :comjyjcbz ");
		//gu20161107 sb.append(" and pcom.aaa027 like :aaa027 ");
		sb.append(" and pcom.comfwnfww = :comfwnfww "); // 范围内范围外类型
		if("jyjc".equals(dto.getQuerytype())){
			sb.append(" and pcom.comdalei = 106001 ");
		}
		if (StringUtils.isEmpty(dto.getQueryall())){
			if (v_sysuser!=null && ("6".equals(v_sysuser.getUserkind())||"7".equals(v_sysuser.getUserkind()))){ //6企业虚拟用户 7快检人员
				sb.append(" and pcom.comid='"+v_sysuser.getAaz001()+"' ");
			};
		};
		if ("1".equals(dto.getComfwnfww())){//0范围内1范围外 gu20170621 以前做的溯源，设置关系，查单位时，默认显示自己添加的
			sb.append(" and pcom.comlrcomid='"+v_sysuser.getAaz001()+"' ");
		}
		//gu20180507add
		if (StringUtils.isNotEmpty(dto.getQuerytype())&&"createComQrcode".equals(dto.getQuerytype())){
            sb.append(" and not exists (select 1 from pcomqrcode t where t.comid=pcom.comid ) ");
		}
		if (StringUtils.isNotEmpty(dto.getComxkzbh())){
			sb.append(" and exists (select 1 from pcompanyxkz t6 where t6.comid=pcom.comid and t6.comxkzbh='"+dto.getComxkzbh()+"') ");
		}
		sb.append(" order by comid desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "aaa027","comid", "comdalei", "commc", "comshbz", "comjyjcbz", "comfwnfww" };
		int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		System.out.println(sql);
		//Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows());
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows(),dto.getUserid(),"aaa027,aae140,orgid");
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 *
	 * MakeCompanyLngLat的中文名称：批量自动生成企业经纬度坐标
	 *
	 * MakeCompanyLngLat的概要说明：
	 *
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@SuppressWarnings("rawtypes")
	public void MakeCompanyLngLatBatch() throws Exception {
		String v_sql="select a.comid,a.comwdzb,a.comjdzb,a.comdz from pcompany a where length(a.comdz)>0 and (a.comjdzb IS NULL OR a.comjdzb='') ";
		List<PcompanyDTO> v_listComdto=(List<PcompanyDTO>)DbUtils.getDataList(v_sql, PcompanyDTO.class);
		for (PcompanyDTO v_comdto :v_listComdto){
			String address = StringHelper.showNull2Empty(v_comdto.getComdz());
			if (!"".equals(address)) {
				//Map ssMap = BaiduUtil.getMapLngAndLat(address);
				Map ssMap = GaodeUtil.getMapLngAndLat(address);
				if (!ssMap.isEmpty()){
					v_sql="update pcompany set comjdzb='"+ssMap.get("lng").toString()+
							"',comwdzb='"+ssMap.get("lat").toString()+"' where comid='"+
							v_comdto.getComid()+"'";
	               Sql v_ssql=Sqls.create(v_sql);
	               dao.execute(v_ssql);	
	               System.out.println(v_comdto.getComid());
				}
//				Pcompany pcompany = dao.fetch(Pcompany.class, v_comdto.getComid());
//				pcompany.setComjdzb(ssMap.get("lng").toString());
//				pcompany.setComwdzb(ssMap.get("lat").toString());
//				dao.update(pcompany);
			}			
		}
				

	}		

	/**
	 * 删除企业信息，根据id删除
	 */
	public String delPcompany(HttpServletRequest request, final PcompanyDTO dto) {
		try {
			delPcompanyImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除企业信息，实现类 交给事务管理
	 *
	 * @param request
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@Aop( { "trans" })
	public void delPcompanyImpl(HttpServletRequest request, PcompanyDTO dto) throws Exception {
		if (!(dto.getComid() == null || "".equals(dto.getComid()))) {
			
			// 删除企业用户信息
			dao.clear(Sysuser.class, Cnd.where("userid", "=", dto.getComid()));
			// 删除企业许可证信息
			String v_sql="select a.* from pcompanyxkz a where a.comid='"+dto.getComid()+"'";
			List<PcompanyXkz> v_listComXkz=(List<PcompanyXkz>)DbUtils.getDataList(v_sql, PcompanyXkz.class);
			for (PcompanyXkz v_xkz:v_listComXkz){
				//删除许可证图片信息
				pubService.delFjFromFjwid(request,v_xkz.getComxkzid());					
			}
			dao.clear(PcompanyXkz.class, Cnd.where("comid", "=", dto.getComid()));	
			// 删除企业二维码
			dao.clear(Pcomqrcode.class, Cnd.where("comid", "=", dto.getComid()));
			//删除企业图片信息
			pubService.delFjFromFjwid(request,dto.getComid());	
			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(dto.getComid());
			v_HviewjgztDTO.setDokind("delete");
			v_HviewjgztDTO.setTablemc("pcompany");
			HviewjgztManage(v_HviewjgztDTO);			
			//删除企业信息
			dao.clear(Pcompany.class, Cnd.where("comid", "=", dto.getComid()));

//gjf20170408改前备份			// 删除企业信息
//			List<PcompanyComdalei> comDaleiList = dao.query(PcompanyComdalei.class, Cnd.where("comid","=",dto.getComid()));
//			if(comDaleiList.size()>1){
//				dao.clear(PcompanyComdalei.class, Cnd.where("comid", "=", dto.getComid()).and("comdalei", "=", dto.getComdalei()));
//				StringBuffer comdaleiStr = new StringBuffer("");
//				for (PcompanyComdalei dalei:comDaleiList) {
//					if(!dalei.getComdalei().equals(dto.getComdalei())){
//						comdaleiStr.append(dalei.getComdalei()).append(",");
//					}
//				}
//				comdaleiStr.subSequence(0,comdaleiStr.length()-2);
//				Pcompany pcompanyOld = dao.fetch(Pcompany.class,dto.getComid());
//				pcompanyOld.setComdalei(comdaleiStr.toString());
//				dao.update(pcompanyOld);
//			}else{
//				dao.clear(Pcompany.class, Cnd.where("comid", "=", dto.getComid()));
//				// 删除企业用户信息
//				dao.clear(Sysuser.class, Cnd.where("userid", "=", dto.getComid()));
//				// 删除企业许可证信息
//				dao.clear(PcompanyXkz.class, Cnd.where("comid", "=", dto.getComid()));	
//				// 删除企业二维码
//				dao.clear(Pcomqrcode.class, Cnd.where("comid", "=", dto.getComid()));
//			}
		}
	}

	/**
	 * 企业信息审核通过 审核通过之后将审核状态修改 同时向SysUser (系统用户表)中插入用户名和密码，密码初始值为123456
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	public String examPass(HttpServletRequest request, final PcompanyDTO dto) {
		try {
			examPassImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 企业信息审核通过的实现方法 使用事务控制
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void examPassImpl(HttpServletRequest request, PcompanyDTO dto) throws Exception {
		if (null != dto.getComid() && !"".equals(dto.getComid())) {
			// 更新企业表
			Pcompany pcompany = dao.fetch(Pcompany.class, dto.getComid());
			// BeanHelper.copyProperties(dto, pcompany);
			pcompany.setComshbz("2");
			dao.update(pcompany);
			// 新增系统用户表
			// gu20160510 暂时先去了
			// Sysuser sysUser = new Sysuser();
			// sysUser.setUserid(DbUtils.getSequenceL("sq_userid"));
			// sysUser.setUsername(dto.getUsername());
			// sysUser.setPasswd("123456");
			// dao.insert(sysUser);
		}
	}

	/**
	 *
	 * queryPcomdqTree的中文名称：按easyui tree格式构造所在地区树
	 *
	 * queryPcomdqTree的概要说明:
	 *
	 * @return Written by : zy
	 * @throws Exception
	 *
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List queryPcomdqTree(HttpServletRequest request) throws Exception {
		String parentid = request.getParameter("parentid");
		if (parentid == null || "".equals(parentid)) {
			parentid = "0";
		}
		List resLs = new ArrayList();
		List ls = queryPcomdqZTree(parentid);
		for (int i = 0; i < ls.size(); i++) {
			Aa26 s = (Aa26) ls.get(i);
			Map cm = new HashMap();
			cm.put("id", s.getAab301());
			cm.put("text", s.getAaa146());
			resLs.add(cm);
		}
		return resLs;
	}

	/**
	 *
	 * queryPcomdqZTree的中文名称：按Ztree插件格式构造统地区下拉列表
	 *
	 * queryPcomdqZTree的概要说明：
	 *
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 *
	 */
	@SuppressWarnings("rawtypes")
	public List queryPcomdqZTree(String parentid) throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append("SELECT * FROM aa26 WHERE AAA148 = '");
		sb.append(parentid).append("'");

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, Aa26.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 *
	 * MakeCompanyLngLat的中文名称：批量自动生成企业经纬度坐标
	 *
	 * MakeCompanyLngLat的概要说明：
	 *
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@SuppressWarnings("rawtypes")
	public void MakeCompanyLngLat(PcompanyDTO dto) throws Exception {
		String address = StringHelper.showNull2Empty(dto.getComdz());
		if (!"".equals(address)) {
			Map ssMap = BaiduUtil.getMapLngAndLat(address);

			Pcompany pcompany = dao.fetch(Pcompany.class, dto.getComid());
			pcompany.setComjdzb(ssMap.get("lng").toString());
			pcompany.setComwdzb(ssMap.get("lat").toString());
			dao.update(pcompany);
		}
	}
	
	/**
	 * 
	 *  checkUpLoadXls的中文名称：企业信息导入上传验证
	 *
	 *  checkUpLoadXls的概要说明：
	 *
	 *  @param request
	 *  @param vali
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written  by  : zjf
	 *
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ValidateData checkUpLoadXls(HttpServletRequest request, ValidateData vali, PcompanyDTO dto) throws Exception {
		// 处理正确数据
		if (vali.getCorrectData().size() > 0) {
			int i = 0;
			// 遍历文件记录
			while ((!vali.getCorrectData().isEmpty()) && i < vali.getCorrectData().size()) {
				final PcompanyDTO wdto = (PcompanyDTO) vali.getCorrectData().get(i);
				// 校验代码
				BeanHelper.copyProperties(wdto, dto);
				String errorMsg = isExistsPc(dto);
				if (errorMsg != null) {
					ValidateData.ErrorItem item = new ValidateData.ErrorItem();
					item.setErrorData(wdto);
					item.addErrorMsg("commc", errorMsg);
					vali.addErrorItem(item);
					vali.getCorrectData().remove(i);// 移除不匹配的记录
				} else {
					i++;
					// 校验是否有重复记录
//					for (int j = i; j < vali.getCorrectData().size(); j++) {
//						final PcompanyDTO wdto2 = (PcompanyDTO) vali.getCorrectData().get(j);
//						if (wdto2.getComfrsfzh().equals(wdto.getComfrsfzh())) {
//							throw new BusinessException("上传文件记录中存在重复的企业信息，重复的企业名称为【" + wdto2.getCommc() + "】");
//						}
//					}
				}
			}
		}

		// 处理错误数据
		if (vali.getErrData().size() > 0) {
			final List errorList = new ArrayList();
			for (final Iterator it = vali.getErrData().iterator(); it.hasNext();) {
				final ValidateData.ErrorItem itm = (ValidateData.ErrorItem) it.next();
				final PcompanyDTO wdto = (PcompanyDTO) itm.getErrorData();
				wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
				errorList.add(wdto);
			}
			vali.setErrData(errorList);
		}
		return vali;
	}
	
	/**
	 * 
	 * checkApproveUpLoadXls的中文名称：企业信息导入上传验证
	 * 
	 * checkApproveUpLoadXls的概要说明：行政审批企业
	 *
	 * @param request
	 * @param vali
	 * @param dto 
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ValidateData checkApproveUpLoadXls(HttpServletRequest request, 
			ValidateData vali, ApprovePcompanyDTO dto) throws Exception {
		// 处理错误数据
		if (vali.getErrData().size() > 0) {
			final List errorList = new ArrayList();
			for (final Iterator it = vali.getErrData().iterator(); it.hasNext();) {
				final ValidateData.ErrorItem itm = (ValidateData.ErrorItem) it.next();
				final ApprovePcompanyDTO wdto = (ApprovePcompanyDTO) itm.getErrorData();
				wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
				errorList.add(wdto);
			}
			vali.setErrData(errorList);
		}
		return vali;
	}

	/**
	 *  校验企业信息编号是否已经存在   保证维一性
	 * @param dto
	 * @return
	 * @throws Exception
     */
	@SuppressWarnings("rawtypes")
	public String isExistsPc(PcompanyDTO dto) throws Exception {
		// 校验厨师身份证号是否已经存在
		PagesDTO pd = new PagesDTO();
		PcompanyDTO PcompanyDTO = new PcompanyDTO();
		PcompanyDTO.setCommc(dto.getCommc());//企业名称
		PcompanyDTO.setComdalei(dto.getComdalei()); // 企业大类
		PcompanyDTO.setComxkzbh(dto.getComxkzbh()); // 许可证编号
		Map m = queryCompany2(PcompanyDTO,pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			PcompanyDTO pdto = (PcompanyDTO) ls.get(0);
			final StringBuffer sb = new StringBuffer();
			sb.append("您登记的企业信息：企业名称【");
			sb.append(pdto.getCommc());
			sb.append(" 】已登记过，请勿重复登记！");
			return sb.toString();
		}
		return null;
	}
	
	/**
	 *
	 * @param dto   查询企业信息
	 * @param pd
	 * @return
	 * @throws Exception
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCompany2( PcompanyDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select * ");
		sb.append(" from pcompany pcom,pcompanycomdalei cd, pcompanyxkz xkz ");
		sb.append(" where 1=1 and pcom.comid = cd.comid and xkz.comid = pcom.comid ");
		sb.append(" and pcom.commc = :commc");
		sb.append(" and cd.comdalei = :comdalei");
		sb.append(" and xkz.comxkzbh = :comxkzbh");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "commc", "comdalei", "comxkzbh"};
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	/**
	 *
	 * @param request    企业信息保存
	 * @param succJsonStr
	 * @return
	 */
	public String savePcompanydr(HttpServletRequest request, String succJsonStr) {
		try {
			savePcompanydrImp(request, succJsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Aop( { "trans" })
	public void savePcompanydrImp(HttpServletRequest request, String succJsonStr) throws Exception {
//		Timestamp startTime = SysmanageUtil.currentTime();
//		String aaa027 = SysmanageUtil.getSysuser().getAaa027();
//		String orgid = SysmanageUtil.getSysuser().getOrgid();

		List<PcompanyDTO> lst = Json.fromJsonAsList(PcompanyDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
//			boolean isUpdate = true;
			// 插入企业
			PcompanyDTO dto = (PcompanyDTO) lst.get(i);
			Pcompany com = new Pcompany();
			PcompanyXkzDTO v_xkz = new PcompanyXkzDTO();
			BeanHelper.copyProperties(dto, com);
			BeanHelper.copyProperties(dto, v_xkz);
			//根据企业名称 判断企业是否存在
		    List<Pcompany> v_comlist = dao.query(Pcompany.class, Cnd.where("commc", "=", dto.getCommc()));
		    // 如果企业不存在，插入企业
		    if (v_comlist == null || v_comlist.size() == 0) {
				String comdm = "";
				if (null == dto.getComid() || "".equals(dto.getComid())) {// 生成企业代码
					comdm = SysmanageUtil.getComdm();
				} else {// 获取企业代码
					comdm = dto.getComdm();
				}
				com.setComdm(comdm);
//				com.setCommc(StringHelper.myDecodeURI(com.getCommc().toString()));
//				com.setComdz(StringHelper.myDecodeURI(com.getComdz().toString()));
//				com.setComxkzbh(StringHelper.myDecodeURI(com.getComxkzbh().toString()));
//				com.setComxkfw(StringHelper.myDecodeURI(com.getComxkfw().toString()));
//				com.setComfrhyz(StringHelper.myDecodeURI(com.getComfrhyz().toString()));
//				com.setComfzr(StringHelper.myDecodeURI(com.getComfzr().toString()));
//				com.setComzzzmbh(StringHelper.myDecodeURI(com.getComzzzmbh().toString()));
				String v_syqylx = SysmanageUtil.getComsyqylx(dto.getComdalei());
				com.setComsyqylx(v_syqylx);
				if (com.getOrgid() == null || "".equals(com.getOrgid())) {
					com.setOrgid(SysmanageUtil.getSysuser().getOrgid()); // 默认企业组织id为操作员组织id
				}
				if (com.getAaa027() == null || "".equals(com.getAaa027())) {
					com.setAaa027(SysmanageUtil.getSysuser().getAaa027()); // 默认企业统筹区为操作员所在统筹区
				}
				com.setComfwnfww("0");//0:范围内，1:范围外
				
				com.setComid(DbUtils.getSequenceStr());
				//gu20170602begin
				String v_sql="select a.* from aa10 a where a.aaa100='COMDALEI' and a.aaa102='"+dto.getComdalei()+"'";
				List<Aa10> lstAa10 = DbUtils.getDataList(v_sql, Aa10.class);
				if (lstAa10!=null && lstAa10.size()>0){
					Aa10 v_aa10=lstAa10.get(0);
					com.setComdaleiname(v_aa10.getAaa103());
				};
				
				//gu20170602end
				dao.insert(com);
				//gu20161102begin 插入许可证信息 改为企业大类 写在一条信息中，许可证信息多条
				String[] daleiArr = com.getComdalei().split(",");
		    	for (String temp : daleiArr) {
				    PcompanyComdalei comdalei = new PcompanyComdalei();
					comdalei.setComdalei(temp); // 企业大类
					comdalei.setComid(com.getComid()); // 企业id
					comdalei.setComdaleiid(DbUtils.getSequenceStr()); // id
					dao.insert(comdalei);
	    	    }
				//gu20161102end
		    } else {
//		    	com = v_comlist.get(0);
//		    	String[] daleiArr = com.getComdalei().split(",");
//		    	
//		    	for (String temp : daleiArr) {
//		    		if (temp.equals(dto.getComdalei())) {
//		    			isUpdate = false;
//		    		}
//		    	}
//		    	if (isUpdate) {
//		    		com.setComdalei(com.getComdalei() + "," + dto.getComdalei()); // 企业大类
//			    	dao.update(com);
//		    	}
		    }
//			System.out.print("============savePcompanydrImp:@isUpdate="+isUpdate);
//		    if (isUpdate) {
//				// 插入企业大类
//			    PcompanyComdalei comdalei = new PcompanyComdalei();
//				comdalei.setComdalei(dto.getComdalei()); // 企业大类
//				comdalei.setComid(com.getComid()); // 企业id
//				comdalei.setComdaleiid(DbUtils.getSequenceStr()); // id
//				dao.insert(comdalei);
//		    }
			// 插入企业许可证
			String comJsonStr = JSONArray.fromObject(dto).toString();
			addXkz(comJsonStr, com.getComid()); // 插入许可证
		}// end for
//		Timestamp endTime = SysmanageUtil.currentTime();
	}
	
	/**
	 * 
	 * saveApprovePcompanydr的中文名称：
	 * 
	 * saveApprovePcompanydr的概要说明：
	 *
	 * @param request
	 * @param succJsonStr
	 * @return
	 * @author : zy
	 */
	public String saveApprovePcompanydr(HttpServletRequest request, String succJsonStr) {
		try {
			saveApprovePcompanydrImp(request, succJsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * saveApprovePcompanydrImp的中文名称：保存企业导入信息
	 * 
	 * saveApprovePcompanydrImp的概要说明：行政审批企业
	 *
	 * @param request
	 * @param succJsonStr
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveApprovePcompanydrImp(HttpServletRequest request, String succJsonStr) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();

		List<ApprovePcompanyDTO> lst = Json.fromJsonAsList(ApprovePcompanyDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
			// 插入企业
			ApprovePcompanyDTO dto = (ApprovePcompanyDTO) lst.get(i);
			Pcompany com = new Pcompany();
			BeanHelper.copyProperties(dto, com);
			// 根据企业名称 判断企业是否存在
		    List<Pcompany> v_comlist = dao.query(Pcompany.class, Cnd.where("commc", "=", dto.getCommc()));
		    // 企业id
		    String v_comid = (v_comlist == null || v_comlist.size() == 0) ? DbUtils.getSequenceStr() : 
		    	v_comlist.get(0).getComid();
		    String v_comdm = SysmanageUtil.getComdm();
		    // 企业监管人员
	    	if (dto.getComrcjdglry() != null && !"".equals(dto.getComrcjdglry())) {
	    		// 首先删除企业监管人员
			    dao.clear(Pcomrcjdglry.class, Cnd.where("comid", "=", v_comid));
			    
				String[] glrArr = dto.getComrcjdglry().split(",");
		    	for (String glr : glrArr) {
		    		Pcomrcjdglry glry = new Pcomrcjdglry();
		    		
		    		Sysuser v_glry = getJgryByName(glr); // 通过监管人员名字获取其信息
		    		if (v_glry != null) {
		    			glry.setUserid(v_glry.getUserid()); // 监管人员id
						com.setOrgid(v_glry.getOrgid()); // 默认企业监管人员组织id为组织id
						com.setAaa027(v_glry.getAaa027()); // 默认企业统筹区为监管人所在统筹区
		    		}
	    			
		    		glry.setPcomrcjdglryid(DbUtils.getSequenceStr()); // 主键id
		    		glry.setComid(v_comid); // 监管企业id
		    		
		    		glry.setAae011(user.getUserid()); // 操作员id
		    		glry.setAae036(SysmanageUtil.getDbtimeYmdHnsTimestamp()); // 操作时间
					dao.insert(glry);
	    	    }
	    	}
		    // 如果企业不存在，插入企业
		    if (v_comlist == null || v_comlist.size() == 0) {
				com.setComsyqylx("3"); // 溯源企业类型0非溯源企业1生成2流通3餐饮
				com.setComfwnfww("0");//0:范围内，1:范围外
				com.setComid(v_comid);
				com.setComdm(v_comdm); // 企业代码
				com.setCommcjc(PinYinUtil.GetChineseSpell(dto.getCommc())); // 企业名称拼音
				dao.insert(com);
				
				// gu20170425 往主体信息表同步数据
				HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
				v_HviewjgztDTO.setHviewjgztid(v_comid);
				v_HviewjgztDTO.setDokind("add");
				v_HviewjgztDTO.setTablemc("pcompany");
				HviewjgztManage(v_HviewjgztDTO);
				
				// gu20160621企业新增后往sysuser表插入一条
				if ("1".equals(SysmanageUtil.g_ADDCOMCREATEUSER)){
					Sysuser v_newSysuser = new Sysuser();
					v_newSysuser.setUserid(v_comid);
					v_newSysuser.setUsername(v_comdm);
					v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
					v_newSysuser.setUserkind("6");
					v_newSysuser.setDescription(dto.getCommc());
					v_newSysuser.setAaa027(com.getAaa027());
					v_newSysuser.setOrgid("2016062217255064055994870");
					v_newSysuser.setMobile(dto.getComyddh());//gu20161020add
					v_newSysuser.setAaz001(v_comid);//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
					dao.insert(v_newSysuser);
					
					Sysuserrole v_Sysuserrole=new Sysuserrole();
					String v_USERROLEID = DbUtils.getSequenceStr();
					v_Sysuserrole.setUserroleid(v_USERROLEID);
					v_Sysuserrole.setUserid(v_comid);
					v_Sysuserrole.setRoleid("2016062216563315846077196");//食品溯源企业角色
					dao.insert(v_Sysuserrole);
				}
				
		    } else {
		    	com = v_comlist.get(0);
		    	BeanHelper.copyProperties(dto, com);
		    	dao.update(com);
		    	// gu20170425 往主体信息表同步数据
		    	HviewjgztDTO v_HviewjgztDTO = new HviewjgztDTO();
				v_HviewjgztDTO.setHviewjgztid(v_comid);
				v_HviewjgztDTO.setDokind("update");
				v_HviewjgztDTO.setTablemc("pcompany");
				HviewjgztManage(v_HviewjgztDTO);
		    }
			// 插入企业许可证
		    dao.clear(PcompanyXkz.class, Cnd.where("comid", "=", v_comid).and("comxkzlx", "=", "1"));
		    PcompanyXkz xkz = new PcompanyXkz();
		    xkz.setComxkzid(DbUtils.getSequenceStr()); // id
		    xkz.setComxkzlx("1"); // 许可证类型，默认为营业执照
		    xkz.setComxkzbh(dto.getComxkzbh()); // 许可证编号
		    xkz.setComxkfw(dto.getComxkfw()); // 许可范围
		    xkz.setComxkyxqq(dto.getComxkyxqq()); // 有效期起
		    xkz.setComxkyxqz(dto.getComxkyxqz()); // 有效期止
		    xkz.setComxkzztyt(dto.getComxkzztyt()); // 主体业态
		    xkz.setComid(v_comid); // 企业id
		    dao.insert(xkz);
		}
	}
	
	/**
	 * 
	 * getJgryByName的中文名称：通过监管人员名字获取信息
	 * 
	 * getJgryByName的概要说明：
	 *
	 * @param name
	 * @return
	 * @author : zy
	 */
	public Sysuser getJgryByName (String name) {
		List<Sysuser> v_glry = dao.query(Sysuser.class, 
				Cnd.where("DESCRIPTION", "=", name));
		if (v_glry != null && v_glry.size() > 0) {
			return v_glry.get(0);
		}
		return null;
	}


	/**
	 * 查询企业许可证信息并分页显示
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPcompanyXkz(PcompanyXkzDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT p.*,  ");
		sb.append(" (select getAa10_aaa103('COMZZZM', p.comxkzlx)) as comxkzlxstr,");
		sb.append(" (select getAa10_aaa103('ZZZMZTYT', p.comxkzztyt)) as comxkzztytstr,"); // 主体业态
		sb.append(" (select t.fjpath from fj t where t.fjwid=p.comxkzid and fjtype=concat('ZZZM',p.comxkzlx)) as zzzmpath ");
		sb.append(" FROM pcompanyxkz p WHERE 1=1 ");
		sb.append(" and p.comid = :comid ");
		sb.append(" and p.comxkzid = :comxkzid ");
		sb.append(" and p.comxkzbh = :comxkzbh ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "comid","comxkzid","comxkzbh" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyXkzDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * addXkz的中文名称：添加许可证信息
	 *
	 * addXkz的概要说明：
	 *
	 * @return Written by : sunyifeng
	 *
	 */
	public List<String> addXkz(String succJsonStr,String comid) {
		List<String> xkzList = new ArrayList<String>();
		try {
			xkzList = addXkzImp(succJsonStr, comid);
		} catch (Exception e) {
			return null;
		}
		return xkzList;
	}

	@Aop( { "trans" })
	public List<String> addXkzImp(String succJsonStr,String comid) throws Exception {
//		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		List<String> xkzList = new ArrayList<String>();
		if ("".equals(comid)) {
			throw new BusinessException("企业ID不能为空！");
		}
		if (succJsonStr!=null){
			List<PcompanyXkzDTO> lst = Json.fromJsonAsList(PcompanyXkzDTO.class, succJsonStr);
			for (int i = 0; i < lst.size(); i++) {
				PcompanyXkzDTO xkzDTO = (PcompanyXkzDTO) lst.get(i);
				if(	StringUtils.isEmpty(xkzDTO.getComxkfw())&&
						//StringUtils.isEmpty(xkzDTO.getComxkyxqq())&&
						StringUtils.isEmpty(xkzDTO.getComxkzbh())&&
						//gu20161019 StringUtils.isEmpty(xkzDTO.getComxkyxqz())&&
						StringUtils.isEmpty(xkzDTO.getComxkzlx())
						){
					continue;
				}


				String xkzid = StringHelper.showNull2Empty(xkzDTO.getComxkzid());
				PcompanyXkz xkz_old = dao.fetch(PcompanyXkz.class, xkzid);
				if (xkz_old != null) {
					xkz_old.setComxkzbh(xkzDTO.getComxkzbh());

					xkz_old.setComxkfw(xkzDTO.getComxkfw());

					if (xkzDTO.getComxkyxqq()!=null && !"".equals(xkzDTO.getComxkyxqq())){
						//xkz_old.setComxkyxqq(new Date(fm.parse(xkzDTO.getComxkyxqq()).getTime()));
						xkz_old.setComxkyxqq(xkzDTO.getComxkyxqq());
					}

					if (xkzDTO.getComxkyxqz()!=null && !"".equals(xkzDTO.getComxkyxqz())){
						//xkz_old.setComxkyxqz(new Date(fm.parse(xkzDTO.getComxkyxqz()).getTime()));
						xkz_old.setComxkyxqz(xkzDTO.getComxkyxqz());
					}

					xkz_old.setComxkzlx(xkzDTO.getComxkzlx());
					xkz_old.setComxkzzcxs(xkzDTO.getComxkzzcxs());//gu20161019 组成形式
					xkz_old.setComxkzztyt(xkzDTO.getComxkzztyt());//gu20161019 主题业态
					xkz_old.setComxkzjycs(xkzDTO.getComxkzjycs());
					dao.update(xkz_old);
					xkzList.add(xkzid);
				} else {
					PcompanyXkz xkz = new PcompanyXkz();
					String v_xkzid = DbUtils.getSequenceStr();
					xkz.setComid(comid);
					xkz.setComxkzid(v_xkzid);
					xkz.setComxkzbh(xkzDTO.getComxkzbh());

					xkz.setComxkfw(xkzDTO.getComxkfw());

					if (xkzDTO.getComxkyxqq()!=null && !"".equals(xkzDTO.getComxkyxqq())){
						//xkz.setComxkyxqq(new Date(fm.parse(xkzDTO.getComxkyxqq()).getTime()));
						xkz.setComxkyxqq(xkzDTO.getComxkyxqq());
					}
					if (xkzDTO.getComxkyxqz()!=null && !"".equals(xkzDTO.getComxkyxqz())){
						//xkz.setComxkyxqz(new Date(fm.parse(xkzDTO.getComxkyxqz()).getTime()));
						xkz.setComxkyxqz(xkzDTO.getComxkyxqz());
					}
					xkz.setComxkzlx(xkzDTO.getComxkzlx());
					xkz.setComxkzzcxs(xkzDTO.getComxkzzcxs());//gu20161019 组成形式
					xkz.setComxkzztyt(xkzDTO.getComxkzztyt());//gu20161019 主题业态
					xkz.setComxkzjycs(xkzDTO.getComxkzjycs());
					dao.insert(xkz);
					xkzList.add(v_xkzid);
				}
			}
		}
		return xkzList;

	}

	/**
	 *
	 * addXkz的中文名称：添加许可证信息
	 *
	 * addXkz的概要说明：
	 *
	 * @param dto
	 * @return Written by : sunyifeng
	 *
	 */
	public String savePcompanyXkzSingle(HttpServletRequest request,@Param("..")PcompanyXkzDTO dto){
		try {
			savePcompanyXkzSingleImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;			
	}

	@Aop( { "trans" })
	public void savePcompanyXkzSingleImp(HttpServletRequest request,@Param("..")PcompanyXkzDTO dto) throws Exception{
		
		if (null != dto.getComxkzid() && !"".equals(dto.getComxkzid())) {
			PcompanyXkz v_oldPcompanyXkz=dao.fetch(PcompanyXkz.class, dto.getComxkzid());
			BeanHelper.copyProperties(dto, v_oldPcompanyXkz); // 拷贝对应的从前台传来的数据
			dao.update(v_oldPcompanyXkz);
		}else{
			String comxkzid = DbUtils.getSequenceStr();
			PcompanyXkz v_newPcompanyXkz=new PcompanyXkz();
			BeanHelper.copyProperties(dto, v_newPcompanyXkz); // 拷贝对应的从前台传来的数据
			v_newPcompanyXkz.setComxkzid(comxkzid);
			dao.insert(v_newPcompanyXkz);	
			
			//资质证明图片的保存
			FjDTO v_fjdto=new FjDTO();			
			v_fjdto.setFjwid(comxkzid);	
			v_fjdto.setFolderName("companyzzzm");
			
			v_fjdto.setFjpath(dto.getZzzmpath());
			v_fjdto.setFjname(dto.getZzzmname());
			v_fjdto.setFjtype("ZZZM"+dto.getComxkzlx());
			pubService.saveFjWuzhuti(request,v_fjdto);			
		}
	}
	
	/**
	 *
	 * delXkz的中文名称：删除许可证信息
	 *
	 * delXkz的概要说明：
	 *
	 * @param dto
	 * @return Written by : sunyifeng
	 *
	 */
	public String delXkz(HttpServletRequest request,PcompanyXkzDTO dto ) {
		try {
			delXkzImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delXkzImp(HttpServletRequest request,PcompanyXkzDTO dto) throws Exception {
		if (!(dto.getComxkzid() == null || "".equals(dto.getComxkzid()))) {
			//删除许可证图片信息
			pubService.delFjFromFjwid(request,dto.getComxkzid());		
			//dao.clear(Fj.class,Cnd.where("fjwid", "=", dto.getComxkzid()));
			dao.clear(PcompanyXkz.class, Cnd.where("comxkzid", "=", dto.getComxkzid()));
			
		}
	}


	/**
	 *
	 * saveComdalei的中文名称：添加企业分类
	 *
	 * saveComdalei的概要说明：
	 * @return Written by : sunyifeng
	 *
	 */
	public String saveComdalei(String succJsonStr,String comid) {
		try {
			saveComdaleiImpl(succJsonStr, comid);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveComdaleiImpl(String succJsonStr,String comid) {
		if ("".equals(comid)) {
			throw new BusinessException("企业ID不能为空！");
		}
		dao.clear(PcompanyComdalei.class, Cnd.where("comid", "=", comid));
		String[] lst = succJsonStr.split(",") ;
		for (int i = 0; i < lst.length; i++) {
			String comdaleiStr =  lst[i];
			String v_sql="select aaz093 "+
					" from viewcomdalei "+
					" where aaa102= '"+comdaleiStr+"'";
			String aaz093= DbUtils.getOneValue(dao,v_sql);

			PcompanyComdalei comdalei = new PcompanyComdalei();
			comdalei.setComdalei(comdaleiStr);
			comdalei.setComid(comid);
			comdalei.setComdaleiid(DbUtils.getSequenceStr());
			comdalei.setAaz093(aaz093);
			dao.insert(comdalei);
		}
	}
	
	/**
	 *
	 * saveComdalei的中文名称：添加企业分类
	 *
	 * saveComdalei的概要说明：
	 *
	 * @return Written by : sunyifeng
	 *
	 */
	public String saveComxiaolei(String succJsonStr,String comid) {
		try {
			saveComxiaoleiImpl(succJsonStr, comid);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Aop( { "trans" })
	public void saveComxiaoleiImpl(String succJsonStr,String comid) throws Exception {
		if ("".equals(comid)) {
			throw new BusinessException("企业ID不能为空！");
		}
		
		String v_sql="select * from viewcomxiaolei where aaa102 in ('"+succJsonStr+"')";
		List<Aa10> aa10list=(List<Aa10>)DbUtils.getDataList(v_sql, Aa10.class);
		
		dao.clear(Pcomxiaolei.class, Cnd.where("comid", "=", comid));
		for (Aa10 aa10temp:aa10list){
			Pcomxiaolei comxiaolei = new Pcomxiaolei();
			comxiaolei.setPcomxiaoleiid(DbUtils.getSequenceStr());
			comxiaolei.setComid(comid);
			comxiaolei.setComxiaolei(aa10temp.getAaa102());	
			comxiaolei.setComdalei(aa10temp.getAaa104());
			dao.insert(comxiaolei);
		}
		
	}	
	
	/**
	 * 
	 * queryCompanyQRcode的中文名称：查询企业二维码
	 * 
	 * queryCompanyQRcode的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCompanyQRcode(HttpServletRequest request, PcomqrcodeDTO dto) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select  p.commc,  p.comid, pcode.qrcodecontent ");
		sb.append(" from pcompany p  LEFT JOIN pcomqrcode pcode  ");
		sb.append(" ON p.comid = pcode.comid  ");
		sb.append(" where 1=1 ");
		sb.append(" and p.comid = :comid ");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "comid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcomqrcodeDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		// 判断应用服务器上是否存在二维码图片 
		if (list != null && list.size() > 0) {
			// 获取二维码对象
			PcomqrcodeDTO pdto = (PcomqrcodeDTO) list.get(0);
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			String fjpath = rootPath + File.separator + "/upload/qrcode/" + pdto.getComid() + ".gif";
			// 存放二维码文件夹是否存在
			String folderPath = rootPath + File.separator + "/upload/qrcode/";
			File folder = new File(folderPath);
			if (!folder.exists()) {
				folder.mkdirs();
			}
			// 从数据库中输出
			String fjcontent = pdto.getQrcodecontent();
			if (!Strings.isBlank(fjcontent)) {
				byte b[] = Base64.base64ToByteArray(fjcontent);
				File file = new File(fjpath);
				FileOutputStream fos = new FileOutputStream(file);
				fos.write(b);
				fos.close();
			}
		}
		return map;
	}
	
	/**
	 * 
	 * createComQRcode的中文名称：创建企业二维码
	 * 
	 * createComQRcode的概要说明：
	 * @param request
	 * @throws Exception
	 *        Written by : zy
	 */
	public void createComQRcode(HttpServletRequest request) throws Exception {
		// 企业id
		String comid = StringHelper.myDecodeURI(request.getParameter("comid"));
		// 根路径
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		// 二维码保存路径
		String codePath = rootPath + File.separator + "/upload/qrcode/" + comid + ".gif";
		
		//先删除原来的二维码图片
		if(FileUtil.checkFile(codePath)){
			FileUtil.delFile(codePath);
		}
		// 获取企业二维码前缀
		Aa01 aa01 = SysmanageUtil.getAa01("QYEWMQZ");
		// 二维码内容
		String comInfo = aa01.getAaa005() + comid;
		SysmanageUtil.createQrcode(codePath, comInfo, ""); // 创建二维码
	}
	
	/**
	 * 
	 * savePcompanyQRcode的中文名称：保存企业二维码
	 * 
	 * savePcompanyQRcode的概要说明：
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String savePcompanyQRcode(HttpServletRequest request, PcomqrcodeDTO dto) {
		try {
			savePcompanyQRcodeImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void savePcompanyQRcodeImpl(HttpServletRequest request, PcomqrcodeDTO dto) throws IOException {
		// 先删除，再保存
		dao.clear(Pcomqrcode.class, Cnd.where("comid", "=", dto.getComid()));
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		String fjpath = rootPath + File.separator + dto.getQrcodepath();
		File file = new File(fjpath);
		// 将图片读进输入流
		InputStream fis = new FileInputStream(file);
		Pcomqrcode code = new Pcomqrcode();
		code.setComid(dto.getComid());
		code.setQrcodecontent(fis);
		code.setQrcodepath(dto.getQrcodepath());//zjf add
		dao.insert(code);
		fis.close();
	}
	
	/**
	 * 
	 * createCompanyQRcodes的中文名称：批量创建企业二维码
	 * 
	 * createCompanyQRcodes的概要说明：
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	public void createCompanyQRcodes(HttpServletRequest request, PcompanyDTO dto) throws Exception {
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		String folderPath = rootPath + File.separator + "/upload/qrcode/";
		// 二维码保存文件夹
		File folder = new File(folderPath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		String qrcodePath = "/upload/qrcode/" + dto.getComid() + ".gif";//zjf add
		String codePath = rootPath + File.separator + "/upload/qrcode/" + dto.getComid() + ".gif";
		//先删除原来的二维码图片
		if(FileUtil.checkFile(codePath)){
			FileUtil.delFile(codePath);
		}
		
		// 获取企业二维码前缀
		Aa01 aa01 = SysmanageUtil.getAa01("QYEWMQZ");
		String comInfo = aa01.getAaa005() + dto.getComid();
		boolean flag =  SysmanageUtil.createQrcode(codePath, comInfo, ""); // 创建二维码
		// 创建二维码成功，保存进数据库
		if (flag) {
			dao.clear(Pcomqrcode.class, Cnd.where("comid", "=", dto.getComid()));
			File file = new File(codePath);
			// 将图片读进输入流
			InputStream fis = new FileInputStream(file);
			Pcomqrcode code = new Pcomqrcode();
			code.setComid(dto.getComid());
			code.setQrcodecontent(fis);
			code.setQrcodepath(qrcodePath);//zjf add
			dao.insert(code);
			fis.close();
		}
	}
	
	/**
	 * HviewjgztManage 管理监督主体信息
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked" })
	public void HviewjgztManage(HviewjgztDTO dto) throws Exception {
		//本方法调用时 应往dto中初始化 hviewjgztid
	   String v_sql="";	   
	   if ("add".equalsIgnoreCase(dto.getDokind()) || "update".equalsIgnoreCase(dto.getDokind())){
	       if ("pcompany".equalsIgnoreCase(dto.getTablemc())){
	    	   v_sql="select a.comid AS hviewjgztid,a.comdm AS jgztbh,a.commc AS jgztmc,"+
	                 "a.commcjc AS jgztmcjc,a.comfzr AS jgztlxr,a.comgddh AS jgztlxrgddh,"+
	                 "a.comyddh AS jgztlxryddh,a.comdz AS jgzttxdz,a.aaa027,b.jgztzzzmmc,"+
	                 "b.jgztzzzmbh,'1' AS jgztlx,'' AS jgztgsztid,'1' AS jgztfwnfww "+
	                 " from pcompany a LEFT join viewComxkz b on a.comid=b.comid "+
	                 " where a.comid='"+dto.getHviewjgztid()+"'";
	       }else if ("hjgztkhgx".equalsIgnoreCase(dto.getTablemc())){//监管主体客户关系表hjgztkhgx
	    	   v_sql="SELECT a.hjgztkhgxid AS hviewjgztid,a.jgztkhbh AS jgztbh,"+
	                 "jgztkhmc AS jgztmc,a.jgztkhmcjc AS jgztmcjc,jgztkhlxr AS jgztlxr,"+
	                 "a.jgztkhgddh AS jgztlxrgddh,a.jgztkhyddh as jgztlxryddh,"+
	                 "a.jgztkhlxdz AS jgzttxdz,a.aaa027,a.jgztkhzzzmmc AS jgztzzzmmc,"+
	                 "a.jgztkhzzzmbh AS jgztzzzmbh,"+
	                 "(case when a.jgztkhgx='1' then '3' when a.jgztkhgx='2' then '4' when a.jgztkhgx='3' then '5' else '' end) AS jgztlx,"+
	                 "a.hviewjgztid AS jgztgsztid,a.jgztfwnfww AS jgztfwnfww "+
	                 " FROM hjgztkhgx a "+
	                 " where a.hjgztkhgxid='"+dto.getHviewjgztid()+"'";
	       }else if ("psh".equalsIgnoreCase(dto.getTablemc())){//商户表psh
	    	   v_sql="SELECT a.pshid AS hviewjgztid,a.shtwh AS jgztbh,a.shmc AS jgztmc,"+
	                 "a.shjc AS jgztmcjc,a.shlxr AS jgztlxr,a.shgddh AS jgztlxrgddh,"+
	      			 "a.shyddh AS jgztlxryddh,a.shtxdz AS jgzttxdz,c.aaa027 AS aaa027,"+
	                 "a.shzzzmmc AS jgztzzzmmc,a.shzzzmbh AS jgztzzzmbh,'2' AS jgztlx,"+
	      			 "a.comid AS jgztgsztid,'1' AS jgztfwnfww "+
	                   " FROM psh a,pscfq b,pcompany c "+
	                   " WHERE a.pscfqid=b.pscfqid "+
	                   " AND b.comid=c.comid "+
	                   " and a.pshid='"+dto.getHviewjgztid()+"' ";    	   
	       }	   
	
		   List<Hviewjgzt> v_oldHviewjgztList=(List<Hviewjgzt>)DbUtils.getDataList(v_sql, Hviewjgzt.class);
		   if (v_oldHviewjgztList!=null && v_oldHviewjgztList.size()>0){
			   Hviewjgzt v_oldHviewjgzt=v_oldHviewjgztList.get(0);
	    	   if ("add".equalsIgnoreCase(dto.getDokind())){
	    		   v_oldHviewjgzt.setJgztmcjc(PinYinUtil.GetChineseSpell(v_oldHviewjgzt.getJgztmc()));
	    		   dao.insert(v_oldHviewjgzt);
	    	   }else if ("update".equalsIgnoreCase(dto.getDokind())){
	    		   v_oldHviewjgzt.setJgztmcjc(PinYinUtil.GetChineseSpell(v_oldHviewjgzt.getJgztmc()));
	    		   dao.update(v_oldHviewjgzt);
	    	   }
//	    	   else if ("delete".equalsIgnoreCase(dto.getDokind())){
//	    		   dao.delete(v_oldHviewjgzt);
//	    	   }    		   
		   }  
	   } else if ("delete".equalsIgnoreCase(dto.getDokind())){
		   dao.clear(Hviewjgzt.class, Cnd.where("hviewjgztid", "=", dto.getHviewjgztid()));
	   } 
	   
	}
	
	/**
	 * RuZhouComDataRuku 汝州企业数据入库
	 *
	 * @return
	 * @throws Exception
	 */	
	public void RuZhouComDataRuku(HttpServletRequest request) throws Exception {
		String prm_aaa027="";
		String prm_pkid="";
		
		String v_sql="select a.* from tabrzcom a where doflag=0 ";
		if (!StringUtils.isEmpty(prm_aaa027)){
			v_sql=v_sql+" and a.aaa027='"+prm_aaa027+"'";
		};
		if (!StringUtils.isEmpty(prm_pkid)){
			v_sql=v_sql+" and a.pkid='"+prm_pkid+"'";
		};	
		v_sql=v_sql+" order by pkid ";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");
		int v_count=0;
		List<TabrzcomDTO> v_list=(List<TabrzcomDTO>)DbUtils.getDataList(v_sql, TabrzcomDTO.class);
		if (v_list!=null && v_list.size()>0){
			v_count=v_count+1;
			for (TabrzcomDTO v_dto:v_list){
				PcompanyDTO v_pcomdto=new PcompanyDTO();
				v_pcomdto.setCommc(v_dto.getDwmc());
				v_pcomdto.setComfrhyz(v_dto.getFrxm());
				v_pcomdto.setComyddh(v_dto.getLxdh());
				v_pcomdto.setComdz(v_dto.getDz());
				v_pcomdto.setCombeizhu(v_dto.getBz());
				v_pcomdto.setAaa027(v_dto.getAaa027());
				v_pcomdto.setComdalei(v_dto.getComdalei());
				v_pcomdto.setSjordnbz("2");
				v_pcomdto.setOrderno(String.valueOf(v_dto.getPkid()));
				
				PcompanyXkzDTO v_xkzdto=new PcompanyXkzDTO();
//				餐饮          101202
//				食品流通      101302
//				学校食堂      101201
//				卫生室诊所    102201
//				药店          102302
//				化妆品店      103201
//				食品生产      101101 
				String v_comxkzlx="4";//食品经营许可证
				if ("101202".equals(v_dto.getComdalei()) || 
						"101302".equals(v_dto.getComdalei())||
						"101201".equals(v_dto.getComdalei())
						){//餐饮,食品流通,学校食堂
					v_comxkzlx="4";
				}else if ("101101".equals(v_dto.getComdalei())){//食品生产
					v_comxkzlx="3";
				}else if ("102201".equals(v_dto.getComdalei())){//卫生室诊所
					v_comxkzlx="2";
				}else if ("102302".equals(v_dto.getComdalei())){//药店
					v_comxkzlx="6";
				}else if ("103201".equals(v_dto.getComdalei())){//药店
					v_comxkzlx="10";
				}
				
				v_xkzdto.setComxkzlx(v_comxkzlx);
				v_xkzdto.setComxkzbh(v_dto.getXkzh());
				if (null!=v_dto.getFzrq() && !"".equals(v_dto.getFzrq())){
					v_xkzdto.setComxkyxqq(java.sql.Date.valueOf(v_dto.getFzrq().toString()));
				}
				if (null!=v_dto.getYxq() && !"".equals(v_dto.getYxq())){
					v_xkzdto.setComxkyxqz(java.sql.Date.valueOf(v_dto.getYxq().toString()));
				}
				String v_xkzstr="["+Json.toJson(v_xkzdto)+"]";
				v_pcomdto.setComzzzmlist(v_xkzstr);
				//ServletContext application = LeafCache.getAppContext();
				
				//org.nutz.mvc.ActionContext v_context=org.nutz.mvc.Mvcs.getActionContext(); 
				//HttpServletRequest v_request = v_context.getRequest();
				savePcompany(request,v_pcomdto);
				//savePcompanyXkzSingle(request,v_xkzdto);
				
				Sql v_exesql=Sqls.create("update tabrzcom set doflag=1 where pkid='"+v_dto.getPkid()+"'");
				dao.execute(v_exesql);
				System.out.println("v_count"+v_count+" pkid"+v_dto.getPkid());
			}
			
			
		}
//		private static Sql updateByPcom = Sqls.create("UPDATE pcompanyimport INNER JOIN pcompany ON pcompanyimport.outercomname=pcompany.commc SET pcompanyimport.comid=pcompany.comid");
//
//	dao.execute(updateByJK);
	}
	
	/**
	 *
	 *  getDataFromSJ的中文名称：获取省局数据
	 *
	 *  getDataFromSJ的概要说明：
	 *
	 *  @return
	 *  Written  by  : gjf
	 * @throws Exception 
	 *
	 */
	public Timestamp myTimestamp(String prm_str){
		if (!StringUtils.isEmpty(prm_str)){
			return Timestamp.valueOf(prm_str);
		}else{
			return null;
		}
	};
	
	public void getComDataFromSJ(HttpServletRequest request) throws Exception{
		//获取本地企业最新的同步时间
		String v_aaa027 = request.getParameter("aaa027");
		if (StringUtils.isEmpty(v_aaa027)){
			throw new BusinessException("请传入地区编码");
		};
		String v_firstinit = request.getParameter("firstinit");
		if (v_firstinit==null){
			v_firstinit="0";
		};
		String v_sql="";
		int v_pages=0;

		List<Bscompany> v_listBscompany=new ArrayList();
		boolean v_loop=true;
		while (v_loop) {
			v_pages=v_pages+1;
			v_listBscompany.clear();
			SimpleDateFormat v_fmt=new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			v_sql="select max(sjdatatime) as sjdatatime from pcompany a ";
			PcompanyDTO v_pcomDto=(PcompanyDTO)DbUtils.getDataList(v_sql, PcompanyDTO.class).get(0);
			Timestamp v_maxcomSjdatatime=v_pcomDto.getSjdatatime();
			if (v_maxcomSjdatatime==null){
				v_maxcomSjdatatime=myTimestamp("1991-01-01 12:12:12");
			};
			
			String v_sql2="select max(sjc) as sjc from bscompany a ";
			BscompanyDTO v_BscompanyDTO=(BscompanyDTO)DbUtils.getDataList(v_sql, BscompanyDTO.class).get(0);
			Timestamp v_maxcomsjc=v_BscompanyDTO.getSjc();
			if (v_maxcomsjc==null){
				v_maxcomsjc=myTimestamp("1991-01-01 12:12:12");
			}
			
			if (v_maxcomSjdatatime.compareTo(v_maxcomsjc)<0){
				v_maxcomSjdatatime=v_maxcomsjc;
			}
			
			String v_comMaxtime=v_fmt.format(v_maxcomSjdatatime);
			System.out.println("v_xkzMaxtime "+v_comMaxtime);
			com.alibaba.fastjson.JSONArray jsonArray = null;
			String requestUrl = "http://as.hda.gov.cn/com_onSearchCompany.action?time="+v_comMaxtime
					+"&gUser=askj&gPwd=5FC17478F4171944318FE9256BEDB47B&pageSize=1000&pageCurrent="+v_pages+"&qhdm="+v_aaa027;//410122
			
			String charset = "UTF-8";
			String content = HttpUtil.httpGet(requestUrl, charset);
			if(StringUtils.isNotEmpty(content)) {
				com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
				if (jsonObject!=null&&jsonObject.containsKey("rows")){
					jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("rows").toString());
				}
			}
			if(jsonArray!=null){
				for (Object cominfo:jsonArray){
					JSONObject v_cominfo=(JSONObject)cominfo;
					
					//存在删除
					if ( "0".equals(v_firstinit)) //首次初始化不 执行是否存在判断
					{
						String v_comid=v_cominfo.getString("comId");
						Bscompany v_oldBscompany=dao.fetch(Bscompany.class, v_comid);
						if (v_oldBscompany!=null){
							dao.delete(v_oldBscompany);
						}
					};
					
					  Bscompany v_newBscompany=new Bscompany();
					  
					  v_newBscompany.setComId(v_cominfo.getString("comId"));// COM_ID bigint(20) NOT NULL DEFAULT 0 COMMENT '企业ID',
					  v_newBscompany.setComUserName(v_cominfo.getString("comUserName"));//COM_USER_NAME varchar(50) NOT NULL COMMENT '登录用户名',
					  v_newBscompany.setComPwd(v_cominfo.getString("comPwd"));//COM_PWD varchar(32) NOT NULL COMMENT '登录密码',
					  v_newBscompany.setComMc(v_cominfo.getString("comMc"));//COM_MC varchar(200) NOT NULL COMMENT '公司名称',
					  v_newBscompany.setComZjhm(v_cominfo.getString("comZjhm"));//COM_ZJHM varchar(100) NOT NULL COMMENT '营业执照号',
					  v_newBscompany.setComDm(v_cominfo.getString("comDm"));//COM_DM varchar(50) DEFAULT NULL COMMENT '企业代码：企业类型字母+6位行政区域代码+9位序列号',
					  v_newBscompany.setComLxr(v_cominfo.getString("comLxr"));//COM_LXR varchar(50) DEFAULT NULL COMMENT '联系人',
					  v_newBscompany.setComLxdh(v_cominfo.getString("comLxdh"));//COM_LXDH varchar(30) DEFAULT NULL COMMENT '联系固定电话',
					  v_newBscompany.setComAddress(v_cominfo.getString("comAddress"));//COM_ADDRESS varchar(200) DEFAULT NULL COMMENT '公司地址',
					  v_newBscompany.setComShbz(v_cominfo.getString("comShbz"));//COM_SHBZ varchar(1) DEFAULT 'Y' COMMENT '审核标志 Y通过 N未通过 M 等待审核',
					  v_newBscompany.setComShrid(v_cominfo.getLong("comShrid"));//COM_SHRID bigint(20) DEFAULT NULL COMMENT '审核人ID(默认审核人ID=3)',
					  System.out.println("comShsjcomShsjcomShsj "+v_cominfo.getString("comShsj"));
					  v_newBscompany.setComShsj(myTimestamp(v_cominfo.getString("comShsj")));//COM_SHSJ datetime DEFAULT NULL COMMENT '审核时间',
					  v_newBscompany.setComQylx(v_cominfo.getString("comQylx"));//COM_QYLX varchar(100) DEFAULT NULL COMMENT '企业类型ID ：参照BS_QYLX',
					  v_newBscompany.setComQyxz(v_cominfo.getString("comQyxz"));//COM_QYXZ varchar(3) DEFAULT NULL COMMENT '1国有 2集体 3股份 4私营 5合资 6外资 7其他',
					  v_newBscompany.setComProvinceDm(v_cominfo.getString("comProvinceDm"));//COM_PROVINCE_DM varchar(8) DEFAULT NULL COMMENT '省份代码',
					  v_newBscompany.setComCityDm(v_cominfo.getString("comCityDm"));//COM_CITY_DM varchar(8) DEFAULT NULL COMMENT '市代码',
					  v_newBscompany.setComCountyDm(v_cominfo.getString("comCountyDm"));//COM_COUNTY_DM varchar(8) DEFAULT NULL COMMENT '县区代码',
					  v_newBscompany.setComWeb(v_cominfo.getString("comWeb"));//COM_WEB varchar(300) DEFAULT NULL COMMENT '网址',
					  v_newBscompany.setComEmail(v_cominfo.getString("comEmail"));//COM_EMAIL varchar(150) DEFAULT NULL COMMENT '电子邮件',
					  v_newBscompany.setComProvince(v_cominfo.getString("comProvince"));//COM_PROVINCE varchar(200) DEFAULT NULL COMMENT '省份名称',
					  v_newBscompany.setComCity(v_cominfo.getString("comCity"));//COM_CITY varchar(200) DEFAULT NULL COMMENT '市名称',
					  v_newBscompany.setComCounty(v_cominfo.getString("comCounty"));//COM_COUNTY varchar(200) NOT NULL COMMENT '县区名称',
					  System.out.println("comWtgyycomWtgyy  "+v_cominfo.getString("comWtgyy"));
					  v_newBscompany.setComWtgyy(v_cominfo.getString("comWtgyy"));//COM_WTGYY varchar(200) DEFAULT NULL COMMENT '审核未通过原因',
					  v_newBscompany.setComFax(v_cominfo.getString("comFax"));//COM_FAX varchar(20) DEFAULT NULL COMMENT '传真',
					  v_newBscompany.setComZip(v_cominfo.getString("comZip"));//COM_ZIP varchar(6) DEFAULT NULL COMMENT '邮编',
					  v_newBscompany.setComLxsj(v_cominfo.getString("comLxsj"));//COM_LXSJ varchar(20) DEFAULT NULL COMMENT '联系手机',
					  v_newBscompany.setComJjxz(v_cominfo.getString("comJjxz"));//COM_JJXZ varchar(50) DEFAULT NULL COMMENT '营业执照上的经济性质或者企业名称预核准上的的经济类型',
					  v_newBscompany.setComZzjgdm(v_cominfo.getString("comZzjgdm"));//COM_ZZJGDM varchar(50) DEFAULT NULL COMMENT '组织机构代码',
					  v_newBscompany.setComGsdjjg(v_cominfo.getString("comGsdjjg"));//COM_GSDJJG varchar(200) DEFAULT NULL COMMENT '营业执照上的登记机构全称',
					  System.out.println(v_cominfo.getString("comClrq"));
					  v_newBscompany.setComClrq(myTimestamp(v_cominfo.getString("comClrq")));//COM_CLRQ datetime DEFAULT NULL COMMENT '公司成立日期',
					  v_newBscompany.setComJyqx(v_cominfo.getString("comJyqx"));//COM_JYQX varchar(50) DEFAULT NULL COMMENT '营业执照上的经营期限',
					  v_newBscompany.setComZczj(v_cominfo.getLong("comZczj"));//COM_ZCZJ bigint(20) DEFAULT NULL COMMENT '注册资金（万元）',
					  v_newBscompany.setComFddbr(v_cominfo.getString("comFddbr"));//COM_FDDBR varchar(50) DEFAULT NULL COMMENT '法定代表人',
					  v_newBscompany.setComZclb(v_cominfo.getString("comZclb"));//COM_ZCLB varchar(10) DEFAULT '1' COMMENT '1企业自行注册2 操作员添加注册',
					  v_newBscompany.setComDzcrid(v_cominfo.getLong("comDzcrid"));//COM_DZCRID bigint(20) DEFAULT NULL COMMENT '代企业注册的操作人ID',
					  v_newBscompany.setComDzcsj(myTimestamp(v_cominfo.getString("comDzcsj")));//COM_DZCSJ datetime DEFAULT NULL COMMENT '代注册时间',
					  v_newBscompany.setQymc(v_cominfo.getString("qymc"));//QYMC varchar(100) DEFAULT NULL COMMENT '企业名称',
					  v_newBscompany.setQyywmc(v_cominfo.getString("qyywmc"));//QYYWMC varchar(100) DEFAULT NULL COMMENT '企业英文名称',
					  v_newBscompany.setYljgmc(v_cominfo.getString("yljgmc"));//YLJGMC varchar(100) DEFAULT NULL COMMENT '医疗机构名称',
					  v_newBscompany.setZzjgdm(v_cominfo.getString("zzjgdm"));//ZZJGDM varchar(100) DEFAULT NULL COMMENT '组织机构代码',
					  v_newBscompany.setYyzzzch(v_cominfo.getString("yyzzzch"));//YYZZZCH varchar(100) DEFAULT NULL COMMENT '营业执照注册号',
					  v_newBscompany.setZczj(v_cominfo.getFloat("zczj"));//ZCZJ float(20, 2) DEFAULT NULL COMMENT '注册资金',
					  v_newBscompany.setTzzb(v_cominfo.getFloat("tzzb"));//tzzb float(20, 2) DEFAULT NULL COMMENT '投资资本',
					  v_newBscompany.setJyfs(v_cominfo.getString("jyfs"));//JYFS varchar(50) DEFAULT NULL COMMENT '经营方式',
					  v_newBscompany.setQylx(v_cominfo.getString("qylx"));//QYLX varchar(100) DEFAULT NULL COMMENT '企业类型',
					  v_newBscompany.setFddbr(v_cominfo.getString("fddbr"));//FDDBR varchar(50) DEFAULT NULL COMMENT '法定代表人',
					  v_newBscompany.setFrdb(v_cominfo.getString("frdb"));//FRDB varchar(50) DEFAULT NULL COMMENT '法人代表',
					  v_newBscompany.setQygm(v_cominfo.getString("qygm"));//QYGM varchar(10) DEFAULT NULL COMMENT '企业规模',
					  v_newBscompany.setQyrs(v_cominfo.getLong("qyrs"));//QYRS bigint(20) DEFAULT NULL COMMENT '企业人数',
					  v_newBscompany.setQysjsj(myTimestamp(v_cominfo.getString("qysjsj")));//QYSJSJ datetime DEFAULT NULL COMMENT '企业始建时间',
					  v_newBscompany.setQyzjgmsj(myTimestamp(v_cominfo.getString("qyzjgmsj")));//QYZJGMSJ datetime DEFAULT NULL COMMENT '企业最近更名时间',
					  v_newBscompany.setQylxdhhm(v_cominfo.getString("qylxdhhm"));//QYLXDHHM varchar(20) DEFAULT NULL COMMENT '企业联系电话号码',
					  v_newBscompany.setQylxczhm(v_cominfo.getString("qylxczhm"));//QYLXCZHM varchar(20) DEFAULT NULL COMMENT '企业联系传真号码',
					  v_newBscompany.setQywz(v_cominfo.getString("qywz"));//QYWZ varchar(200) DEFAULT NULL COMMENT '企业网址',
					  v_newBscompany.setQyfzrxm(v_cominfo.getString("qyfzrxm"));//QYFZRXM varchar(50) DEFAULT NULL COMMENT '企业负责人姓名',
					  v_newBscompany.setQylxrxm(v_cominfo.getString("qylxrxm"));//QYLXRXM varchar(50) DEFAULT NULL COMMENT '企业联系人姓名',
					  v_newBscompany.setZcdz(v_cominfo.getString("zcdz"));//ZCDZ varchar(200) DEFAULT NULL COMMENT '注册地址',
					  v_newBscompany.setZcdzyw(v_cominfo.getString("zcdzyw"));//ZCDZYW varchar(200) DEFAULT NULL COMMENT '注册地址(英文)',
					  v_newBscompany.setScdz(v_cominfo.getString("scdz"));//SCDZ varchar(200) DEFAULT NULL COMMENT '生产地址',
					  v_newBscompany.setScdzyw(v_cominfo.getString("scdzyw"));//SCDZYW varchar(200) DEFAULT NULL COMMENT '生产地址(英文)',
					  v_newBscompany.setTxdz(v_cominfo.getString("txdz"));//TXDZ varchar(200) DEFAULT NULL COMMENT '通信地址',
					  v_newBscompany.setYzbm(v_cominfo.getString("yzbm"));//YZBM varchar(16) DEFAULT NULL COMMENT '邮政编码',
					  v_newBscompany.setDzgjhdq(v_cominfo.getString("dzgjhdq"));//DZGJHDQ varchar(70) DEFAULT '中国' COMMENT '地址-国家/或地区',
					  v_newBscompany.setDzszxszzq(v_cominfo.getString("dzszxszzq"));//DZSZXSZZQ varchar(70) DEFAULT '河南' COMMENT '地址-省/直辖市/自治区',
					  v_newBscompany.setDzsqzzzm(v_cominfo.getString("dzsqzzzm"));//DZSQZZZM varchar(70) DEFAULT '' COMMENT '地址-市/区/自治州/盟',
					  v_newBscompany.setDzxzzxxjs(v_cominfo.getString("dzxzzxxjs"));//DZXZZXXJS varchar(70) DEFAULT '' COMMENT '地址-县/自治县/县级市',
					  v_newBscompany.setDzxzjdbsc(v_cominfo.getString("dzxzjdbsc"));//DZXZJDBSC varchar(70) DEFAULT NULL COMMENT '地址-乡/镇/街道办事处',
					  v_newBscompany.setDzcjlnd(v_cominfo.getString("dzcjlnd"));//DZCJLND varchar(70) DEFAULT NULL COMMENT '地址-村/街/路/弄等',
					  v_newBscompany.setDzmphm(v_cominfo.getString("dzmphm"));//DZMPHM varchar(70) DEFAULT NULL COMMENT '地址-门牌号码',
					  v_newBscompany.setYpscxkzbh(v_cominfo.getString("ypscxkzbh"));//YPSCXKZBH varchar(50) DEFAULT NULL COMMENT '药品生产许可证编号',
					  v_newBscompany.setYpgmpzsbh(v_cominfo.getString("ypgmpzsbh"));//YPGMPZSBH varchar(50) DEFAULT NULL COMMENT '药品GMP证书编号',
					  v_newBscompany.setYpjyxkzh(v_cominfo.getString("ypjyxkzh"));//YPJYXKZH varchar(50) DEFAULT NULL COMMENT '药品经营许可证号',
					  v_newBscompany.setYpjyzlglgfrzzsbh(v_cominfo.getString("ypjyzlglgfrzzsbh"));//YPJYZLGLGFRZZSBH varchar(50) DEFAULT NULL COMMENT '药品经营质量管理规范认证证书编号',
					  v_newBscompany.setYlqxscxkzh(v_cominfo.getString("ylqxscxkzh"));//YLQXSCXKZH varchar(50) DEFAULT NULL COMMENT '医疗器械生产许可证号',
					  v_newBscompany.setFzjg(v_cominfo.getString("fzjg"));//FZJG varchar(100) DEFAULT NULL COMMENT '发证机关',
					  v_newBscompany.setFzrq(myTimestamp(v_cominfo.getString("fzrq")));//FZRQ datetime DEFAULT NULL COMMENT '发证日期',
					  v_newBscompany.setZjzsyxqqsrq(myTimestamp(v_cominfo.getString("zjzsyxqqsrq")));//ZJZSYXQQSRQ datetime DEFAULT NULL COMMENT '证件/证书有效期起始日期',
					  v_newBscompany.setZjzsyxqzzrq(myTimestamp(v_cominfo.getString("zjzsyxqzzrq")));//ZJZSYXQZZRQ datetime DEFAULT NULL COMMENT '证件/证书有效期终止日期',
					  v_newBscompany.setCpzcdljg(v_cominfo.getString("cpzcdljg"));//CPZCDLJG varchar(200) DEFAULT NULL COMMENT '产品注册代理机构',
					  v_newBscompany.setCpdlr(v_cominfo.getString("cpdlr"));//CPDLR varchar(200) DEFAULT NULL COMMENT '产品代理人',
					  v_newBscompany.setCpshfwjg(v_cominfo.getString("cpshfwjg"));//CPSHFWJG varchar(200) DEFAULT NULL COMMENT '产品售后服务机构',
					  v_newBscompany.setWtyjjg(v_cominfo.getString("wtyjjg"));//WTYJJG varchar(200) DEFAULT NULL COMMENT '委托研究机构',
					  v_newBscompany.setQyzjbmmc(v_cominfo.getString("qyzjbmmc"));//QYZJBMMC varchar(100) DEFAULT NULL COMMENT '企业质监部门名称',
					  v_newBscompany.setQyzjbmgjjszcrs(v_cominfo.getLong("qyzjbmgjjszcrs"));//QYZJBMGJJSZCRS bigint(20) DEFAULT NULL COMMENT '企业质监部门高级技术职称人数',
					  v_newBscompany.setQyzjbmzjjszcrs(v_cominfo.getLong("qyzjbmzjjszcrs"));//QYZJBMZJJSZCRS bigint(20) DEFAULT NULL COMMENT '企业质监部门中级技术职称人数',
					  v_newBscompany.setQyzcdzybhpzs(v_cominfo.getLong("qyzcdzybhpzs"));//QYZCDZYBHPZS bigint(20) DEFAULT NULL COMMENT '企业注册的中药保护品种数',
					  v_newBscompany.setGdzcyz(v_cominfo.getLong("gdzcyz"));//GDZCYZ bigint(20) DEFAULT NULL COMMENT '固定资产原值',
					  v_newBscompany.setGdzcjz(v_cominfo.getLong("gdzcjz"));//GDZCJZ bigint(20) DEFAULT NULL COMMENT '固定资产净值',
					  v_newBscompany.setSndxse(v_cominfo.getFloat("sndxse"));//SNDXSE float(20, 2) DEFAULT NULL COMMENT '上年度销售额',
					  v_newBscompany.setSndls(v_cominfo.getFloat("sndls"));//SNDLS float(20, 2) DEFAULT NULL COMMENT '上年度利税',
					  v_newBscompany.setSngyzcz(v_cominfo.getLong("sngyzcz"));//SNGYZCZ bigint(20) DEFAULT NULL COMMENT '上年工业总产值',
					  v_newBscompany.setSnxssr(v_cominfo.getLong("snxssr"));//SNXSSR bigint(20) DEFAULT NULL COMMENT '上年销售收入',
					  v_newBscompany.setNxseF(v_cominfo.getFloat("nxseF"));//nxse_f float(20, 2) DEFAULT NULL COMMENT '连续三年销售额 第一年',
					  v_newBscompany.setNxseS(v_cominfo.getFloat("nxseS"));//nxse_s float(20, 2) DEFAULT NULL COMMENT '连续三年销售额 第二年',
					  v_newBscompany.setNxseT(v_cominfo.getFloat("nxseT"));//nxse_t float(20, 2) DEFAULT NULL COMMENT '连续三年销售额 第三年',
					  v_newBscompany.setSnlr(v_cominfo.getFloat("snlr"));//SNLR float(20, 2) DEFAULT NULL COMMENT '上年利润',
					  v_newBscompany.setSnsj(v_cominfo.getLong("snsj"));//SNSJ bigint(20) DEFAULT NULL COMMENT '上年税金',
					  v_newBscompany.setSnch(v_cominfo.getLong("snch"));//SNCH bigint(20) DEFAULT NULL COMMENT '上年创汇',
					  v_newBscompany.setZyjsrybl(v_cominfo.getLong("zyjsrybl"));//ZYJSRYBL bigint(20) DEFAULT NULL COMMENT '专业技术人员比例',
					  v_newBscompany.setZlsqr(v_cominfo.getString("zlsqr"));//ZLSQR varchar(50) DEFAULT NULL COMMENT '质量受权人',
					  v_newBscompany.setZlfzr(v_cominfo.getString("zlfzr"));//ZLFZR varchar(50) DEFAULT NULL COMMENT '质量负责人',
					  v_newBscompany.setZlfzrs(v_cominfo.getLong("zlfzrs"));//ZLFZRS bigint(20) DEFAULT NULL COMMENT '质量负责人数',
					  v_newBscompany.setScfzr(v_cominfo.getString("scfzr"));//SCFZR varchar(50) DEFAULT NULL COMMENT '生产负责人',
					  v_newBscompany.setScfzrs(v_cominfo.getLong("scfzrs"));//SCFZRS bigint(20) DEFAULT NULL COMMENT '生产负责人数',
					  v_newBscompany.setZyysrs(v_cominfo.getLong("zyysrs"));//ZYYSRS bigint(20) DEFAULT NULL COMMENT '执业药师人数',
					  v_newBscompany.setZyysrs(v_cominfo.getLong("zyysrs"));//ZRYSRS bigint(20) DEFAULT NULL COMMENT '主任药师人数',
					  v_newBscompany.setFzrysrs(v_cominfo.getLong("fzrysrs"));//FZRYSRS bigint(20) DEFAULT NULL COMMENT '副主任药师人数',
					  v_newBscompany.setZgysrs(v_cominfo.getLong("zgysrs"));//ZGYSRS bigint(20) DEFAULT NULL COMMENT '主管药师人数',
					  v_newBscompany.setYsrs01(v_cominfo.getLong("ysrs01"));//YSRS01 bigint(20) DEFAULT NULL COMMENT '药师人数',
					  v_newBscompany.setYsrs02(v_cominfo.getLong("ysrs02"));//YSRS02 bigint(20) DEFAULT NULL COMMENT '药士人数',
					  v_newBscompany.setCqzdmj(v_cominfo.getLong("cqzdmj"));//CQZDMJ bigint(20) DEFAULT NULL COMMENT '厂区占地面积',
					  v_newBscompany.setJzmj(v_cominfo.getFloat("jzmj"));//JZMJ float(20, 2) DEFAULT NULL COMMENT '建筑面积',
					  v_newBscompany.setScmj(v_cominfo.getFloat("scmj"));//scmj float(20, 2) DEFAULT NULL COMMENT '生产面积',
					  v_newBscompany.setJhmj(v_cominfo.getFloat("jhmj"));//jhmj float(20, 2) DEFAULT NULL COMMENT '净化面积',
					  v_newBscompany.setJymj(v_cominfo.getFloat("jymj"));//jymj float(20, 2) DEFAULT NULL COMMENT '检验面积',
					  v_newBscompany.setYclccmj(v_cominfo.getFloat("yclccmj"));//yclccmj float(20, 2) DEFAULT NULL COMMENT '原材料仓储面积',
					  v_newBscompany.setCpccmj(v_cominfo.getFloat("cpccmj"));//cpccmj float(20, 2) DEFAULT NULL COMMENT '成品仓储面积',
					  v_newBscompany.setYljgbzcws(v_cominfo.getLong("yljgbzcws"));//YLJGBZCWS bigint(20) DEFAULT NULL COMMENT '医疗机构编制床位数',
					  v_newBscompany.setQyzxbz(v_cominfo.getString("qyzxbz"));//QYZXBZ varchar(1) DEFAULT NULL COMMENT '企业注销标志',
					  v_newBscompany.setQyzxrq(myTimestamp(v_cominfo.getString("qyzxrq")));//QYZXRQ datetime DEFAULT NULL COMMENT '企业注销日期',
					  v_newBscompany.setQyzxyy(v_cominfo.getString("qyzxyy"));//QYZXYY varchar(20) DEFAULT NULL COMMENT '企业注销原因',
					  v_newBscompany.setQyssmgsmc(v_cominfo.getString("qyssmgsmc"));//QYSSMGSMC varchar(100) DEFAULT NULL COMMENT '企业所属母公司名称',
					  v_newBscompany.setQyssmgsdz(v_cominfo.getString("qyssmgsdz"));//QYSSMGSDZ varchar(200) DEFAULT NULL COMMENT '企业所属母公司地址',
					  v_newBscompany.setWfgbhdq(v_cominfo.getString("wfgbhdq"));//WFGBHDQ varchar(50) DEFAULT NULL COMMENT '外方国别或地区',
					  v_newBscompany.setGysmc(v_cominfo.getString("gysmc"));//GYSMC varchar(100) DEFAULT NULL COMMENT '供应商名称',
					  v_newBscompany.setCpjxsmc(v_cominfo.getString("cpjxsmc"));//CPJXSMC varchar(100) DEFAULT NULL COMMENT '产品经销商名称',
					  v_newBscompany.setFddbrsfz(v_cominfo.getString("fddbrsfz"));//FDDBRSFZ varchar(50) DEFAULT NULL COMMENT '法定代表人身份证号',
					  v_newBscompany.setFddbrlxdh(v_cominfo.getString("fddbrlxdh"));//FDDBRLXDH varchar(50) DEFAULT NULL COMMENT '法定代表人联系电话',
					  v_newBscompany.setZcly(v_cominfo.getString("zcly"));//ZCLY varchar(10) DEFAULT '1' COMMENT '注册来源  1企业主动注册 2工商数据资料补齐生成',
					  v_newBscompany.setUuid(v_cominfo.getString("uuid"));//UUID varchar(40) DEFAULT NULL COMMENT 'UUID',
					  v_newBscompany.setLxDl(v_cominfo.getString("lxDl"));//LX_DL varchar(200) DEFAULT NULL COMMENT '企业类型所属的大类，对应bs_qylxl中的x_dl',
					  v_newBscompany.setZjlx(v_cominfo.getString("zjlx"));//zjlx char(2) DEFAULT NULL COMMENT '证件类型 01 社会信用代码 02 营业执照号 03身份证',
					  v_newBscompany.setZycp(v_cominfo.getString("zycp"));//zycp varchar(500) DEFAULT NULL COMMENT '主要产品',
					  v_newBscompany.setNcl(v_cominfo.getString("ncl"));//ncl varchar(100) DEFAULT NULL COMMENT '年产量',
					  v_newBscompany.setSjc(myTimestamp(v_cominfo.getString("sjc")));//sjc date DEFAULT NULL COMMENT '更新时间戳',
					  v_listBscompany.add(v_newBscompany);
					  //dao.insert(v_newBscompany);
				};
				if (v_listBscompany.size()>0){
				dao.fastInsert(v_listBscompany);
				v_listBscompany.clear();
				System.out.println("com insert "+v_listBscompany.size());
				}else{
					v_loop=false;
					System.out.println("com insert wan cheng ");					
				}
				
		}else{
			v_loop=false;
			System.out.println("com insert wan cheng ");
		}//loop
       }	
	};//end
	
	/**
	 *
	 *  getDataFromSJ的中文名称：获取省局数据
	 *
	 *  getDataFromSJ的概要说明：
	 *
	 *  @return
	 *  Written  by  : gjf
	 * @throws Exception 
	 *
	 */
	public void getXkzDataFromSJ(HttpServletRequest request) throws Exception{
		//获取本地企业最新的同步时间
		String v_aaa027 = request.getParameter("aaa027");
		String v_firstinit = request.getParameter("firstinit");
		if (v_firstinit==null){
			v_firstinit="0";
		};
		String v_sql="";
		
		if (StringUtils.isEmpty(v_aaa027)){
			throw new BusinessException("请传如地区编码");
		}		
		List<Bstyxkz> v_listBstyxkz=new ArrayList();
		boolean v_loop=true;
		int pages = 0;
		while (v_loop) {
			pages= pages+1;
			v_listBstyxkz.clear();
			SimpleDateFormat v_fmt=new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			v_sql="select max(sjdatatime) as sjdatatime from pcompanyxkz a ";
			PcompanyXkzDTO v_pcomxkzDto=(PcompanyXkzDTO)DbUtils.getDataList(v_sql, PcompanyXkzDTO.class).get(0);
			Timestamp v_maxxkzSjdatatime=v_pcomxkzDto.getSjdatatime();
			if (v_maxxkzSjdatatime==null){
				v_maxxkzSjdatatime=myTimestamp("1991-01-01 12:12:12");
			};
			
			String v_sql2="select max(sjc) as sjc from bstyxkz a ";
			BstyxkzDTO v_BstyxkzDTO=(BstyxkzDTO)DbUtils.getDataList(v_sql, BstyxkzDTO.class).get(0);
			Timestamp v_maxxkzsjc=v_BstyxkzDTO.getSjc();
			if (v_maxxkzsjc==null){
				v_maxxkzsjc=myTimestamp("1991-01-01 12:12:12");
			}
			
			if (v_maxxkzSjdatatime.compareTo(v_maxxkzsjc)<0){
				v_maxxkzSjdatatime=v_maxxkzsjc;
			}

			String v_xkzMaxtime=v_fmt.format(v_maxxkzSjdatatime);
			System.out.println("v_xkzMaxtime "+v_xkzMaxtime);
			com.alibaba.fastjson.JSONArray jsonArray = null;
			String requestUrl = "http://as.hda.gov.cn/com_onSearchXkz.action?time="+v_xkzMaxtime
					+"&gUser=askj&gPwd=5FC17478F4171944318FE9256BEDB47B&pageSize=1000&pageCurrent="+pages+"&qhdm="+v_aaa027;//410122
			
			String charset = "UTF-8";
			String content = HttpUtil.httpGet(requestUrl, charset);
			if(StringUtils.isNotEmpty(content)) {
				com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
				if (jsonObject!=null&&jsonObject.containsKey("rows")){
					jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("rows").toString());
				}
			}
			if(jsonArray!=null){
				for (Object xkzinfo:jsonArray){
					JSONObject v_xkzinfo=(JSONObject)xkzinfo;
					//存在删除
					if ( "0".equals(v_firstinit)) //首次初始化不 执行是否存在判断
					{
						String v_id=v_xkzinfo.getString("id");
						Bstyxkz v_oldBstyxkz=dao.fetch(Bstyxkz.class, v_id);
						if (v_oldBstyxkz!=null){
							dao.delete(v_oldBstyxkz);
						}
					};
					  
					  Bstyxkz v_newBstyxkz=new Bstyxkz();
					  
					  v_newBstyxkz.setId(v_xkzinfo.getString("id"));// ID bigint(20) NOT NULL AUTO_INCREMENT,
					  v_newBstyxkz.setComDm(v_xkzinfo.getString("comDm"));//COM_DM varchar(50) NOT NULL COMMENT '企业代码',
					  v_newBstyxkz.setXkzbh(v_xkzinfo.getString("xkzbh"));//XKZBH varchar(200) NOT NULL COMMENT '许可证编号',
					  v_newBstyxkz.setSqSqbh(v_xkzinfo.getString("sqSqbh"));//SQ_SQBH varchar(20) NOT NULL COMMENT '对应申请编号',
					  v_newBstyxkz.setYyzzh(v_xkzinfo.getString("yyzzh"));//YYZZH varchar(30) DEFAULT NULL COMMENT '营业执照号',
					  v_newBstyxkz.setComMc(v_xkzinfo.getString("comMc"));//COM_MC varchar(100) DEFAULT NULL COMMENT '企业名称',
					  v_newBstyxkz.setZzjgdm(v_xkzinfo.getString("zzjgdm"));//ZZJGDM varchar(50) DEFAULT NULL COMMENT '组织机构代码',
					  v_newBstyxkz.setXkzFzrq(mysqldate(v_xkzinfo.getString("xkzFzrq")));//XKZ_FZRQ date NOT NULL COMMENT '发证日期',
					  v_newBstyxkz.setXkzYxq(myIntegervalue(v_xkzinfo.getString("xkzYxq")));//XKZ_YXQ int(11) NOT NULL DEFAULT 5 COMMENT '有效期',
					  v_newBstyxkz.setXkzYxqz(mysqldate(v_xkzinfo.getString("xkzYxqz")));//XKZ_YXQZ date NOT NULL COMMENT '有效期止',
					  v_newBstyxkz.setXkzSfzx(v_xkzinfo.getString("xkzSfzx"));//XKZ_SFZX varchar(1) DEFAULT 'N' COMMENT '是否注销 Y是 N否',
					  v_newBstyxkz.setXkzZxyy(v_xkzinfo.getString("xkzZxyy"));//XKZ_ZXYY varchar(200) DEFAULT NULL COMMENT '注销原因',
					  System.out.println("xkzZxsj "+v_xkzinfo.getString("xkzZxsj"));
					  v_newBstyxkz.setXkzZxsj(myTimestamp(v_xkzinfo.getString("xkzZxsj")));//XKZ_ZXSJ datetime DEFAULT NULL COMMENT '注销时间',
					  v_newBstyxkz.setXkzXklb(v_xkzinfo.getString("xkzXklb"));//XKZ_XKLB varchar(20) DEFAULT NULL COMMENT '许可类别（对应代码表 dm_dmlb=XKZLB）',
					  v_newBstyxkz.setXkzXkzlbbz(v_xkzinfo.getString("xkzXkzlbbz"));//xkz_xkzlbbz varchar(10) DEFAULT NULL COMMENT '许可证类别标注(1,食品添加剂 2 食品 .....)',
					  v_newBstyxkz.setXkzBz(v_xkzinfo.getString("xkzBz"));//XKZ_BZ varchar(200) DEFAULT NULL COMMENT '备注',
					  v_newBstyxkz.setCpmc(v_xkzinfo.getString("cpmc"));//CPMC varchar(1000) DEFAULT NULL COMMENT '产品名称',
					  v_newBstyxkz.setCpgg(v_xkzinfo.getString("cpgg"));//CPGG varchar(200) DEFAULT NULL COMMENT '产品规格、型号',
					  v_newBstyxkz.setYlqxxnjgjzc(v_xkzinfo.getString("ylqxxnjgjzc"));//YLQXXNJGJZC varchar(1000) DEFAULT NULL COMMENT '结构及组成',
					  v_newBstyxkz.setCpsyfw(v_xkzinfo.getString("cpsyfw"));//CPSYFW varchar(1000) DEFAULT NULL COMMENT '适用范围',
					  v_newBstyxkz.setCpjsyq(v_xkzinfo.getString("cpjsyq"));//CPJSYQ varchar(1000) DEFAULT NULL COMMENT '产品技术要求',
					  v_newBstyxkz.setQyScdz(v_xkzinfo.getString("qyScdz"));//QY_SCDZ varchar(200) DEFAULT NULL COMMENT '企业生产地址',
					  v_newBstyxkz.setQyLxdh(v_xkzinfo.getString("qyLxdh"));//qy_lxdh varchar(20) DEFAULT NULL COMMENT '企业联系电话',
					  v_newBstyxkz.setQyScdzYzbm(v_xkzinfo.getString("qyScdzYzbm"));//QY_SCDZ_YZBM varchar(16) DEFAULT NULL COMMENT '企业生产地址邮政编码',
					  v_newBstyxkz.setBjpScpz(v_xkzinfo.getString("bjpScpz"));//BJP_SCPZ varchar(200) DEFAULT NULL COMMENT '保健品生产品种',
					  v_newBstyxkz.setBjpXkfw(v_xkzinfo.getString("bjpXkfw"));//BJP_XKFW varchar(200) DEFAULT NULL COMMENT '保健品许可范围',
					  v_newBstyxkz.setCctj(v_xkzinfo.getString("cctj"));//CCTJ varchar(200) DEFAULT NULL COMMENT '存储条件',
					  v_newBstyxkz.setCpyqyt(v_xkzinfo.getString("cpyqyt"));//CPYQYT varchar(200) DEFAULT NULL COMMENT '产品预期用途',
					  v_newBstyxkz.setCpyxq(v_xkzinfo.getString("cpyxq"));//CPYXQ varchar(10) DEFAULT NULL COMMENT '产品有效期',
					  v_newBstyxkz.setSqHzSzdybh(v_xkzinfo.getString("sqHzSzdybh"));//SQ_HZ_SZDYBH varchar(100) DEFAULT NULL COMMENT '经核准后的申请单元编号(申请单元编号) 多个以,分隔',
					  v_newBstyxkz.setSfjysq(v_xkzinfo.getString("sfjysq"));//SFJYSQ varchar(1) DEFAULT '0' COMMENT '是否检验申请',
					  v_newBstyxkz.setOsVer(v_xkzinfo.getLong("osVer"));//OS_VER bigint(20) DEFAULT 0 COMMENT '操作版本号',
					  v_newBstyxkz.setOsYxbz(v_xkzinfo.getString("osYxbz"));//OS_YXBZ varchar(1) DEFAULT '1' COMMENT '有效标志 1有  0无',
					  System.out.println("osSj  "+v_xkzinfo.getString("osSj"));
					  v_newBstyxkz.setOsSj(mysqldate(v_xkzinfo.getString("osSj")));//OS_SJ date DEFAULT NULL COMMENT '操作时间',
					  v_newBstyxkz.setBgVer(v_xkzinfo.getString("bgVer"));//BG_VER varchar(5) DEFAULT NULL COMMENT '检测报告版本号',
					  v_newBstyxkz.setOsVerLast(v_xkzinfo.getLong("osVerLast"));//OS_VER_LAST bigint(20) DEFAULT 0 COMMENT '上一步操作版本号',
					  v_newBstyxkz.setXkzFzjg(v_xkzinfo.getString("xkzFzjg"));//xkz_fzjg varchar(50) DEFAULT '河南省食品药品监督管理局' COMMENT '许可证发证机关',
					  v_newBstyxkz.setJyxm(v_xkzinfo.getString("jyxm"));//JYXM varchar(2000) DEFAULT NULL COMMENT '认证/经营项目或经营范围',
					  v_newBstyxkz.setJyxmyw(v_xkzinfo.getString("jyxmyw"));//jyxmyw varchar(200) DEFAULT NULL COMMENT '认证/经营范围或项目-英文',
					  v_newBstyxkz.setZtxt(v_xkzinfo.getString("ztxt"));//ZTXT char(1) NOT NULL DEFAULT '9' COMMENT '主体业态',
					  v_newBstyxkz.setFzrq(mysqldate(v_xkzinfo.getString("fzrq")));//FZRQ date DEFAULT NULL COMMENT '发证日期',
					  v_newBstyxkz.setFzjg(v_xkzinfo.getString("fzjg"));//FZJG varchar(100) DEFAULT NULL COMMENT '发证机关',
					  v_newBstyxkz.setQfr(v_xkzinfo.getString("qfr"));//qfr varchar(50) DEFAULT NULL COMMENT '签发人',
					
					  System.out.println("fbsfbs "+v_xkzinfo.getString("fbs"));
					  v_newBstyxkz.setFbs(myIntegervalue(v_xkzinfo.getString("fbs")));//FBS int(2) DEFAULT NULL COMMENT '副本数',
					  v_newBstyxkz.setYxqxz(mysqldate(v_xkzinfo.getString("yxqxz")));//YXQXZ date DEFAULT NULL COMMENT '有效期限自(食品生产签发人下面的)',
					  v_newBstyxkz.setYxqxz01(mysqldate(v_xkzinfo.getString("yxqxz01")));//YXQXZ01 date DEFAULT NULL COMMENT '有效期限至',
					  v_newBstyxkz.setSfsqjtycps(myIntegervalue(v_xkzinfo.getString("sfsqjtycps")));//SFSQJTYCPS tinyint(4) DEFAULT NULL COMMENT '是否申请集体用餐配送',
					  v_newBstyxkz.setSfsqwljy(v_xkzinfo.getString("sfsqwljy"));//SFSQWLJY char(1) DEFAULT NULL COMMENT '是否申请网络经营',
					  v_newBstyxkz.setSfsqjlzycf(myIntegervalue(v_xkzinfo.getString("sfsqjlzycf")));//SFSQJLZYCF tinyint(4) DEFAULT NULL COMMENT '是否申请建立中央厨房',
					  v_newBstyxkz.setJycs(v_xkzinfo.getString("jycs"));//JYCS varchar(100) DEFAULT NULL COMMENT '经营场所',
					  v_newBstyxkz.setZs(v_xkzinfo.getString("zs"));//ZS varchar(100) DEFAULT NULL COMMENT '住所',
					  v_newBstyxkz.setZsyw(v_xkzinfo.getString("zsyw"));//zsyw varchar(100) DEFAULT NULL COMMENT '住所英文',
					  v_newBstyxkz.setFddbr(v_xkzinfo.getString("fddbr"));//FDDBR varchar(100) DEFAULT NULL COMMENT '法定代表人',
					  v_newBstyxkz.setFddbrId(v_xkzinfo.getLong("fddbrId"));//fddbr_id bigint(20) DEFAULT NULL COMMENT '法定代表人id',
					  v_newBstyxkz.setFddbrsfzh(v_xkzinfo.getString("fddbrsfzh"));//fddbrsfzh varchar(30) DEFAULT NULL COMMENT '法定代表人身份证号',
					  v_newBstyxkz.setFddbrlxdh(v_xkzinfo.getString("fddbrlxdh"));//fddbrlxdh varchar(200) DEFAULT NULL COMMENT '法定代表人联系电话',
					  v_newBstyxkz.setFax(v_xkzinfo.getString("fax"));//fax varchar(20) DEFAULT NULL COMMENT '传真电话',
					  v_newBstyxkz.setZip(v_xkzinfo.getString("zip"));//zip varchar(10) DEFAULT NULL COMMENT '邮政编码',
					  v_newBstyxkz.setComMcyw(v_xkzinfo.getString("comMcyw"));//COM_MCYW varchar(50) DEFAULT NULL COMMENT '企业名称英文',
					  v_newBstyxkz.setQywz(v_xkzinfo.getString("qywz"));//QYWZ varchar(50) DEFAULT NULL COMMENT '企业网址',
					  v_newBstyxkz.setRcjdgljg(v_xkzinfo.getString("rcjdgljg"));//rcjdgljg varchar(50) DEFAULT NULL COMMENT '日常监督管理机构',
					  v_newBstyxkz.setRcjdglry(v_xkzinfo.getString("rcjdglry"));//rcjdglry varchar(50) DEFAULT NULL COMMENT '日常监督管理人员',
					  v_newBstyxkz.setXkzZxzt(v_xkzinfo.getString("xkzZxzt"));//xkz_zxzt varchar(1) DEFAULT NULL,
					  v_newBstyxkz.setSpjyJycs(v_xkzinfo.getString("spjyJycs"));//spjy_jycs varchar(200) DEFAULT NULL COMMENT '食品经营，经营场所地址',
					  v_newBstyxkz.setSpjyCkdz(v_xkzinfo.getString("spjyCkdz"));//spjy_ckdz varchar(200) DEFAULT NULL COMMENT '食品经营，仓库地址',
					  v_newBstyxkz.setSpjyFzrId(v_xkzinfo.getString("spjyFzrId"));//spjy_fzr_id varchar(20) DEFAULT NULL COMMENT '食品经营，负责人id',
					  v_newBstyxkz.setSpjyZtlx(v_xkzinfo.getString("spjyZtlx"));//spjy_ztlx varchar(20) DEFAULT NULL COMMENT '食品经营,主体类型',
					  v_newBstyxkz.setSpjyJylb(v_xkzinfo.getString("spjyJylb"));//spjy_jylb varchar(200) DEFAULT NULL COMMENT '食品经营，经营类别',
					  v_newBstyxkz.setSpjyJyqx(v_xkzinfo.getString("spjyJyqx"));//spjy_jyqx varchar(20) DEFAULT NULL COMMENT '食品经营，经营期限',
					  v_newBstyxkz.setSpjyJymj(v_xkzinfo.getString("spjyJymj"));//spjy_jymj varchar(20) DEFAULT NULL COMMENT '食品经营，经营面积',
					  v_newBstyxkz.setSpjyJyxm(v_xkzinfo.getString("spjyJyxm"));//spjy_jyxm varchar(200) DEFAULT NULL COMMENT '食品经营，经营项目',
					  v_newBstyxkz.setXkzTjdylcbz(v_xkzinfo.getString("xkzTjdylcbz"));//xkz_tjdylcbz varchar(2) DEFAULT '0' COMMENT '提交打印流程标志0否1是',
					  v_newBstyxkz.setYpjyJyfw(v_xkzinfo.getString("ypjyJyfw"));//YPJY_JYFW varchar(500) DEFAULT NULL COMMENT '药品经营,经营范围',
					  v_newBstyxkz.setYpjyFddbr(v_xkzinfo.getString("ypjyFddbr"));//YPJY_FDDBR varchar(20) DEFAULT NULL COMMENT '药品经营,法定代表人',
					  v_newBstyxkz.setYpjyQyfzr(v_xkzinfo.getString("ypjyQyfzr"));//YPJY_QYFZR varchar(20) DEFAULT NULL COMMENT '药品经营，企业负责人',
					  v_newBstyxkz.setYpjyZlfzr(v_xkzinfo.getString("ypjyZlfzr"));//YPJY_ZLFZR varchar(20) DEFAULT NULL COMMENT '药品经营，质量负责人',
					  v_newBstyxkz.setYpjyJyfs(v_xkzinfo.getString("ypjyJyfs"));//YPJY_JYFS varchar(20) DEFAULT NULL COMMENT '药品经营，经营方式',
					  v_newBstyxkz.setYpjyZcdz(v_xkzinfo.getString("ypjyZcdz"));//YPJY_ZCDZ varchar(100) DEFAULT NULL COMMENT '药品经营，注册地址',
					  v_newBstyxkz.setYpjyCkdz(v_xkzinfo.getString("ypjyCkdz"));//YPJY_CKDZ varchar(100) DEFAULT NULL COMMENT '药品经营，仓库地址',
					  v_newBstyxkz.setYpjyQymc(v_xkzinfo.getString("ypjyQymc"));//YPJY_QYMC varchar(50) DEFAULT NULL COMMENT '药品经营，企业名称',
					  v_newBstyxkz.setQyfzr(v_xkzinfo.getString("qyfzr"));//qyfzr varchar(50) DEFAULT NULL COMMENT '企业负责人',
					  v_newBstyxkz.setYlqxjyCkdz(v_xkzinfo.getString("ylqxjyCkdz"));//ylqxjy_ckdz varchar(100) DEFAULT NULL COMMENT '医疗器械经营仓库地址',
					  v_newBstyxkz.setZlglr(v_xkzinfo.getString("zlglr"));//zlglr varchar(50) DEFAULT NULL COMMENT '质量管理人',
					  v_newBstyxkz.setYlqxscZcdz(v_xkzinfo.getString("ylqxscZcdz"));//ylqxsc_zcdz varchar(50) DEFAULT NULL COMMENT '医疗器械生产注册地址',
					  v_newBstyxkz.setXkzQylx(v_xkzinfo.getString("xkzQylx"));//xkz_qylx varchar(20) DEFAULT NULL COMMENT '企业类型',
					  v_newBstyxkz.setJyfs(v_xkzinfo.getString("jyfs"));//JYFS varchar(20) DEFAULT NULL COMMENT '经营方式',
					  v_newBstyxkz.setJyms(v_xkzinfo.getString("jyms"));//JYMS varchar(50) DEFAULT NULL COMMENT '经营模式',
					  v_newBstyxkz.setZczb(myIntegervalue(v_xkzinfo.getString("zczb")));//ZCZB int(11) DEFAULT NULL COMMENT '注册资本（万元）',
					  v_newBstyxkz.setYljgzjxkYljgmc(v_xkzinfo.getString("yljgzjxkYljgmc"));//yljgzjxk_yljgmc varchar(100) DEFAULT NULL COMMENT '医疗机构名称',
					  v_newBstyxkz.setYljgzjxkZcdz(v_xkzinfo.getString("yljgzjxkZcdz"));//yljgzjxk_zcdz varchar(500) DEFAULT NULL COMMENT '注册地址',
					  v_newBstyxkz.setYljgzjxkLxr(v_xkzinfo.getString("yljgzjxkLxr"));//yljgzjxk_lxr varchar(20) DEFAULT NULL COMMENT '联系人',
					  v_newBstyxkz.setYljgzjxkLxrDh(v_xkzinfo.getString("yljgzjxkLxrDh"));//yljgzjxk_lxr_dh varchar(20) DEFAULT NULL COMMENT '联系人电话',
					  v_newBstyxkz.setYljgzjxkJglx(v_xkzinfo.getString("yljgzjxkJglx"));//yljgzjxk_jglx varchar(20) DEFAULT NULL COMMENT '机构类型',
					  v_newBstyxkz.setYljgzjxkFddbr(v_xkzinfo.getString("yljgzjxkFddbr"));//yljgzjxk_fddbr varchar(20) DEFAULT NULL COMMENT '法定代表人',
					  v_newBstyxkz.setYljgzjxkFgyz(v_xkzinfo.getString("yljgzjxkFgyz"));//yljgzjxk_fgyz varchar(20) DEFAULT NULL COMMENT '分管院长',
					  v_newBstyxkz.setYljgzjxkPzdz(v_xkzinfo.getString("yljgzjxkPzdz"));//yljgzjxk_pzdz varchar(500) DEFAULT NULL COMMENT '配制地址',
					  v_newBstyxkz.setYljgzjxkPzfw(v_xkzinfo.getString("yljgzjxkPzfw"));//yljgzjxk_pzfw varchar(500) DEFAULT NULL COMMENT '配置范围',
					  v_newBstyxkz.setSpjyYbzsp(v_xkzinfo.getString("spjyYbzsp"));//spjy_ybzsp char(1) DEFAULT NULL COMMENT '食品经营预包装食品详细',
					  v_newBstyxkz.setSpjySzsp(v_xkzinfo.getString("spjySzsp"));//spjy_szsp char(1) DEFAULT NULL COMMENT '食品经营散装食品详细',
					  v_newBstyxkz.setSpjyTssp(v_xkzinfo.getString("spjyTssp"));//spjy_tssp varchar(20) DEFAULT NULL COMMENT '食品经营特殊食品详细',
					  v_newBstyxkz.setSpjySzss(v_xkzinfo.getString("spjySzss"));//spjy_szss varchar(20) DEFAULT NULL COMMENT '食品经营散装熟食',
					  v_newBstyxkz.setSpjyZzyp(v_xkzinfo.getString("spjyZzyp"));//spjy_zzyp varchar(20) DEFAULT NULL COMMENT '食品经营自制饮品酿酒',
					  v_newBstyxkz.setSpjySxryp(v_xkzinfo.getString("spjySxryp"));//spjy_sxryp varchar(20) DEFAULT NULL COMMENT '食品经营生鲜乳饮品',
					  v_newBstyxkz.setSpjyBhdg(v_xkzinfo.getString("spjyBhdg"));//spjy_bhdg varchar(20) DEFAULT NULL COMMENT '食品经营裱花蛋糕',
					  v_newBstyxkz.setSpjyQtsp(v_xkzinfo.getString("spjyQtsp"));//spjy_qtsp varchar(200) DEFAULT NULL COMMENT '食品经营其他食品销售',
					  v_newBstyxkz.setSpjyQtzs(v_xkzinfo.getString("spjyQtzs"));//spjy_qtzs varchar(200) DEFAULT NULL COMMENT '食品经营其他食品制售',
					  v_newBstyxkz.setSpjyRslnr(v_xkzinfo.getString("spjyRslnr"));//spjy_rslnr varchar(200) DEFAULT NULL,
					  v_newBstyxkz.setSpjyLslnr(v_xkzinfo.getString("spjyLslnr"));//spjy_lslnr varchar(200) DEFAULT NULL,
					  v_newBstyxkz.setSpjySslnr(v_xkzinfo.getString("spjySslnr"));//spjy_sslnr varchar(200) DEFAULT NULL,
					  v_newBstyxkz.setSpjyGdlnr(v_xkzinfo.getString("spjyGdlnr"));//spjy_gdlnr varchar(200) DEFAULT NULL,
					  v_newBstyxkz.setSpjyZzypnr(v_xkzinfo.getString("spjyZzypnr"));//spjy_zzypnr varchar(200) DEFAULT NULL,
					  v_newBstyxkz.setZjlx(v_xkzinfo.getString("zjlx"));//zjlx varchar(10) DEFAULT NULL COMMENT '证件类型 01 社会信用代码 02 营业执照号 03身份证',
					  v_newBstyxkz.setSfks(v_xkzinfo.getString("sfks"));//sfks char(1) DEFAULT 'N' COMMENT '是否快速申请 Y是 N否',
					  v_newBstyxkz.setXzqh(v_xkzinfo.getString("xzqh"));//xzqh varchar(10) DEFAULT NULL COMMENT '行政区划',
					  v_newBstyxkz.setSfxx(v_xkzinfo.getString("sfxx"));//sfxx varchar(10) DEFAULT NULL COMMENT '是否学校',
					  v_newBstyxkz.setYxkzbh(v_xkzinfo.getString("yxkzbh"));//yxkzbh varchar(500) DEFAULT '' COMMENT '原许可证号',
					  v_newBstyxkz.setSqtjdqx(v_xkzinfo.getString("sqtjdqx"));//sqtjdqx varchar(10) DEFAULT NULL COMMENT '申请提交地区县区',
					  v_newBstyxkz.setSqtjdqs(v_xkzinfo.getString("sqtjdqs"));//sqtjdqs varchar(10) DEFAULT NULL COMMENT '申请提交地区市区',
					  v_newBstyxkz.setYjsj(v_xkzinfo.getString("yjsj"));//yjsj varchar(10) DEFAULT '0' COMMENT '永杰数据1 非永杰数据0',
					  v_newBstyxkz.setYljgzjxkZjsfzr(v_xkzinfo.getString("yljgzjxkZjsfzr"));//yljgzjxk_zjsfzr varchar(50) DEFAULT NULL COMMENT '医疗机构制剂制剂室负责人',
					  v_newBstyxkz.setZzywlx(v_xkzinfo.getString("zzywlx"));//zzywlx char(1) DEFAULT NULL COMMENT '最终业务类型 记录业务类型 新办 1  变更 2  延续3   补发 4 注销 5',
					  v_newBstyxkz.setDyzt(v_xkzinfo.getString("dyzt"));//DYZT char(1) DEFAULT '0' COMMENT '打印状态  0 默认（未打印） 1 已打印 2老数据',
					  v_newBstyxkz.setSpxkzbgrq(mysqldate(v_xkzinfo.getString("spxkzbgrq")));//SPXKZBGRQ date DEFAULT NULL COMMENT '食品生产许可证变更日期',
					  v_newBstyxkz.setBzZb(myIntegervalue(v_xkzinfo.getString("bzZb")));//bz_zb int(5) DEFAULT 0 COMMENT '正本打印状态：0、未打印；1、打印完成',
					  v_newBstyxkz.setBzFb(myIntegervalue(v_xkzinfo.getString("bzFb")));//bz_fb int(5) DEFAULT 0 COMMENT '副本打印状态：0、未打印；1、打印完成',
					  v_newBstyxkz.setBzMx(myIntegervalue(v_xkzinfo.getString("bzMx")));//bz_mx int(5) DEFAULT 0 COMMENT '明细打印状态：0、未打印；1、打印完成',
					  v_newBstyxkz.setQyLocation(v_xkzinfo.getString("qyLocation"));//qy_location varchar(100) DEFAULT NULL COMMENT '企业位置',
					  v_newBstyxkz.setXkzbhXh(v_xkzinfo.getString("xkzbhXh"));//xkzbh_xh varchar(10) DEFAULT NULL COMMENT '许可证编号的序号-取得序列号',
					  v_newBstyxkz.setSpjySfdj(v_xkzinfo.getString("spjySfdj"));//spjy_sfdj char(1) DEFAULT '0' COMMENT '食品经营数据是否对接 0 未对接  1 已对接 2 变更未更新  3 延续未更新  4 注销未更新',
					  v_newBstyxkz.setQrcode(v_xkzinfo.getString("qrcode"));//qrcode text DEFAULT NULL COMMENT '证书二维码串',
					  v_newBstyxkz.setTsbz(v_xkzinfo.getString("tsbz"));//tsbz varchar(300) DEFAULT '0,' COMMENT '推送标志 默认0, 河南信用食品经营已推送1, 失败2,河南信用食品生产已推送3, 失败4,药品生产已推送5, 失败6, 药品批发已推送7, 失败8, 器生产已推送9, 失败10,器械注册已推送11, 失败12,化妆品已推送13, 失败14,',
					  v_newBstyxkz.setQrcodeId(v_xkzinfo.getString("qrcodeId"));//qrcode_id varchar(50) DEFAULT NULL COMMENT '化妆品qrcode_id 二维码url的id',
					  v_newBstyxkz.setShzt(v_xkzinfo.getString("shzt"));//shzt char(2) DEFAULT '0',
					  v_newBstyxkz.setSjc(myTimestamp(v_xkzinfo.getString("sjc")));//sjc date DEFAULT NULL COMMENT '更新时间戳',
					  
					  v_listBstyxkz.add(v_newBstyxkz);
				}
				if (v_listBstyxkz.size()>0){
					dao.fastInsert(v_listBstyxkz);
					v_listBstyxkz.clear();
					System.out.println("xkz insert "+v_listBstyxkz.size());
				}else{
					v_loop=false;
					System.out.println("xkz insert over ");
				}
				
				
		}else{
			v_loop=false;
			System.out.println("xkz insert over ");
		}//loop
      }	
	};//end	
	
	private SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public java.sql.Date mysqldate(String dateStr){
		if (!StringUtils.isEmpty(dateStr)){
			try {
				return new java.sql.Date(( format.parse(dateStr ).getTime()));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}			
		}else{
			return null;
		}
	}
	
	public int myIntegervalue(String prm_str){
		if (StringUtils.isEmpty(prm_str)){
			return 0;
		}else{
			return Integer.valueOf(prm_str);
		}
	};
	
	/**
	 * RuZhouComDataRuku 汝州企业数据入库
	 * prm_orgid,机构编码，在根据日常监督管理员，产生操作员信息时用到
	 * @throws Exception
	 */	
	public void sjdateToLocalData(HttpServletRequest request,final String prm_aaa027,final String prm_orgid) throws Exception {
		Boolean v_loop=true;
		String v_sql="";
		String v_xkzbhtemp="";
		String v_xkzbhtemp3="";
		int v_count=0;
		//处理单位信息开始
		while (v_loop) {
		v_sql="select a.*,b.comdalei from bscompany a left join bs_qylx b on a.com_qylx=b.lx_id where doflag=0 limit 100 ";
		//v_sql=v_sql+" order by com_id ";
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");
		
		List<BscompanyDTO> v_comlist=(List<BscompanyDTO>)DbUtils.getDataList(v_sql, BscompanyDTO.class);
		if (v_comlist!=null && v_comlist.size()>0){
			for (BscompanyDTO v_dto:v_comlist){
				v_count=v_count+1;
				System.out.println("com v_count"+v_count+" comid "+v_dto.getComId());
				//获取该企业对应的许可证信息
				BstyxkzDTO v_oldBstyxkzDTO=new BstyxkzDTO();
				v_sql="select a.* from bstyxkz a where a.com_dm='"+v_dto.getComDm()+"' limit 1 ";
				List<BstyxkzDTO> v_listBstyxkzDTO = (List<BstyxkzDTO>) DbUtils.getDataList(v_sql, BstyxkzDTO.class);
				if (v_listBstyxkzDTO!=null && v_listBstyxkzDTO.size()>0){
					v_oldBstyxkzDTO=v_listBstyxkzDTO.get(0);
				}
				
				PcompanyDTO v_pcomdto=new PcompanyDTO();
				//判断是否存在
				v_sql="select a.* from pcompany a where a.sjdatacomid='"+v_dto.getComId()+"'";
				List<PcompanyDTO> v_listoldPcompanyDTO=DbUtils.getDataList(v_sql, PcompanyDTO.class);
				if (v_listoldPcompanyDTO!=null && v_listoldPcompanyDTO.size()>0){
					PcompanyDTO v_oldPcompanyDTO=v_listoldPcompanyDTO.get(0);
					//v_pcomdto.setComid(v_oldPcompanyDTO.getComid());
					//BeanUtils.copyProperties(dest, orig);
					BeanHelper.copyProperties(v_oldPcompanyDTO, v_pcomdto); 
				};	

				//gu20180507优先使用 许可证信息
				//gu20180508 李肇 JY 后 第一位数字 代表的是 主体业态 ，1、食品销售经营者、2餐饮服务经营者 、3单位食堂
				v_xkzbhtemp=v_oldBstyxkzDTO.getXkzbh();
				if (StringUtils.isNotEmpty(v_xkzbhtemp)&&"JY".equals(v_xkzbhtemp.substring(0,2))){
					v_xkzbhtemp3=v_xkzbhtemp.substring(3,4);
					if ("1".equals(v_xkzbhtemp3)){
						v_pcomdto.setComdalei("101302");//食品零售企业
					}else if ("2".equals(v_xkzbhtemp3)){
						v_pcomdto.setComdalei("101202");//餐馆
					}else if ("3".equals(v_xkzbhtemp3)){
						v_pcomdto.setComdalei("101201");//食堂
					}else{
						v_pcomdto.setComdalei(v_dto.getComdalei());
					}
				}else{
					v_pcomdto.setComdalei(v_dto.getComdalei());
				}

                if (StringUtils.isNotEmpty(v_oldBstyxkzDTO.getComMc())){
					v_pcomdto.setCommc(v_dto.getComMc());
				}else{
					v_pcomdto.setCommc(v_dto.getComMc());
				}
				if (StringUtils.isNotEmpty(v_oldBstyxkzDTO.getFddbr())){
					v_pcomdto.setComfrhyz(v_oldBstyxkzDTO.getFddbr());
				}else{
					v_pcomdto.setComfrhyz(v_dto.getComFddbr());
				}
				v_pcomdto.setComfzr(v_dto.getComLxr());

				v_pcomdto.setComyddh(v_dto.getComLxsj());
				v_pcomdto.setComgddh(v_dto.getComLxdh());
				v_pcomdto.setComdz(v_oldBstyxkzDTO.getJycs()==null?v_dto.getComAddress():v_oldBstyxkzDTO.getJycs());
				//gu20171216 v_pcomdto.setComdz(v_dto.getComAddress());			
				//v_pcomdto.setCombeizhu(v_dto.getBz());
				v_pcomdto.setAaa027(v_dto.getComCountyDm()+"000000");
				v_pcomdto.setComwz(v_dto.getComWeb());
				v_pcomdto.setComemail(v_dto.getComEmail());
				v_pcomdto.setComcz(v_dto.getComFax());
				v_pcomdto.setComyzbm(v_dto.getComZip());
				v_pcomdto.setComclrq(v_dto.getComClrq());
				v_pcomdto.setComzczj(v_dto.getComZczj());
				
				v_pcomdto.setComrcjdglry(v_oldBstyxkzDTO.getRcjdglry());
				String v_comrcjdglryid=getRcjdglryid(prm_aaa027,prm_orgid,v_oldBstyxkzDTO.getRcjdglry());
				v_pcomdto.setComrcjdglryid(v_comrcjdglryid);
				
				//自动拷贝了 v_pcomdto.setComdalei(v_dto.getComdalei());
				v_pcomdto.setSjordnbz("2");
				//v_pcomdto.setOrderno(String.valueOf(v_dto.getPkid()));
				v_pcomdto.setSjdatatime(v_dto.getSjc());
				v_pcomdto.setSjdatacomdm(v_dto.getComDm());
				v_pcomdto.setSjdatacomid(String.valueOf(v_dto.getComId()));
				
				//如果营业执照号 不为空 往资质证明表插入一条 信息
				if (!StringUtils.isEmpty(v_dto.getComZjhm())){
				  PcompanyXkzDTO v_xkzdto=new PcompanyXkzDTO();
				  //comxkzid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
				  //comid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
				  v_xkzdto.setComxkzbh(v_dto.getComZjhm());//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
				  //comxkfw varchar(4000) DEFAULT NULL COMMENT '许可范围',
				  //comxkyxqq date DEFAULT NULL COMMENT '许可有效期起',
				  //comxkyxqz date DEFAULT NULL COMMENT '许可有效期止',
				  v_xkzdto.setComxkzlx("1");//1营业执照 comxkzlx varchar(32) DEFAULT NULL COMMENT '许可证类型',
				  //comxkzzcxs varchar(50) DEFAULT NULL COMMENT '组成形式',
				  //comxkzztyt varchar(200) DEFAULT NULL COMMENT '主体业态',
				  //comxkzjycs varchar(200) DEFAULT NULL COMMENT '经营场所',
				  //sjdatatime date DEFAULT NULL COMMENT '省局数据同步时间',
				  //sjdataid varchar(32) DEFAULT NULL COMMENT '省局数据主键',
				  v_xkzdto.setSjdatacomdm("a");//sjdatacomdm varchar(32) DEFAULT NULL COMMENT '省局数据企业代码'
					
				  String v_xkzstr="["+Json.toJson(v_xkzdto)+"]";
				  v_pcomdto.setComzzzmlist(v_xkzstr);				  
				}
				//ServletContext application = LeafCache.getAppContext();
				//org.nutz.mvc.ActionContext v_context=org.nutz.mvc.Mvcs.getActionContext(); 
				//HttpServletRequest v_request = v_context.getRequest();
				savePcompany(request,v_pcomdto);
				//savePcompanyXkzSingle(request,v_xkzdto);
				
				Sql v_exesql=Sqls.create("update bscompany set doflag=1 where com_id='"+v_dto.getComId()+"'");
				dao.execute(v_exesql);
				System.out.println("com v_count"+v_count+" comid "+v_dto.getComId());
			}
			
			
		}else {
			v_loop=false;
			System.out.println("单位信息处理完成");
		}};//单位信息处理结束
//		private static Sql updateByPcom = Sqls.create("UPDATE pcompanyimport INNER JOIN pcompany ON pcompanyimport.outercomname=pcompany.commc SET pcompanyimport.comid=pcompany.comid");
//
//	dao.execute(updateByJK);
		
		
		//开始插入许可证信息
		v_loop=true;
		v_count=0;
		while (v_loop){
		v_sql="select a.*,b.duiyingzhi from bstyxkz a left join bs_daima b on a.xkz_xklb=b.dm_dmz where doflag=0 limit 100 ";
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");
		v_count=0;
		List<BstyxkzDTO> v_xkzlist=(List<BstyxkzDTO>)DbUtils.getDataList(v_sql, BstyxkzDTO.class);
		if (v_xkzlist!=null && v_xkzlist.size()>0){
			v_count=v_count+1;
			for (BstyxkzDTO v_xkzdto:v_xkzlist){                 								
				PcompanyXkzDTO v_newPcompanyXkzDTO=new PcompanyXkzDTO();
				//判断是否存在
				v_sql="select a.* from pcompanyxkz a where a.sjdataid='"+v_xkzdto.getId()+"' limit 100 ";
				List<BstyxkzDTO> v_listoldBstyxkzDTO=DbUtils.getDataList(v_sql, BstyxkzDTO.class);
				if (v_listoldBstyxkzDTO!=null && v_listoldBstyxkzDTO.size()>0){
					BstyxkzDTO v_oldBstyxkzDTO=v_listoldBstyxkzDTO.get(0);
					//v_pcomdto.setComid(v_oldPcompanyDTO.getComid());
					//BeanUtils.copyProperties(dest, orig);
					BeanHelper.copyProperties(v_oldBstyxkzDTO, v_newPcompanyXkzDTO); 
				};	
				
				  //comxkzid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
				  //comid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
				  v_newPcompanyXkzDTO.setComid("no");
				  v_newPcompanyXkzDTO.setComxkzbh(v_xkzdto.getXkzbh());//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
				  v_newPcompanyXkzDTO.setComxkfw(v_xkzdto.getJyxm()); //comxkfw varchar(4000) DEFAULT NULL COMMENT '许可范围',
				  v_newPcompanyXkzDTO.setComxkyxqq(v_xkzdto.getXkzFzrq());//comxkyxqq date DEFAULT NULL COMMENT '许可有效期起',
				  v_newPcompanyXkzDTO.setComxkyxqz(v_xkzdto.getXkzYxqz());//comxkyxqz date DEFAULT NULL COMMENT '许可有效期止',
				  v_newPcompanyXkzDTO.setComxkzlx(v_xkzdto.getDuiyingzhi());//comxkzlx varchar(32) DEFAULT NULL COMMENT '许可证类型',
				  //v_newPcompanyXkzDTO.setComxkzzcxs(comxkzzcxs);//comxkzzcxs varchar(50) DEFAULT NULL COMMENT '组成形式',
				  v_newPcompanyXkzDTO.setComxkzztyt(v_xkzdto.getZtxt());//comxkzztyt varchar(200) DEFAULT NULL COMMENT '主体业态',
				  v_newPcompanyXkzDTO.setComxkzjycs(v_xkzdto.getJycs());//comxkzjycs varchar(200) DEFAULT NULL COMMENT '经营场所',
				  v_newPcompanyXkzDTO.setSjdatatime(v_xkzdto.getSjc());//sjdatatime date DEFAULT NULL COMMENT '省局数据同步时间',
				  v_newPcompanyXkzDTO.setSjdataid(String.valueOf(v_xkzdto.getId()));//sjdataid varchar(32) DEFAULT NULL COMMENT '省局数据主键',
				  v_newPcompanyXkzDTO.setSjdatacomdm(v_xkzdto.getComDm());//sjdatacomdm varchar(32) DEFAULT NULL COMMENT '省局数据企业代码',				

				  savePcompanyXkzSingle(request,v_newPcompanyXkzDTO);
				
				Sql v_exesql=Sqls.create("update bstyxkz set doflag=1 where id='"+v_xkzdto.getId()+"'");
				dao.execute(v_exesql);
				v_count=v_count+1;
				System.out.println("xkz v_count"+v_count+" id "+v_xkzdto.getId());
			}
		}else{
			v_loop=false;
			System.out.println("许可证信息处理完成");
		};//许可证处理结束		
		};//xkz loop end
		
		//根据comdm更新刚插入的许可证信息的comid
		v_sql="update pcompanyxkz a set a.comid=(select max(t.comid) from pcompany t where t.sjdatacomdm=a.sjdatacomdm) "+
		" where a.comid='no' AND EXISTS (SELECT 1 FROM pcompany t2 WHERE t2.sjdatacomdm=a.sjdatacomdm )";
		Sql v_exesql2=Sqls.create(v_sql);
		dao.execute(v_exesql2);				
	};//end
	
	
	public String getRcjdglryid (final String prm_aaa027,final String prm_orgid,
			String prm_comrcjdglry) throws Exception{
		String v_comrcjdglryid="";
		String v_sql="";
		if (!StringUtils.isEmpty(prm_comrcjdglry)){
			String[] rynamearray=prm_comrcjdglry.split(",");
			String ryname="";
			for (int i=0;i<rynamearray.length;i++){
				ryname=rynamearray[i];
				v_sql="select a.* from sysuser a where a.description='"+ryname+"' limit 1";
				List<Sysuser> v_sysuserList=(List<Sysuser>)DbUtils.getDataList(v_sql, Sysuser.class);
				if (v_sysuserList!=null && v_sysuserList.size()>0){
					Sysuser v_sysuser=v_sysuserList.get(0);
					if ("".equals(v_comrcjdglryid)){
						v_comrcjdglryid=v_sysuser.getUserid();
					}else{
						v_comrcjdglryid=v_comrcjdglryid+","+v_sysuser.getUserid();
					}
				}else{//不存在，增加一个操作员
					Sysuser v_newSysuser = new Sysuser();
					String v_userjc=PinYinUtil.GetChineseSpell(ryname);
					
					String v_userid=DbUtils.getSequenceStr();
					String v_username=v_userjc.toLowerCase();
					//判断username是否存在，存在的话
					v_sql="select * from sysuser where username='"+v_username+"'";
					List<Sysuser> v_listsysuser=DbUtils.getDataList(v_sql, Sysuser.class);
					if (v_listsysuser!=null && v_listsysuser.size()>0){
						Random ra = new Random();
						String v_random = String.valueOf(ra.nextInt(100));
						v_username=v_username+v_random;
					};
					
					v_newSysuser.setUserid(v_userid);
					v_newSysuser.setUsername(v_username);
					v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
					v_newSysuser.setUserkind("5");//默认执法人员
					v_newSysuser.setDescription(ryname);
					v_newSysuser.setAaa027(prm_aaa027);
					v_newSysuser.setOrgid(prm_orgid);
					v_newSysuser.setMobile("");//gu20161020add
					v_newSysuser.setAaz001("");//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
					v_newSysuser.setSelfcomflag("0");
					v_newSysuser.setUserjc(v_userjc);
					dao.insert(v_newSysuser);
					
					if ("".equals(v_comrcjdglryid)){
						v_comrcjdglryid=v_userid;
					}else{
						v_comrcjdglryid=v_comrcjdglryid+","+v_userid;
					}					
				}
			}
		};
		return v_comrcjdglryid;
	};


	/**
	 * LingBaoComDataRuku 灵宝企业数据入库
	 *
	 * @throws Exception
	 */
	public void LingBaoComDataRuku(HttpServletRequest request) throws Exception {
		String prm_aaa027="";
		String prm_pkid="";
		String prm_orgid="";
		String v_sql="select a.* from tablbcom a where doflag=0 ";
		if (!StringUtils.isEmpty(prm_aaa027)){
			v_sql=v_sql+" and a.aaa027='"+prm_aaa027+"'";
		};
		if (!StringUtils.isEmpty(prm_pkid)){
			v_sql=v_sql+" and a.pkid='"+prm_pkid+"'";
		};
		if (!StringUtils.isEmpty(prm_orgid)){
			v_sql=v_sql+" and a.prm_orgid='"+prm_pkid+"'";
		};
		v_sql=v_sql+" order by pkid ";

		int v_count=0;
		List<TablbcomDTO> v_list=(List<TablbcomDTO>)DbUtils.getDataList(v_sql, TablbcomDTO.class);
		if (v_list!=null && v_list.size()>0){
			v_count=v_count+1;
			for (TablbcomDTO v_dto:v_list){
				PcompanyDTO v_pcomdto=new PcompanyDTO();
				v_pcomdto.setCombeizhu(v_dto.getBz());
				//接收许可名称如果为空录入商店名称不为空许可名称
				String xkmc=v_dto.getXkmc();
				if (null!=xkmc && !"".equals(xkmc)){
					v_pcomdto.setCommc(xkmc);
				}else {
					v_pcomdto.setCommc(v_dto.getSdmc());
				}
				v_pcomdto.setComfzr(v_dto.getFzr());
				v_pcomdto.setOrgid(v_dto.getOrgid());
				v_pcomdto.setAaa027(v_dto.getAaa027());
				v_pcomdto.setComcfw(v_dto.getCfw());
				v_pcomdto.setComdz(v_dto.getJydz());
				v_pcomdto.setComyddh(v_dto.getLxfs());
				v_pcomdto.setSjordnbz("2");
				v_pcomdto.setCommdbh(v_dto.getMdbh());
				v_pcomdto.setOrderno(String.valueOf(v_dto.getPkid()));

				StringBuffer daleis = new StringBuffer();
				String dalei=v_dto.getJylb();
				if (dalei != null && !"".equals(dalei)){
					char[] paramType = dalei.toCharArray();
					for (char b:paramType){
						daleis.append(b).append(",");
					}
					daleis.deleteCharAt(daleis.length() - 1);

				}
				v_pcomdto.setComdalei("".equals(daleis) ? null : daleis.toString());

				v_pcomdto.setComzmj(v_dto.getZmj());

				//校园周边
				String xyzb=v_dto.getXyzb();
				if (null!=xyzb && !"".equals(xyzb)){
					v_pcomdto.setComxyzb("0");
				}else{
					v_pcomdto.setComxyzb("1");
				}
				//酒类有无
				String jlyw=v_dto.getYwjl();
				if (null!=jlyw && !"".equals(jlyw)){
					v_pcomdto.setComjlyw("0");
				}else {
					v_pcomdto.setComjlyw("1");
				}
				//酒类专兼
				String jlzj=v_dto.getZjjl();
				if (null!=jlzj && !"".equals(jlzj)){
					v_pcomdto.setComjlzj("0");
				}else {
					v_pcomdto.setComjlzj("1");
				}
				v_pcomdto.setComfxdj(v_dto.getFxdj());
				PcompanyXkzDTO v_xkzdto=new PcompanyXkzDTO();
				String cfw=v_dto.getCfw();
				String xkzh=v_dto.getXkzh();

				String yyzh=v_dto.getYyzh();

				String leibie=v_dto.getXkfw();
				StringBuffer xkfws = new StringBuffer();
				if (leibie != null && !"".equals(leibie)){
					char[] paramType = leibie.toCharArray();

//					String xkfws="";
					for (char b:paramType){
						List<Aa10> aa10List = (List<Aa10>) dao.query(Aa10.class, Cnd.where("AAA100", "=", "XKFW")
								.and("AAA102", "=", b));
						if (aa10List != null && aa10List.size() > 0) {
							xkfws.append(aa10List.get(0).getAaa103()).append(",");
						}
						xkfws.deleteCharAt(xkfws.length() - 1);
					}

				}

				if (null!=xkzh && !"".equals(xkzh)){
					v_xkzdto.setComxkzbh(xkzh);
					v_xkzdto.setComxkzlx("4");
					v_xkzdto.setComxkyxqz(v_dto.getYxqz());
					v_xkzdto.setComxkfw(xkfws.toString());
				}

				PcompanyXkzDTO v_xkzdtos=new PcompanyXkzDTO();
				if (null!=yyzh && !"".equals(yyzh)){
					v_xkzdtos.setComxkzbh(yyzh);
					v_xkzdtos.setComxkzlx("1");
					v_xkzdtos.setComxkyxqz(v_dto.getYxqz());
					v_xkzdtos.setComxkfw(xkfws.toString());
				}
				String v_comxkzlx="4";//食品经营许可证

				String v_xkzstr="["+Json.toJson(v_xkzdto)+","+Json.toJson(v_xkzdtos)+"]";
				v_pcomdto.setComzzzmlist(v_xkzstr);

				savePcompany(request,v_pcomdto);

				Sql v_exesql=Sqls.create("update tablbcom set doflag=1 where pkid='"+v_dto.getPkid()+"'");
				dao.execute(v_exesql);
				System.out.println("v_count"+v_count+" pkid"+v_dto.getPkid());
			}
		}
	}

	/**
	 * 添加企业信息 完成的是注册功能
	 * @throws Exception
	 */
	public void saveComJingWeiDu(HttpServletRequest request, final PcompanyDTO dto) throws Exception {
		if (StringUtils.isEmpty(dto.getComid())){
			throw new BusinessException("comid不能为空");
		};
		Pcompany v_oldPcompany=dao.fetch(Pcompany.class,dto.getComid());

		//写日志
		Map<String, String> map2 = GaodeUtil.getMapAddress(dto.getComjdzb(), dto.getComwdzb());
		String v_newAddress=map2.get("address");

		String v_description="企业经纬度变更：企业名称："+v_oldPcompany.getCommc()+"，原经度为【"+v_oldPcompany.getComjdzb()+","+
				v_oldPcompany.getComwdzb()+"】变更后经纬度为【"+dto.getComjdzb()+","+dto.getComwdzb()+"】。地址目前未自动变更，原地址【"+
				v_oldPcompany.getComdz()+"】变更后地址【"+v_newAddress+"】";
		Sysoperatelog v_newSysoperatelog=new Sysoperatelog();
		v_newSysoperatelog.setUserid(dto.getUserid());
		v_newSysoperatelog.setModule("企业经纬度变更");
		v_newSysoperatelog.setDescription(v_description);
		SysmanageUtil.g_writeSysoperatelog(request,v_newSysoperatelog);

		v_oldPcompany.setComjdzb(dto.getComjdzb());
		v_oldPcompany.setComwdzb(dto.getComwdzb());
		dao.update(v_oldPcompany);

//         String v_sql="update pcompany set comjdzb='"+dto.getComjdzb()+"',comwdzb='"+dto.getComwdzb()+"' where comid='"+dto.getComid()+"'";
//		 Sql myexesql=Sqls.create(v_sql);
//		 dao.execute(myexesql);
	}

	/**
	 *
	 * addXkz的中文名称：添加许可证信息
	 *
	 * addXkz的概要说明：
	 *
	 * @return Written by : sunyifeng
	 *
	 */
	public Map getXkzinfoFromQrcodeFromShengju(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto ) throws Exception {
		String v_sql="";
		Sysuser v_Sysuser = null;
		if (dto.getSjordnbz() != null && "2".equals(dto.getSjordnbz())) {
			v_Sysuser = SysmanageUtil.g_getGlobalSysUser(dto.getUserid());
			//request.setAttribute("CURRENT_USER",v_Sysuser);
			org.nutz.mvc.Mvcs.getHttpSession().setAttribute("CURRENT_USER",v_Sysuser);
//			org.nutz.mvc.Mvcs.getHttpSession().getAttribute("CURRENT_USER");
		} else {
			v_Sysuser = (Sysuser) SysmanageUtil.getSysuser();
		}
		;

		//http://as.hda.gov.cn/layerJyXkzxx.jsp?xkzbh=JY34104810019807
		//String str1="许可证编号:JY14105230016578;经营者名称:汤阴新合作联购超市;经营场所:汤阴县人民路与中华路交叉口西北角（上亿...法定代表人(负责人):叶长锋;主体业态:食品销售经营者;有效期至:2021-08-15;更多信息请访问http://hda.gov.cn/CL0577";
		//String str2="生产者名称:获嘉县和佳调味品酿造厂,社会信用代码（身份证号码）914107241732747048,法定代表人（负责人）娄季隆,生产地址获嘉县获武路,食品类别调味品,许可证编号SC10341072400030,有效期2021-02-25 00:00:00;更多信息请访问http://hda.gov.cn/CL0577";
		Map v_retmap = new HashMap();
		if (StringUtils.isEmpty(dto.getQrcodecontent())) {
			return v_retmap;
		}
		String v_url = "";
		String v_qrcodecontent = dto.getQrcodecontent();
		String v_xkzbh = huoquXkzbh(v_qrcodecontent);
		if (StringUtils.isEmpty(v_xkzbh)) {
			return v_retmap;
		}
		PcompanyXkzDTO v_tempxkzdto = new PcompanyXkzDTO();
		PagesDTO v_tempPagesDto = new PagesDTO();
		v_tempPagesDto.setPage(0);
		v_tempPagesDto.setRows(100);
		v_tempxkzdto.setComxkzbh(v_xkzbh);
		Map v_xkzmap = queryPcompanyXkz(v_tempxkzdto, v_tempPagesDto);
		if (Integer.parseInt(v_xkzmap.get("total").toString()) >0 ) {

			List list = (List) v_xkzmap.get("rows");
			PcompanyXkzDTO v_getPcompanyXkzDTO = null;
			if(list!=null && list.size()>0){
				v_getPcompanyXkzDTO = (PcompanyXkzDTO)list.get(0);
			}
			v_retmap.put("localxkzdto", v_getPcompanyXkzDTO);

			PcompanyDTO v_tempPcompanydto = new PcompanyDTO();
			v_tempPcompanydto.setComxkzbh(v_xkzbh);
			Map v_commap = queryCompany(request, v_tempPcompanydto, v_tempPagesDto);
			if (Integer.parseInt(v_commap.get("total").toString()) >0) {
				List v_list2=(List)v_commap.get("rows");
				PcompanyDTO v_getPcompanyDTO=null;
				if(v_list2!=null && v_list2.size()>0){
					v_getPcompanyDTO = (PcompanyDTO)v_list2.get(0);
				}

				v_retmap.put("localcomdto", v_getPcompanyDTO);
			}
			v_retmap.put("xkzhaveexist","1");//许可证是否已经存在
		}else{
			v_retmap.put("xkzhaveexist","0");
		}
		//下面从省局获取
			v_url = "http://as.hda.gov.cn/com_onSearchXkz.action?gUser=askj&gPwd=5FC17478F4171944318FE9256BEDB47B&pageSize=10&pageCurrent=1&xkzbh=" + v_xkzbh;
			com.alibaba.fastjson.JSONArray jsonArray = null;
			String charset = "UTF-8";
			String content = HttpUtil.httpGet(v_url, charset);
			if (StringUtils.isNotEmpty(content)) {
				com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
				if (jsonObject != null && jsonObject.containsKey("rows")) {
					jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("rows")
																					.toString());
				}
			}
			PcompanyXkzDTO v_newPcompanyXkzDTO = new PcompanyXkzDTO();
			PcompanyDTO v_newPcompanyDTO = new PcompanyDTO();
			if (jsonArray != null) {
				for (Object xkzinfo : jsonArray) {
					JSONObject v_xkzinfo = (JSONObject) xkzinfo;
					Bstyxkz v_newBstyxkz = new Bstyxkz();

					v_newPcompanyXkzDTO.setComid("no");
					v_newPcompanyXkzDTO.setComxkzbh(
							v_xkzinfo.getString("xkzbh"));//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
					v_newPcompanyXkzDTO.setCommc(
							v_xkzinfo.getString("comMc"));//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
					v_newPcompanyXkzDTO.setFddbr(
							v_xkzinfo.getString("fddbr"));//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
					v_newPcompanyXkzDTO.setJycs(
							v_xkzinfo.getString("jycs"));//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
					v_newPcompanyXkzDTO.setRcjdglry(
							v_xkzinfo.getString("rcjdglry"));//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',

					v_newPcompanyXkzDTO.setComxkfw(
							v_xkzinfo.getString("jyxm")); //comxkfw varchar(4000) DEFAULT NULL COMMENT '许可范围',
					v_newPcompanyXkzDTO.setComxkyxqq(
							mysqldate(v_xkzinfo.getString("xkzFzrq")));//comxkyxqq date DEFAULT NULL COMMENT '许可有效期起',
					v_newPcompanyXkzDTO.setComxkyxqz(
							mysqldate(v_xkzinfo.getString("xkzYxqz")));//comxkyxqz date DEFAULT NULL COMMENT '许可有效期止',
					String v_xkzxklb = v_xkzinfo.getString("xkzXklb");
					v_sql = "select a.* from bs_daima a where dm_dmz='" + v_xkzxklb + "'";
					List<BstyxkzDTO> v_bsdaima = (List<BstyxkzDTO>) DbUtils.getDataList(v_sql, BstyxkzDTO.class);
					BstyxkzDTO v_BstyxkzDTO = new BstyxkzDTO();
					if (v_bsdaima != null && v_bsdaima.size() > 0) {
						v_BstyxkzDTO = v_bsdaima.get(0);
					}
					v_newPcompanyXkzDTO.setComxkzlx(
							v_BstyxkzDTO.getDuiyingzhi());//comxkzlx varchar(32) DEFAULT NULL COMMENT '许可证类型',
					if (StringUtils.isNotEmpty(v_newPcompanyXkzDTO.getComxkzlx())){
						v_sql="select getAa10_aaa103('COMZZZM', '"+v_newPcompanyXkzDTO.getComxkzlx()+"') as comxkzlxstr ";
						String v_comxkzlxstr=DbUtils.getOneValue(dao,v_sql);
						v_newPcompanyXkzDTO.setComxkzlxstr(v_comxkzlxstr);
					}
					//v_newPcompanyXkzDTO.setComxkzzcxs(comxkzzcxs);//comxkzzcxs varchar(50) DEFAULT NULL COMMENT '组成形式',
					v_newPcompanyXkzDTO.setComxkzztyt(
							v_xkzinfo.getString("ztxt"));//comxkzztyt varchar(200) DEFAULT NULL COMMENT '主体业态',
					if (StringUtils.isNotEmpty(v_newPcompanyXkzDTO.getComxkzztyt())){
						v_sql="select getAa10_aaa103('ZZZMZTYT', '"+v_newPcompanyXkzDTO.getComxkzztyt()+"') as comxkzztytstr ";
						String v_comxkzztytstr=DbUtils.getOneValue(dao,v_sql);
						v_newPcompanyXkzDTO.setComxkzztytstr(v_comxkzztytstr);
					}
					v_newPcompanyXkzDTO.setComxkzjycs(
							v_xkzinfo.getString("jycs"));//comxkzjycs varchar(200) DEFAULT NULL COMMENT '经营场所',
					v_newPcompanyXkzDTO.setSjdatatime(
							myTimestamp(v_xkzinfo.getString("sjc")));//sjdatatime date DEFAULT NULL COMMENT '省局数据同步时间',
					v_newPcompanyXkzDTO.setSjdataid(
							v_xkzinfo.getString("id"));//sjdataid varchar(32) DEFAULT NULL COMMENT '省局数据主键',
					v_newPcompanyXkzDTO.setSjdatacomdm(
							v_xkzinfo.getString("comDm"));//sjdatacomdm varchar(32) DEFAULT NULL COMMENT '省局数据企业代码',

				}

			}
			v_retmap.put("shengjuxkzdto", v_newPcompanyXkzDTO);

			//com.alibaba.fastjson.JSONArray jsonArray = null;
			String requestUrl = "http://as.hda.gov.cn/com_onSearchCompany.action?gUser=askj&gPwd=5FC17478F4171944318FE9256BEDB47B&pageSize=10&pageCurrent=1&xkzbh=" + v_xkzbh;

			charset = "UTF-8";
			content = HttpUtil.httpGet(requestUrl, charset);
			if (StringUtils.isNotEmpty(content)) {
				com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
				if (jsonObject != null && jsonObject.containsKey("rows")) {
					jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("rows")
																					.toString());
				}
			}
			if (jsonArray != null) {
				for (Object cominfo : jsonArray) {
					JSONObject v_cominfo = (JSONObject) cominfo;

					//获取该企业对应的许可证信息
					//gu20180507优先使用 许可证信息
					//gu20180508 李肇 JY 后 第一位数字 代表的是 主体业态 ，1、食品销售经营者、2餐饮服务经营者 、3单位食堂
					String v_xkzbhtemp = v_newPcompanyXkzDTO.getComxkzbh();
					if (StringUtils.isNotEmpty(v_xkzbhtemp) && "JY".equals(v_xkzbhtemp.substring(0, 2))) {
						String v_xkzbhtemp3 = v_xkzbhtemp.substring(3, 4);
						if ("1".equals(v_xkzbhtemp3)) {
							v_newPcompanyDTO.setComdalei("101302");//食品零售企业
						} else if ("2".equals(v_xkzbhtemp3)) {
							v_newPcompanyDTO.setComdalei("101202");//餐馆
						} else if ("3".equals(v_xkzbhtemp3)) {
							v_newPcompanyDTO.setComdalei("101201");//食堂
						} else {
							v_newPcompanyDTO.setComdalei("101302");
						}
					} else {
						v_newPcompanyDTO.setComdalei("101302");
					}
					v_sql="select max(t.aaa103) as aaa103 from viewcomfenlei t where t.aaa102='"+v_newPcompanyDTO.getComdalei()+"'";
					String v_comdaleistr=DbUtils.getOneValue(dao,v_sql);
					v_newPcompanyDTO.setComdaleistr(v_comdaleistr);


					if (StringUtils.isNotEmpty(v_newPcompanyXkzDTO.getCommc())) {
						v_newPcompanyDTO.setCommc(v_newPcompanyXkzDTO.getCommc());
					} else {
						v_newPcompanyDTO.setCommc(v_newPcompanyXkzDTO.getCommc());
					}
					if (StringUtils.isNotEmpty(v_newPcompanyXkzDTO.getFddbr())) {
						v_newPcompanyDTO.setComfrhyz(v_newPcompanyXkzDTO.getFddbr());
					} else {
						v_newPcompanyDTO.setComfrhyz(v_cominfo.getString("comFddbr"));
					}
					v_newPcompanyDTO.setComfzr(v_cominfo.getString("comLxr"));

					v_newPcompanyDTO.setComyddh(v_cominfo.getString("comLxsj"));
					v_newPcompanyDTO.setComgddh(v_cominfo.getString("comLxdh"));
					v_newPcompanyDTO.setComdz(v_newPcompanyXkzDTO.getJycs() == null ? v_cominfo.getString(
							"comAddress") : v_newPcompanyXkzDTO.getJycs());
					//gu20171216 v_pcomdto.setComdz(v_dto.getComAddress());
					//v_pcomdto.setCombeizhu(v_dto.getBz());
					v_newPcompanyDTO.setAaa027(v_cominfo.getString("comCountyDm") + "000000");

					v_sql="select max(t.aaa129) as aaa129 from aa13nodelete t where t.aaa027='"+v_newPcompanyDTO.getAaa027()+"'";
					String v_aaa027name=DbUtils.getOneValue(dao,v_sql);
					v_newPcompanyDTO.setAaa027name(v_aaa027name);

					v_newPcompanyDTO.setComwz(v_cominfo.getString("comWeb"));
					v_newPcompanyDTO.setComemail(v_cominfo.getString("comEmail"));
					v_newPcompanyDTO.setComcz(v_cominfo.getString("comFax"));
					v_newPcompanyDTO.setComyzbm(v_cominfo.getString("comZip"));
					v_newPcompanyDTO.setComclrq(myTimestamp(v_cominfo.getString("comClrq")));
					v_newPcompanyDTO.setComzczj(v_cominfo.getLong("comZczj"));

					v_newPcompanyDTO.setComrcjdglry(v_newPcompanyXkzDTO.getRcjdglry());
					String v_comrcjdglryid = getRcjdglryid(v_Sysuser.getAaa027(), v_Sysuser.getOrgid(),
														   v_newPcompanyXkzDTO.getRcjdglry());
					v_newPcompanyDTO.setComrcjdglryid(v_comrcjdglryid);

					//自动拷贝了 v_pcomdto.setComdalei(v_dto.getComdalei());
					v_newPcompanyDTO.setSjordnbz("2");
					//v_pcomdto.setOrderno(String.valueOf(v_dto.getPkid()));
					v_newPcompanyDTO.setSjdatatime(myTimestamp(v_cominfo.getString("sjc")));
					v_newPcompanyDTO.setSjdatacomdm(v_cominfo.getString("comDm"));
					v_newPcompanyDTO.setSjdatacomid(v_cominfo.getString("comId"));

					//如果营业执照号 不为空 往资质证明表插入一条 信息
					if (!StringUtils.isEmpty(v_cominfo.getString("comZjhm"))) {
						PcompanyXkzDTO v_xkzdto = new PcompanyXkzDTO();
						//comxkzid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
						//comid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
						v_xkzdto.setComxkzbh(
								v_cominfo.getString("comZjhm"));//comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
						//comxkfw varchar(4000) DEFAULT NULL COMMENT '许可范围',
						//comxkyxqq date DEFAULT NULL COMMENT '许可有效期起',
						//comxkyxqz date DEFAULT NULL COMMENT '许可有效期止',
						v_xkzdto.setComxkzlx("1");//1营业执照 comxkzlx varchar(32) DEFAULT NULL COMMENT '许可证类型',
						//comxkzzcxs varchar(50) DEFAULT NULL COMMENT '组成形式',
						//comxkzztyt varchar(200) DEFAULT NULL COMMENT '主体业态',
						//comxkzjycs varchar(200) DEFAULT NULL COMMENT '经营场所',
						//sjdatatime date DEFAULT NULL COMMENT '省局数据同步时间',
						//sjdataid varchar(32) DEFAULT NULL COMMENT '省局数据主键',
						v_xkzdto.setSjdatacomdm("a");//sjdatacomdm varchar(32) DEFAULT NULL COMMENT '省局数据企业代码'

						String v_xkzstr = "[" + Json.toJson(v_xkzdto) + "]";
						v_newPcompanyDTO.setComzzzmlist(v_xkzstr);
					}


				}
			}
			v_retmap.put("shengjucomdto", v_newPcompanyDTO);
		return v_retmap;
	};

	public static String huoquXkzbh(String prm_str){
		int v_newPos=prm_str.indexOf("xkzbh=");
		int v_xkzPos1=prm_str.indexOf("许可证编号:");
		if (v_newPos<0){
			if (v_xkzPos1<0){
				v_xkzPos1=prm_str.indexOf("许可证编号")+5;
			}else{
				v_xkzPos1=v_xkzPos1+6;
			}
		}else{
			v_xkzPos1=v_newPos+6;
		}


		String v_tempStr=prm_str.substring(v_xkzPos1);
		int v_douhaoPos=v_tempStr.indexOf(",");
		v_douhaoPos=v_douhaoPos<0?999:v_douhaoPos;
		int v_fenhaoPos=v_tempStr.indexOf(";");
		v_fenhaoPos=v_fenhaoPos<0?999:v_fenhaoPos;
		v_fenhaoPos=v_fenhaoPos<v_douhaoPos?v_fenhaoPos:v_douhaoPos;
		if (v_newPos<0) {
			v_tempStr = v_tempStr.substring(0, v_fenhaoPos);
		}
		return v_tempStr;
	};

}