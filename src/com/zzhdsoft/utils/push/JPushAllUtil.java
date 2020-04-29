package com.zzhdsoft.utils.push;

import java.util.ArrayList;
import java.util.List;

import cn.jpush.api.common.ClientConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.zzhdsoft.utils.SysmanageUtil;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Message;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.Notification;

/**
 * 极光推送工具类
 * 
 * @author why
 * 
 */
public class JPushAllUtil {
	protected static final Logger LOG = LoggerFactory
			.getLogger(JPushAllUtil.class);

	// private final static String appKey ="2e54238b91bcda4a0e312ea6";
	// private final static String masterSecret ="7e4b26428981a41a6e46d048";
	// 汤阴的极光key
	private static String appKey = "9c01e23c9f37402c33354e09";
	private static String masterSecret = "e8c08bb4f5e8e840cb8f0343";
	public static final String TITLE = "消息通知";
	public static final String ALERT = "消息通知";
	public static final String MSG_CONTENT = "location";
	public static final String REGISTRATION_ID = "0900e8d85ef";
	public static final String TAG = "tag_api";

	public static void main(String[] args) {
		List list = new ArrayList();
		list.add("0");
		// androidSendPush(list, null, null, null,null);
		androidSendMsgPushByalias(list, "0", "location");
	}

	// 获得相应的极光推送key
	public static void getappKeyAndmasterSecret() {
		appKey = SysmanageUtil.getAa01("APPKEY").getAaa005();
		masterSecret = SysmanageUtil.getAa01("MASTERSECRET").getAaa005();
	}

	/**
	 * 发给所有安装app应用的人(通知，app客户端收到后会显示在通知栏)
	 * 
	 * @param tags
	 *            标签
	 * @param alias
	 *            别名
	 * @param type
	 *            0:系统消息,1:个人消息
	 * @param alert
	 *            通知内容
	 * @param title
	 *            通知标题
	 */
	public static boolean androidAllSendAlertPush(String type, String alert,
			String title) {
		boolean sucess = true;
		StringBuffer str = null;
		ClientConfig clientConfig = ClientConfig.getInstance();
		// 获取极光相应的key
		getappKeyAndmasterSecret();
		// 很重要啊(客户端)
		JPushClient jpushClient = new JPushClient(masterSecret, appKey, null,
				clientConfig);
		// For push, all you need do is to build PushPayload object.
		PushPayload payload = sendAllAlert(alert);
		try {
			// 发送信息
			PushResult result = jpushClient.sendPush(payload);
			LOG.info("Got result - " + result);
		} catch (Exception e) {
			sucess = false;
			e.printStackTrace();
		}

		return sucess;
	}

	/**
	 * 发给所有安装app应用的人(静默发送，app客户端收到后不会显示在通知栏)
	 * 
	 * @param tags
	 *            标签
	 * @param alias
	 *            别名
	 * @param type
	 *            0:系统消息,1:个人消息
	 * @param msg
	 *            内容
	 * @param title
	 *            标题
	 */
	public static boolean androidAllSendMSgPush(String type, String msg) {
		boolean sucess = true;
		StringBuffer str = null;
		ClientConfig clientConfig = ClientConfig.getInstance();
		// 获取极光相应的key
		getappKeyAndmasterSecret();
		// 很重要啊(客户端)
		JPushClient jpushClient = new JPushClient(masterSecret, appKey, null,
				clientConfig);
		PushPayload payload = sendAllMsg(msg);
		try {
			// 发送信息
			PushResult result = jpushClient.sendPush(payload);
			LOG.info("Got result - " + result);
		} catch (Exception e) {
			sucess = false;
			e.printStackTrace();
		}

		return sucess;
	}

