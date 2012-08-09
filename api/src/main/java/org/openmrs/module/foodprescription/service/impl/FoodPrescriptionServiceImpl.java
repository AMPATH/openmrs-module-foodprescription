/**
 * 
 */
package org.openmrs.module.foodprescription.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.foodprescription.dao.FoodPrescriptionDAO;
import org.openmrs.module.foodprescription.model.FoodCombination;
import org.openmrs.module.foodprescription.model.FoodEncounter;
import org.openmrs.module.foodprescription.model.FoodPackage;
import org.openmrs.module.foodprescription.model.FoodPackageCombination;
import org.openmrs.module.foodprescription.model.FoodPrescription;
import org.openmrs.module.foodprescription.model.FoodProduct;
import org.openmrs.module.foodprescription.model.FoodSource;
import org.openmrs.module.foodprescription.model.FoodWeightRestriction;
import org.openmrs.module.foodprescription.service.FoodPrescriptionService;
import org.openmrs.module.household.model.Household;

/**
 *  @author jmwogi
 *
 */
public class FoodPrescriptionServiceImpl extends BaseOpenmrsService implements FoodPrescriptionService {
	
	protected static final Log log = LogFactory.getLog(FoodPrescriptionServiceImpl.class);
	
	private FoodPrescriptionDAO dao;

	public void setDao(FoodPrescriptionDAO dao) {
	    this.dao = dao;
    }

	public boolean saveFoodProduct(FoodProduct foodProduct) {
	    return dao.saveFoodProduct(foodProduct);
    }

	public FoodProduct getFoodProduct(int id) {
	    return dao.getFoodProduct(id);
    }

	public FoodProduct getFoodProduct(String uuid) {
	    return dao.getFoodProduct(uuid);
    }

	public FoodProduct getFoodProduct(FoodProduct foodProduct) {
	    return dao.getFoodProduct(foodProduct);
    }

	public boolean purgeFoodProduct(FoodProduct foodProduct, String retireReason) {
	    return dao.purgeFoodProduct(foodProduct, retireReason);
    }

	public List<FoodProduct> getFoodProduct(boolean retiredIncluded) {
	    return dao.getFoodProduct(retiredIncluded);
    }

	public boolean saveFoodSource(FoodSource foodSource) {
	    return dao.saveFoodSource(foodSource);
    }

	public FoodSource getFoodSource(int id) {
	    return dao.getFoodSource(id);
    }

	public FoodSource getFoodSource(String uuid) {
	    return dao.getFoodSource(uuid);
    }

	public FoodSource getFoodSource(FoodSource foodSource) {
	    return dao.getFoodSource(foodSource);
    }

	public boolean purgeFoodSource(FoodSource foodSource, String retireReason) {
	    return dao.purgeFoodSource(foodSource, retireReason);
    }

	public List<FoodSource> getFoodSource(boolean retiredIncluded) {
	    return dao.getFoodSource(retiredIncluded);
    }

	public boolean saveFoodEncounter(FoodEncounter foodEncounter) {
	    return dao.saveFoodEncounter(foodEncounter);
    }

	public FoodEncounter getFoodEncounter(int id) {
	    return dao.getFoodEncounter(id);
    }

	public FoodEncounter getFoodEncounter(String uuid) {
	    return dao.getFoodEncounter(uuid);
    }

	public FoodEncounter getFoodEncounter(FoodEncounter foodEncounter) {
	    return dao.getFoodEncounter(foodEncounter);
    }

	public boolean purgeFoodEncounter(FoodEncounter foodEncounter, String voidReason) {
	    return dao.purgeFoodEncounter(foodEncounter, voidReason);
    }

	public List<FoodEncounter> getFoodEncounterByHousehold(Household household, boolean voidedIncluded) {
	    return dao.getFoodEncounterByHousehold(household, voidedIncluded);
    }

	public boolean saveFoodCombination(FoodCombination foodCombination){
		return dao.saveFoodCombination(foodCombination);
	}
	public FoodCombination getFoodCombination(int id){
		return dao.getFoodCombination(id);
	}
	public FoodCombination getFoodCombination(String uuid){
		return dao.getFoodCombination(uuid);
	}
	public FoodCombination getFoodCombination(FoodCombination foodCombination){
		return dao.getFoodCombination(foodCombination);
	}
	public boolean purgeFoodCombination(FoodCombination foodCombination, String voidReason){
		return dao.purgeFoodCombination(foodCombination, voidReason);
	}
	public List<FoodCombination> getFoodCombination(boolean voidedIncluded){
		return dao.getFoodCombination(voidedIncluded);
	}
	public List<FoodCombination> getFoodCombinationByFoodSource(FoodSource foodSource, boolean voidedIncluded){
		return dao.getFoodCombinationByFoodSource(foodSource, voidedIncluded);
	}
	
