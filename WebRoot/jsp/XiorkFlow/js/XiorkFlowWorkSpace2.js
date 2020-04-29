//zjf add
function getRootPath() { 
	//获取当前网址，如： http://localhost:8088/test/test.jsp
	var curPath = window.document.location.href;
	//alert(curPath);
	//获取主机地址之后的目录，如： test/test.jsp
	var pathName = window.document.location.pathname;
	//alert(pathName);
	var pos = curPath.indexOf(pathName); 
	//获取主机地址，如： http://localhost:8088
	var localhostPath = curPath.substring(0, pos);
	//alert(localhostPath);
	//获取带"/"的项目名，如：/test
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	var realPath = localhostPath + projectName; 
	//alert(realPath);
	return realPath;
}
//获取当前网址，如： http://localhost:8088/test/test.jsp
var curPath = window.document.location.href;
//alert(curPath); 
//获取主机地址之后的目录，如： test/test.jsp
var pathName = window.document.location.pathname; 
//alert(pathName); 
var pos = curPath.indexOf(pathName); 
//获取主机地址，如： http://localhost:8088/
var localhostPath = curPath.substring(0, pos);
//alert(localhostPath); 
//获取项目名，如：test
var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
//alert(projectName); 

//zjf add
AskjXiorkFlowWorkSpace.realPath = localhostPath + projectName;

//
/**
 * XiorkFlow工作空间，包括建立工作空间所需要的资源。
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */

//
/**
 * XiorkFlow的工作空间
 */
function AskjXiorkFlowWorkSpace() {
}

//
AskjXiorkFlowWorkSpace.BASE_PATH = projectName + "/";
//alert(AskjXiorkFlowWorkSpace.BASE_PATH);
//alert( AskjXiorkFlowWorkSpace.BASE_PATH)
//
AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH = AskjXiorkFlowWorkSpace.BASE_PATH + "jsp/XiorkFlow/";
//alert(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH)
//
AskjXiorkFlowWorkSpace.DEFAULT_PROCESS_NAME = "default";

//
//AskjXiorkFlowWorkSpace.URL_ADD_PROCESS = AskjXiorkFlowWorkSpace.BASE_PATH + "addprocess.xf";
//AskjXiorkFlowWorkSpace.URL_DELETE_PROCESS = AskjXiorkFlowWorkSpace.BASE_PATH + "deleteprocess.xf";
//AskjXiorkFlowWorkSpace.URL_GET_PROCESS = AskjXiorkFlowWorkSpace.BASE_PATH + "getprocess.xf";
//AskjXiorkFlowWorkSpace.URL_LIST_PROCESS = AskjXiorkFlowWorkSpace.BASE_PATH + "listprocess.xf";
//AskjXiorkFlowWorkSpace.URL_UPDATE_PROCESS = AskjXiorkFlowWorkSpace.BASE_PATH + "updateprocess.xf";

AskjXiorkFlowWorkSpace.URL_ADD_PROCESS = AskjXiorkFlowWorkSpace.realPath + "/workflow/addWfprocess";
AskjXiorkFlowWorkSpace.URL_DELETE_PROCESS = AskjXiorkFlowWorkSpace.realPath + "/workflow/delWfprocess";
AskjXiorkFlowWorkSpace.URL_UPDATE_PROCESS = AskjXiorkFlowWorkSpace.realPath + "/workflow/updateWfprocess";
AskjXiorkFlowWorkSpace.URL_GET_PROCESS = AskjXiorkFlowWorkSpace.realPath + "/workflow/getWfprocess";
AskjXiorkFlowWorkSpace.URL_LIST_PROCESS = AskjXiorkFlowWorkSpace.realPath + "/workflow/wf_listprocess";

//
AskjXiorkFlowWorkSpace.STATUS_NULL = -1;
AskjXiorkFlowWorkSpace.STATUS_SUCCESS = 0;
AskjXiorkFlowWorkSpace.STATUS_FAIL = 1;
AskjXiorkFlowWorkSpace.STATUS_FILE_EXIST = 3;
AskjXiorkFlowWorkSpace.STATUS_FILE_NOT_FOUND = 5;
AskjXiorkFlowWorkSpace.STATUS_XML_PARSER_ERROR = 7;
AskjXiorkFlowWorkSpace.STATUS_IO_ERROR = 9;

