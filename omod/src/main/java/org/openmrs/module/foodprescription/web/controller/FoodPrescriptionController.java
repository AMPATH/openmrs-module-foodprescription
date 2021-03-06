package org.openmrs.module.foodprescription.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Person;
import org.openmrs.api.context.Context;
import org.openmrs.module.foodprescription.model.FoodCombination;
import org.openmrs.module.foodprescription.model.FoodEncounter;
import org.openmrs.module.foodprescription.model.FoodPackage;
import org.openmrs.module.foodprescription.model.FoodSource;
import org.openmrs.module.foodprescription.model.FoodProduct;
import org.openmrs.module.foodprescription.model.FoodWeightRestriction;
import org.openmrs.module.foodprescription.service.FoodPrescriptionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class FoodPrescriptionController {
	private static final Log log = LogFactory.getLog(FoodPrescriptionController.class);
	Set <Person> personListMap = new HashSet<Person>();
	
    @RequestMapping("/module/foodprescription/prescription")
    public void asPageLoads(ModelMap map) {
    	
    	FoodPrescriptionService service = Context.getService(FoodPrescriptionService.class);
    	
    	List<FoodProduct> allFoodsProduct = service.getFoodProduct(false);
    	List<FoodSource> allFoodsSource = service.getFoodSource(false);
    	
		map.addAttribute("allFoodsProduct",allFoodsProduct );
		map.addAttribute("allFoodsSource",allFoodsSource );
    }
    
    @RequestMapping("/module/foodprescription/configuration")
	public String showConfigurationForm(ModelMap map) throws Exception {
    	FoodPrescriptionService service = Context.getService(FoodPrescriptionService.class);
		List<FoodSource> foodSource = service.getFoodSource(false);
		FoodSource fs = new FoodSource();
		if(foodSource.size() != 0)
			fs = foodSource.get(0);
		List<FoodProduct> foodProduct = service.getFoodProduct(false);
		List<FoodCombination> foodCombination = service.getFoodCombinationByFoodSource(fs, false);
		List<FoodProduct> allFoodsProduct=service.getFoodProduct(false);
    	List<FoodSource> allFoodsSource=service.getFoodSource(false);
    	List<FoodPackage> allFoodPackage=service.getFoodPackage(false);
    	List<FoodWeightRestriction> foodWeightRestriction = service.getFoodWeightRestriction(false);
		map.addAttribute("foodSource", foodSource);
		map.addAttribute("foodProduct", foodProduct);
		map.addAttribute("foodMapm", foodCombination);
		map.addAttribute("allFoodProduct",allFoodsProduct );
		map.addAttribute("allFoodSource",allFoodsSource );
		map.addAttribute("foodMapCom", foodCombination);
		map.addAttribute("foodPackage", allFoodPackage);
		map.addAttribute("foodWeightRestriction", foodWeightRestriction);
		
    	return "/module/foodprescription/configuration";
	}
    
    @RequestMapping("/module/foodprescription/statistic")
	public void showStatisticForm(ModelMap map) throws Exception {
    	FoodPrescriptionService service = Context.getService(FoodPrescriptionService.class);
    	//day = 1, week = 5, month = 30
    	List<FoodEncounter> foodEncounterDay=service.getFoodEncounterEnteredInLastFewDays(1);
    	/*map.addAttribute("dayCount", foodEncounterDurationMap(foodEncounterDay));
    	log.error(foodEncounterDay.size());*/
    	List<FoodEncounter> foodEncounterWeek=service.getFoodEncounterEnteredInLastFewDays(5);
    	/*map.addAttribute("weekCount", foodEncounterDurationMap(foodEncounterWeek));
    	log.error(foodEncounterWeek.size());*/
    	List<FoodEncounter> foodEncounterMonth=service.getFoodEncounterEnteredInLastFewDays(30);
    	/*map.addAttribute("monthCount", foodEncounterDurationMap(foodEncounterMonth));
    	log.error(foodEncounterMonth.size());*/
    	
    	//create a list of persons from all lists
    	Map< Person, Integer > map1 = foodEncounterDurationMap(foodEncounterDay);
    	Map< Person, Integer > map2 = foodEncounterDurationMap(foodEncounterWeek);
    	Map< Person, Integer > map3 = foodEncounterDurationMap(foodEncounterMonth);
    	Map<Person, Integer [] > returnMap = new HashMap<Person, Integer[]>();
    	for(Person person: personListMap){
    		Integer x =0, y=0, z=0;
    		for(Person per: map1.keySet()){
    			if(person.equals(per)){
    				x = map1.get(person);
    				break;
				}
    		}
    		for(Person per: map2.keySet()){
    			if(person.equals(per)){
    				y = map2.get(person);
    				break;
				}
    		}
    		for(Person per: map3.keySet()){
    			if(person.equals(per)){
    				z = map3.get(person);
    				break;
				}
    		}
    		Integer [] arrInt = {x,y,z};
    		returnMap.put(person, arrInt);	
    	}
    	map.addAttribute("listMap", returnMap);
	}
	
    private Map< Person, Integer > foodEncounterDurationMap(List<FoodEncounter> fe){
    	//Get a list of persons Who have done data entry
    	Set<Person> p = new HashSet<Person>();
    	for(FoodEncounter e: fe){
    		p.add(e.getCreator().getPerson());
    	}
    	//Go through persons list and count the encounters they have entered
    	List<Person> lstPerson = new ArrayList<Person>();
    	Map<Person, Integer > personWorkMap = new HashMap<Person, Integer>();
    	for(Person person: p){
    		int x = 0;
    		for(FoodEncounter e: fe){
    			if(person.equals(e.getCreator().getPerson()))
    				x++;
        	}
    		personWorkMap.put(person,x);
    	}
    	personListMap.addAll(p);
    	return personWorkMap;
    }
	
}