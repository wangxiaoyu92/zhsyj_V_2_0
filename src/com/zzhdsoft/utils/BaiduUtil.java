package com.zzhdsoft.utils;

import java.util.HashMap;
import java.util.Map;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import net.sf.json.JSONObject;

/**
 * 
 * BaiduUtil的中文名称：百度地图工具类
 * 
 * BaiduUtil的描述：
 * 
 * Written by : zjf
 */
public class BaiduUtil {
	/**
	 * 
	 * getMapLngAndLat的中文名称：根据地址获取经纬度
	 * 
	 * getMapLngAndLat的概要说明：
	 * 
	 * @param address
	 * @return Written by : zjf
	 * 
	 */
	public static Map getMapLngAndLat(String address) {
		Map<String, Double> map = new HashMap<String, Double>();
		String url = "http://api.map.baidu.com/geocoder/v2/?address=" + address
				+ "&output=json&ak=8uuSXXYnn0z3braHxNkpCAxr";
		String json = loadJSON(url);
		JSONObject obj = JSONObject.fromObject(json);
		if (obj.get("status").toString().equals("0")) {
			double lng = obj.getJSONObject("result").getJSONObject("location")
					.getDouble("lng");
			double lat = obj.getJSONObject("result").getJSONObject("location")
					.getDouble("lat");
			map.put("lng", lng);
			map.put("lat", lat);
			// System.out.println("经度："+lng+"---纬度："+lat);
		} else {
			// System.out.println("未找到相匹配的经纬度！");
		}
		return map;
	}

	/**
	 * 
	 * getMapAddress的中文名称：根据经纬度获取地址
	 * 
	 * getMapAddress的概要说明：
	 * 
	 * @param Lng
	 * @param Lat
	 * @return Written by : zjf
	 * 
	 */
	public static Map<String, String> getMapAddress(String Lng, String Lat) {
		Map<String, String> map = new HashMap<String, String>();
		String location = Lat + "," + Lng;
		String url = "http://api.map.baidu.com/geocoder/v2/?location="
				+ location + "&output=json&ak=8uuSXXYnn0z3braHxNkpCAxr";
		String json = loadJSON(url);
		JSONObject obj = JSONObject.fromObject(json);
		if (obj.get("status").toString().equals("0")) {
			String address = obj.getJSONObject("result").getString(
					"formatted_address");
			map.put("address", address);
		} else {
			// System.out.println("未找到相匹配的地址！");
		}
		return map;
	}

	public static String loadJSON(String url) {
		StringBuilder json = new StringBuilder();
		try {
			URL oracle = new URL(url);
			URLConnection yc = oracle.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(yc
					.getInputStream()));
			String inputLine = null;
			while ((inputLine = in.readLine()) != null) {
				json.append(inputLine);
			}
			in.close();
		} catch (MalformedURLException e) {
		} catch (IOException e) {
		}
		return json.toString();
	}

	private static double EARTH_RADIUS = 6378.137;

	private static double rad(double d) {
		return d * Math.PI / 180.0;
	}

	/**
	 * 
	 * getDistance的中文名称：根据两个位置的经纬度，来计算两地的距离（单位为KM）
	 * 
	 * getDistance的概要说明：
	 * 
	 * @param lng1Str
	 * @param lat1Str
	 * @param lng2Str
	 * @param lat2Str
	 * @return Written by : zjf
	 * 
	 */
	public static String getDistance(String lng1Str, String lat1Str,
			String lng2Str, String lat2Str) {
		Double lng1 = Double.parseDouble(lng1Str);
		Double lat1 = Double.parseDouble(lat1Str);
		Double lng2 = Double.parseDouble(lng2Str);
		Double lat2 = Double.parseDouble(lat2Str);

		double radLat1 = rad(lat1);
		double radLat2 = rad(lat2);
		double difference = radLat1 - radLat2;
		double mdifference = rad(lng1) - rad(lng2);
		double distance = 2 * Math.asin(Math.sqrt(Math.pow(Math
				.sin(difference / 2), 2)
				+ Math.cos(radLat1)
				* Math.cos(radLat2)
				* Math.pow(Math.sin(mdifference / 2), 2)));
		distance = distance * EARTH_RADIUS;
		distance = Math.round(distance * 10000) / 10000;
		String distanceStr = distance + "";
		distanceStr = distanceStr.substring(0, distanceStr.indexOf("."));

		return distanceStr;
	}

	/**
	 * 
	 * getAround的中文名称：获取当前用户一定距离以内的经纬度值
	 * 
	 * getAround的概要说明：minLat 最小经度 minLng 最小纬度 maxLat 最大经度 maxLng 最大纬度 minLat
	 * 
	 * @param latStr
	 * @param lngStr
	 * @param raidus
	 *            单位米
	 * @return Written by : zjf
	 * 
	 */
	public static Map getAround(String lngStr, String latStr, String raidus) {
		Map map = new HashMap();

		Double longitude = Double.parseDouble(lngStr);// 传值给经度
		Double latitude = Double.parseDouble(latStr);// 传值给纬度

		Double degree = (24901 * 1609) / 360.0; // 获取每度
		double raidusMile = Double.parseDouble(raidus);

		Double mpdLng = Double.parseDouble((degree
				* Math.cos(latitude * (Math.PI / 180)) + "").replace("-", ""));
		Double dpmLng = 1 / mpdLng;
		Double radiusLng = dpmLng * raidusMile;
		// 获取最小经度
		Double minLng = longitude - radiusLng;
		// 获取最大经度
		Double maxLng = longitude + radiusLng;

		Double dpmLat = 1 / degree;
		Double radiusLat = dpmLat * raidusMile;
		// 获取最小纬度
		Double minLat = latitude - radiusLat;
		// 获取最大纬度
		Double maxLat = latitude + radiusLat;

		map.put("minLng", minLng + "");
		map.put("maxLng", maxLng + "");
		map.put("minLat", minLat + "");
		map.put("maxLat", maxLat + "");

		return map;
	}

	/**
	 * 测试方法
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		Map<String, Double> map = BaiduUtil.getMapLngAndLat("汤阴县汤河北");
		System.out.println("经度：" + map.get("lng") + "---纬度：" + map.get("lat"));

		Map<String, String> map2 = BaiduUtil.getMapAddress("114.02356",
				"32.968117");
		System.out.println("地址：" + map2.get("address"));

		String distance = getDistance("117.11811", "36.68484",
				"117.00999000000002", "36.66123");
		System.out.println(distance);

		// 济南国际会展中心经纬度：117.11811 36.68484
		// 趵突泉：117.00999000000002 36.66123
		System.out.println(getDistance("117.11811", "36.68484", "114.076401",
				"32.967014"));

		System.out.println(getAround("117.11811", "36.68484", "13000"));
		// 117.01028712333508(Double), 117.22593287666493(Double),
		// 36.44829619896034(Double), 36.92138380103966(Double)
	}
}