//
AskjXiorkFlowWorkSpace.ID = 1;

//
AskjXiorkFlowWorkSpace.META_NODE_MOVED_STEP_TIME = 100;
AskjXiorkFlowWorkSpace.META_NODE_MOVED_STEP = 1;

//
AskjXiorkFlowWorkSpace.META_NODE_MAX = 100;

//
AskjXiorkFlowWorkSpace.META_NODE_MIN_WIDTH = 80;
AskjXiorkFlowWorkSpace.META_NODE_MIN_HEIGHT = 30;

//
/**
 * 建立工作空间
 */
AskjXiorkFlowWorkSpace.build = function () {
 	//引入所需要的资源，资源加载顺序不能更改

	//name.xio.util
    alert(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/util/Message.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/util/Message.js");
    return;
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/util/Array.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/util/String.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/util/List.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/util/Observable.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/util/Observer.js");

	//name.xio.geom
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/geom/Point.js");

	//name.xio.html
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/html/Toolkit.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/html/Browser.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/html/Cursor.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/html/MouseEvent.js");

	//name.xio.xml
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xml/XMLDocument.js");

	//name.xio.ajax
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ajax/Ajax.js");

	//name.xio.ui.event
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/event/KeyListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/event/MouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/event/MouseWheelListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/event/ContextMenuListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/event/ListenerProxy.js");

	//name.xio.ui
    BuildLibrary.loadCSS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/ui.css");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/Dimension.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/Component.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/Button.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/ButtonModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/ToggleButton.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/ToggleButtonModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/ButtonGroup.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/ToolBar.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/Panel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/ScrollPanel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/Label.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/ui/Frame.js");

	//name.xio.geom.ui
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/geom/ui/GeometryCanvas.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/geom/ui/LineView.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/geom/ui/LineTextView.js");

    //name.xio.xiorkflow.meta.event
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/event/MetaNodeMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/event/MetaNodeTextMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/event/MetaNodeTextKeyListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/event/TransitionMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/event/MetaNodeResizeMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/event/TransitionTextMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/event/TransitionTextKeyListener.js");

    //name.xio.xiorkflow.meta
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/DragablePanel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/MetaModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/MetaNodeModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/MetaNode.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/StartNodeModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/StartNode.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/EndNodeModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/EndNode.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/NodeModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/Node.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/ForkNodeModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/ForkNode.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/JoinNodeModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/JoinNode.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/TransitionCompass.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/TransitionModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/meta/Transition.js");

    //name.xio.xiorkflow.event
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/WrapperMetaMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/WrapperSelectMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/MetaMoveMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/MetaMoveKeyListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/WrapperTransitionMouseListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/DeleteMetaActionListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/SaveActionListener.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/event/HelpActionListener.js");

    //name.xio.xiorkflow.process
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/process/AddProcess.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/process/GetProcess.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/process/UpdateProcess.js");

    //name.xio.xiorkflow
    BuildLibrary.loadCSS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/xiorkflow.css");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowToolBar.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/StateMonitor.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/TransitionMonitor.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowViewer.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowTableViewer.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowXMLViewer.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/StatusLabel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowModel.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowModelConverter.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlow.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowWrapper.js");
    BuildLibrary.loadJS(AskjXiorkFlowWorkSpace.XIORK_FLOW_PATH + "src/name/xio/xiorkflow/XiorkFlowViewPattern.js");
};

//
/**
 * 资源加载
 */
function BuildLibrary() {
}
BuildLibrary.loadJS = function (url, charset) {
    if (!charset) {
        charset = "UTF-8";
    }
    alert(url);

    var charsetProperty = " charset=\"" + charset + "\" ";
    document.write("<script type=\"text/javascript\" src=\"" + url + "\" onerror=\"alert('Error loading ' + this.src);\"" + charsetProperty + "></script>");
};
BuildLibrary.loadCSS = function (url, charset) {
    if (!charset) {
        charset = "UTF-8";
    }
    var charsetProperty = " charset=\"" + charset + "\" ";
    document.write("<link href=\"" + url + "\" type=\"text/css\" rel=\"stylesheet\" onerror=\"alert('Error loading ' + this.src);\"" + charsetProperty + "/>");
};