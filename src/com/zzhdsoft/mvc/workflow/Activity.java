package com.zzhdsoft.mvc.workflow;

public class Activity {
	// <Activitie id="1" type="START_NODE" name="xxxx" xCoordinate="22"
	// yCoordinate="39" width="80" height="30"></Activitie>
	private String id;
	private String type;
	private String name;
	private String xCoordinate;
	private String yCoordinate;
	private String width;
	private String height;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getXCoordinate() {
		return xCoordinate;
	}

	public void setXCoordinate(String coordinate) {
		xCoordinate = coordinate;
	}

	public String getYCoordinate() {
		return yCoordinate;
	}

	public void setYCoordinate(String coordinate) {
		yCoordinate = coordinate;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

}
