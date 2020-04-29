package com.zzhdsoft.mvc.workflow;

public class Transition {
	// <Transition id="8" name="请假发起" from="1" to="2"></Transition>
	private String id;
	private String name;
	private String from;
	private String to;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

}
