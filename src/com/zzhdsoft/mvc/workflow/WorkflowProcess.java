package com.zzhdsoft.mvc.workflow;

import java.util.List;

public class WorkflowProcess {
	private List<Activity> activityList;
	private List<Transition> transitionList;

	public List<Activity> getActivityList() {
		return activityList;
	}

	public void setActivityList(List<Activity> activityList) {
		this.activityList = activityList;
	}

	public List<Transition> getTransitionList() {
		return transitionList;
	}

	public void setTransitionList(List<Transition> transitionList) {
		this.transitionList = transitionList;
	}

}
