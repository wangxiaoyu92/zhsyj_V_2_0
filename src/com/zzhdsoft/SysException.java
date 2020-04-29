package com.zzhdsoft;

/**
 * 
 * SysException的中文名称：框架级异常
 * 
 * SysException的描述：
 * 
 * Written by : zjf
 */
public class SysException extends RuntimeException implements IPublished {

	private static final long serialVersionUID = 8390063195293969391L;

	public SysException() {
	}

	public SysException(String s) {
		super(s);
	}

	public SysException(String s, Throwable throwable) {
		super(s, throwable);
	}

	public SysException(Throwable throwable) {
		super(throwable);
	}
}
