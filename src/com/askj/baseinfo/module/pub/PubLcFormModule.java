package com.askj.baseinfo.module.pub;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;

/**
 *
 * PubLcFormModule：公文管理流程页面
 *
 * PubLcFormModule：
 *
 * Written by : sunyifeng
 */
@At("/pub/egovernment")
@IocBean
public class PubLcFormModule {
	protected final Logger logger = Logger.getLogger(PubLcFormModule.class);


	/**
	 *
	 * publishMainIndex：公文管理流程公共页面
	 *
	 * publishMainIndex：
	 * @param request
	 * @throws Exception
	 *        Written by : sunyifeng
	 */
	@At
	@Ok("jsp:/jsp/pub/egovernment/publicForm")
	public void publishMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	/**
	 *
	 * reviewMainIndex：公文管理流程核稿页面
	 *
	 * reviewMainIndex：
	 * @param request
	 * @throws Exception
	 *        Written by : sunyifeng
	 */
	@At
	@Ok("jsp:/jsp/pub/egovernment/reviewForm")
	public void reviewMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/swForm")
	public void swMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/swxtbeginForm")
	public void swxtbeginMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/swxtcyForm")
	public void swxtcyMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/swbeginForm")
	public void swbeginMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/swnbForm")
	public void swnbMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/swzynbForm")
	public void swzynbMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/swzypsForm")
	public void swzypsMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/swpsForm")
	public void swpsMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/swfbForm")
	public void swfbMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/swEndForm")
	public void swEndMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	/**
	 *
	 * fileMainIndex：公文管理流程归档页面
	 *
	 * fileMainIndex：
	 * @param request
	 * @throws Exception
	 *        Written by : sunyifeng
	 */
	@At
	@Ok("jsp:/jsp/pub/egovernment/fileForm")
	public void fileMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwngForm")
	public void fwngMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwcyForm")
	public void fwcyMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwhgForm")
	public void fwhgMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwqfForm")
	public void fwqfMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwqf1Form")
	public void fwqf1MainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwshForm")
	public void fwshMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwsh1Form")
	public void fwsh1MainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwsh2Form")
	public void fwsh2MainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	@At
	@Ok("jsp:/jsp/pub/egovernment/fwtyForm")
	public void fwtyMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	/**
	 *
	 * receiveMainIndex：公文管理流程收文页面
	 *
	 * receiveMainIndex：
	 * @param request
	 * @throws Exception
	 *        Written by : sunyifeng
	 */
	@At
	@Ok("jsp:/jsp/pub/egovernment/receiveForm")
	public void receiveMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	/**
	 *
	 * sendMainIndex：公文管理流程发文页面
	 *
	 * sendMainIndex：
	 * @param request
	 * @throws Exception
	 *        Written by : sunyifeng
	 */
	@At
	@Ok("jsp:/jsp/pub/egovernment/sendForm")
	public void sendMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/workForm")
	public void workIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/rwForm")
	public void rwIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	@At
	@Ok("jsp:/jsp/pub/egovernment/rwfqForm")
	public void rwfqIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}

	/**
	 *
	 * editMainIndex：公文管理流程拟文页面
	 *
	 * editMainIndex：
	 * @param request
	 * @throws Exception
	 *        Written by : sunyifeng
	 */
	@At
	@Ok("jsp:/jsp/pub/egovernment/editForm")
	public void editMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	/**
	 * 
	 * paperFormIndex中文含义:传阅界面
	 * paperFormIndex描述:
	 * @param request
	 * written  by  ：  lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/egovernment/paperForm")
	public void paperFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	

}
