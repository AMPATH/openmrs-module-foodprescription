package org.openmrs.module.fdm.model;

import org.openmrs.BaseOpenmrsData;


public class FoodCombination extends BaseOpenmrsData {
	private Integer id;
	private String uuid;
	private FoodSource foodSource;
	private FoodProduct foodProduct;
	private boolean  dispensable;
	
	public FoodCombination(){}
	
	public FoodCombination(FoodSource foodSource, FoodProduct foodProduct){
		this.foodSource = foodSource;
		this.foodProduct = foodProduct;
	}
	
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
	
	public void setFoodProduct(FoodProduct foodProduct) {
	    this.foodProduct = foodProduct;
    }
	public FoodProduct getFoodProduct() {
	    return foodProduct;
    }
	public void setFoodSource(FoodSource foodSource) {
	    this.foodSource = foodSource;
    }
	public FoodSource getFoodSource() {
	    return foodSource;
    }
	public void setDispensable(boolean dispensable) {
	    this.dispensable = dispensable;
    }
	public boolean isDispensable() {
	    return dispensable;
    }
}
