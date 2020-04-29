package com.zzhdsoft.siweb.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * 
 * ComboboxDTO的中文名称：通用取下拉列表DTO
 *
 * ComboboxDTO的描述：
 *
 * @author ：zjf 
 * @version ：V1.0
 */
public class ComboboxDTO {
	/**
	 * @Description codevalue的中文含义是：代码值
	 */
	private String codevalue;

	/**
	 * @Description codename的中文含义是： 代码名称
	 */
	private String codename;

	public String getCodevalue() {
		return codevalue;
	}

	public void setCodevalue(String codevalue) {
		this.codevalue = codevalue;
	}

	public String getCodename() {
		return codename;
	}

	public void setCodename(String codename) {
		this.codename = codename;
	}	
}