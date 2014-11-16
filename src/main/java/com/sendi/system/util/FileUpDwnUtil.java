package com.sendi.system.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.sendi.system.constants.Globals;

/**
 * @author liujinghua
 * 文件上下载工具类
 */
public class FileUpDwnUtil {

	public static void downLoad(String filePath, HttpServletResponse response, boolean isOnLine) throws Exception {
        File f = new File(filePath);
        if (!f.exists()) {
            response.sendError(404, "File not found!");
            return;
        }
        BufferedInputStream br = new BufferedInputStream(new FileInputStream(f));
        byte[] buf = new byte[1024];
        int len = 0;

        response.reset(); // 非常重要
        if (isOnLine) { // 在线打开方式
            URL u = new URL("file:///" + filePath);
            response.setContentType(u.openConnection().getContentType());
            response.setHeader("Content-Disposition", "inline; filename=" + f.getName());
            // 文件名应该编码成UTF-8
        } else { // 纯下载方式
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename=" + f.getName());
        }
        OutputStream out = response.getOutputStream();
        while ((len = br.read(buf)) > 0)
            out.write(buf, 0, len);
        br.close();
        out.close();
    }
	
	//获取上传文件的全路径
	public static String getFileFullName(String basename) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String filename = FilenameUtils.concat(DateFormatUtils.format(new Date(), "yyyyMMdd"), basename);
		String filefullname = FilenameUtils.concat(request.getSession().getServletContext().getRealPath(Globals.UPLOAD),filename);
		return filefullname;
	}
	
	//获取上传文件的全路径
	public static String getFileAbsoluteName(String subPathName) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String filefullname = FilenameUtils.concat(request.getSession().getServletContext().getRealPath(Globals.UPLOAD),subPathName);
		return filefullname;
	}
}
