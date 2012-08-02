package org.openmrs.module.foodprescription.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.openmrs.BaseOpenmrsMetadata;
import org.openmrs.api.context.Context;
import org.openmrs.module.foodprescription.service.FdmService;


public class FoodPackage extends BaseOpenmrsMetadata{
	private Integer id;
	private String uuid;
	private String name;
	private List<FoodPackageCombination> foodPackageCombination;
	
	public FoodPackage(){}
	
	public FoodPackage(String name){ this.name = name;}
	
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
	public void setFoodPackageCombination(List<FoodPackageCombination> foodPackageCombination) {
		this.foodPackageCombination = foodPackageCombination;
	}
	public List<FoodPackageCombination> getFoodPackageCombination() {
		FdmService service = Context.getService(FdmService.class);
		List<FoodPackageCombination> ret = new ArrayList<FoodPackageCombination>();
		
		ret.addAll(service.getFoodPackageCombinationByPackage(this,false));
		
		return ret;
	}
	/*private List<FoodPackageCombination> getFoodPackageCombinationLeaves(FoodPackageCombination foodPackageCombinationParent) {
		List<FoodPackageCombination> leaves = new ArrayList<FoodPackageCombination>();
		
		if (foodPackageCombinationParent.isVoided() == false) {
			leaves.add(foodPackageCombinationParent);
		}
		
		return leaves;
	}*/
}