	public boolean saveFoodPrescription(FoodPrescription foodPrescription) {
	    return dao.saveFoodPrescription(foodPrescription);
    }
	
	public boolean saveFoodPrescription(List<FoodPrescription> foodPrescriptionList){
	    return dao.saveFoodPrescription(foodPrescriptionList);
    }

	public FoodPrescription getFoodPrescription(int id) {
	    return dao.getFoodPrescription(id);
    }

	public FoodPrescription getFoodPrescription(String uuid) {
	    return dao.getFoodPrescription(uuid);
    }

	public FoodPrescription getFoodPrescription(FoodPrescription foodPrescription) {
	    return dao.getFoodPrescription(foodPrescription);
    }

	public boolean purgeFoodPrescription(FoodPrescription foodPrescription, String voidReason) {
	    return dao.purgeFoodPrescription(foodPrescription, voidReason);
    }

	public List<FoodPrescription> getFoodPrescriptionByEncounter(FoodEncounter foodEncounter, boolean voidedIncluded) {
	    return dao.getFoodPrescriptionByEncounter(foodEncounter, voidedIncluded);
    }
	
	public boolean saveFoodPackage(FoodPackage foodPackage){
		return dao.saveFoodPackage(foodPackage);
	}
	public FoodPackage getFoodPackage(int id){
		return dao.getFoodPackage(id);
	}
	public FoodPackage getFoodPackage(String uuid){
		return dao.getFoodPackage(uuid);
	}
	public FoodPackage getFoodPackageByName(String name){
		return dao.getFoodPackageByName(name);
	}
	public FoodPackage getFoodPackage(FoodPackage foodPackage){
		return dao.getFoodPackage(foodPackage);
	}
	public boolean purgeFoodPackage(FoodPackage foodPackage, String retireReason){
		return dao.purgeFoodPackage(foodPackage, retireReason);
	}
	public List<FoodPackage> getFoodPackage(boolean retiredIncluded){
		return dao.getFoodPackage(retiredIncluded);
	}
	
	public boolean saveFoodPackageCombination(FoodPackageCombination foodPackageCombination){
		return dao.saveFoodPackageCombination(foodPackageCombination);
	}
	public FoodPackageCombination getFoodPackageCombination(int id){
		return dao.getFoodPackageCombination(id);
	}
	public FoodPackageCombination getFoodPackageCombination(String uuid){
		return dao.getFoodPackageCombination(uuid);
	}
	public FoodPackageCombination getFoodPackageCombination(FoodPackageCombination foodPackageCombination){
		return dao.getFoodPackageCombination(foodPackageCombination);
	}
	public boolean purgeFoodPackageCombination(FoodPackageCombination foodPackageCombination, String voidReason){
		return dao.purgeFoodPackageCombination(foodPackageCombination, voidReason);
	}
	public List<FoodPackageCombination> getFoodPackageCombination(FoodPackageCombination foodPackageCombination,boolean voidedIncluded){
		return dao.getFoodPackageCombination(foodPackageCombination, voidedIncluded);
	}
	public List<FoodPackageCombination> getFoodPackageCombinationByPackage(FoodPackage foodPackage,boolean voidedIncluded){
		return dao.getFoodPackageCombinationByPackage(foodPackage, voidedIncluded);
	}
	
	public boolean saveFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction){
		return dao.saveFoodWeightRestriction(foodWeightRestriction);
	}
	public FoodWeightRestriction getFoodWeightRestriction(int id){
		return dao.getFoodWeightRestriction(id);
	}
	public FoodWeightRestriction getFoodWeightRestriction(String uuid){
		return dao.getFoodWeightRestriction(uuid);
	}
	public FoodWeightRestriction getFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction){
		return dao.getFoodWeightRestriction(foodWeightRestriction);
	}
	public boolean purgeFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction, String voidReason){
		return dao.purgeFoodWeightRestriction(foodWeightRestriction, voidReason);
	}
	public List<FoodWeightRestriction> getFoodWeightRestriction(FoodProduct foodProduct, boolean retiredIncluded){
		return dao.getFoodWeightRestriction(foodProduct, retiredIncluded);
	}
	public List<FoodWeightRestriction> getFoodWeightRestriction(boolean retiredIncluded){
		return dao.getFoodWeightRestriction(retiredIncluded);
	}
	public List<FoodEncounter> getFoodEncounterEnteredInLastFewDays(Integer daysEntered){
		return dao.getFoodEncounterEnteredInLastFewDays(daysEntered);
	}
}

