/**
 * 
 */
package org.openmrs.module.fdm.dao.hibernate;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.openmrs.api.context.Context;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.fdm.dao.FdmDAO;
import org.openmrs.module.fdm.model.FoodCombination;
import org.openmrs.module.fdm.model.FoodEncounter;
import org.openmrs.module.fdm.model.FoodPackage;
import org.openmrs.module.fdm.model.FoodPackageCombination;
import org.openmrs.module.fdm.model.FoodPrescription;
import org.openmrs.module.fdm.model.FoodProduct;
import org.openmrs.module.fdm.model.FoodSource;
import org.openmrs.module.fdm.model.FoodWeightRestriction;
import org.openmrs.module.household.model.Household;


/**
 * @author jmwogi
 *
 */
public class HibernateFdmDAO implements FdmDAO {
	
	private SessionFactory sessionFactory;
	
	
    /**
     * @return the sessionFactory
     */
    public SessionFactory getSessionFactory() {
    	return sessionFactory;
    }

    /**
     * @param sessionFactory the sessionFactory to set SessionFactory
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
    	this.sessionFactory = sessionFactory;
    }

	public boolean saveFoodProduct(FoodProduct foodProduct) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodProduct);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	public FoodProduct getFoodProduct(int id) {
		return (FoodProduct) sessionFactory.getCurrentSession().get(FoodProduct.class, id);
    }

	public FoodProduct getFoodProduct(String uuid) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodProduct.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodProduct> hp = criteria.list();
		if (null == hp || hp.isEmpty()) {
			return null;
		}
		return hp.get(0);
    }

	public FoodProduct getFoodProduct(FoodProduct foodProduct) {
	    if (foodProduct.getId() != null){
	    	return (FoodProduct) sessionFactory.getCurrentSession().get(FoodProduct.class, foodProduct.getId());
	    }else if(foodProduct.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodProduct.class).add(
			    Expression.eq("uuid", foodProduct.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodProduct> hp = criteria.list();
			if (null == hp || hp.isEmpty()) {
				return null;
			}
			return hp.get(0);
	    }else
	    	return null;
    }

	public boolean purgeFoodProduct(FoodProduct foodProduct, String retireReason) {
		foodProduct.setRetired(true);
		foodProduct.setRetiredBy(Context.getUserContext().getAuthenticatedUser());
		foodProduct.setRetireReason(retireReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodProduct);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	public List<FoodProduct> getFoodProduct(boolean retiredIncluded) {
		Criteria criteria;
		if(!retiredIncluded){
			criteria = sessionFactory.getCurrentSession().createCriteria(FoodProduct.class).add(
			    Expression.eq("retired", retiredIncluded));
		}else
			criteria = sessionFactory.getCurrentSession().createCriteria(FoodProduct.class);
		
		
		@SuppressWarnings("unchecked")
		List<FoodProduct> fp = criteria.list();
		return fp;
    }

	public boolean saveFoodSource(FoodSource foodSource) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodSource);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	public FoodSource getFoodSource(int id) {
		return (FoodSource) sessionFactory.getCurrentSession().get(FoodSource.class, id);
    }

	@Override
    public FoodSource getFoodSource(String uuid) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodSource.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodSource> hs = criteria.list();
		if (null == hs || hs.isEmpty()) {
			return null;
		}
		return hs.get(0);
    }

	public FoodSource getFoodSource(FoodSource foodSource) {
	    if (foodSource.getId() != null){
	    	return (FoodSource) sessionFactory.getCurrentSession().get(FoodSource.class, foodSource.getId());
	    }else if (foodSource.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodSource.class).add(
			    Expression.eq("uuid", foodSource.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodSource> hs = criteria.list();
			if (null == hs || hs.isEmpty()) {
				return null;
			}
			return hs.get(0);
	    }else
	    	return null;
    }

	public boolean purgeFoodSource(FoodSource foodSource, String retireReason) {
		foodSource.setRetired(true);
		foodSource.setRetiredBy(Context.getUserContext().getAuthenticatedUser());
		foodSource.setRetireReason(retireReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodSource);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	@Override
    public List<FoodSource> getFoodSource(boolean retiredIncluded) {
		Criteria criteria;
		if(!retiredIncluded){
			criteria = sessionFactory.getCurrentSession().createCriteria(FoodSource.class).add(
			    Expression.eq("retired", retiredIncluded));
		}else
			criteria = sessionFactory.getCurrentSession().createCriteria(FoodSource.class);
		
		@SuppressWarnings("unchecked")
		List<FoodSource> fs = criteria.list();
		return fs;
    }

	public boolean saveFoodEncounter(FoodEncounter foodEncounter) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodEncounter);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	public FoodEncounter getFoodEncounter(int id) {
		return (FoodEncounter) sessionFactory.getCurrentSession().get(FoodEncounter.class, id);
    }

	public FoodEncounter getFoodEncounter(String uuid) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodEncounter.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodEncounter> he = criteria.list();
		if (null == he || he.isEmpty()) {
			return null;
		}
		return he.get(0);
    }

	public FoodEncounter getFoodEncounter(FoodEncounter foodEncounter) {
	    if (foodEncounter.getId() != null){
	    	return (FoodEncounter) sessionFactory.getCurrentSession().get(FoodEncounter.class, foodEncounter.getId());
	    }else if(foodEncounter.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodEncounter.class).add(
			    Expression.eq("uuid", foodEncounter.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodEncounter> he = criteria.list();
			if (null == he || he.isEmpty()) {
				return null;
			}
			return he.get(0);
	    }else
	    	return null;
    }

	public boolean purgeFoodEncounter(FoodEncounter foodEncounter, String voidReason) {
		foodEncounter.setVoided(true);
		foodEncounter.setVoidedBy(Context.getUserContext().getAuthenticatedUser());
		foodEncounter.setVoidReason(voidReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodEncounter);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	public List<FoodEncounter> getFoodEncounterByHousehold(Household household, boolean voidedIncluded) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodEncounter.class).add(
		    Expression.eq("voided", voidedIncluded)).add(
			    Expression.eq("household", household)).addOrder(
				    Order.desc("encounterDatetime"));
		
		@SuppressWarnings("unchecked")
		List<FoodEncounter> fe = criteria.list();
		return fe;
    }
	
	public boolean saveFoodCombination(FoodCombination foodCombination){
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodCombination);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public FoodCombination getFoodCombination(int id){
		return (FoodCombination) sessionFactory.getCurrentSession().get(FoodCombination.class, id);
	}
	public FoodCombination getFoodCombination(String uuid){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodCombination.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodCombination> fc = criteria.list();
		if (null == fc || fc.isEmpty()) {
			return null;
		}
		return fc.get(0);
	}
	public FoodCombination getFoodCombination(FoodCombination foodCombination){
		if (foodCombination.getId() != null){
	    	return (FoodCombination) sessionFactory.getCurrentSession().get(FoodCombination.class, foodCombination.getId());
	    }else if(foodCombination.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodCombination.class).add(
			    Expression.eq("uuid", foodCombination.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodCombination> fc = criteria.list();
			if (null == fc || fc.isEmpty()) {
				return null;
			}
			return fc.get(0);
	    }else
	    	return null;
	}
	public boolean purgeFoodCombination(FoodCombination foodCombination, String voidReason){
		foodCombination.setVoided(true);
		foodCombination.setVoidedBy(Context.getUserContext().getAuthenticatedUser());
		foodCombination.setVoidReason(voidReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodCombination);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public List<FoodCombination> getFoodCombination(boolean voidedIncluded){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodCombination.class).add(
		    Expression.eq("voided", voidedIncluded));
		
		@SuppressWarnings("unchecked")
		List<FoodCombination> fc = criteria.list();
		return fc;
	}
	public List<FoodCombination> getFoodCombinationByFoodSource(FoodSource foodSource, boolean voidedIncluded){
		Criteria criteria;
		if(!voidedIncluded){
			criteria = sessionFactory.getCurrentSession().createCriteria(FoodCombination.class).add(
				Expression.eq("voided", voidedIncluded)).add(
			    Expression.eq("foodSource", foodSource));
		}else
			criteria = sessionFactory.getCurrentSession().createCriteria(FoodCombination.class).add(
			    Expression.eq("foodSource", foodSource));
		
		@SuppressWarnings("unchecked")
		List<FoodCombination> fc = criteria.list();
		return fc;
	}
	
	public boolean saveFoodPrescription(List<FoodPrescription> foodPrescriptionList) throws DAOException {
		try {
			for (FoodPrescription foodPrescription : foodPrescriptionList) {
				sessionFactory.getCurrentSession().saveOrUpdate(foodPrescription);
            }
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }
	
	public boolean saveFoodPrescription(FoodPrescription foodPrescription) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodPrescription);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	public FoodPrescription getFoodPrescription(int id) {
		return (FoodPrescription) sessionFactory.getCurrentSession().get(FoodPrescription.class, id);
    }

	public FoodPrescription getFoodPrescription(String uuid) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPrescription.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodPrescription> hp = criteria.list();
		if (null == hp || hp.isEmpty()) {
			return null;
		}
		return hp.get(0);
    }

	public FoodPrescription getFoodPrescription(FoodPrescription foodPrescription) {
	    if (foodPrescription.getId() != null){
	    	return (FoodPrescription) sessionFactory.getCurrentSession().get(FoodPrescription.class, foodPrescription.getId());
	    }else if(foodPrescription.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPrescription.class).add(
			    Expression.eq("uuid", foodPrescription.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodPrescription> hp = criteria.list();
			if (null == hp || hp.isEmpty()) {
				return null;
			}
			return hp.get(0);
	    }else
	    	return null;
    }

	public boolean purgeFoodPrescription(FoodPrescription foodPrescription, String voidReason) {
		foodPrescription.setVoided(true);
		foodPrescription.setVoidedBy(Context.getUserContext().getAuthenticatedUser());
		foodPrescription.setVoidReason(voidReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodPrescription);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
    }

	public List<FoodPrescription> getFoodPrescriptionByEncounter(FoodEncounter foodEncounter, boolean voidedIncluded) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPrescription.class).add(
		    Expression.eq("voided", voidedIncluded)).add(
			    Expression.eq("foodEncounter", foodEncounter));
		
		@SuppressWarnings("unchecked")
		List<FoodPrescription> fp = criteria.list();
		return fp;
    }
    
	public boolean saveFoodPackage(FoodPackage foodPackage){
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodPackage);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public FoodPackage getFoodPackage(int id){
		return (FoodPackage) sessionFactory.getCurrentSession().get(FoodPackage.class, id);
	}
	public FoodPackage getFoodPackage(String uuid){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackage.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodPackage> fp = criteria.list();
		if (null == fp || fp.isEmpty()) {
			return null;
		}
		return fp.get(0);
	}
	public FoodPackage getFoodPackageByName(String name){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackage.class).add(
		    Expression.eq("name", name));
		@SuppressWarnings("unchecked")
		List<FoodPackage> fp = criteria.list();
		if (null == fp || fp.isEmpty()) {
			return null;
		}
		return fp.get(0);
	}
	public FoodPackage getFoodPackage(FoodPackage foodPackage){
		if (foodPackage.getId() != null){
	    	return (FoodPackage) sessionFactory.getCurrentSession().get(FoodPackage.class, foodPackage.getId());
	    }else if(foodPackage.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackage.class).add(
			    Expression.eq("uuid", foodPackage.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodPackage> fp = criteria.list();
			if (null == fp || fp.isEmpty()) {
				return null;
			}
			return fp.get(0);
	    }else
	    	return null;
	}
	public boolean purgeFoodPackage(FoodPackage foodPackage, String retireReason){
		foodPackage.setRetired(true);
		foodPackage.setRetiredBy(Context.getUserContext().getAuthenticatedUser());
		foodPackage.setRetireReason(retireReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodPackage);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public List<FoodPackage> getFoodPackage(boolean retiredIncluded){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackage.class).add(
		    Expression.eq("retired", retiredIncluded));
		
		@SuppressWarnings("unchecked")
		List<FoodPackage> fp = criteria.list();
		return fp;
	}
	
	public boolean saveFoodPackageCombination(FoodPackageCombination foodPackageCombination){
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodPackageCombination);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public FoodPackageCombination getFoodPackageCombination(int id){
		return (FoodPackageCombination) sessionFactory.getCurrentSession().get(FoodPackageCombination.class, id);
	}
	public FoodPackageCombination getFoodPackageCombination(String uuid){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackageCombination.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodPackageCombination> fpc = criteria.list();
		if (null == fpc || fpc.isEmpty()) {
			return null;
		}
		return fpc.get(0);
	}
	public FoodPackageCombination getFoodPackageCombination(FoodPackageCombination foodPackageCombination){
		if (foodPackageCombination.getId() != null){
	    	return (FoodPackageCombination) sessionFactory.getCurrentSession().get(FoodPackageCombination.class, foodPackageCombination.getId());
	    }else if(foodPackageCombination.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackageCombination.class).add(
			    Expression.eq("uuid", foodPackageCombination.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodPackageCombination> fpc = criteria.list();
			if (null == fpc || fpc.isEmpty()) {
				return null;
			}
			return fpc.get(0);
	    }else
	    	return null;
	}
	public boolean purgeFoodPackageCombination(FoodPackageCombination foodPackageCombination, String voidReason){
		foodPackageCombination.setVoided(true);
		foodPackageCombination.setVoidedBy(Context.getUserContext().getAuthenticatedUser());
		foodPackageCombination.setVoidReason(voidReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodPackageCombination);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public List<FoodPackageCombination> getFoodPackageCombination(FoodPackageCombination foodPackageCombination,boolean retiredIncluded){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackageCombination.class).add(
		    Expression.eq("voided", retiredIncluded)).add(
			    Expression.eq("foodPackageCombination", foodPackageCombination));
		
		@SuppressWarnings("unchecked")
		List<FoodPackageCombination> fpc = criteria.list();
		return fpc;
	}
	public List<FoodPackageCombination> getFoodPackageCombinationByPackage(FoodPackage foodPackage,boolean voidedIncluded){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackageCombination.class).add(
		    Expression.eq("voided", voidedIncluded)).add(
			    Expression.eq("foodPackage", foodPackage));
		
		@SuppressWarnings("unchecked")
		List<FoodPackageCombination> fpc = criteria.list();
		return fpc;
	}
	
	public boolean saveFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction){
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodWeightRestriction);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public FoodWeightRestriction getFoodWeightRestriction(int id){
		return (FoodWeightRestriction) sessionFactory.getCurrentSession().get(FoodWeightRestriction.class, id);
	}
	public FoodWeightRestriction getFoodWeightRestriction(String uuid){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodWeightRestriction.class).add(
		    Expression.eq("uuid", uuid));
		@SuppressWarnings("unchecked")
		List<FoodWeightRestriction> fpc = criteria.list();
		if (null == fpc || fpc.isEmpty()) {
			return null;
		}
		return fpc.get(0);
	}
	public FoodWeightRestriction getFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction){
		if (foodWeightRestriction.getId() != null){
	    	return (FoodWeightRestriction) sessionFactory.getCurrentSession().get(FoodWeightRestriction.class, foodWeightRestriction.getId());
	    }else if(foodWeightRestriction.getUuid() != null){
	    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodPackageCombination.class).add(
			    Expression.eq("uuid", foodWeightRestriction.getUuid()));
			@SuppressWarnings("unchecked")
			List<FoodWeightRestriction> fpc = criteria.list();
			if (null == fpc || fpc.isEmpty()) {
				return null;
			}
			return fpc.get(0);
	    }else
	    	return null;
	}
	public boolean purgeFoodWeightRestriction(FoodWeightRestriction foodWeightRestriction, String voidReason){
		foodWeightRestriction.setRetired(true);
		foodWeightRestriction.setRetiredBy(Context.getUserContext().getAuthenticatedUser());
		foodWeightRestriction.setRetireReason(voidReason);
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(foodWeightRestriction);
			return true;
        }
        catch (Exception e) {
	        return false;
        }
	}
	public List<FoodWeightRestriction> getFoodWeightRestriction(FoodProduct foodProduct,boolean retiredIncluded){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodWeightRestriction.class).add(
		    Expression.eq("retired", retiredIncluded)).add(
			    Expression.eq("foodProduct", foodProduct));
		
		@SuppressWarnings("unchecked")
		List<FoodWeightRestriction> fwr = criteria.list();
		return fwr;
	}
	public List<FoodWeightRestriction> getFoodWeightRestriction(boolean retiredIncluded){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FoodWeightRestriction.class).add(
		    Expression.eq("retired", retiredIncluded));
		
		@SuppressWarnings("unchecked")
		List<FoodWeightRestriction> foodWeightRestriction = criteria.list();
		return foodWeightRestriction;
	}
	
	public List<FoodEncounter> getFoodEncounterEnteredInLastFewDays(Integer daysEntered) {
		Integer days = daysEntered;
		
		Calendar daysAgo = Calendar.getInstance();
		daysAgo.add(Calendar.DATE, -1 * days);
		
		Criteria crit = sessionFactory.getCurrentSession().createCriteria(FoodEncounter.class)
				.add(Restrictions.gt("dateCreated", daysAgo.getTime()))
				.addOrder(Order.desc("creator"));
		@SuppressWarnings("unchecked")
		List<FoodEncounter> foodEncounter = crit.list();
		
		return foodEncounter;
	}
}
