package org.openmrs.module.foodprescription.model;

import org.openmrs.BaseOpenmrsMetadata;


public class FoodWeightRestriction extends BaseOpenmrsMetadata{
	private Integer id;
	private String uuid;
	private FoodProduct foodProduct;
	private Double quantity;
	private Double startAge;
	private Double stopAge;
	
	public FoodWeightRestriction(){}
	
	public FoodWeightRestriction(FoodProduct foodProduct, Double quantity, Double startAge, Double stopAge){ 
		this.foodProduct = foodProduct;
		this.quantity = quantity;
		this.startAge = startAge;
		this.stopAge = stopAge;
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

	public void setQuantity(Double quantity) {
	    this.quantity = quantity;
    }

	public Double getQuantity() {
	    return quantity;
    }

	public void setStartAge(Double startAge) {
	    this.startAge = startAge;
    }

	public Double getStartAge() {
	    return startAge;
    }

	public void setStopAge(Double stopAge) {
	    this.stopAge = stopAge;
    }

	public Double getStopAge() {
	    return stopAge;
    }
	
}
