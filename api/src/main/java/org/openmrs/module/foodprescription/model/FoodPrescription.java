package org.openmrs.module.foodprescription.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.openmrs.BaseOpenmrsData;
import org.openmrs.Person;
import org.openmrs.api.context.Context;
import org.openmrs.module.household.model.Household;


public class FoodPrescription extends BaseOpenmrsData {
	private Integer id;
	private String uuid;
	private Household household;
	private FoodCombination foodCombination;
	private FoodEncounter foodEncounter;
	private String householdMemberCount;
	private Date prescriptionDate;
	private Person provider;
	private Boolean picked = Boolean.FALSE;
	private Double quantity;
	private Integer serialno;
	
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
	
	public void setHousehold(Household household) {
	    this.household = household;
    }
	public Household getHousehold() {
	    return household;
    }
	public void setFoodCombination(FoodCombination foodCombination) {
	    this.foodCombination = foodCombination;
    }
	public FoodCombination getfoodCombination() {
	    return foodCombination;
    }
	public void setFoodEncounter(FoodEncounter foodEncounter) {
	    this.foodEncounter = foodEncounter;
    }
	public FoodEncounter getFoodEncounter() {
	    return foodEncounter;
    }
	public void setHouseholdMemberCount(String householdMemberCount) {
	    this.householdMemberCount = householdMemberCount;
    }
	public String getHouseholdMemberCount() {
	    return householdMemberCount;
    }
	public Person getProvider() {
		return provider;
	}
	public void setProvider(Person provider) {
		this.provider = provider;
	}
	public void setPrescriptionDate(Date prescriptionDate) {
	    this.prescriptionDate = prescriptionDate;
    }
	public Date getPrescriptionDate() {
	    return prescriptionDate;
    }
	public void setPicked(Boolean picked) {
		this.picked = picked;
	}
	public Boolean getPicked() {
		return this.picked;
	}
	public void setQuantity(Double quantity) {
	    this.quantity = quantity;
    }
	public Double getQuantity() {
	    return quantity;
    }
	public void setSerialno(Integer serialno) {
	    this.serialno = serialno;
    }
	public Integer getSerialno() {
	    return serialno;
    }
}
