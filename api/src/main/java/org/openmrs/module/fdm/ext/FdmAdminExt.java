/**
 * 
 */
package org.openmrs.module.fdm.ext;

import java.util.LinkedHashMap;
import java.util.Map;

import org.openmrs.api.context.Context;
import org.openmrs.module.Extension;
import org.openmrs.module.web.extension.AdministrationSectionExt;
import org.openmrs.util.OpenmrsConstants;


/**
 * @author jmwogi
 *
 */
public class FdmAdminExt extends AdministrationSectionExt {
	
	public Extension.MEDIA_TYPE getMediaType() {
		return Extension.MEDIA_TYPE.html;
	}
	
	public String getTitle() {
		return "fdm.manage.title";
	}
	
	public String getRequiredPrivilege() {
		return "View Food Prescription Module";
	}
	
	public Map<String, String> getLinks() {
		// Using linked hash map to keep order of links
		Map<String, String> map = new LinkedHashMap<String, String>();
		if(Context.getAuthenticatedUser().hasPrivilege("Manage Food Configuration"))
			map.put("module/fdm/fdmConfiguration.form", "Configuration");
		if(Context.getAuthenticatedUser().hasPrivilege("Manage Food Prescriptions"))
			map.put("module/fdm/fdmPrescription.form", "Prescription");
		if(Context.getAuthenticatedUser().hasPrivilege("View Food Statistics"))
			map.put("module/fdm/fdmStatistic.form", "Statistics");
		return map;
	}
	
}
