package com.askj.supervision.module;


import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.supervision.dto.*;
import com.askj.supervision.dto.util.EchartData;
import com.askj.supervision.dto.util.Label;
import com.askj.supervision.dto.util.Normal;
import com.askj.supervision.dto.util.Series;
import com.askj.supervision.entity.BsCheckDetail;
import com.askj.supervision.entity.BsCheckMaster;
import com.askj.supervision.entity.Pcomriskconfirm;
import com.askj.supervision.service.CheckHandlerService;
import com.askj.supervision.service.CheckResultService;
import com.askj.supervision.service.SupervisionApiService;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.document.DocumentInfo;
import org.apache.commons.lang.StringUtils;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 
 * SupervisionApiModule的中文名称：【安全监管手机端】api接口module
 * 
 * SupervisionApiModule的描述：从SjbModule提取安全监管涉及到的方法
 * 
 * @author ：sunyifeng
 * @version ：V1.0
 */
@At("api/supervision/")
@IocBean
public class SupervisionApiModule extends BaseModule {

	@Inject
	protected	CheckHandlerService checkHandlerService;
	@Inject
	protected SupervisionApiService supervisionApiService;
	@Inject
	protected CheckResultService checkResultService;

	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	@DocumentInfo(
			sort = 1,
			name="getPlanListByCompany",
			desc = "根据企业类别获取相关的计划列表（查询结果）和企业id",
			functiondesc = "根据企业类型和企业id查询计划信息和结果状态",
			author = "sunyifeng",
			params = "userid:用户ID,必填/comid:企业ID/itemid:企业大类对应omcheckgroup【itemid】/aaz093:企业大类对应aa10【AAZ903】,必填",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[{"+
							"planid:计划ID,"+
							"plancode: 计划编码,"+
							"plantitle: 计划名称,"+
							"planchecktype:检查类型,"+
							"plantype: 计划类型,"+
							"plantypearea:计划范围,"+
							"planstdate:计划开始日期,"+
							"planeddate:计划结束日期,"+
							"plancontent:计划内容,"+
							"planremark:计划备注,"+
							"planoperatedate:计划操作日期,"+
							"planoperator:计划操作员,"+
							"itemid:计划所属大类ID}"
							+"]}",
			date="2017-09-26",
			version = "1.0.0")
	public Object getPlanListByCompany(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
		Map map = new HashMap();
		try {
			map = supervisionApiService.getPlanListByCompany(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}


	@DocumentInfo(
			sort = 2,
			name="getCheckHistoryListByPlan",
			desc = "根据计划得到历史计划检查记录",
			functiondesc = "根据企业id计划id查询企业检查历史",
			author = "sunyifeng",
			params = "comid:企业ID,必填/planid:计划ID,必填/qtbwid:其他表外键ID/planchecktype:检查类型",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[{"+
					"planid:计划ID,"+
					"plancode: 计划编码,"+
					"plantitle: 计划名称,"+
					"planchecktype:检查类型,"+
					"plantype: 计划类型,"+
					"plantypearea:计划范围,"+
					"planstdate:计划开始日期,"+
					"planeddate:计划结束日期,"+
					"plancontent:计划内容,"+
					"planremark:计划备注,"+
					"planoperatedate:计划操作日期,"+
					"planoperator:计划操作员,"+
					"itemid:计划所属大类ID}"
					+"]}",
			date="2017-09-26",
			version = "1.0.0")
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object getCheckHistoryListByPlan(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			map = supervisionApiService.getCheckHistoryListByPlan(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@DocumentInfo(
			sort = 3,
			name="getCheckDetailListByCheckHistory",
			desc = "根据检查历史相关信息获取相关的执法项内容",
			functiondesc = "根据企业类型,企业id和计划id获取检查项目明细",
			author = "sunyifeng",
			params = "itemid:企业大类ID,必填/planid:计划ID,必填/comid:企业ID,必填/resultid:结果ID",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:["+
					"{itempid:检查项父ID,"+
					"itempidname:检查项父名称,"+
					"itemid:检查项ID,"+
					"itemname:检查项名称,"+
					"contentid:明细ID,"+
					"content:明细内容,"+
					"detaildecide:明细判定,"+
					"detailscore:明细得分,"+
					"contentscore:明细分值,"+
					"contentcode:明细编号,"+
					"contentimpt:明细重要性}"
					+"]}",
			date="2017-09-26",
			version = "1.0.0")
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object getCheckDetailListByCheckHistory(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
		Map map = new HashMap();
		try {
			if("null".equalsIgnoreCase(dto.getResultid()) || StringUtils.isEmpty(dto.getResultid())){
				dto.setResultid("");
			}
			map = supervisionApiService.getCheckDetailListByCheckHistory(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@DocumentInfo(
			sort = 12,
			name="getCheckDetailByResultIdAndContentId",
			desc = "查询检查明细历史",
			functiondesc = "根据检查结果ID和检查内容ID查询检查明细信息 （日期样例-2017-10-23 11:38:34）",
			author = "sunyifeng",
			params = "resultid:检查结果ID,必填/contentid:检查内容ID,必填",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[{"+
					"{\"checkavgscore\":检查平均分,\"detailid\":\"检查明细ID\",\"resultid\":\"结果ID\",\"contentid\":\"检查项目ID\",\"detaildecide\":\"明细判定\",\"detailscore\":明细得分,\"detailoperatedate\":\"明细操作日期\",\"detailcheckdate\":\"明细检查日期\",\"detailng\":\"明细不符合项说明\",\"detailremark\":\"明细备注\"}"
					+"]}",
			date="2017-10-23",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object getCheckDetailByResultIdAndContentId(HttpServletRequest request, @Param("..") BsCheckDetailDTO dto) {
		Map map = new HashMap();
		try {
			if("null".equalsIgnoreCase(dto.getResultid()) || StringUtils.isEmpty(dto.getResultid())){
				throw new BusinessException("检查结果ID不能为空");
			}
			if("null".equalsIgnoreCase(dto.getContentid()) || StringUtils.isEmpty(dto.getContentid())){
				throw new BusinessException("检查项目ID不能为空");
			}
			map = supervisionApiService.getCheckDetailByResultIdAndContentId(dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@DocumentInfo(
			sort = 4,
			name="getCheckProblemListByContentId",
			desc = "查询检查指南常见问题列表",
			functiondesc = "根据明细contentid查询问题列表",
			author = "sunyifeng",
			params = "contentid:明细ID,必填",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[{"+
					"problemid:问题ID,problemdesc:问题描述,selected:是否选中-0否1是}"
					+"]}",
			date="2017-10-16",
			version = "1.0.0")
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object getCheckProblemListByContentId(HttpServletRequest request, @Param("..") OmcheckbasisDTO dto) {
		Map map = new HashMap();
		try {
			if("null".equalsIgnoreCase(dto.getContentid()) || StringUtils.isEmpty(dto.getContentid())){
				throw new BusinessException("检查项目ID不能为空");
			}
			if("null".equalsIgnoreCase(dto.getResultid()) || StringUtils.isEmpty(dto.getResultid())){
				throw new BusinessException("检查结果ID不能为空");
			}
			map = supervisionApiService.getCheckProblemListByContentId(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@DocumentInfo(
			sort = 5,
			name="getCheckBasisListByProblemIdOrContentId",
			desc = "查询检查指南",
			functiondesc = "根据ProblemId或者contentid",
			author = "sunyifeng",
			params = "contentid:明细ID/problemid:问题ID",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[<br>"+
					"{"+
					"problemInfo:问题描述-逗号分隔,"+
					"basisid:检查依据ID,"+
					"typedesc:检查类型描述,"+
					"guide:检查指南,"+
					"punishmeasures:处罚措施,"+
					"basisdesc:检查依据描述,"+
					"lawList:["+
					"{"+
					"flfgid:法律法规Id,"+
					"flfgtkxm:法律法规项目,"+
					"flfgtkid:法律条款ID,"+
					"flfgtknr:法律条款内容,"+
					"flfgtkcybz:法律条款标志"+
					"}"+
					"]"+
					"}"+
					"]}",
			date="2017-10-16",
			version = "1.0.0")
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object getCheckBasisListByProblemIdOrContentId(HttpServletRequest request, @Param("..") OmcheckbasisDTO dto) {
		Map map = new HashMap();
		try {
			if("null".equalsIgnoreCase(dto.getContentid()) || StringUtils.isEmpty(dto.getContentid())){
				dto.setContentid("");
			}
			map = supervisionApiService.getCheckBasisListByProblemIdOrContentId(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@DocumentInfo(
			sort = 6,
			name="showContentGuide",
			desc = "展示检查指南接口",
			functiondesc = "该接口返回jsp页面",
			author = "sunyifeng",
			params = "contentid:用户ID/problemid:问题ID",
			returndesc = "jsp页面",
			date="2017-10-16",
			version = "1.0.0")
	@At
	@Ok("jsp:/jsp/supervision/guide/contentGuide")
	public void showContentGuide(HttpServletRequest request, @Param("..") OmcheckbasisDTO dto) {
		Map map = new HashMap();
		try {
			if("null".equalsIgnoreCase(dto.getContentid()) || StringUtils.isEmpty(dto.getContentid())){
				dto.setContentid("aa");
			}
			map = supervisionApiService.getCheckBasisListByProblemIdOrContentId(request, dto);

		} catch (Exception e) {
			SysmanageUtil.execAjaxResult(map, e);
		}

		request.setAttribute("datalist",map.get("rows"));
	}


	@DocumentInfo(
			sort = 7,
			name="saveCheckDetailForBatch",
			desc = "批量保存检查结果明细",
			functiondesc = "步骤：１．保存检查结果明细，２．保存检查结果摘要",
			author = "sunyifeng",
			params = "resultid:结果ID,必填/comdalei:企业大类,必填/resultstate:结果状态2,必填/aaa027:行政区划编码,必填/aaa383:统筹区级别/detaillist:[{"+
					"contentid:明细ID,必填/"+
					"detaildecide:明细结果判定,必填/"+
					"detailscore:明细得分,必填"
					+"}]",
			returndesc = "{msg:返回消息,success:是否成功 ,code:'返回码<0000:成功-9999:失败>',resultid:结果ID}",
			date="2017-09-26",
			version = "1.0.0")
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object saveCheckDetailForBatch(HttpServletRequest request, @Param("..") BsCheckDetailDTO dto,
									  @Param("..") BsCheckMasterDTO mdto)
			throws Exception {
		// request.getParameter(arg0);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "9999");
		result.put("msg", "保存失败");
		result.put("success", false);
		// 批量保存明细
		Map map = checkHandlerService.saveCheckDetailForBatch(request, dto);
		// 修改结果状态(保存平均分)
		mdto.setResultid(dto.getResultid());
		checkHandlerService.updateBsCheckMasterStateByResultid(request, mdto);

//		//gu20180514add
//		if (dto.getOperatetype()!=null && "shengchandongtai".equals(dto.getOperatetype())){
//			checkHandlerService.addOrUpdatePcompanynddtpj(dto.getComid(),"dongtai","",String.valueOf(mdto.getResultscore()),"","");
//		}

		if ((Boolean) map.get("success")) {
			result.put("msg", map.get("msg"));
			result.put("success", map.get("success"));
			result.put("code", "0000");
		} else {
			result.put("msg", map.get("msg"));
		}
		return result;

	}


	@DocumentInfo(
			sort = 8,
			name="saveCheckDetail",
			desc = "保存检查明细-逐条",
			functiondesc = "以单条形式保存检查明细",
			author = "sunyifeng",
			params = "resultid:结果ID,必填/"+
					"contentid:明细ID,必填/"+
					"detaildecide:明细结果判定,必填/"+
					"detailscore:明细得分/"+
					"detailng:明细不符合项说明-最终的问题列表ID多条以逗号分割/"+
					"detailattachment:明细附件-暂时不用/"+
					"detailremark:明细备注-最终问题描述/"+
					"detailoperatedate:明细经办日期/"+
					"detailoperateperson:明细经办人/"+
					"detailcheckdate:明细核查日期/"+
					"detailcheckperson:明细检查人/",
			returndesc = "{msg:返回信息,success:是否成功,'返回码<0000:成功-9999:失败>',detailid:明细ID}",
			date="2017-10-15",
			version = "1.0.0")
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object saveCheckDetail(HttpServletRequest request, @Param("..") BsCheckDetail dto) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "9999");
		result.put("msg", "保存失败");
		result.put("success", false);
		Map map = checkHandlerService.saveCheckDetail(request, dto);
		if ((Boolean) map.get("success")) {
			result.put("msg", map.get("msg"));
			result.put("detailid", map.get("detailid"));
//			request.setAttribute("", map.get("detailid"));
			result.put("success", map.get("success"));
			result.put("code", "0000");
		} else {
			result.put("msg", map.get("msg"));
		}
		return result;

	}

	@DocumentInfo(
			sort = 9,
			name="commitResultinfo",
			desc = "提交结果信息 保存最终判定结果信息",
			functiondesc = "以单条形式保存检查明细",
			author = "sunyifeng",
			params = "resultid:结果ID,必填/"+
					"comid:企业ID,必填/"+
					"resultstate:结果状态,必填/"+
					"location:位置信息/"+
					"latitude:纬度/"+
					"longitude:经度/"+
					"resultperson:经办陪同人/"+
					"lxr:负责人名称/"+
					"lxdh:负责人电话/"+

					"resultng:结果不符合说明/"+
					"resultdecision:结果判定/"+
					"resultfinal:结果处理/"+

					"aaa027:行政区划编码/"+
					"aaa383:行政区划级别",
			returndesc = "{msg:返回信息,success:是否成功,code:'返回码<-1:失败-0:成功>'}",
			date="2017-10-15",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object commitResultinfo(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "-1");
		result.put("msg", "操作失败");
		result.put("success", false);
		if ("null".equalsIgnoreCase(dto.getResultid()) || StringUtils.isEmpty(dto.getResultid())) {
			result.put("msg", "检查计划ID[resultid]不能为空");
			return result;
		}
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			result.put("msg", "公司ID[commid]不能为空");
			return result;
		}

		return SysmanageUtil.execAjaxResult(checkHandlerService.updateResultinfo(request, dto));

	}
	@DocumentInfo(
			sort = 10,
			name="getResultinfoForConfirm",
			desc = "获取核查结果",
			functiondesc = "为结果确定界面提供提交后的判定数据",
			author = "sunyifeng",
			params = "resultid:结果ID,必填",
			returndesc = "{msg:返回信息,success:是否成功,code:'返回码<-1:失败-0:成功>',data:{" +
					"label1: 检查结果判定标准:,                                                                                                            "+
					"label1_01: 关键项允许不符合数:3,                                                                                                      "+
					"label1_02: 重点项和一般项允许不符合数：3,                                                                                             "+
					"label1_03: 重点项和一般项不符合总数<8项，其中重点项不符合数<2项。,                                                                    "+
					"label2: 核查结论审核对照结果：,                                                                                                       "+
					"label2_01: 你单位关键项允许不符合数6项，重点项允许不符合数6项，一般项允许不符合数9项，根据现场核查结果判定准则，判断如下结果，请选择, "+
					"label3: 检查结果：,                                                                                                                   "+
					"label3_01: 符合规定,                                                                                                                  "+
					"label3_02: 限期整改,                                                                                                                  "+
					"label3_03: 不符合规定                                                                                                                 "+
					"}}",
			date="2017-10-15",
			version = "1.0.0")
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object getResultinfoForConfirm(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			map = checkHandlerService.getinconformityNumid(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@DocumentInfo(
			sort = 11,
			name="getResultInfoForHtml",
			desc = "查询检查结果信息",
			functiondesc = "根据resultid结果ID查询检查结果信息以html形式返回",
			author = "tmm",
			params = "resultid:结果ID,必填",
			returndesc = "html页面",
			date="2017-07-15",
			version = "1.0.0")
	@At
	@Ok("raw:htm")
	public Object getResultInfoForHtml(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {

		try {
			return checkResultService.getResultInfoForHTML(request, dto).getDetailinfo();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return "暂无数据";
		}
	}

	@DocumentInfo(
			sort = 12,
			name="queryCheckPlan",
			desc = "查询检查计划",
			functiondesc = "查询检查计划",
			author = "ly",
			params = "page：页数 / pageSize：每页条数 ",
			returndesc = "{\n" +
					"    \"total\": 4,\n" +
					"    \"code\": \"0\",\n" +
					"    \"msg\": \"\",\n" +
					"    \"rows\": [\n" +
					"        {\n" +
					"            \"unchecked\": \"未检查数量\",\n" +
					"            \"checking\": \"检查中数量\",\n" +
					"            \"checked\": \"已检查数量\",\n" +
					"            \"planid\": \"计划ID\",\n" +
					"            \"plancode\": \"检查计划代码截取后字符串，如RC\",\n" +
					"            \"plantitle\": \"计划名称\",\n" +
					"            \"planchecktype\": \"检查计划类型\",\n" +
					"            \"plantype\": \"检查类型\",\n" +
					"            \"planstdate\": \"计划开始日期\",\n" +
					"            \"planeddate\": \"计划截止日期\"\n" +
					"        }\n" +
					"    ]\n" +
					"} ",
			date="2017-12-25",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object queryCheckPlan(HttpServletRequest request, @Param("..") BscheckplanDTO dto,  @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = supervisionApiService.queryCheckPlan(request, dto, pd);
			return  SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
			return  SysmanageUtil.execAjaxResult(map,e);
		}
	};

	/**
	 *
	 * queryRiskCheckMasterId的中文名称：查询检查结果ID 新增量化检查
	 *
	 * queryRiskCheckMasterId的概要说明：如果没有检查结果ID，新增一个检查结果
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryRiskCheckMasterId(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "9999");
		result.put("msg", "操作失败");
		result.put("success", false);
		result.put("resultid", "");
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			result.put("msg", "企业单位ID[comid]不能为空");
			return result;
		}
		Map retMap = new HashMap();

		result = supervisionApiService.saveRiskCheckMaster(request, dto);
		if ((Boolean) result.get("success")) {
			result.put("code", "0000");
			result.put("msg", "保存成功");
		}
		return result;
	};
	/**
	 * 获取企业量化检查历史记录
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object getRiskCheckHistoryList(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
				map.put("msg", "公司ID[commid]不能为空");
				map.put("code", "-1");
				return map;
			}
			map = supervisionApiService.getRiskCheckHistoryList(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	};

	/**
	 *
	 * saveCompanyRiskCheck的中文名称：保存企业量化等级
	 *
	 * saveCompanyRiskCheck的概要说明：首先要对企业进行量化分级后，才能对企业进行检查
	 * @param dto
	 * @return Written by :zy
	 *
	 */
	@At
	@Ok("json")
	public Object saveCompanyRiskCheck_zy(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "9999");
		result.put("msg", "操作失败");
		result.put("success", false);
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			result.put("msg", "公司ID[comid]不能为空");
			return result;
		}
		return SysmanageUtil.execAjaxResult(checkHandlerService.saveCompanyRiskCheck_zy(request, dto));
	};

	/**
	 *
	 * saveSpxsStaticRiskPingji食品销售静态风险评级：保存
	 *
	 * saveSpxsStaticRiskPingji食品销售静态风险评级：首先要对企业进行量化分级后，才能对企业进行检查
	 * @param dto
	 * @return Written by :zy
	 *
	 */
	@At
	@Ok("json")
	public Object saveSpxsStaticRiskPingji(HttpServletRequest request, @Param("..") PjingspxsDTO dto) {
	//	pjingspxs
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("code", "9999");
		resultMap.put("msg", "操作失败");
		resultMap.put("success", false);
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			resultMap.put("msg", "公司ID[comid]不能为空");
			return resultMap;
		}
		try{
			String v_resultid=checkHandlerService.saveSpxsStaticRiskPingji(request, dto);
			resultMap.put("resultid",v_resultid);
			return SysmanageUtil.execAjaxResult(resultMap, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(resultMap, e);
		}
	};

	/**
	 * saveCyfwStaticRiskPingji餐饮服务提供者静态风险因素量化分值表
	 * @param dto
	 * @return Written by :zy
	 *
	 */
	@At
	@Ok("json")
	public Object saveCyfwStaticRiskPingji(HttpServletRequest request, @Param("..") PjingcyfwlhDTO dto) {
		//	pjingspxs
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("code", "9999");
		resultMap.put("msg", "操作失败");
		resultMap.put("success", false);
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			resultMap.put("msg", "公司ID[comid]不能为空");
			return resultMap;
		}
		try{
			String v_resultid=checkHandlerService.saveCyfwStaticRiskPingji(request, dto);
			resultMap.put("resultid",v_resultid);
			return SysmanageUtil.execAjaxResult(resultMap, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(resultMap, e);
		}
	};

	/**
	 *
	 * queryAjdjlyList的中文名称：查询案件来由
	 *
	 * querySptjjJtfxlhList的概要说明：查询食品、食品添加剂生产者静态风险因素量化分值表
	 *
	 * @param request
	 *            wfxwms wfxwbh
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object querySptjjJtfxlhList(HttpServletRequest request, @Param("..") OmcheckcontentDTO dto,
									   @Param("..") PagesDTO pd) {
		// 查询案件登记列表信息
		Map map = new HashMap();
		try {
			if (pd.getPageSize()==0){
               pd.setPageSize(50);
			};
			map = checkHandlerService.querySptjjJtfxlhList(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 * saveCyfwNddjpd餐饮服务食品安全监督年度等级评定表
	 * @param dto
	 * @return Written by :zy
	 *
	 */
	@At
	@Ok("json")
	public Object saveCyfwNddjpd(HttpServletRequest request, @Param("..") PcyfwnddjpdDTO dto) {
		//	pjingspxs
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("code", "9999");
		resultMap.put("msg", "操作失败");
		resultMap.put("success", false);
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			resultMap.put("msg", "公司ID[comid]不能为空");
			return resultMap;
		}
		try{
			String v_resultid=checkHandlerService.saveCyfwNddjpd(request, dto);
			resultMap.put("resultid",v_resultid);
			return SysmanageUtil.execAjaxResult(resultMap, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(resultMap, e);
		}
	};

	/**
	 *
	 * saveSpscjyRiskCheckConfirm：保存食品生产经营者风险等级确定表
	 *
	 * saveSpscjyRiskCheckConfirm：保存食品生产经营者风险等级确定表
	 * @param dto
	 * @return Written by :zy
	 *
	 */
	@At
	@Ok("json")
	public Object saveSpscjyRiskCheckConfirm(HttpServletRequest request, @Param("..") PcomriskconfirmDTO dto) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("code", "9999");
		resultMap.put("msg", "操作失败");
		resultMap.put("success", false);
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			resultMap.put("msg", "公司ID[comid]不能为空");
			return resultMap;
		}

		try{
			String v_resultid=checkHandlerService.saveSpscjyRiskCheckConfirm(request, dto);
			resultMap.put("resultid",v_resultid);
			return SysmanageUtil.execAjaxResult(resultMap, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(resultMap, e);
		}
	};

/**
 * 食品相关静态动态评定结果表
 * param resultid
 * return Written by :gjf
 * */
	@At
	@Ok("json")
	public Object queryRiskPingDing(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto,  @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = supervisionApiService.queryRiskPingDing(request, dto, pd);
			return  SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
			return  SysmanageUtil.execAjaxResult(map,e);
		}
	};

	/**
	 * 获取餐饮服务食品安全监督年度等级评定表中 动态等级评定情况
	 * param resultid
	 * return Written by :gjf
	 * */
	@At
	@Ok("json")
	public Object queryCyfwNddtpdDtdjpdqk(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto,  @Param("..") PagesDTO pd){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("code", "9999");
		resultMap.put("msg", "操作失败");
		resultMap.put("success", false);
		if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			resultMap.put("msg", "公司ID[comid]不能为空");
			return resultMap;
		};
		try {
			resultMap = supervisionApiService.queryCyfwNddtpdDtdjpdqk(request, dto, pd);
			return  SysmanageUtil.execAjaxResult(resultMap,null);
		} catch (Exception e) {
			return  SysmanageUtil.execAjaxResult(resultMap,e);
		}
	};

	/**
	 * 食品生产经营者风险等级确定表,新增时需要的单位信息和单位历史评定信息
	 *
	 * */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryPcomriskconfirmAddinfo(HttpServletRequest request, @Param("..") Pcomriskconfirm dto,
								  @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = supervisionApiService.queryPcomriskconfirmAddinfo(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	};

	@DocumentInfo(
			sort = 13,
			name="queryCompanyByPlan",
			desc = "根据检查计划信息查询企业",
			functiondesc = "计划信息包含检查计划ID和检查结果完成类型",
			author = "ly",
			params = "resultType:检查结果完成类型-1:未检查,2:检查中,3:已完成,必填,/planid :计划id，必填 / page：页数 / pageSize：每页条数",
			returndesc = " {\n" +
					"    \"total\": \"返回总数\",\n" +
					"    \"code\": \"返回状态标志 正确为0\",\n" +
					"    \"msg\": \"返回信息\",\n" +
					"    \"rows\": [\n" +
					"            \"comxyzb\": \"1\",\n" +
					"            \"commdbh\": \"企业门店编号\",\n" +
					"            \"comjlzj\": \"酒类专兼\",\n" +
					"            \"comjlyw\": \"有无酒类\",\n" +
					"            \"comid\": \"企业id\",\n" +
					"            \"comdm\": \"企业代码\",\n" +
					"            \"comdalei\": \"企业大类编号   101303,201314\",\n" +
					"            \"commc\": \"企业名称\",\n" +
					"            \"comfzr\": \"企业法人\",\n" +
					"            \"comyddh\": \"企业移动电话\",\n" +
					"            \"comdz\": \"企业地址\",\n" +
					"            \"comzmj\": 总面积,\n" +
					"            \"comdzcsj\": \"代注册时间\",\n" +
					"            \"comshbz\": \"审核标志\",\n" +
					"            \"aaa027\": \"区域编码\",\n" +
					"            \"comfwnfww\": \"范围内外 \",\n" +
					"            \"orgid\": \"机构id\",\n" +
					"            \"commcjc\": \"企业名称简称\",\n" +
					"            \"comdaleiname\": \"企业大类名称\",\n" +
					"            \"comxiaoleiname\": \"小类名称 \",\n" +
					"            \"orderno\": \"6164\"\n" +
					"    ]\n" +
					"}",
			date="2017-12-25",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object queryCompanyByPlan(HttpServletRequest request, @Param("resultType") int resultType,
									 @Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = supervisionApiService.queryCompanyByPlan(request,resultType, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

    /**
	 * 查询检查历史记录
	 * */
	@At
	@Ok("json")
	public Object queryHistoryCheck(HttpServletRequest request,
									@Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) {
		Map mapc = new HashMap();
		try {
			mapc = checkResultService.queryResultList(request, dto,pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}

	/**
	 *
	 * getLhAndSupervisionEcharts的中文名称：获取量化检查情况统计
	 *
	 * getLhAndSupervisionEcharts的概要说明：
	 *
	 * @param request
	 *
	 *
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getLhAndSupervisionEcharts(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto ) {
		// 页面初始化
		List<String> legends = new ArrayList<String>(); // 分组显示（量化检查）
		List<Series> seriesList = new ArrayList<Series>(); // 纵坐标数据（检查个数）
		List<String> categoryList = new ArrayList<String>(); // 横坐标数据（各乡所机构）
		Map map = new HashMap();
		if(dto.getCheckyear() == null || "".equals(dto.getCheckyear())){
			dto.setCheckyear(String.valueOf(DateUtil.convertDateToYear(new Date())));
		}
		try {
			List list = supervisionApiService.getSysorgStatistic(dto.getCheckyear());
			// 分组显示
			legends.add("已量化");
			legends.add("量化中");
			legends.add("已检查");
			legends.add("检查中");
			// 添加横坐标信息
			for (int j = 0; j < list.size(); j++) {
				Map m = (Map) list.get(j);
				categoryList.add((String) m.get("orgname")); // 各乡所机构名称
			}
			// 添加纵坐标信息
			for (int i = 0; i < legends.size(); i++) {
				List<Integer> serieslist = new ArrayList<Integer>(); // 纵坐标数据
				for (int j = 0; j < list.size(); j++) {
					Map m = (Map) list.get(j);
					switch (i){
						case 0 : serieslist.add(Integer.parseInt((String)m.get("lhed"))); // 已量化数量
							break;
						case 1 : serieslist.add(Integer.parseInt((String)m.get("lhing"))); // 量化中数量
							break;
						case 2 : serieslist.add(Integer.parseInt((String)m.get("checked"))); // 已检查数量
							break;
						case 3 : serieslist.add(Integer.parseInt((String)m.get("checking"))); // 检查中数量
							break;
					}
				}
				Series series = new Series(legends.get(i), "bar", serieslist, new Label(new Normal(true, "top")));
				seriesList.add(series);
			}
			EchartData echarts = new EchartData(legends, categoryList,  seriesList);
			map.put("data", echarts);
			map.put("year", String.valueOf(dto.getCheckyear()));
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getComdaleiOfAaa027Echarts的中文名称：获取各地区各大类企业检查统计
	 *
	 * getComdaleiOfAaa027Echarts的概要说明：
	 *
	 * @param request
	 *
	 *
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getComdaleiOfAaa027Echarts(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto ) {
		// 页面初始化
		List<String> legends = new ArrayList<String>();
		List<Series> seriesList = new ArrayList<Series>();
		Map map = new HashMap();
		if(dto.getCheckyear()==null||"".equals(dto.getCheckyear())){
			dto.setCheckyear(String.valueOf(DateUtil.convertDateToYear(new Date())));
		}
		try {
			//获取食品流通科企业大类
			List<Aa10> comdaleis = checkHandlerService.getAa10ListByaaa101("comdalei", "100");// 数组
			List<String> categoryList = checkHandlerService.queryaaa207Strlist(request, dto); //

			for(Aa10 aa10 : comdaleis){
				legends.add(aa10.getAaa103());
				dto.setComdalei(aa10.getAaa102());
				List<Integer> serieslist = checkHandlerService.queryPcomPlanResultNumBycomdalei(request, dto);//
				Series series = new Series(aa10.getAaa103(), "bar", serieslist,new Label(new Normal(true, "top")));
				seriesList.add(series);
			}

			EchartData echarts = new EchartData(legends, categoryList,  seriesList);
			map.put("data", echarts);
			map.put("year", String.valueOf(DateUtil.convertDateToYear(new Date())));
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

}
