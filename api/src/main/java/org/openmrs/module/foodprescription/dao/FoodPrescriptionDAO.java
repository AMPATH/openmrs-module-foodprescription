/**
 * 
 */
package org.openmrs.module.foodprescription.dao;

import java.util.List;

import org.openmrs.module.foodprescription.model.FoodCombination;
import org.openmrs.module.foodprescription.model.FoodEncounter;
import org.openmrs.module.foodprescription.model.FoodPackage;
import org.openmrs.module.foodprescription.model.FoodPackageCombination;
import org.openmrs.module.foodprescription.model.FoodPrescription;
import org.openmrs.module.foodprescription.model.FoodProduct;
import org.openmrs.module.foodprescription.model.FoodSource;
import org.openmrs.module.foodprescription.model.FoodWeightRestriction;
import org.openmrs.module.household.model.Household;


/**
 * Contact for database operation on Food Prescription Module
 *  
 * @author jmwogi
 */
public interface FoodPrescriptionDAO {
	
	public boolean saveFoodProduct(FoodProduct foodProduct);
	public FoodProduct getFoodProduct(int id);
	public FoodProduct getFoodProduct(String uuid);
	public FoodProduct getFoodProduct(FoodProduct foodProduct);
	public boolean purgeFoodProduct(FoodProduct foodProduct, String retireReason);
	public List<FoodProduct> getFoodProduct(boolean retiredIncluded);
	
	public boolean saveFoodSource(FoodSource foodSource);
	public FoodSource getFoodSource(int id);
	public FoodSource getFoodSource(String uuid);
	public FoodSource getFoodSource(FoodSource foodSource);
	public boolean purgeFoodSource(FoodSource foodSource, String retireReason);
	public List<FoodSource> getFoodSource(boolean retiredIncluded);
	
	public boolean saveFoodEncounter(FoodEncounter foodEncounter);
	public FoodEncounter getFoodEncounter(int id);
	public FoodEncounter getFoodEncounter(String uuid);
	public FoodEncounter getFoodEncounter(FoodEncounter foodEncounter);
	public boolean purgeFoodEncounter(FoodEncounter foodEncounter, String voidReason);
	public List<FoodEncounter> getFoodEncounterByHousehold(Household household, boolean voidedIncluded);
	
	public boolean saveFoodCombination(FoodCombination foodCombination);
	public FoodCombination getFoodCombination(int id);
	public FoodCombination getFoodCombination(String uuid);
	public FoodCombination getFoodCombination(FoodCombination foodCombination);
	public boolean purgeFoodCombination(FoodCombination foodCombination, String voidReason);
	public List<FoodCombination> getFoodCombination(boolean voidedIncluded);
	public List<FoodCombination> getFoodCombinationByFoodSource(FoodSource foodSource, boolean voidedIncluded);
	
	public boolean saveFoodPrescription(FoodPrescription foodPrescription);
	public boolean saveFoodPrescription(List<FoodPrescription> foodPrescription);
	public FoodPrescription getFoodPrescription(int id);
	public FoodPrescription getFoodPrescription(String uuid);
	public FoodPrescription getFoodPrescription(FoodPrescription foodPrescription);
	public boolean purgeFoodPrescription(FoodPrescription foodPrescription, String voidReason);
	public List<FoodPrescription> getFoodPrescriptionByEncounter(FoodEncounter foodEncounter, boolean voidedIncluded);
	
	
	public boolean saveFoodPackage(FoodPackage foodPackage);
	public FoodPackage getFoodPackage(int id);
	public FoodPackage getFoodPackage(String uuid);
	public FoodPackage getFoodPackageByName(String name);
	public FoodPackage getFoodPackage(FoodPackage foodPackage);
	public boolean purgeFoodPackage(FoodPackage foodPackage, String retireReason);
	public List<FoodPackage> getFoodPackage(boolean retiredIncluded);
	
	public boolean saveFoodPackageCombination(FoodPackageCombination foodPackageCombination);
	public FoodPackageCombination getFoodPackageCombination(int id);
	public FoodPackageCombination getFoodPackageCombination(String uuid);
	public FoodPackageCombination getFoodPackageCombination(FoodPackageCombination foodPackageCombination);
	public boolean purgeFoodPackageCombination(FoodPackageCombination foodPackageCombination, String voidReason);
	public List<FoodPackageCombination> getFoodPackageCombination(FoodPackageCombination foodPackageCombination,boolean retiredIncluded);
	public List<FoodPackageCombination> getFoodPackageCombinationByPackage(FoodPackage foodPackage,boolean voidedIncluded);
	
	public boolean saveFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction);
	public FoodWeightRestriction getFoodWeightRestriction(int id);
	public FoodWeightRestriction getFoodWeightRestriction(String uuid);
	public FoodWeightRestriction getFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction);
	public boolean purgeFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction, String voidReason);
	public List<FoodWeightRestriction> getFoodWeightRestriction(FoodProduct foodProduct, boolean retiredIncluded);
	public List<FoodWeightRestriction> getFoodWeightRestriction(boolean retiredIncluded);
	
	//Statistics methods
	public List<FoodEncounter> getFoodEncounterEnteredInLastFewDays(Integer daysEntered);
}
