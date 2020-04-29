package com.askj.baseinfo.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.dto.PcomryDTO;
import com.askj.baseinfo.dto.PcomryzpDTO;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.baseinfo.entity.Pcomry;
import com.askj.baseinfo.service.pub.PubService;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuserrole;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 企业人员基本信息  业务逻辑层
 * @author CatchU
 *
 */
@IocBean
public class PcomryService extends BaseService {

	protected final Logger logger = Logger.getLogger(PcomryService.class);

	@Inject
	private Dao dao;
	@Inject
	private PubService pubService;


	/**
	 * 添加人员信息
	 * 完成的是注册功能
	 */
	public String savePcomry(HttpServletRequest request,final PcomryDTO dto){
		try{
			savePcomryImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 保存人员信息的实现方法
	 * 使用事务控制
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	@Aop({"trans"})
	public void savePcomryImpl(HttpServletRequest request, PcomryDTO dto) throws Exception {
		//获取归属的企业信息
		Pcompany v_pcompany=dao.fetch(Pcompany.class, Cnd.where("comid", "=", dto.getComid()));
		//首先判断用户是更新还是添加操作
		if(null != dto.getRyid()&&!"".equals(dto.getRyid())){//更新，通过id找到本条数据而后跟新
			Pcomry pcomry = dao.fetch(Pcomry.class,dto.getRyid());
			//如果是检验检测机构，更新操作员的姓名和手机号
			//gu20180601先注销 用户仿照 执法人员添加方式 从用户管理处增加
/*			if (v_pcompany.getComdalei().indexOf("106001")!=-1){//106001 检验检测机构
				Sysuser v_oldsysuser=dao.fetch(Sysuser.class, Cnd.where("aaz001", "=", dto.getRyid()));
				v_oldsysuser.setDescription(dto.getRyxm());
				v_oldsysuser.setMobile(dto.getRylxdh());
				dao.update(v_oldsysuser);
			}		*/
			BeanHelper.copyProperties(dto, pcomry);  //拷贝对应的从前台传来的数据
			dao.update(pcomry);
		}else{//添加
			String ryid="";
			if(null ==dto.getWuzhutipicid()){
				ryid = DbUtils.getSequenceStr();
			}else {
				ryid=dto.getWuzhutipicid();
			}

			Pcomry pcomry = new Pcomry();
			BeanHelper.copyProperties(dto, pcomry);  //拷贝对应的从前台传来的数据
			pcomry.setRyid(ryid);
			dao.insert(pcomry);
			if (dto.getSjordn() == null || "".endsWith(dto.getSjordn())) {
				//保存图片
				FjDTO v_fjdto=new FjDTO();
				v_fjdto.setFjwid(ryid);
				v_fjdto.setFolderName("comry");
				//保存健康证 图片
				v_fjdto.setFjpath(dto.getRyjkzpath());
				v_fjdto.setFjname(dto.getRyjkzname());
				v_fjdto.setFjtype("5");
				pubService.saveFjWuzhuti(request,v_fjdto);
				//保存培训证 图片
				v_fjdto.setFjpath(dto.getRypxzpath());
				v_fjdto.setFjname(dto.getRypxzname());
				v_fjdto.setFjtype("6");
				pubService.saveFjWuzhuti(request,v_fjdto);
				//保存人员图片
				v_fjdto.setFjpath(dto.getRyzppath());
				v_fjdto.setFjname(dto.getRyzpname());
				v_fjdto.setFjtype("7");
				pubService.saveFjWuzhuti(request,v_fjdto);
				// gu20170507 如果是检验检测企业  往操作员表插入记录
				//gu20180601先注销 用户仿照 执法人员添加方式 从用户管理处增加
/*			if (v_pcompany.getComdalei().indexOf("106001")!=-1){//106001 检验检测机构
				Sysuser v_newSysuser = new Sysuser();
				String v_username=SysmanageUtil.getComUsername(v_pcompany.getComdm());
				v_newSysuser.setUserid(ryid);
				v_newSysuser.setUsername(v_username);
				v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
				v_newSysuser.setUserkind("7");//7 快检人员
				v_newSysuser.setDescription(dto.getRyxm());
				v_newSysuser.setAaa027(v_pcompany.getAaa027());
				v_newSysuser.setOrgid("2017050714470572088189206");
				v_newSysuser.setMobile(dto.getRylxdh());//gu20161020add
				v_newSysuser.setAaz001(ryid);//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
				v_newSysuser.setUsercomid(dto.getComid());

				Sysuserrole v_Sysuserrole=new Sysuserrole();
				String v_USERROLEID = DbUtils.getSequenceStr();
				v_Sysuserrole.setUserroleid(v_USERROLEID);
				v_Sysuserrole.setUserid(ryid);
				v_Sysuserrole.setRoleid("2017050714492830438122991");
				dao.insert(v_newSysuser);
				dao.insert(v_Sysuserrole);
			}*/
			}
		}
	}

	/**
	 * 保存人员信息的实现方法
	 * 使用事务控制
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	@Aop({"trans"})
	public void savePcomryImplold(HttpServletRequest request, PcomryDTO dto) throws Exception {
		// 将图片保存至数据库
//		String rootPath = request.getSession().getServletContext()
//				.getRealPath("/");
//		InputStream fis =null;
//		if (dto.getRyzpwjm()!=null && !"".equals(dto.getRyzpwjm())){
//			File file = new File(rootPath + File.separator + "/upload/pcomryzp/"+ dto.getRyzpwjm());
//			if (file.exists()){
//				// 将图片读进输入流
//				fis = new FileInputStream(file);			
//			}			
//		}

		//首先判断用户是更新还是添加操作
		if(null != dto.getRyid()&&!"".equals(dto.getRyid())){//更新，通过id找到本条数据而后跟新
			Pcomry pcomry = dao.fetch(Pcomry.class,dto.getRyid());
			//BeanHelper.copyProperties(dto, pcomry);
			pcomry.setRyid(dto.getRyid());  //修正id
			pcomry.setRyzjlx(dto.getRyzjlx());
			pcomry.setRyzjh(dto.getRyzjh());
			pcomry.setRyxm(dto.getRyxm());
			pcomry.setRyxb(dto.getRyxb());
			pcomry.setRycsrq(dto.getRycsrq());
			pcomry.setRynl(dto.getRynl());
			pcomry.setRyxueli(dto.getRyxueli());
			pcomry.setRybeginwork(dto.getRybeginwork());
			pcomry.setRylxdh(dto.getRylxdh());
			pcomry.setRyzhuanye(dto.getRyzhuanye());
			pcomry.setRyjszc(dto.getRyjszc());
			pcomry.setRycyfw(dto.getRycyfw());
			pcomry.setRycyzglb(dto.getRycyzglb());
			pcomry.setRyzgzsbh(dto.getRyzgzsbh());
			//pcomry.setRyzgzsfzrq(dto.getRyzgzsfzrq());
			pcomry.setRysfzyys(dto.getRysfzyys());
			pcomry.setRyzyyszcbh(dto.getRyzyyszcbh());
			//pcomry.setRyzyyszcrq(dto.getRyzyyszcrq());
			//pcomry.setRyzyyszsyxqz(dto.getRyzyyszsyxqz());
			pcomry.setRybyyx(dto.getRybyyx());
			pcomry.setRyzwgw(dto.getRyzwgw());
			pcomry.setRymz(dto.getRymz());
			pcomry.setComid(dto.getComid());
			//pcomry.setRyzhaopian(fis);   //保存人员照片
			//pcomry.setRyzpwjm(dto.getRyzpwjm());
//			if(pcomry.getRyzgzsfzrq() != null && pcomry.getRyzgzsfzrq().equals("")){
//				pcomry.setRyzgzsfzrq(null);
//			}
//			if(pcomry.getRyzyyszcrq() != null && pcomry.getRyzyyszcrq().equals("")){
//				pcomry.setRyzyyszcrq(null);
//			}
//			if(pcomry.getRyzyyszsyxqz() != null && pcomry.getRyzyyszsyxqz().equals("")){
//				pcomry.setRyzyyszsyxqz(null);
//			}
//			if(pcomry.getRybeginwork() != null && pcomry.getRybeginwork().equals("")){
//				pcomry.setRybeginwork(null);
//			}
			dao.update(pcomry);

//			Pcomryzp v_Pcomryzp=dao.fetch(Pcomryzp.class, Cnd.where("ryid", "=", dto.getRyid()));
//			v_Pcomryzp.setRyzp(fis);
//			v_Pcomryzp.setRyzpwjm(dto.getRyzpwjm());
//			dao.update(v_Pcomryzp);

		}else{//添加
			String ryid = DbUtils.getSequenceStr();
			Pcomry pcomry = new Pcomry();
			BeanHelper.copyProperties(dto, pcomry);  //拷贝对应的从前台传来的数据
			/*pcomry.setRyzgzsfzrq(new SimpleDateFormat("yyyy-MM-dd").format(new Date(request.getParameter("ryzgzsfzrq"))));
			pcomry.setRyzyyszcrq(new SimpleDateFormat("yyyy-MM-dd").format(new Date(request.getParameter("ryzyyszcrq"))));
			pcomry.setRyzyyszsyxqz(new SimpleDateFormat("yyyy-MM-dd").format(new Date(request.getParameter("ryzyyszsyxqz"))));*/
			pcomry.setRyid(ryid);
			//pcomry.setRyzhaopian(fis);   //保存人员照片
			//用于解决从前端传来是" "但是数据库是null的问题
//			if(pcomry.getRycsrq() != null && pcomry.getRycsrq().equals("")){
//				pcomry.setRycsrq(null);
//			}
//			if(pcomry.getRynl() != null && pcomry.getRynl().equals("")){
//				pcomry.setRynl("0");
//			}
//			if(pcomry.getRyzgzsfzrq() != null && pcomry.getRyzgzsfzrq().equals("")){
//				pcomry.setRyzgzsfzrq(null);
//			}
//			if(pcomry.getRyzyyszcrq() != null && pcomry.getRyzyyszcrq().equals("")){
//				pcomry.setRyzyyszcrq(null);
//			}
//			if(pcomry.getRyzyyszsyxqz() != null && pcomry.getRyzyyszsyxqz().equals("")){
//				pcomry.setRyzyyszsyxqz(null);
//			}
//			if(pcomry.getRybeginwork() != null && pcomry.getRybeginwork().equals("")){
//				pcomry.setRybeginwork(null);
//			}
			dao.insert(pcomry);

//			String v_pcomryzpid = DbUtils.getSequenceStr();
//			Pcomryzp v_Pcomryzp=new Pcomryzp();
//			v_Pcomryzp.setPcomryzpid(v_pcomryzpid);
//			v_Pcomryzp.setRyid(ryid);
//			v_Pcomryzp.setRyzp(fis);
//			v_Pcomryzp.setRyzpwjm(dto.getRyzpwjm());
//			dao.insert(v_Pcomryzp);

		}
	}
	/*
	public void savePcomryImplOldback(HttpServletRequest request, PcomryDTO dto) throws Exception {
		//获取归属的企业信息
		Pcompany v_pcompany=dao.fetch(Pcompany.class, Cnd.where("comid", "=", dto.getComid()));
		//首先判断用户是更新还是添加操作
		if(null != dto.getRyid()&&!"".equals(dto.getRyid())){//更新，通过id找到本条数据而后跟新
			Pcomry pcomry = dao.fetch(Pcomry.class,dto.getRyid());
			
			//如果是检验检测机构，更新操作员的姓名和手机号
			if (v_pcompany.getComdalei().indexOf("106001")!=-1){//106001 检验检测机构
				Sysuser v_oldsysuser=dao.fetch(Sysuser.class, Cnd.where("aaz001", "=", dto.getRyid()));
				v_oldsysuser.setDescription(dto.getRyxm());
				v_oldsysuser.setMobile(dto.getRylxdh());
				dao.update(v_oldsysuser);
			}			
//			//BeanHelper.copyProperties(dto, pcomry);
//			pcomry.setRyid(dto.getRyid());  //修正id
//			pcomry.setRyzjlx(dto.getRyzjlx());
//			pcomry.setRyzjh(dto.getRyzjh());
//			pcomry.setRyxm(dto.getRyxm());
//			pcomry.setRyxb(dto.getRyxb());
//			pcomry.setRycsrq(dto.getRycsrq());
//			pcomry.setRynl(dto.getRynl());
//			pcomry.setRyxueli(dto.getRyxueli());
//			pcomry.setRybeginwork(dto.getRybeginwork());
//			pcomry.setRylxdh(dto.getRylxdh());
//			pcomry.setRyzhuanye(dto.getRyzhuanye());
//			pcomry.setRyjszc(dto.getRyjszc());
//			pcomry.setRycyfw(dto.getRycyfw());
//			pcomry.setRycyzglb(dto.getRycyzglb());
//			pcomry.setRyzgzsbh(dto.getRyzgzsbh());
//			//pcomry.setRyzgzsfzrq(dto.getRyzgzsfzrq());
//			pcomry.setRysfzyys(dto.getRysfzyys());
//			pcomry.setRyzyyszcbh(dto.getRyzyyszcbh());
//			//pcomry.setRyzyyszcrq(dto.getRyzyyszcrq());
//			//pcomry.setRyzyyszsyxqz(dto.getRyzyyszsyxqz());
//			pcomry.setRybyyx(dto.getRybyyx());
//			pcomry.setRyzwgw(dto.getRyzwgw());
//			pcomry.setRymz(dto.getRymz());
//			pcomry.setComid(dto.getComid());
//			//pcomry.setRyzhaopian(fis);   //保存人员照片
//			//pcomry.setRyzpwjm(dto.getRyzpwjm());
			
			BeanHelper.copyProperties(dto, pcomry);  //拷贝对应的从前台传来的数据
			dao.update(pcomry);
			
//			Pcomryzp v_Pcomryzp=dao.fetch(Pcomryzp.class, 
//					Cnd.where("ryid", "=", dto.getRyid()));
//			v_Pcomryzp.setRyzp(fis);
//			v_Pcomryzp.setRyzpwjm(dto.getRyzpwjm());
//			dao.update(v_Pcomryzp);
			
		}else{//添加
			String ryid = DbUtils.getSequenceStr();
			Pcomry pcomry = new Pcomry();
			BeanHelper.copyProperties(dto, pcomry);  //拷贝对应的从前台传来的数据
			pcomry.setRyid(ryid);
			dao.insert(pcomry);
			
//			String v_pcomryzpid = DbUtils.getSequenceStr();
//			Pcomryzp v_Pcomryzp=new Pcomryzp();
//			v_Pcomryzp.setPcomryzpid(v_pcomryzpid);
//			v_Pcomryzp.setRyid(ryid);
//			v_Pcomryzp.setRyzp(fis);
//			v_Pcomryzp.setRyzpwjm(dto.getRyzpwjm());
//			dao.insert(v_Pcomryzp);
			//保存图片
			
			FjDTO v_fjdto=new FjDTO();			
			v_fjdto.setFjwid(ryid);	
			v_fjdto.setFolderName("comry");
			
			//保存健康证 图片
			v_fjdto.setFjpath(dto.getRyjkzpath());
			v_fjdto.setFjname(dto.getRyjkzname());
			v_fjdto.setFjtype("5");
			pubService.saveFjWuzhuti(request,v_fjdto);
			//保存培训证 图片
			v_fjdto.setFjpath(dto.getRypxzpath());
			v_fjdto.setFjname(dto.getRypxzname());
			v_fjdto.setFjtype("6");
			pubService.saveFjWuzhuti(request,v_fjdto);
			//保存人员图片
			v_fjdto.setFjpath(dto.getRypxzpath());
			v_fjdto.setFjname(dto.getRypxzname());
			v_fjdto.setFjtype("7");
			pubService.saveFjWuzhuti(request,v_fjdto);			
			
			// gu20170507 如果是检验检测企业  往操作员表插入记录
			if (v_pcompany.getComdalei().indexOf("106001")!=-1){//106001 检验检测机构
				Sysuser v_newSysuser = new Sysuser();
				String v_username=SysmanageUtil.getComUsername(v_pcompany.getComdm());
				v_newSysuser.setUserid(ryid);
				v_newSysuser.setUsername(v_username);
				v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
				v_newSysuser.setUserkind("7");//7 快检人员
				v_newSysuser.setDescription(dto.getRyxm());
				v_newSysuser.setAaa027(v_pcompany.getAaa027());
				v_newSysuser.setOrgid("2017050714470572088189206");
				v_newSysuser.setMobile(dto.getRylxdh());//gu20161020add
				v_newSysuser.setAaz001(ryid);//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
				
				Sysuserrole v_Sysuserrole=new Sysuserrole();
				String v_USERROLEID = DbUtils.getSequenceStr();
				v_Sysuserrole.setUserroleid(v_USERROLEID);
				v_Sysuserrole.setUserid(ryid);
				v_Sysuserrole.setRoleid("2017050714492830438122991");
				dao.insert(v_newSysuser);
				dao.insert(v_Sysuserrole);
			}
		}
	}*/

