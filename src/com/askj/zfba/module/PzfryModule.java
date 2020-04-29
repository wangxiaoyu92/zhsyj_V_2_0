package com.askj.zfba.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.PzfryDTO;
import com.askj.zfba.service.PzfryService;
import com.zzhdsoft.utils.SysmanageUtil;

@At("/zfba/zfrygl")
@IocBean
public class PzfryModule extends BaseModule {
    @Inject
    private PzfryService pzfryService;

    /**
     * findZfry的中文名称：查询执法人员列表 性别和执法领域需要汉字
     * findZfry的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by:ly
     */
    @At
    @Ok("json")
    public Object findZfry(HttpServletRequest request,
                           @Param("..") PzfryDTO dto, @Param("..") PagesDTO pd)
            throws Exception {
        Map mapc = new HashMap();
        try {
            mapc = pzfryService.pzfry(dto, pd);
            return SysmanageUtil.execAjaxResult(mapc, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(mapc, e);
        }
//		return pzfryService.pzfry(dto, pd);
    }

    /**
     * pzfryIndex的中文名称：跳转到执法人员列表页面
     * pzfryIndex的概要说明：
     *
     * @param request Written by:ly
     */

    @At
    @Ok("jsp:/jsp/zfba/zfrygl/pzfry")
    public void pzfryIndex(HttpServletRequest request) {
        // 页面初始化
    }

    /**
     * getPY的中文名称：得到执法人员姓名拼音首字母
     * getPY的概要说明：
     *
     * @param dto
     * @return Written by:ly
     */
    @At
    @Ok("json")
    public String getPY(@Param("..") PzfryDTO dto) {
        return pzfryService.getPY(dto);
    }

    /**
     * pzfryFormIndex的中文名称：跳转到修改 查看页面
     * pzfryFormIndex的概要说明：
     *
     * @param request Written by:ly
     */
    @At
    @Ok("jsp:/jsp/zfba/zfrygl/pzfryForm")
    public void pzfryFormIndex(HttpServletRequest request) {
        // 页面初始化
    }

    /**
     * pzfryDTO的中文名称：页面需要查询出执法人员的性别和领域是数字
     * pzfryDTO的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by:ly
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @At
    @Ok("json")
    public Object pzfryDTO(HttpServletRequest request,
                           @Param("..") PzfryDTO dto, @Param("..") PagesDTO pd)
            throws Exception {
        Map map = new HashMap();
        try {
            map = pzfryService.pzfrych(dto, pd);
            List ls = (List) map.get("rows");
            PzfryDTO pzfryDTO = null;
            if (ls != null && ls.size() > 0) {
                pzfryDTO = (PzfryDTO) ls.get(0);
            }
            map.put("data", pzfryDTO);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * isExistsZfry的中文名称：检查执法人员身份证是否登记过
     * isExistsZfry的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by:ly
     */

    @At
    @Ok("json")
    public Object isExistsZfry(HttpServletRequest request,
                               @Param("..") PzfryDTO dto) throws Exception {
        String v_ret = pzfryService.isExistsZfry(dto);
        if ("0".equals(v_ret)) {
            v_ret = "";
        }
        //return SysmanageUtil.execAjaxResult("");
        return SysmanageUtil.execAjaxResult(v_ret);
    }

    /**
     * reZfry的中文名称：更新执法人员信息
     * reZfry的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by:ly
     */
    @Ok("json")
    @At
    public Object reZfry(HttpServletRequest request, @Param("..") PzfryDTO dto) {
        return SysmanageUtil.execAjaxResult(pzfryService.updateZfry(request,
                dto));
    }

}
