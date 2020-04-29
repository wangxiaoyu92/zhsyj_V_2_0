package com.zzhdsoft.utils.covert;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * VideoUtil的中文名称：视频文件转换工具
 *
 * VideoUtil的描述：支持文件类型(asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等 wmv9，rm，rmvb等)
 *
 * Written by : sunyifeng at 2017-04-19
 */
public class VideoUtil {

	private static String FILE_NAME = "";     // 文件名
	private static String INPUT_PATH = "";    // 文件输入路径
	public static String OUTPUT_PATH = "";    // 文件输出路径
	// exe存放路径
	private static final String EXE_DIR_PATH = VideoUtil.class.getResource("/")
			.toString().substring(VideoUtil.class.getResource("/").toString().indexOf(":") + 2).replaceAll("%20", " ")
			+ "com//zzhdsoft//utils//covert//exe//";

    /**
     *
     * process的中文名称：转换处理方法
     *
     * process的概要说明:
     *     <p>
     *         先检查文件类型，如果是ffmpeg支持的直接转换flv
     *         否则先转换为avi，再转换为flv
     *     </p>
     *
     * @return boolean
     * @throws IOException
     * Written by : sunyifeng at 2017-04-19
     *
     */
	private static boolean process() throws IOException  {
		int type = checkContentType(); // 检测文件类型
		boolean status = false;
		if (type == 0) {
			System.out.println("直接将文件转为flv文件");
			status = processFLV(INPUT_PATH + FILE_NAME); // 直接将文件转为flv文件
		} else if (type == 1) { // 对于不支持类型，首先转为avi
			String avifilepath = processAVI();
			if (avifilepath == null)
				return false; // avi文件没有得到
			status = processFLV(avifilepath);// 将avi转为flv
		}
		return status;
	}

    /**
     *
     * checkContentType的中文名称：检查文件类型
     *
     * checkContentType的概要说明：
     *
     * @return int
     * Written by : sunyifeng at 2017-04-19
     *
     */
	private static int checkContentType() {
		String type = FILE_NAME.substring(FILE_NAME.lastIndexOf(".") + 1,
				FILE_NAME.length()).toLowerCase();
		// ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）
		if (type.equals("avi")) {
			return 0;
		} else if (type.equals("mpg")) {
			return 0;
		} else if (type.equals("wmv")) {
			return 0;
		} else if (type.equals("3gp")) {
			return 0;
		} else if (type.equals("mov")) {
			return 0;
		} else if (type.equals("mp4")) {
			return 0;
		} else if (type.equals("asf")) {
			return 0;
		} else if (type.equals("asx")) {
			return 0;
		} else if (type.equals("flv")) {
			return 0;
		}
		// 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等),
		// 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.
		else if (type.equals("wmv9")) {
			return 1;
		} else if (type.equals("rm")) {
			return 1;
		} else if (type.equals("rmvb")) {
			return 1;
		}
		return 9;
	}

    /**
     *
     * checkfile的中文名称：检查文件是否存在
     *
     * checkfile的概要说明:
     *
     * @param path 被检查文件路径
     *
     * @return boolean
     * Written by : sunyifeng at 2017-04-19
     *
     */
	private static boolean checkfile(String path) {
		File file = new File(path);
		return file.isFile();
	}

    /**
     *
     * processAVI的中文名称：处理avi视频文件
     *
     * processAVI的概要说明:
     *   <p>对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等), 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.</p>
     *
     * @return String
     * @throws IOException
     * Written by : sunyifeng at 2017-04-19
     *
     */
	private static String processAVI()  throws IOException  {
		List<String> commend = new ArrayList<String>();
		commend.add(EXE_DIR_PATH + "mencoder");
		commend.add(INPUT_PATH + FILE_NAME);
		commend.add("-oac");
		commend.add("lavc");
		commend.add("-lavcopts");
		commend.add("acodec=mp3:abitrate=64");
		commend.add("-ovc");
		commend.add("xvid");
		commend.add("-xvidencopts");
		commend.add("bitrate=600");
		commend.add("-of");
		commend.add("avi");
		commend.add("-o");
		commend.add(OUTPUT_PATH + FILE_NAME.split("\\.")[0] + ".avi");

        ProcessBuilder builder = new ProcessBuilder();
        builder.command(commend);
        builder.start();
        return OUTPUT_PATH + FILE_NAME.split("\\.")[0] + ".avi";
	}

