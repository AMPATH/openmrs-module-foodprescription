package org.openmrs.module.fdm.web.dwr;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Location;
import org.openmrs.Person;
import org.openmrs.api.LocationService;
import org.openmrs.api.context.Context;
import org.openmrs.module.fdm.model.*;
import org.openmrs.module.fdm.service.FdmService;
import org.openmrs.module.household.model.Household;
import org.openmrs.module.household.model.HouseholdMembership;
import org.openmrs.module.household.service.HouseholdService;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class DWRFoodService {
	
	private static final Log log = LogFactory.getLog(DWRFoodService.class);
	
	public boolean addEditFoodSource(String [] passedArr){
		FdmService service = Context.getService(FdmService.class);
		
		if(passedArr[0].equals("1")){
			FoodSource fs = new FoodSource(passedArr[2], passedArr[3], passedArr[4]);
			service.saveFoodSource(fs);
		}else if(passedArr[0].equals("2")){
			FoodSource fs = service.getFoodSource(Integer.parseInt(passedArr[1]));
			fs.setCode(passedArr[2]);
			fs.setName(passedArr[3]);
			fs.setDescription(passedArr[4]);
			service.saveFoodSource(fs);
		}else if(passedArr[0].equals("3")){
			FoodSource fs = service.getFoodSource(Integer.parseInt(passedArr[1]));
			return service.purgeFoodSource(fs,passedArr[4]);
		}
		return false;
	}
	
	public boolean addEditFoodProduct(String [] passedArr){
		FdmService service = Context.getService(FdmService.class);
		
		if(passedArr[0].equals("1")){
			FoodProduct fp = new FoodProduct(passedArr[2]);
			if(StringUtils.isNotEmpty(passedArr[4]))
				fp.setIndividualized(true);
			service.saveFoodProduct(fp);
		}else if(passedArr[0].equals("2")){
			FoodProduct fp = service.getFoodProduct(Integer.parseInt(passedArr[1]));
			if(StringUtils.isNotEmpty(passedArr[4]))
				fp.setIndividualized(true);
			else
				fp.setIndividualized(false);
			fp.setName(passedArr[3]);
			service.saveFoodProduct(fp);
		}else if(passedArr[0].equals("3")){
			FoodProduct fp = service.getFoodProduct(Integer.parseInt(passedArr[1]));
			return service.purgeFoodProduct(fp,passedArr[3]);
		}
		return false;
	}
	/**
	 * Get Households by personID
	 * @Param personID
	 */
	@SuppressWarnings("null")
    public static List<HouseholdMembership> getHouseholdsByPersonID(String personID){
		List<HouseholdMembership> hm = new ArrayList<HouseholdMembership>();
		
		Person p = Context.getPersonService().getPerson(Integer.parseInt(personID));
		HouseholdService service = Context.getService(HouseholdService.class);
		List<HouseholdMembership> householdMem = service.getAllHouseholdMembershipsByPerson(p);
		
		String definitionCode = Context.getAdministrationService().getGlobalProperty("fdm.householdDefinitionCode");
		String []def = null;
		if(definitionCode.contains(","))
			def = definitionCode.split(",");
		else
			def[0] = definitionCode;
		for (HouseholdMembership householdMembership : householdMem) {
	        for (int i = 0; i < def.length; i++) {
	        	if(householdMembership.getHouseholdMembershipGroups().getHouseholdDef().getHouseholdDefinitionsCode().equals(def[i]))
	        		hm.add(householdMembership);
            }
        }
		return hm;
	}
	
	public boolean addEditFoodCombination(String [] passedArr){
		FdmService service = Context.getService(FdmService.class);
		
		if(passedArr[0].equals("1")){
			FoodSource fs = service.getFoodSource(Integer.parseInt(passedArr[2]));
			FoodProduct fp = service.getFoodProduct(Integer.parseInt(passedArr[3]));
			FoodCombination fc = new FoodCombination(fs, fp);
			
			List<FoodCombination> comb = service.getFoodCombinationByFoodSource(fs, false);

			for (FoodCombination foodCombination : comb) {
	            if(foodCombination.getFoodProduct().equals(fp))
	            	return false;
            }
			fc.setDispensable(true);
			return service.saveFoodCombination(fc);
		}else if(passedArr[0].equals("2")){
			FoodCombination fc = service.getFoodCombination(Integer.parseInt(passedArr[1]));
			if(fc.isDispensable())
				fc.setDispensable(false);
			else
				fc.setDispensable(true);
			return service.saveFoodCombination(fc);
		}else if(passedArr[0].equals("3")){
			FoodCombination fc = service.getFoodCombination(Integer.parseInt(passedArr[1]));
			return service.purgeFoodCombination(fc,passedArr[3]);
		}
		return false;
	}
	
	public void savePrescription(String household,String foodProduct,String foodSource,String foodEncounter,String provide){
		
	}
	
	public boolean populatePackage(String []pack){
		FdmService service = Context.getService(FdmService.class);
		
		FoodPackage fp = new FoodPackage();
		
		List<String> passedCombination = new ArrayList<String>();
		String [] pop = null;
		if (pack[0].contains(",")){
			pop = pack[0].split(",");
			for (int i = 0; i < pop.length; i++)
				passedCombination.add(pop[i]);
		}else
			passedCombination.add(pack[0]);
		String packageName = pack[1];
		fp.setName(packageName);
		
		boolean isPackageSaved = service.saveFoodPackage(fp);
		
		FoodPackage fpack = service.getFoodPackageByName(packageName);
		
		boolean nini = true;
		if(isPackageSaved){
			for (int i = 0; i < passedCombination.size(); i++) {
				FoodCombination fc = service.getFoodCombination(Integer.parseInt(passedCombination.get(i)));
				FoodPackageCombination foodPackageCombination = new FoodPackageCombination(fc,fpack);
		        nini = service.saveFoodPackageCombination(foodPackageCombination);
		        if (!nini)
		        	break;
	        }
			return nini;
		}else
			return false;
	}
	public boolean addFoodPrescription(String [] arrData) throws ParseException{
		FdmService service = Context.getService(FdmService.class);
		
		Household household = Context.getService(HouseholdService.class).getHouseholdGroup(Integer.parseInt(arrData[0]));
		Location location = Context.getService(LocationService.class).getLocation(Integer.parseInt(arrData[1]));
		FoodPackage foodPackage = service.getFoodPackage(Integer.parseInt(arrData[2]));
		Person provider = Context.getPersonService().getPerson(Integer.parseInt(arrData[3]));
		String additionalFoodPresc = arrData[5];
		String []individualized = null;
		if(StringUtils.isNotEmpty(arrData[6]))
			individualized = arrData[6].split(",");
		
		List<String> passedCombination = new ArrayList<String>();
		if(StringUtils.isNotEmpty(additionalFoodPresc)){
			String [] pop = null;
			if (additionalFoodPresc.contains(",")){
				pop = additionalFoodPresc.split(",");
				for (int i = 0; i < pop.length; i++)
					passedCombination.add(pop[i]);
			}else
				passedCombination.add(additionalFoodPresc);
		}
		
		FoodEncounter foodEncounter = new FoodEncounter();
		foodEncounter.setHousehold(household);
		foodEncounter.setLocation(location);
		foodEncounter.setProvider(provider);
		foodEncounter.setSerialno(Integer.parseInt(arrData[7]));
		if(StringUtils.isNotEmpty(arrData[4]))
			foodEncounter.setEncounterDatetime(dateFormatHelper(arrData[4]));
		else
			foodEncounter.setEncounterDatetime(new Date());
		service.saveFoodEncounter(foodEncounter);
		
		List<FoodCombination> foodCombination = new ArrayList<FoodCombination>();
		List<FoodPackageCombination> foodPackageCombination = service.getFoodPackageCombinationByPackage(foodPackage, false);
		for (int i = 0; i < foodPackageCombination.size(); i++) {
			foodCombination.add(foodPackageCombination.get(i).getFoodCombination());
        }
		if(passedCombination!=null){
			for (int i = 0; i < passedCombination.size(); i++) {
				FoodCombination fc = service.getFoodCombination(Integer.parseInt(passedCombination.get(i)));
				foodCombination.add(fc);
	        }
		}
		
		String memberID = "";
		List<HouseholdMembership> hmem = Context.getService(HouseholdService.class).getAllHouseholdMembershipsByGroup(household);
		List<Person> personList = new ArrayList<Person>();
		List<Person> personListOrig = new ArrayList<Person>();
		List<Person> personListMod;
		for (HouseholdMembership householdMembership : hmem) {
			memberID += householdMembership.getHouseholdMembershipMember().getPersonId() + ",";
			personListOrig.add(householdMembership.getHouseholdMembershipMember());
        }
		List<FoodPrescription> foodPrescriptionList = new ArrayList<FoodPrescription>();
		for (int i = 0; i < foodCombination.size(); i++) {
			personList = personListOrig;
			personListMod = new ArrayList<Person>();
			FoodPrescription foodPrescription = new FoodPrescription();
			foodPrescription.setFoodCombination(foodCombination.get(i));
			foodPrescription.setSerialno(Integer.parseInt(arrData[7]));
			
			String memIDs = "";
			
			if(foodCombination.get(i).getFoodProduct().getIndividualized()){
				for(int k=0; k<individualized.length; k++){
					String ind = individualized[k];
					String str[] = ind.split(":");
					if(foodCombination.get(i).getId() == Integer.parseInt(str[0])){
						memIDs = str[1] + "," + memIDs;
						personListMod.add(Context.getPersonService().getPerson(Integer.parseInt(str[1])));
					}
				}
				if(StringUtils.isNotEmpty(memIDs)){
					personList = personListMod;
					foodPrescription.setHouseholdMemberCount(memIDs);
				}else
					continue;
			}
			else
				foodPrescription.setHouseholdMemberCount(memberID);
			/*
			 * 1. Get List<FoodWeightRestriction> foodWeightRestriction based on the product
			 * 2a. If(foodWeightRestriction.size() == 0) provide a default quantity of 1kg for a prescription
			 * 2b. If(foodWeightRestriction.size() == 1) if age restriction == 0 for start and stop then use quantity provided for all prescription
			 * 2b1. If(foodWeightRestriction.size() == 1) if age restriction varies for start and stop then use quantity provided for prescription accordingly
			 * 2b. If(foodWeightRestriction.size() > 1) if age restriction apply for start and stop then use quantity provided for relevant prescription
			 */
			List<FoodWeightRestriction> foodWeightRestriction =  service.getFoodWeightRestriction(foodCombination.get(i).getFoodProduct(), false);
			if(foodWeightRestriction.size() == 0)
				foodPrescription.setQuantity(0.0);
			else if(foodWeightRestriction.size() == 1){
				if((foodWeightRestriction.get(0).getStartAge() == 0.0 ) && (foodWeightRestriction.get(0).getStopAge() == 0.0)){
					Double m = personList.size() * foodWeightRestriction.get(0).getQuantity();
					foodPrescription.setQuantity(m);
				}else{
					int gotMem = membersAgeRestriction(personList, foodWeightRestriction.get(0).getStartAge(), foodWeightRestriction.get(0).getStopAge() );
					Double m =gotMem * foodWeightRestriction.get(0).getQuantity();
					foodPrescription.setQuantity(m);
				}
			}else if(foodWeightRestriction.size() > 1){
				/*
				 * Loop through List<FoodWeightRestriction> foodWeightRestriction
				 * pass the restrictions to the counterByAge of members passing Start and Stop age and members of the household
				 * The method should return the number of members fitting the restriction 
				 */
				Double quan = 0.0;
				for(FoodWeightRestriction foodWeightRestrict: foodWeightRestriction){
					int gotMem = membersAgeRestriction(personList, foodWeightRestrict.getStartAge(), foodWeightRestrict.getStopAge() );
					quan += gotMem * foodWeightRestrict.getQuantity();
				}
				foodPrescription.setQuantity(quan);
			}
			
			
			foodPrescription.setFoodEncounter(foodEncounter);
			foodPrescription.setHousehold(household);
			foodPrescription.setProvider(provider);
			if(StringUtils.isNotEmpty(arrData[4]))
				foodPrescription.setPrescriptionDate(dateFormatHelper(arrData[4]));
			else
				foodPrescription.setPrescriptionDate(new Date());
			
			foodPrescriptionList.add(foodPrescription);
        }
		return service.saveFoodPrescription(foodPrescriptionList);
	}
	
	private int membersAgeRestriction(List<Person> hmem, Double startAge, Double stopAge ){
		int ret = 0;
		for(int i=0; i<hmem.size();i++){
			int ageOfMember = hmem.get(i).getAge();
			if((ageOfMember >= startAge) && (ageOfMember<stopAge))
				ret++;
		}
		return ret;
	}
	
	public boolean pickedAllPrescription(String arrData) throws ParseException{
		boolean pick = false;
		FdmService service = Context.getService(FdmService.class);
		
		if (arrData != null){
			FoodEncounter foodEncounter = service.getFoodEncounter(arrData);
			List<FoodPrescription> fpl = service.getFoodPrescriptionByEncounter(foodEncounter, false);
			try {
				for (@SuppressWarnings("rawtypes")
                Iterator iterator = fpl.iterator(); iterator.hasNext();) {
					FoodPrescription foodPrescription = (FoodPrescription) iterator.next();
					foodPrescription.setPicked(true);
					service.saveFoodPrescription(foodPrescription);
				}
            }
            catch (Exception e) {
	            return pick;
            }
            foodEncounter.setPicked(true);
			return service.saveFoodEncounter(foodEncounter);
		}
		return pick;
	}
	
	public boolean pickedSomePrescription(String [] arrData) throws ParseException{
		Context.clearSession();
		FdmService service = Context.getService(FdmService.class);
		boolean pick = false;
		List<String> presc = new ArrayList<String>();
		if(StringUtils.isNotEmpty(arrData[1])){
			String [] pop = null;
			if (arrData[1].contains(",")){
				pop = arrData[1].split(",");
				for (int i = 0; i < pop.length; i++)
					presc.add(pop[i]);
			}else
				presc.add(arrData[1]);
		}
		List<FoodPrescription> fp = new ArrayList<FoodPrescription>();
		for(int i=0; i<presc.size(); i++){
			FoodPrescription pr = service.getFoodPrescription(Integer.parseInt(presc.get(i)));
			pr.setPicked(true);
			fp.add(pr);
		}
		try {
			FdmService fs = Context.getService(FdmService.class);
	        FoodEncounter foodEncounter = fs.getFoodEncounter(arrData[0]);
	        foodEncounter.setPicked(true);
			if(!fs.saveFoodEncounter(foodEncounter))
				return pick;
		}
		catch (Exception e) {
			return pick;
		}
		return service.saveFoodPrescription(fp);
		
	}
	public boolean pickedNewPrescription( String [] arrData) throws ParseException{
		Context.clearSession();
		
			FdmService fs = Context.getService(FdmService.class);
			List<String> passedCombination = new ArrayList<String>();
			FoodEncounter foodEncounter = fs.getFoodEncounter(Integer.parseInt(arrData[0]));
			Person provider = Context.getPersonService().getPerson(Integer.parseInt(arrData[2]));
			if(StringUtils.isNotEmpty(arrData[1])){
				String [] pop = null;
				if (arrData[1].contains(",")){
					pop = arrData[1].split(",");
					for (int i = 0; i < pop.length; i++)
						passedCombination.add(pop[i]);
				}else
					passedCombination.add(arrData[1]);
			}
			List<FoodCombination> foodCombination = new ArrayList<FoodCombination>();
			if(passedCombination!=null){
				for (int i = 0; i < passedCombination.size(); i++) {
					FoodCombination fc = fs.getFoodCombination(Integer.parseInt(passedCombination.get(i)));
					foodCombination.add(fc);
		        }
			}
			FdmService service = Context.getService(FdmService.class);
			Household hs = foodEncounter.getHousehold();
			String memberID = "";
			List<HouseholdMembership> hmem = Context.getService(HouseholdService.class).getAllHouseholdMembershipsByGroup(hs);
			for (HouseholdMembership householdMembership : hmem) {
				memberID += householdMembership.getHouseholdMembershipMember().getPersonId() + ",";
	        }
			
			List<FoodPrescription> foodPrescriptionList = new ArrayList<FoodPrescription>();
			for (int i = 0; i < foodCombination.size(); i++) {
				FoodPrescription foodPrescription = new FoodPrescription();
				foodPrescription.setFoodCombination(foodCombination.get(i));
				foodPrescription.setFoodEncounter(foodEncounter);
				foodPrescription.setHousehold(hs);
				foodPrescription.setHouseholdMemberCount(memberID);
				foodPrescription.setProvider(provider);
				if(StringUtils.isNotEmpty(arrData[3]))
					foodPrescription.setPrescriptionDate(dateFormatHelper(arrData[3]));
				else
					foodPrescription.setPrescriptionDate(new Date());
				foodPrescriptionList.add(foodPrescription);
	        }
		try {
			return service.saveFoodPrescription(foodPrescriptionList);
        }
        catch (Exception e) {
        	return false;
        }
	}
	
	public boolean saveEditedQuantity( String [] arrData){
		boolean saved = false;
		FdmService service = Context.getService(FdmService.class);
		FoodPrescription foodPrescription = service.getFoodPrescription(Integer.parseInt(arrData[0]));
		foodPrescription.setQuantity(Double.parseDouble(arrData[1]));
		saved = service.saveFoodPrescription(foodPrescription);
		return saved;
	}
	
	public boolean purgeFoodPackage(String [] arrData){
		FdmService service = Context.getService(FdmService.class);
		FoodPackage foodPackage = service.getFoodPackage(Integer.parseInt(arrData[0]));
		return service.purgeFoodPackage(foodPackage, arrData[1]);
	}
	
	public boolean addEditFoodWeightRestriction( String [] arrData){
		FdmService service = Context.getService(FdmService.class);
		boolean saved = false;
		int firstTask = Integer.parseInt(arrData[0]);
		String quantity = "0";
		String startAge = "0";
		String stopAge = "0";
		if(StringUtils.isNotEmpty(arrData[3]))
			quantity = arrData[3] ;
		if(StringUtils.isNotEmpty(arrData[4]))
			startAge = arrData[4] ;
		if(StringUtils.isNotEmpty(arrData[5]))
			stopAge = arrData[5] ;
		
		if(firstTask == 1){
			FoodProduct foodProduct = service.getFoodProduct(Integer.parseInt(arrData[2]));
			FoodWeightRestriction foodWeightRestriction = new FoodWeightRestriction(foodProduct, Double.parseDouble(quantity), 
				Double.parseDouble(startAge), Double.parseDouble(stopAge));
			saved = service.saveFoodWeightRestriction(foodWeightRestriction);
		}else if(firstTask == 2){
			FoodProduct foodProduct = service.getFoodProduct(Integer.parseInt(arrData[2]));
			FoodWeightRestriction foodWeightRestriction = service.getFoodWeightRestriction(Integer.parseInt(arrData[1]));
			foodWeightRestriction.setFoodProduct(foodProduct);
			foodWeightRestriction.setQuantity(Double.parseDouble(quantity));
			foodWeightRestriction.setStartAge(Double.parseDouble(startAge));
			foodWeightRestriction.setStopAge(Double.parseDouble(stopAge));
			saved = service.saveFoodWeightRestriction(foodWeightRestriction);
		}else if(firstTask == 3){
			FoodWeightRestriction foodWeightRestriction = service.getFoodWeightRestriction(Integer.parseInt(arrData[1]));
			saved = service.purgeFoodWeightRestriction(foodWeightRestriction, arrData[6]);
		}
		
		return saved;
	}
	
	static DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy"); 
	private static Date dateFormatHelper(String strvalue) throws ParseException {
		if (strvalue == null || strvalue.length() == 0)
			return new Date();
		else
			return dateFormat.parse(strvalue);
	}
}
