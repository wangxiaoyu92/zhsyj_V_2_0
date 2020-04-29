package com.askj.zx.dto;


/**
 * @Description  ZXBUSINESSCODE的中文含义是: 征集系统业务编码（用于建立业务参数级别树）; InnoDB free: 28672 kBDTO
 * @Creation     2016/01/20 08:42:48
 * @Written      Create Tool By zjf 
 **/
public class ZxbusinesscodeDTO {
	/**
	 * @Description bcid的中文含义是： ID
	 */
	private Integer bcid;

	/**
	 * @Description bccode的中文含义是： 编码
	 */
	private String bccode;

	/**
	 * @Description bcname的中文含义是： 名称
	 */
	private String bcname;

	/**
	 * @Description bcparentcode的中文含义是： 父节点编码
	 */
	private String bcparentcode;

	/**
	 * @Description bclevel的中文含义是： 级别，1：子系统；2：业务；3：项目；4：级别
	 */
	private String bclevel;

	/**
	 * @Description bcpublicity的中文含义是： 是否作为公示选项。 0:不公示；1：公示
	 */
	private String bcpublicity;

	/**
	 * @Description bctreecode的中文含义是： 树编码 子系统、业务、项目、级别，均是二位。如01010101,代表一个系统一个业务一个项目一个级别。
	 */
	private String bctreecode;

	/**
	 * @Description bcenable的中文含义是： 是否启用 0：不启用。1：启用
	 */
	private String bcenable;

	
		/**
	 * @Description bcid的中文含义是： ID
	 */
	public void setBcid(Integer bcid){ 
		this.bcid = bcid;
	}
	/**
	 * @Description bcid的中文含义是： ID
	 */
	public Integer getBcid(){
		return bcid;
	}
	/**
	 * @Description bccode的中文含义是： 编码
	 */
	public void setBccode(String bccode){ 
		this.bccode = bccode;
	}
	/**
	 * @Description bccode的中文含义是： 编码
	 */
	public String getBccode(){
		return bccode;
	}
	/**
	 * @Description bcname的中文含义是： 名称
	 */
	public void setBcname(String bcname){ 
		this.bcname = bcname;
	}
	/**
	 * @Description bcname的中文含义是： 名称
	 */
	public String getBcname(){
		return bcname;
	}
	/**
	 * @Description bcparentcode的中文含义是： 父节点编码
	 */
	public void setBcparentcode(String bcparentcode){ 
		this.bcparentcode = bcparentcode;
	}
	/**
	 * @Description bcparentcode的中文含义是： 父节点编码
	 */
	public String getBcparentcode(){
		return bcparentcode;
	}
	/**
	 * @Description bclevel的中文含义是： 级别，1：子系统；2：业务；3：项目；4：级别
	 */
	public void setBclevel(String bclevel){ 
		this.bclevel = bclevel;
	}
	/**
	 * @Description bclevel的中文含义是： 级别，1：子系统；2：业务；3：项目；4：级别
	 */
	public String getBclevel(){
		return bclevel;
	}
	/**
	 * @Description bcpublicity的中文含义是： 是否作为公示选项。 0:不公示；1：公示
	 */
	public void setBcpublicity(String bcpublicity){ 
		this.bcpublicity = bcpublicity;
	}
	/**
	 * @Description bcpublicity的中文含义是： 是否作为公示选项。 0:不公示；1：公示
	 */
	public String getBcpublicity(){
		return bcpublicity;
	}
	/**
	 * @Description bctreecode的中文含义是： 树编码 子系统、业务、项目、级别，均是二位。如01010101,代表一个系统一个业务一个项目一个级别。
	 */
	public void setBctreecode(String bctreecode){ 
		this.bctreecode = bctreecode;
	}
	/**
	 * @Description bctreecode的中文含义是： 树编码 子系统、业务、项目、级别，均是二位。如01010101,代表一个系统一个业务一个项目一个级别。
	 */
	public String getBctreecode(){
		return bctreecode;
	}
	/**
	 * @Description bcenable的中文含义是： 是否启用 0：不启用。1：启用
	 */
	public void setBcenable(String bcenable){ 
		this.bcenable = bcenable;
	}
	/**
	 * @Description bcenable的中文含义是： 是否启用 0：不启用。1：启用
	 */
	public String getBcenable(){
		return bcenable;
	}

	
}