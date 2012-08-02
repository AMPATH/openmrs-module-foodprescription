package org.openmrs.module.fdm.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.openmrs.BaseOpenmrsData;
import org.openmrs.Location;
import org.openmrs.Person;
import org.openmrs.api.context.Context;
import org.openmrs.module.household.model.Household;


public class FoodEncounter extends BaseOpenmrsData {
	private Integer id;
	private String uuid;
	private Household household;
	private Location location;
	private Date encounterDatetime;
	private Person provider;
	private String householdMemberCount;
	private Boolean picked = Boolean.FALSE;
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
	public void setLocation(Location location) {
	    this.location = location;
    }
	public Location getLocation() {
	    return location;
    }
	public void setEncounterDatetime(Date encounterDatetime) {
	    this.encounterDatetime = encounterDatetime;
    }
	public Date getEncounterDatetime() {
	    return encounterDatetime;
    }
	public Person getProvider() {
		return provider;
	}
	public void setProvider(Person provider) {
		this.provider = provider;
	}
	/*public void setRegisteredPerson(List<Person> registeredPerson) {
	    this.registeredPerson = registeredPerson;
    }*/
	public List<Person> getRegisteredPerson() {
		String [] pp = this.householdMemberCount.split(",");
		List<Person> plist = new ArrayList<Person>();
		for (int i = 0; i < pp.length-1; i++) {
			plist.add(Context.getPersonService().getPerson(Integer.parseInt(pp[i])));
        }
		return plist;
    }
	public void setHouseholdMemberCount(String householdMemberCount) {
	    this.householdMemberCount = householdMemberCount;
    }
	public String getHouseholdMemberCount() {
	    return householdMemberCount;
    }
	public void setPicked(Boolean picked) {
		this.picked = picked;
	}
	public Boolean getPicked() {
		return this.picked;
	}
	public void setSerialno(Integer serialno) {
	    this.serialno = serialno;
    }
	public Integer getSerialno() {
	    return serialno;
    }
	
}