	/**
	 * 查询出所有的人员信息，并分页显示
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	public Map queryPcomry(HttpServletRequest request,PcomryDTO dto, PagesDTO pd,String querytype) throws Exception {
		Sysuser v_sysuser = (Sysuser)SysmanageUtil.getSysuser();
		if (v_sysuser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
			v_sysuser = dao.fetch(Sysuser.class, dto.getUserid());
		}
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
//		sb.append(" select ryid,ryzjlx,ryzjh,ryxm,ryxb,rycsrq, ");
//		sb.append(" rynl,ryxueli,rybeginwork,rylxdh,ryzhuanye,ryjszc,rycyfw,rycyzglb,ryzgzsbh,ryzgzsfzrq, ");
//		sb.append(" rysfzyys,ryzyyszcbh,ryzyyszcrq,ryzyyszsyxqz,rybyyx,ryzwgw,rymz,pcom.comid,p.commc,");
//		
		sb.append(" select pcom.*,p.commc,p.aaa027,p.orgid,");//gu20170503
		sb.append(" (SELECT AAA103 FROM aa10   WHERE  AAA100 ='ryzwgw' AND AAA102 = ryzwgw) AS ryzwgwinfo,");
		sb.append(" (select t.fjpath from fj t where t.fjwid=pcom.ryid and fjtype='5') as ryjkzpath,");
		sb.append(" (select t.fjpath from fj t where t.fjwid=pcom.ryid and fjtype='6') as rypxzpath,");
		sb.append(" (select t.fjpath from fj t where t.fjwid=pcom.ryid and fjtype='7') as ryzppath, ");
		sb.append(" (select t.username from sysuser t where t.aaz001=pcom.ryid ) as comryusername ");
		sb.append(" from pcomry pcom,pcompany p ");
		sb.append(" where 1=1 ");
		sb.append(" and pcom.ryid = :ryid ");
		sb.append(" and pcom.ryxm like :ryxm ");
		sb.append(" and pcom.ryzjh = :ryzjh ");
		sb.append(" and pcom.comid = :comid ");
		if("jyjc".equals(querytype)){
			sb.append(" and p.comdalei = 106001");
		}
		sb.append(" and p.commc = :commc ");
		//sb.append(" and p.aaa027 like :aaa027 ");
		sb.append(" and pcom.comid = p.comid");

		if ("6".equals(v_sysuser.getUserkind())){ //6企业虚拟用户 
			sb.append(" and p.comid='"+v_sysuser.getAaz001()+"' ");
		};
		sb.append(" order by ryid desc ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "ryid","ryxm","ryzjh","comid","commc"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, PcomryDTO.class, pd.getPage(), pd.getRows(),dto.getUserid(),"aaa027,aae140,orgid");
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		// 判断应用服务器上是否存在附件副本,若服务器不存在则将数据库中存储的照片复制到服务器中
//		if (list != null && list.size() > 0) {
//			for (int i = 0; i < list.size(); i++) {
//				PcomryDTO pdto = (PcomryDTO) list.get(i);
//				String rootPath = request.getSession().getServletContext()
//						.getRealPath("/");
//				String fjpath = rootPath + File.separator + "/upload/pcomryzp/" + pdto.getRyzpwjm();
//				if (!FileUtil.checkFile(fjpath)) {
//					String fjcontent = pdto.getRyzhaopian();
//					if (!Strings.isBlank(fjcontent)) {
//						byte b[] = Base64.base64ToByteArray(fjcontent);
//						File file = new File(fjpath);
//						FileOutputStream fos = new FileOutputStream(file);
//						fos.write(b);
//						fos.close();
//					}
//				}
//			}
//		}
		return map;
	}

	/**
	 * 删除人员信息，根据id删除
	 */
	public String delPcomry(HttpServletRequest request,final PcomryDTO dto){
		try {
			delPcomryImpl(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 删除人员信息，实现类
	 * 交给事务管理
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop({"trans"})
	public void delPcomryImpl(HttpServletRequest request, PcomryDTO dto) throws Exception {
		if(!(dto.getRyid() == null || "".equals(dto.getRyid()))){
			//删除许可证图片信息
			pubService.delFjFromFjwid(request,dto.getRyid());
			//删除人员信息
			dao.clear(Pcomry.class,Cnd.where("ryid", "=", dto.getRyid()));
		}
	}

	/**
	 * 人员信息审核通过
	 * 审核通过之后将审核状态修改 同时向SysUser
	 * (系统用户表)中插入用户名和密码，密码初始值为123456
	 * @param request
	 * @param dto
	 * @return
	 */
	public String examPass(HttpServletRequest request, final PcomryDTO dto) {
		try{
			examPassImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 人员信息审核通过的实现方法
	 * 使用事务控制
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@Aop({"trans"})
	public void examPassImpl(HttpServletRequest request, PcomryDTO dto) throws Exception {
		if(null!=dto.getRyid()){
			//更新企业表
			Pcomry pcomry = dao.fetch(Pcomry.class,dto.getRyid());
			BeanHelper.copyProperties(dto, pcomry);
		/*	pcomry.setComshbz("2");*/
			dao.update(pcomry);
			//新增系统用户表
			Sysuser sysUser = new Sysuser();
			sysUser.setUserid(DbUtils.getSequenceStr());
			/*sysUser.setUsername(dto.getUsername());*/
			sysUser.setPasswd("123456");
			dao.insert(sysUser);
		}
	}

	/**
	 *
	 * uploadryZp的中文名称:上传人员照片
	 *
	 * uploadryZp的概要说明:
	 *
	 * @param request
	 * @return
	 * Written by CatchU 2016年5月11日上午9:42:45
	 */
	public String uploadryZp(HttpServletRequest request) {
		try {
			uploadryZpImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * uploadryZpImp的中文名称:上传人员照片实现方法
	 *
	 * uploadryZpImp的概要说明:
	 *
	 * @param request
	 * Written by CatchU 2016年5月11日上午9:43:07
	 */
	private void uploadryZpImp(HttpServletRequest request) {
		//利用上传路径和上传文件名构建文件对象 File  file = new File(path,fileName);
		//上传路径
		String realPath = request.getSession().getServletContext()
				.getRealPath("/upload/pcomryzp");
		//上传文件名
		String fileName = null;
		BufferedOutputStream  bos = null; //缓冲输出字节流
		//判断是否是上传文件表单
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setHeaderEncoding("UTF-8");
				List<FileItem> items = upload.parseRequest(request);
				// 区分表单域
				for (int i = 0; i < items.size(); i++) {
					FileItem fi = items.get(i);
					// 获取文件名
					fileName = fi.getName();
					if (fileName != null) {
						File savedFile = new File(realPath, fileName);
						fi.write(savedFile);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (bos != null)
						bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 *
	 * getComryzp的中文名称：获取数据库存储的单位人员照片信息
	 *
	 * getComryzp的概要说明: 创建照片，并返回服务器端路径
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */

	public String getComryzp(HttpServletRequest request, PcomryDTO dto)
			throws Exception {
		String filePath = null;
		try {
			String sql = "select * from pcomryzp where ryid = :ryid";
			String[] ParaName = new String[] { "ryid" };
			int[] ParaType = new int[] { Types.VARCHAR };
			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcomryzpDTO.class);
			List ls = (List) m.get(GlobalNames.SI_RESULTSET);

			if (ls != null && ls.size() > 0) {
				PcomryzpDTO pdto = (PcomryzpDTO) ls.get(0);
				String ryzp = pdto.getRyzp();
				if (!Strings.isBlank(ryzp)) {
					String fileName = String.valueOf(pdto.getRyzpwjm());
					String rootPath = request.getSession().getServletContext()
							.getRealPath(GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH);
					filePath = rootPath + File.separator + fileName;// + ".jpg";
					File file = new File(filePath);
					if (!file.exists()){
						byte b[] = Base64.base64ToByteArray(ryzp);
						FileUtil.createFolder(rootPath);
						FileOutputStream fos = new FileOutputStream(file);
						fos.write(b);
						fos.close();
					}
				}
			}

			return filePath;
		} catch (Exception e) {
			throw new BusinessException("获取照片信息失败：" + e.getMessage());
		}
	}


}