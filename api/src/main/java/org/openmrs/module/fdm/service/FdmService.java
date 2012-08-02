/**
 * 
 */
package org.openmrs.module.fdm.service;

import java.util.List;

import org.openmrs.api.OpenmrsService;
import org.openmrs.module.fdm.model.FoodCombination;
import org.openmrs.module.fdm.model.FoodEncounter;
import org.openmrs.module.fdm.model.FoodPackage;
import org.openmrs.module.fdm.model.FoodPackageCombination;
import org.openmrs.module.fdm.model.FoodPrescription;
import org.openmrs.module.fdm.model.FoodProduct;
import org.openmrs.module.fdm.model.FoodSource;
import org.openmrs.module.fdm.model.FoodWeightRestriction;
import org.openmrs.module.household.model.Household;
import org.springframework.transaction.annotation.Transactional;


/**
 * @author jmwogi
 *
 */
@Transactional
public interface FdmService extends OpenmrsService{
	
	public boolean saveFoodProduct(FoodProduct foodProduct);
	@Transactional(readOnly = true)
	public FoodProduct getFoodProduct(int id);
	@Transactional(readOnly = true)
	public FoodProduct getFoodProduct(String uuid);
	@Transactional(readOnly = true)
	public FoodProduct getFoodProduct(FoodProduct foodProduct);
	public boolean purgeFoodProduct(FoodProduct foodProduct, String retireReason);
	@Transactional(readOnly = true)
	public List<FoodProduct> getFoodProduct(boolean retiredIncluded);
	
	public boolean saveFoodSource(FoodSource foodSource);
	@Transactional(readOnly = true)
	public FoodSource getFoodSource(int id);
	@Transactional(readOnly = true)
	public FoodSource getFoodSource(String uuid);
	@Transactional(readOnly = true)
	public FoodSource getFoodSource(FoodSource foodSource);
	public boolean purgeFoodSource(FoodSource foodSource, String retireReason);
	@Transactional(readOnly = true)
	public List<FoodSource> getFoodSource(boolean retiredIncluded);
	
	public boolean saveFoodEncounter(FoodEncounter foodEncounter);
	@Transactional(readOnly = true)
	public FoodEncounter getFoodEncounter(int id);
	@Transactional(readOnly = true)
	public FoodEncounter getFoodEncounter(String uuid);
	@Transactional(readOnly = true)
	public FoodEncounter getFoodEncounter(FoodEncounter foodEncounter);
	public boolean purgeFoodEncounter(FoodEncounter foodEncounter, String voidReason);
	@Transactional(readOnly = true)
	public List<FoodEncounter> getFoodEncounterByHousehold(Household household, boolean voidedIncluded);
	
	public boolean saveFoodCombination(FoodCombination foodCombination);
	@Transactional(readOnly = true)
	public FoodCombination getFoodCombination(int id);
	@Transactional(readOnly = true)
	public FoodCombination getFoodCombination(String uuid);
	@Transactional(readOnly = true)
	public FoodCombination getFoodCombination(FoodCombination foodCombination);
	public boolean purgeFoodCombination(FoodCombination foodCombination, String voidReason);
	@Transactional(readOnly = true)
	public List<FoodCombination> getFoodCombination(boolean voidedIncluded);
	@Transactional(readOnly = true)
	public List<FoodCombination> getFoodCombinationByFoodSource(FoodSource foodSource, boolean voidedIncluded);
	
	public boolean saveFoodPrescription(FoodPrescription foodPrescription);
	public boolean saveFoodPrescription(List<FoodPrescription> foodPrescriptionList);
	@Transactional(readOnly = true)
	public FoodPrescription getFoodPrescription(int id);
	@Transactional(readOnly = true)
	public FoodPrescription getFoodPrescription(String uuid);
	@Transactional(readOnly = true)
	public FoodPrescription getFoodPrescription(FoodPrescription foodPrescription);
	public boolean purgeFoodPrescription(FoodPrescription foodPrescription, String voidReason);
	@Transactional(readOnly = true)
	public List<FoodPrescription> getFoodPrescriptionByEncounter(FoodEncounter foodEncounter, boolean voidedIncluded);
	
	public boolean saveFoodPackage(FoodPackage foodPackage);
	@Transactional(readOnly = true)
	public FoodPackage getFoodPackage(int id);
	@Transactional(readOnly = true)
	public FoodPackage getFoodPackage(String uuid);
	@Transactional(readOnly = true)
	public FoodPackage getFoodPackageByName(String name);
	@Transactional(readOnly = true)
	public FoodPackage getFoodPackage(FoodPackage foodPackage);
	public boolean purgeFoodPackage(FoodPackage foodPackage, String retireReason);
	@Transactional(readOnly = true)
	public List<FoodPackage> getFoodPackage(boolean retiredIncluded);
	
	public boolean saveFoodPackageCombination(FoodPackageCombination foodPackageCombination);
	@Transactional(readOnly = true)
	public FoodPackageCombination getFoodPackageCombination(int id);
	@Transactional(readOnly = true)
	public FoodPackageCombination getFoodPackageCombination(String uuid);
	@Transactional(readOnly = true)
	public FoodPackageCombination getFoodPackageCombination(FoodPackageCombination foodPackageCombination);
	public boolean purgeFoodPackageCombination(FoodPackageCombination foodPackageCombination, String voidReason);
	@Transactional(readOnly = true)
	public List<FoodPackageCombination> getFoodPackageCombination(FoodPackageCombination foodPackageCombination,boolean voidedIncluded);
	@Transactional(readOnly = true)
	public List<FoodPackageCombination> getFoodPackageCombinationByPackage(FoodPackage foodPackage,boolean voidedIncluded);
	
	public boolean saveFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction);
	@Transactional(readOnly = true)
	public FoodWeightRestriction getFoodWeightRestriction(int id);
	@Transactional(readOnly = true)
	public FoodWeightRestriction getFoodWeightRestriction(String uuid);
	@Transactional(readOnly = true)
	public FoodWeightRestriction getFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction);
	public boolean purgeFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction, String voidReason);
	@Transactional(readOnly = true)
	public List<FoodWeightRestriction> getFoodWeightRestriction(FoodProduct foodProduct, boolean retiredIncluded);
	@Transactional(readOnly = true)
	public List<FoodWeightRestriction> getFoodWeightRestriction(boolean retiredIncluded);
	
	//Statistics methods
	@Transactional(readOnly = true)
	public List<FoodEncounter> getFoodEncounterEnteredInLastFewDays(Integer daysEntered);
	
}
