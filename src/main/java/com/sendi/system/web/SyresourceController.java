package com.sendi.system.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.entity.Syresource;
import com.sendi.system.service.SyresourceService;
import com.sendi.system.util.BeanUtils;
import com.sendi.system.util.Json;
import com.sendi.system.util.tree.Tree;

@Controller
@RequestMapping("/syresourceController")
public class SyresourceController extends BaseController {
	
	@Autowired
	private SyresourceService syresourceService;
	
	/**
	 * 查询所有,不带条件
	 */
	@RequestMapping(params = "queryAll")
	public void queryAll(HttpServletRequest request,HttpServletResponse response) {
		List<Syresource> datas = syresourceService.queryAll();
		
		List<Tree> tree = new ArrayList<Tree>();
		for (Syresource resource : datas) {
			Tree node = new Tree();
			BeanUtils.copyNotNullProperties(resource, node);
			node.setText(resource.getName());
			node.setState("open");
			node.setPid(resource.getSysresource_id());
			Map<String, String> attributes = new HashMap<String, String>();
			attributes.put("url", resource.getUrl());
			attributes.put("target", resource.getTarget());
			node.setAttributes(attributes);
			tree.add(node);
		}
		
		String responseText = toJSONArraytring(tree);
		writeResponseText(responseText, response);
	}
	
	/**
	 * 根据角色ID进行查询，查询出所属角色的资源id用于授权的checkbox过滤
	 */
	@RequestMapping(params = "queryByRoleId")
	public void queryByRoleId(HttpServletRequest request,HttpServletResponse response,String roleid) {
		
		if(StringUtils.isEmpty(roleid)) throw new RuntimeException("roleid is not allowed null");
		
		List<Map<String,Object>> datas = syresourceService.queryByRoleId(roleid);
		
		String responseText = toJSONArraytring(datas);
		writeResponseText(responseText, response);
	}
	
	/**
	 * 授权
	 */
	@RequestMapping(params = "grant")
	public void grant(HttpServletRequest request,HttpServletResponse response,String roleid,String resourceids) {
		Json j = new Json();
		try {
			
			syresourceService.grant(roleid, resourceids);
			
			j.setMsg("授权成功");
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("授权失败");
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
		
	}

	/**
	 * 资源管理查询页面
	 */
	@RequestMapping(params = "querySyresourceTreeGridDatas")
	public void querySyresourceTreeGridDatas(HttpServletRequest request,HttpServletResponse response,String id) {

		List<Syresource> datas = syresourceService.querySyresourceTreeGridDatas(id);
		String responseText = toJSONArraytring(datas);
		writeResponseText(responseText, response);
	}
	
	/**
	 * 左边树功能菜单列表
	 */
	@RequestMapping(params = "getMainMenu")
	public void getMainMenu(HttpServletRequest request,HttpServletResponse response){
		
		String roleid = (String)request.getSession().getAttribute(super.SESSION_ROLE_ID);
		
		List<Map<String,Object>> datas = syresourceService.getMainMenu(roleid);
		
		List<Tree> tree = new ArrayList<Tree>();
		for (Map<String,Object> resource : datas) {
			Tree node = new Tree();
			node.setId((String)resource.get("ID"));
			node.setIconCls((String)resource.get("ICONCLS"));
			node.setText((String)resource.get("NAME"));
			node.setPid((String)resource.get("SYRESOURCE_id"));
			Map<String, String> attributes = new HashMap<String, String>();
			attributes.put("url", (String)resource.get("URL"));
			attributes.put("target", (String)resource.get("TARGET"));
			node.setAttributes(attributes);
			tree.add(node);
		}
		String responseText = toJSONArraytring(tree);
		writeResponseText(responseText, response);
	}
	
	/**
	 * 根据ID查找资源对像
	 * @param request
	 * @param response
	 * @param id
	 */
	@RequestMapping(params = "loadSyresourceById")
	public void loadSyresourceById(HttpServletRequest request,HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			Syresource syresource = syresourceService.loadSyresourceById(id);
			writeResponseText(toJSONString(syresource), response);
		}
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(params = "add")
	public void add(HttpServletRequest request,HttpServletResponse response,Syresource syresource){
		Json j = new Json();
		try {
			syresourceService.add(syresource);
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(params = "update")
	public void update(HttpServletRequest request,HttpServletResponse response,Syresource syresource){
		
		Json j = new Json();
		try {
			if(StringUtils.isEmpty(syresource.getId())) throw new RuntimeException("error: syresource's id is not allowed null!");
			//1、先从数据库中读取实体
			Syresource target = syresourceService.loadSyresourceById(syresource.getId());
			BeanUtils.copyNotNullProperties(syresource, target, new String[] { "createdatetime" });//将非空属性拷贝给target以供持久化

			syresourceService.update(target);
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(params = "del")
	public void del(HttpServletRequest request,HttpServletResponse response,String id){
		Json j = new Json();
		try {
			
			if(!syresourceService.isNotExistsChilds(id)) throw new RuntimeException("该资源下存在子资源，不允许删除!");

			syresourceService.delete(id);
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据角色id查询resource，用于显示用户的功能权限。
	 * @author devchao
	 */
	@RequestMapping(params = "queryResourceByRoleId")
	public void queryResourceByRoleId(HttpServletRequest request,HttpServletResponse response) {
		
		String roleId=(String)request.getSession().getAttribute(this.SESSION_ROLE_ID);
		List<Syresource> datas = syresourceService.queryResourceByRoleId(roleId);
		List<Tree> tree = new ArrayList<Tree>();
		for (Syresource resource : datas) {
			Tree node = new Tree();
			BeanUtils.copyNotNullProperties(resource, node);
			node.setText(resource.getName());
			node.setState("open");
			node.setPid(resource.getSysresource_id());
			Map<String, String> attributes = new HashMap<String, String>();
			attributes.put("url", resource.getUrl());
			attributes.put("target", resource.getTarget());
			node.setAttributes(attributes);
			tree.add(node);
		}
		String responseText = toJSONArraytring(tree);
		writeResponseText(responseText, response);
	}
}
