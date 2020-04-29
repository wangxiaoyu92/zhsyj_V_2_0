package com.zzhdsoft.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;
import java.util.ResourceBundle;

public class ConfigUtil {
	private static Object lock = new Object();
	private static Properties props;
	private static ConfigUtil config = null;
	private static String configfile = null;

	/**
	 * 采用静态方法
	 */
	public static ConfigUtil getInstance(String config_file) {
		synchronized (lock) {
			if (config == null || !configfile.equals(config_file)) {
				configfile = config_file;
				props = new Properties();
				try {
					props.load(new FileInputStream(config_file));
					config = new ConfigUtil();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
					System.exit(-1);
				} catch (IOException e) {
					System.exit(-1);
				}
			}
		}
		return config;
	}

	/**
	 * 读取属性文件中相应键的值
	 */
	public String getKeyValue(String key) {
		return props.getProperty(key);
	}

	/**
	 * 更新（或插入）一对properties信息(主键及其键值) 如果该主键已经存在，更新该主键的值； 如果该主键不存在，则插件一对键值。
	 * 
	 * @param keyname
	 *            键名
	 * @param keyvalue
	 *            键值
	 */
	public void writeProperties(String keyname, String keyvalue) {
		try {
			OutputStream fos = new FileOutputStream(configfile);
			props.setProperty(keyname, keyvalue);
			props.store(fos, "Update '" + keyname + "' value");
		} catch (IOException e) {
			System.err.println("属性文件更新错误");
		}
	}

	public static String getValue(String config_file, String key) {
		return (ResourceBundle.getBundle(config_file).getString(key));
	}

}
