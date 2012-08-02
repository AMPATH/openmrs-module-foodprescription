package org.openmrs.module.fdm.model;

import org.openmrs.BaseOpenmrsMetadata;


public class FoodProduct extends BaseOpenmrsMetadata{
	private Integer id;
	private String uuid;
	private String name;
	private boolean individualized;
	
	public FoodProduct(){}
	
	public FoodProduct(String name){ this.name = name;}
	
	public Integer getId() {
	    return this.id;
    }
	public void setId(Integer id) {
	    this.id = id;
    }
	
	public void setUuid(String uuid) {
	    this.uuid = uuid;
    }
	public String getUuid() {
	    return uuid;
    }
	
	public void setName(String name) {
	    this.name = name;
    }
	public String getName() {
	    return name;
    }

	public void setIndividualized(boolean individualized) {
	    this.individualized = individualized;
    }

	public boolean getIndividualized() {
	    return individualized;
    }
	
}
