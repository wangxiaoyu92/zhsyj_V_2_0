package com.askj.oa.module;

import com.askj.oa.service.KqglService;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 考勤管理
 * Created by Administrator on 2017/9/26.
 */
@IocBean
@At("/kqgl/qddc")
public class KqglModule {
    protected final Logger logger = Logger.getLogger(KqglModule.class);

    @Inject
    private KqglService kqglService;

    @At
    @Ok("json")
    public List getcsv(String startDate , String endDate) throws Exception {
        return   kqglService.Qdtj(startDate ,endDate);
    }

    /**
     * 考勤管理
     * @param startDate
     * @param endDate
     * @return
     * @throws Exception
     */
    @At
    @Ok("jsp:/jsp/oa/kqgl")
    public void kqglIndex(HttpServletRequest request) throws Exception {
    }

}
