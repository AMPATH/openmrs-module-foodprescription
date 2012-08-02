package org.openmrs.module.foodprescription.model;

import org.openmrs.BaseOpenmrsData;


public class FoodPackageCombination extends BaseOpenmrsData {
	private Integer id;
	private String uuid;
	private FoodPackage foodPackage;
	private FoodCombination foodCombination;
	
	public FoodPackageCombination(){}
	
	/*public FoodPackageCombination(FoodPackage foodPackage){
		//this.foodCombination = foodCombination;
		this.foodPackage = foodPackage;
	}*/
	public FoodPackageCombination(FoodCombination foodCombination,FoodPackage foodPackage){
		this.foodCombination = foodCombination;
		this.foodPackage = foodPackage;
	}

	@Override
    public Integer getId() {
	    return this.id;
    }

	@Override
    public void setId(Integer id) {
		this.id = id;
    }
	
	public void setUuid(String uuid) {
	    this.uuid = uuid;
    }
	public String getUuid() {
	    return uuid;
    }
	
	public void setFoodPackage(FoodPackage foodPackage) {
	    this.foodPackage = foodPackage;
    }
	public FoodPackage getFoodPackage() {
	    return foodPackage;
    }
	public void setFoodCombination(FoodCombination foodCombination) {
	    this.foodCombination = foodCombination;
    }
	public FoodCombination getFoodCombination() {
	    return foodCombination;
    }
	
	
	
}
