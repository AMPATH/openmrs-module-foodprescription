/**
 * 
 */
package org.openmrs.module.foodprescription.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.foodprescription.dao.FdmDAO;
import org.openmrs.module.foodprescription.model.FoodCombination;
import org.openmrs.module.foodprescription.model.FoodEncounter;
import org.openmrs.module.foodprescription.model.FoodPackage;
import org.openmrs.module.foodprescription.model.FoodPackageCombination;
import org.openmrs.module.foodprescription.model.FoodPrescription;
import org.openmrs.module.foodprescription.model.FoodProduct;
import org.openmrs.module.foodprescription.model.FoodSource;
import org.openmrs.module.foodprescription.model.FoodWeightRestriction;
import org.openmrs.module.foodprescription.service.FdmService;
import org.openmrs.module.household.model.Household;


/**
 *  @author jmwogi
 *
 */
public class FdmServiceImpl extends BaseOpenmrsService implements FdmService {
	
	protected static final Log log = LogFactory.getLog(FdmServiceImpl.class);
	
	private FdmDAO fdmDAO;

	public void setFdmDAO(FdmDAO fdmDAO) {
	    this.fdmDAO = fdmDAO;
    }

	public FdmDAO getFdmDAO() {
	    return fdmDAO;
    }

	public boolean saveFoodProduct(FoodProduct foodProduct) {
	    return fdmDAO.saveFoodProduct(foodProduct);
    }

	public FoodProduct getFoodProduct(int id) {
	    return fdmDAO.getFoodProduct(id);
    }

	public FoodProduct getFoodProduct(String uuid) {
	    return fdmDAO.getFoodProduct(uuid);
    }

	public FoodProduct getFoodProduct(FoodProduct foodProduct) {
	    return fdmDAO.getFoodProduct(foodProduct);
    }

	public boolean purgeFoodProduct(FoodProduct foodProduct, String retireReason) {
	    return fdmDAO.purgeFoodProduct(foodProduct, retireReason);
    }

	public List<FoodProduct> getFoodProduct(boolean retiredIncluded) {
	    return fdmDAO.getFoodProduct(retiredIncluded);
    }

	public boolean saveFoodSource(FoodSource foodSource) {
	    return fdmDAO.saveFoodSource(foodSource);
    }

	public FoodSource getFoodSource(int id) {
	    return fdmDAO.getFoodSource(id);
    }

	public FoodSource getFoodSource(String uuid) {
	    return fdmDAO.getFoodSource(uuid);
    }

	public FoodSource getFoodSource(FoodSource foodSource) {
	    return fdmDAO.getFoodSource(foodSource);
    }

	public boolean purgeFoodSource(FoodSource foodSource, String retireReason) {
	    return fdmDAO.purgeFoodSource(foodSource, retireReason);
    }

	public List<FoodSource> getFoodSource(boolean retiredIncluded) {
	    return fdmDAO.getFoodSource(retiredIncluded);
    }

	public boolean saveFoodEncounter(FoodEncounter foodEncounter) {
	    return fdmDAO.saveFoodEncounter(foodEncounter);
    }

	public FoodEncounter getFoodEncounter(int id) {
	    return fdmDAO.getFoodEncounter(id);
    }

	public FoodEncounter getFoodEncounter(String uuid) {
	    return fdmDAO.getFoodEncounter(uuid);
    }

	public FoodEncounter getFoodEncounter(FoodEncounter foodEncounter) {
	    return fdmDAO.getFoodEncounter(foodEncounter);
    }

	public boolean purgeFoodEncounter(FoodEncounter foodEncounter, String voidReason) {
	    return fdmDAO.purgeFoodEncounter(foodEncounter, voidReason);
    }

	public List<FoodEncounter> getFoodEncounterByHousehold(Household household, boolean voidedIncluded) {
	    return fdmDAO.getFoodEncounterByHousehold(household, voidedIncluded);
    }

	public boolean saveFoodCombination(FoodCombination foodCombination){
		return fdmDAO.saveFoodCombination(foodCombination);
	}
	public FoodCombination getFoodCombination(int id){
		return fdmDAO.getFoodCombination(id);
	}
	public FoodCombination getFoodCombination(String uuid){
		return fdmDAO.getFoodCombination(uuid);
	}
	public FoodCombination getFoodCombination(FoodCombination foodCombination){
		return fdmDAO.getFoodCombination(foodCombination);
	}
	public boolean purgeFoodCombination(FoodCombination foodCombination, String voidReason){
		return fdmDAO.purgeFoodCombination(foodCombination, voidReason);
	}
	public List<FoodCombination> getFoodCombination(boolean voidedIncluded){
		return fdmDAO.getFoodCombination(voidedIncluded);
	}
	public List<FoodCombination> getFoodCombinationByFoodSource(FoodSource foodSource, boolean voidedIncluded){
		return fdmDAO.getFoodCombinationByFoodSource(foodSource, voidedIncluded);
	}
	
