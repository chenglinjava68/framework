package com.sendi.system.util;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * 处理excel到导入或导出等功能
 * @author 邹山
 *
 */
public class PoiUtils {

	/**
	 * 创建excel并将其写入到响应流
	 * @param response 
	 * @param list 数据集
	 * @param headArray 表头(数组)
	 * @param fieldArray 字段名(数组)
	 * @throws Exception 
	 */
	public static void createAndExportExcel(HttpServletResponse response, List<Map<String, Object>> dataList, String[] headArray, String[] fieldArray)throws Exception{
		if(headArray==null || fieldArray==null || headArray.length!=fieldArray.length){
			throw new RuntimeException("表头和字段名数组为NULL或长度不相等!");
		}
		
		if(dataList==null || dataList.size()==0){
			response.getWriter().write("no data in datagrid.");
			return;
		}
		
		XSSFWorkbook wb = new XSSFWorkbook(); 
		XSSFSheet sheet  = wb.createSheet();   //创建sheet
		wb.setSheetName(0, "数据");  //设置sheet名
		sheet.setDefaultColumnWidth(15);
		XSSFRow headRow = sheet.createRow(0);
		
		//设置表头
		XSSFCellStyle headerStyle = getCellStyle(wb,"header"); //获取表头样式
		for (int i = 0; i < headArray.length; i++) {
			XSSFCell cell = headRow.createCell(i);
			cell.setCellStyle(headerStyle);
			cell.setCellValue(headArray[i]);
		}
		
		//写入内容
		XSSFCellStyle contentStyle = getCellStyle(wb, "content");  //获取内容样式
		for (int i = 0; i < dataList.size(); i++) {
			Map<String, Object> map = dataList.get(i);
			XSSFRow row = sheet.createRow(i + 1);
			for (int j = 0; j < fieldArray.length; j++) {
				XSSFCell cell = row.createCell(j);
				cell.setCellType(XSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(contentStyle);
				String cellvalue=  String.valueOf(map.get(fieldArray[j]));
				
				cell.setCellValue(!StringUtils.isEmpty(cellvalue)?cellvalue:"");
			}
		}
		
		//将excel以数据流形式写入到客户端
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;chartset=utf-8");
		String filename = new String(UUIDGenerator.generate().getBytes("gb2312"),"ISO-8859-1")+".xlsx";
		response.setHeader("Content-disposition", "attachment;filename="+filename);
		wb.write(response.getOutputStream());
	}
	
	private static XSSFCellStyle getCellStyle(XSSFWorkbook workbook,String type) {
		if("header".equals(type)){
			// 生成一个样式
			XSSFCellStyle style = workbook.createCellStyle();
			
			// 设置这些样式
			style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
			style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.ALIGN_CENTER);
			
			//设置自动换行
			style.setWrapText(true);
			
			// 生成一个字体
			Font font = workbook.createFont();
			font.setColor(HSSFColor.VIOLET.index);
			font.setFontHeightInPoints((short) 10);
			font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
			
			// 把字体应用到当前的样式
			style.setFont(font);
			return style;
		}else{
			// 生成一个样式
			XSSFCellStyle style = workbook.createCellStyle();
			// 设置这些样式
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			//设置自动换行
			style.setWrapText(true);
			return style;
		}
	}
	
}
