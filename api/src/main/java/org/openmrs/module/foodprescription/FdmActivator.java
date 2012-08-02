package org.openmrs.module.foodprescription;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.Activator;


/**
 * 
 */

/**
 * @author jmwogi
 *
 */
public class FdmActivator implements Activator {
	private static Log log = LogFactory.getLog(FdmActivator.class);
	/* (non-Javadoc)
	 * @see org.openmrs.module.Activator#startup()
	 */
	public void startup() {
		log.info("Starting Food Distribution module");
	}
	
	/* (non-Javadoc)
	 * @see org.openmrs.module.Activator#shutdown()
	 */
	public void shutdown() {
		log.info("Stopping Food Distribution module");
	}
	
}