	public boolean saveFoodPrescription(FoodPrescription foodPrescription) {
	    return fdmDAO.saveFoodPrescription(foodPrescription);
    }
	
	public boolean saveFoodPrescription(List<FoodPrescription> foodPrescriptionList){
	    return fdmDAO.saveFoodPrescription(foodPrescriptionList);
    }

	public FoodPrescription getFoodPrescription(int id) {
	    return fdmDAO.getFoodPrescription(id);
    }

	public FoodPrescription getFoodPrescription(String uuid) {
	    return fdmDAO.getFoodPrescription(uuid);
    }

	public FoodPrescription getFoodPrescription(FoodPrescription foodPrescription) {
	    return fdmDAO.getFoodPrescription(foodPrescription);
    }

	public boolean purgeFoodPrescription(FoodPrescription foodPrescription, String voidReason) {
	    return fdmDAO.purgeFoodPrescription(foodPrescription, voidReason);
    }

	public List<FoodPrescription> getFoodPrescriptionByEncounter(FoodEncounter foodEncounter, boolean voidedIncluded) {
	    return fdmDAO.getFoodPrescriptionByEncounter(foodEncounter, voidedIncluded);
    }
	
	public boolean saveFoodPackage(FoodPackage foodPackage){
		return fdmDAO.saveFoodPackage(foodPackage);
	}
	public FoodPackage getFoodPackage(int id){
		return fdmDAO.getFoodPackage(id);
	}
	public FoodPackage getFoodPackage(String uuid){
		return fdmDAO.getFoodPackage(uuid);
	}
	public FoodPackage getFoodPackageByName(String name){
		return fdmDAO.getFoodPackageByName(name);
	}
	public FoodPackage getFoodPackage(FoodPackage foodPackage){
		return fdmDAO.getFoodPackage(foodPackage);
	}
	public boolean purgeFoodPackage(FoodPackage foodPackage, String retireReason){
		return fdmDAO.purgeFoodPackage(foodPackage, retireReason);
	}
	public List<FoodPackage> getFoodPackage(boolean retiredIncluded){
		return fdmDAO.getFoodPackage(retiredIncluded);
	}
	
	public boolean saveFoodPackageCombination(FoodPackageCombination foodPackageCombination){
		return fdmDAO.saveFoodPackageCombination(foodPackageCombination);
	}
	public FoodPackageCombination getFoodPackageCombination(int id){
		return fdmDAO.getFoodPackageCombination(id);
	}
	public FoodPackageCombination getFoodPackageCombination(String uuid){
		return fdmDAO.getFoodPackageCombination(uuid);
	}
	public FoodPackageCombination getFoodPackageCombination(FoodPackageCombination foodPackageCombination){
		return fdmDAO.getFoodPackageCombination(foodPackageCombination);
	}
	public boolean purgeFoodPackageCombination(FoodPackageCombination foodPackageCombination, String voidReason){
		return fdmDAO.purgeFoodPackageCombination(foodPackageCombination, voidReason);
	}
	public List<FoodPackageCombination> getFoodPackageCombination(FoodPackageCombination foodPackageCombination,boolean voidedIncluded){
		return fdmDAO.getFoodPackageCombination(foodPackageCombination, voidedIncluded);
	}
	public List<FoodPackageCombination> getFoodPackageCombinationByPackage(FoodPackage foodPackage,boolean voidedIncluded){
		return fdmDAO.getFoodPackageCombinationByPackage(foodPackage, voidedIncluded);
	}
	
	public boolean saveFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction){
		return fdmDAO.saveFoodWeightRestriction(foodWeightRestriction);
	}
	public FoodWeightRestriction getFoodWeightRestriction(int id){
		return fdmDAO.getFoodWeightRestriction(id);
	}
	public FoodWeightRestriction getFoodWeightRestriction(String uuid){
		return fdmDAO.getFoodWeightRestriction(uuid);
	}
	public FoodWeightRestriction getFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction){
		return fdmDAO.getFoodWeightRestriction(foodWeightRestriction);
	}
	public boolean purgeFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction, String voidReason){
		return fdmDAO.purgeFoodWeightRestriction(foodWeightRestriction, voidReason);
	}
	public List<FoodWeightRestriction> getFoodWeightRestriction(FoodProduct foodProduct, boolean retiredIncluded){
		return fdmDAO.getFoodWeightRestriction(foodProduct, retiredIncluded);
	}
	public List<FoodWeightRestriction> getFoodWeightRestriction(boolean retiredIncluded){
		return fdmDAO.getFoodWeightRestriction(retiredIncluded);
	}
	public List<FoodEncounter> getFoodEncounterEnteredInLastFewDays(Integer daysEntered){
		return fdmDAO.getFoodEncounterEnteredInLastFewDays(daysEntered);
	}
}