	/**
	 * 通过别名和标签给某些人发送消息
	 * 
	 * @param tags
	 *            标签
	 * @param alias
	 *            别名
	 * @param type
	 *            0:系统消息,1:个人消息
	 * @param alert
	 *            通知
	 * @param title
	 *            标题
	 */
	public static boolean androidSendPush(List<String> tags,
			List<String> alias, String type, String alert, String title) {
		boolean sucess = true;
		StringBuffer str = null;
		ClientConfig clientConfig = ClientConfig.getInstance();
		// 获取极光相应的key
		getappKeyAndmasterSecret();
		// 很重要啊(客户端)
		JPushClient jpushClient = new JPushClient(masterSecret, appKey, null,
				clientConfig);
		// For push, all you need do is to build PushPayload object.
		PushPayload payload = alertWithExtrasAndMessage(tags, alias, type,
				alert, title);
		try {
			// 发送信息
			PushResult result = jpushClient.sendPush(payload);
			LOG.info("Got result - " + result);
		} catch (Exception e) {
			sucess = false;
			e.printStackTrace();
		}

		return sucess;
	}

	/**
	 * 通过标签给某些人发送消息
	 * 
	 * @param tags
	 *            标签
	 * @param type
	 *            0:系统消息,1:个人消息
	 * @param alert
	 *            通知
	 * @param title
	 *            标题
	 */
	public static boolean androidSendPushBytags(List<String> tags, String type,
			String alert, String title) {
		boolean sucess = true;
		StringBuffer str = null;
		ClientConfig clientConfig = ClientConfig.getInstance();
		// 获取极光相应的key
		getappKeyAndmasterSecret();
		// 很重要啊(客户端)
		JPushClient jpushClient = new JPushClient(masterSecret, appKey, null,
				clientConfig);
		// For push, all you need do is to build PushPayload object.
		PushPayload payload = alertWithExtrasBytags(tags, type, alert, title);
		try {
			// 发送信息
			PushResult result = jpushClient.sendPush(payload);
			LOG.info("Got result - " + result);
		} catch (Exception e) {
			sucess = false;
			e.printStackTrace();
		}

		return sucess;
	}

	/**
	 * 通过别名给某些人发送消息
	 * 
	 * @param alias
	 *            别名
	 * @param type
	 *            0:系统消息,1:个人消息
	 * @param alert
	 *            通知
	 * @param title
	 *            标题
	 */
	public static boolean androidSendPushByalias(List<String> alias,
			String type, String alert, String title) {
		boolean sucess = true;
		StringBuffer str = null;
		ClientConfig clientConfig = ClientConfig.getInstance();
		// 获取极光相应的key
		getappKeyAndmasterSecret();
		// 很重要啊(客户端)
		JPushClient jpushClient = new JPushClient(masterSecret, appKey, null,
				clientConfig);
		// For push, all you need do is to build PushPayload object.
		PushPayload payload = alertWithExtrasByalias(alias, type, alert, title);
		try {
			// 发送信息
			PushResult result = jpushClient.sendPush(payload);
			LOG.info("Got result - " + result);
		} catch (Exception e) {
			sucess = false;
			e.printStackTrace();
		}

		return sucess;
	}

	/**
	 * 通过别名给某些人发送消息
	 * 
	 * @param alias
	 *            别名
	 * @param type
	 *            0:系统消息,1:个人消息
	 * @param msg
	 *            内容
	 */
	public static boolean androidSendMsgPushByalias(List<String> alias,
			String type, String msg) {
		boolean sucess = true;
		StringBuffer str = null;
		ClientConfig clientConfig = ClientConfig.getInstance();
		// 获取极光相应的key
		getappKeyAndmasterSecret();
		// 很重要啊(客户端)
		JPushClient jpushClient = new JPushClient(masterSecret, appKey, null,
				clientConfig);
		// For push, all you need do is to build PushPayload object.
		PushPayload payload = msgWithExtrasByalias(alias, type, msg);
		try {
			// 发送信息
			PushResult result = jpushClient.sendPush(payload);
			LOG.info("Got result - " + result);
		} catch (Exception e) {
			sucess = false;
			e.printStackTrace();
		}

		return sucess;
	}

