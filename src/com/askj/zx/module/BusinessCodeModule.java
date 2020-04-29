package com.askj.zx.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxParamDTO;
import com.askj.zx.entity.Zxbusinesscode;
import com.askj.zx.service.BusinessCodeService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 业务参数
 * @author lfy
 *
 */
@IocBean
@At("/zx/BusinessCode")
@Fail("jsp:/jsp/error/error")
public class BusinessCodeModule extends BaseModule{
		@Inject
		private BusinessCodeService  businessCodeService;
		/**
		 * lfy
		 * 分页查询
		 * @param dto
		 * @param pd
		 * @return
		 */
		@SuppressWarnings("rawtypes")
		@At
		@Ok("json")
		public Object queryBusinessCode(@Param("..") Zxbusinesscode dto,
					@Param("..") PagesDTO pd){
			Map m = businessCodeService.queryBusinessAllInfo(dto, pd);
			Object o = m.get("rows");
			return o;
		}
		/**
		 * lfy
		 * @param dto
		 * @param pd
		 * @return
		 */
		@At
		@Ok("json")
		public Object queryBusinessCodeCombox(@Param("..") Zxbusinesscode dto,
					@Param("..") PagesDTO pd){
			return businessCodeService.queryBusinessAllInfo(dto, pd);
		}
		/**
		 * lfy
		 * 返回页面
		 * @param request
		 */
		@At
		@Ok("jsp:/jsp/zx/businesscode/zxBusinessCode")
		public void zxBusinessCodeIndex(HttpServletRequest request) {
			// 页面初始化
		}
		
		/**
		 * @TODO: 业务参数管理导航
		 * @author: zhaichunlei
		 & @DATE : 2016年1月22日
		 */
		@At
		@Ok("jsp:/jsp/zx/businesscode/codemanager")
		public void init(){
			
		}
		
		/**
		 * @TODO: 查询业务树
		 * @author: zhaichunlei
		 & @DATE : 2016年1月25日
		 * @return
		 */
		@At
		@Ok("json")
		public Object queryBusinessCodeZTree(HttpServletRequest request){
			String curCode = request.getParameter("curCode");
			
			try {
				List<ZxParamDTO> lst = businessCodeService.queryBusinessCode(curCode);
				String json = Json.toJson(lst);
				json.replace("isparent","isParent");
				Map<String,String> m = new HashMap<String,String>();
				m.put("treeData", json);
				return SysmanageUtil.execAjaxResult(m, null);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return SysmanageUtil.execAjaxResult(null,e);
			}
		}
		
		/**
		 * @TODO: 查询业务参数数据列表
		 * @author: zhaichunlei
		 & @DATE : 2016年1月25日
		 * @return
		 */
		@At
		@Ok("json")
		public Object queryBusinessCodeList(@Param("..") ZxParamDTO dto, @Param("..") PagesDTO pd){
			try {
				Map<Object,Object> map = businessCodeService.queryBusinessCodeList(dto,pd);
				return map;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return SysmanageUtil.execAjaxResult(null, e);
			}
		}
}
