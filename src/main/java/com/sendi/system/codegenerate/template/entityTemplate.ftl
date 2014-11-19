package ${entityPackage}.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;

/**   
 * @Title: Entity
 * @Description: ${ftl_description}
 * @author liujinghua
 * @date ${ftl_create_time}
 * @version V1.0   
 *
 */
@Entity
@Table(name = "${tableName}", schema = "")
public class ${entityName} implements java.io.Serializable {
	
	private String id;
	<#list originalColumns as po>
	/**${po.fieldComment}*/
	private ${po.fieldType} ${po.fieldName};
	</#list>
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=36)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	<#list originalColumns as po>
	/**
	 *方法: 取得${po.fieldType}
	 *@return: ${po.fieldType}  ${po.fieldComment}
	 */
	@Column(name ="${po.fieldName}",nullable=<#if po.nullable == 'Y'>true<#else>false</#if><#if po.charmaxLength != ''>,length=${po.charmaxLength}</#if>)
	public ${po.fieldType} get${po.fieldName?cap_first}(){
		return this.${po.fieldName};
	}

	/**
	 *方法: 设置${po.fieldType}
	 *@param: ${po.fieldType}  ${po.fieldComment}
	 */
	public void set${po.fieldName?cap_first}(${po.fieldType} ${po.fieldName}){
		this.${po.fieldName} = ${po.fieldName};
	}
	</#list>
}