	/**
	 * 发给所有安装app应用的人(静默发送，app客户端收到后不会显示在通知栏)
	 * 
	 * @return
	 */
	public static PushPayload sendAllMsg(String msg) {
		PushPayload pushPayload = null;
		try {
			pushPayload = PushPayload.messageAll(msg == null ? MSG_CONTENT
					: msg);
			LOG.info("Got result - " + pushPayload);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pushPayload;
	}

	/**
	 * 发给所有安装app应用的人(通知，app客户端收到后会显示在通知栏)
	 * 
	 * @return
	 */
	public static PushPayload sendAllAlert(String alert) {
		PushPayload pushPayload = null;
		try {
			pushPayload = PushPayload.alertAll(alert == null ? ALERT : alert);
			LOG.info("Got result - " + pushPayload);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pushPayload;
	}

	/**
	 * 构建推送对象：平台是 iOS，推送目标是 "tag1", "tag_all" 的交集，推送内容同时包括通知与消息 - 通知信息是 ALERT，
	 * 角标数字为 5，通知声音为 "happy"，并且附加字段 from = "JPush"；消息内容是 MSG_CONTENT。 通知是 APNs
	 * 推送通道的，消息是 JPush 应用内消息通道的。APNs 的推送环境是“生产”（如果不显式设置的话，Library 会默认指定为开发）
	 * 
	 * @return
	 */
	public static PushPayload alertWithExtrasBytags(List tags, String type,
			String alert, String title) {
		PushPayload pushPayload = null;
		if (tags == null || tags.size() == 0) {
			pushPayload = PushPayload.newBuilder()
					.setPlatform(Platform.android())
					// 手机端必须先设置标签，之后电脑才可以发送，不然报错
					// alter 通知消息,1位message 消息内容
					.setNotification(
							Notification
									.newBuilder()
									.addPlatformNotification(
											AndroidNotification
													.newBuilder()
													.setAlert(
															alert == null ? ALERT
																	: alert)
													.setTitle(
															title == null ? TITLE
																	: title)
													.addExtra(
															"type",
															type == null ? "0"
																	: type)// 0为系统消息，1:个人消息,2:视屏请求
													.build()).build()).build();
		} else {
			pushPayload = PushPayload.newBuilder()
					.setPlatform(Platform.android())
					// 手机端必须先设置标签，之后电脑才可以发送，不然报错
					// alter 通知消息,1位message 消息内容
					.setAudience(Audience.tag(tags))
					// 标签
					.setNotification(
							Notification
									.newBuilder()
									.addPlatformNotification(
											AndroidNotification
													.newBuilder()
													.setAlert(
															alert == null ? ALERT
																	: alert)
													.setTitle(
															title == null ? TITLE
																	: title)
													.addExtra(
															"type",
															type == null ? "0"
																	: type)
													.build()).build()).build();
		}
		return pushPayload;
	}

	/**
	 * 构建推送对象：平台是 iOS，推送目标是 "tag1", "tag_all" 的交集，推送内容同时包括通知与消息 - 通知信息是 ALERT，
	 * 角标数字为 5，通知声音为 "happy"，并且附加字段 from = "JPush"；消息内容是 MSG_CONTENT。 通知是 APNs
	 * 推送通道的，消息是 JPush 应用内消息通道的。APNs 的推送环境是“生产”（如果不显式设置的话，Library 会默认指定为开发）
	 * 
	 * @return
	 */
	public static PushPayload alertWithExtrasByalias(List alias, String type,
			String alert, String title) {
		PushPayload pushPayload = null;
		if (alias == null || alias.size() == 0) {
			pushPayload = PushPayload.newBuilder()
					.setPlatform(Platform.android())
					// 手机端必须先设置标签，之后电脑才可以发送，不然报错
					// alter 通知消息,1位message 消息内容
					.setNotification(
							Notification
									.newBuilder()
									.addPlatformNotification(
											AndroidNotification
													.newBuilder()
													.setAlert(
															alert == null ? ALERT
																	: alert)
													.setTitle(
															title == null ? TITLE
																	: title)
													.addExtra(
															"type",
															type == null ? "0"
																	: type)// 0为系统消息，1:个人消息,2:视屏请求
													.build()).build()).build();
		} else {
			pushPayload = PushPayload.newBuilder()
					.setPlatform(Platform.android())
					// 手机端必须先设置标签，之后电脑才可以发送，不然报错
					// alter 通知消息,1位message 消息内容
					.setAudience(Audience.alias(alias))
					// 标签
					.setNotification(
							Notification
									.newBuilder()
									.addPlatformNotification(
											AndroidNotification
													.newBuilder()
													.setAlert(
															alert == null ? ALERT
																	: alert)
													.setTitle(
															title == null ? TITLE
																	: title)
													.addExtra(
															"type",
															type == null ? "0"
																	: type)// 0为系统消息，1:个人消息,2:视屏请求
													.build()).build()).build();

		}
		return pushPayload;
	}

	/**
	 * 构建推送对象：平台是 iOS，推送目标是 "tag1", "tag_all" 的交集，推送内容同时包括通知与消息 - 通知信息是 ALERT，
	 * 角标数字为 5，通知声音为 "happy"，并且附加字段 from = "JPush"；消息内容是 MSG_CONTENT。 通知是 APNs
	 * 推送通道的，消息是 JPush 应用内消息通道的。APNs 的推送环境是“生产”（如果不显式设置的话，Library 会默认指定为开发）
	 * 
	 * @return
	 */
	public static PushPayload msgWithExtrasByalias(List alias, String type,
			String msg) {
		PushPayload pushPayload = null;
		if (alias == null || alias.size() == 0) {
			pushPayload = PushPayload.newBuilder()
					.setPlatform(Platform.android())
					// 手机端必须先设置标签，之后电脑才可以发送，不然报错
					// alter 通知消息,1位message 消息内容
					.setMessage(
							Message.newBuilder()
									.setMsgContent(
											msg == null ? MSG_CONTENT : msg)
									// .addExtra("type", "0")
									.build()).build();
		} else {
			pushPayload = PushPayload.newBuilder()
					.setPlatform(Platform.android())
					// 手机端必须先设置标签，之后电脑才可以发送，不然报错
					// alter 通知消息,1位message 消息内容
					.setAudience(Audience.alias(alias))// 标签
					.setMessage(
							Message.newBuilder()
									.setMsgContent(
											msg == null ? MSG_CONTENT : msg)
									// .addExtra("type", type)
									.build()).build();

		}
		return pushPayload;
	}

	/**
	 * 构建推送对象：平台是 iOS，推送目标是 "tag1", "tag_all" 的交集，推送内容同时包括通知与消息 - 通知信息是 ALERT，
	 * 角标数字为 5，通知声音为 "happy"，并且附加字段 from = "JPush"；消息内容是 MSG_CONTENT。 通知是 APNs
	 * 推送通道的，消息是 JPush 应用内消息通道的。APNs 的推送环境是“生产”（如果不显式设置的话，Library 会默认指定为开发）
	 * 
	 * @return
	 */
	public static PushPayload alertWithExtrasAndMessage(List tags, List alias,
			String type, String alert, String title) {
		PushPayload pushPayload = null;
		pushPayload = PushPayload.newBuilder().setPlatform(Platform.android())
		// 手机端必须先设置标签，之后电脑才可以发送，不然报错
		// alter 通知消息,1位message 消息内容
				.setAudience(Audience.tag(tags))// 标签
				.setAudience(Audience.alias(alias))
				// 别名
				.setNotification(
						Notification
								.newBuilder()
								.addPlatformNotification(
										AndroidNotification
												.newBuilder()
												.setAlert(
														alert == null ? ALERT
																: alert)
												.setTitle(
														title == null ? TITLE
																: title)
												.addExtra(
														"type",
														type == null ? "0"
																: type)// 0为系统消息，1:个人消息,2:视屏请求
												.build()).build()).build();
		return pushPayload;
	}

}