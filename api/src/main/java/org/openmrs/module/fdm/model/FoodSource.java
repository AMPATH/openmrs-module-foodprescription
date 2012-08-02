package org.openmrs.module.fdm.model;

import org.openmrs.BaseOpenmrsMetadata;


public class FoodSource extends BaseOpenmrsMetadata {
	private Integer id;
	private String uuid;
	private String code;
	private String name;
	private String description;
	
	public FoodSource(){}
	
	public FoodSource(String code, String name, String description ){
		this.setCode(code);
		this.setName(name);
		this.setDescription(description);
	}
	
	public Integer getId() {
	    return this.id;
    }
	public void setId(Integer id) {
	    this.id = id;
    }
	public void setName(String name) {
	    this.name = name;
    }
	public String getName() {
	    return name;
    }
	
	public void setUuid(String uuid) {
	    this.uuid = uuid;
    }
	public String getUuid() {
	    return uuid;
    }
	public void setCode(String code) {
	    this.code = code;
    }
	public String getCode() {
	    return code;
    }
	public void setDescription(String description) {
	    this.description = description;
    }
	public String getDescription() {
	    return description;
    }
	
}