    /**
     *
     * processFLV的中文名称：处理avi视频文件
     *
     * processFLV的概要说明:
     *      <p>ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）.</p>
     * @param filepath 视频文件路径
     *
     * @return boolean
     * @throws IOException
     * Written by : sunyifeng at 2017-04-19
     *
     */
	private static boolean processFLV(String filepath)  throws IOException {
		if (!checkfile(filepath)) {
			System.out.println(filepath + " is not file");
			return false;
		}

		// 文件命名
		List<String> command = new ArrayList<String>();
		command.add(EXE_DIR_PATH + "ffmpeg");
		command.add("-i");
		command.add(filepath);
		command.add("-ab");
		command.add("56");
		command.add("-ar");
		command.add("22050");
		command.add("-qscale");
		command.add("8");
		command.add("-r");
		command.add("15");
		command.add("-s");
		command.add("600x500");
		command.add(OUTPUT_PATH + FILE_NAME.split("\\.")[0] + ".flv");

        String cmd = "";
        String cut = EXE_DIR_PATH
                + "ffmpeg.exe   -i   " + filepath
                + "   -y   -f   image2   -ss   8   -t   0.001   -s   600x500   "
                + OUTPUT_PATH + FILE_NAME.split("\\.")[0] + ".jpg";
        String cutCmd = cmd + cut;
		System.out.println("视频截取图片开始..."+ System.currentTimeMillis());
		File file = new File(OUTPUT_PATH + FILE_NAME.split("\\.")[0] + ".jpg");
		if(file.exists()){
			file.delete();
		}
		Process process = Runtime.getRuntime().exec(cutCmd);
		// 获取进程的标准输入流
		final InputStream inputStream = process.getInputStream();
		// 获取进城的错误流
		final InputStream errorStream = process.getErrorStream();
		// 启动两个线程，一个线程负责读标准输出流，另一个负责读标准错误流
		new ResetThread(inputStream).start();
		new ResetThread(errorStream).start();

		try {
			process.waitFor();
			process.destroy();
			System.out.println("视频截取图片结束..."+ System.currentTimeMillis());
		} catch (InterruptedException e) {
			process.getErrorStream().close();
			process.getInputStream().close();
			process.getOutputStream().close();
		}

		StringBuffer cmdBuffer = new StringBuffer("");
		for(String cmdItem : command){
			cmdBuffer.append(cmdItem).append(" ");
		}
		cmdBuffer.deleteCharAt(cmdBuffer.length() - 1);

		System.out.println("视频转换开始..." + System.currentTimeMillis());
		file = new File(OUTPUT_PATH + FILE_NAME.split("\\.")[0] + ".flv");
		if(file.exists()){
			file.delete();
		}
		Process process2 = Runtime.getRuntime().exec(cmdBuffer.toString());
		// 获取进程的标准输入流
		final InputStream inputStream2 = process2.getInputStream();
		// 获取进城的错误流
		final InputStream errorStream2 = process2.getErrorStream();
		// 启动两个线程，一个线程负责读标准输出流，另一个负责读标准错误流
		new ResetThread(inputStream2).start();
		new ResetThread(errorStream2).start();

		try {
			process2.waitFor();
			process2.destroy();
			System.out.println("视频转换结束..."+ System.currentTimeMillis());
		} catch (InterruptedException e) {
			process2.getErrorStream().close();
			process2.getInputStream().close();
			process2.getOutputStream().close();
		}
        return true;
	}

    /**
     *
     * convert的中文名称：转换视频文件
     *
     * convert的概要说明:
     *      <p>ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv, wmv9 ， rm，rmvb .</p>
     * @param filePath 视频文件路径
     *
     * @throws IOException
     * Written by : sunyifeng at 2017-04-19
     *
     */
    public static void convert(String filePath)  throws IOException  {
		FILE_NAME = filePath
				.substring(filePath.lastIndexOf(File.separator) + 1);
		INPUT_PATH = filePath.substring(0,
				filePath.lastIndexOf(File.separator) + 1);
		if (!checkfile(INPUT_PATH + FILE_NAME)) {
			System.out.println(INPUT_PATH + FILE_NAME + " is not file");
			return;
		}
		if (process()) {
			System.out.println("ok");
		}
	}

    /**
     *
     * main的中文名称：main示例方法
     *
     * main的概要说明:
     *      <p>main示例方法</p>
     * @param args 运行时传参数
     *
     * @throws IOException
     * Written by : sunyifeng at 2017-04-19
     *
     */
    public static void main(String[] args) throws Exception {

        // 使用时OUTPUT_PATH须调用VideoUtil.OUTPUT_PATH = "D:\ffmpeg\input\" 需要带上最后一个分割符
        OUTPUT_PATH = EXE_DIR_PATH + "output\\";
		INPUT_PATH = EXE_DIR_PATH + "input\\";

        // 文件绝对路径
		convert("E:\\idea\\zhsyj\\src\\com\\zzhdsoft\\utils\\covert\\exe\\input\\33.mp4");

}
}

class ResetThread extends Thread{
    private InputStream is;
	public ResetThread(InputStream is){
		this.is = is;
	}
	@Override
	public void run() {
		BufferedReader br = new  BufferedReader(new  InputStreamReader(this.is));
		try {
			String line = null ;
			while ((line = br.readLine()) !=  null ) {
				if (line != null){}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		finally{
			try {
				this.is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}


