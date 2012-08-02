<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="Manage Food Prescriptions" otherwise="/login.htm" redirect="/module/fdm/fdmPrescription.form" />
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="localHeader.jsp"%>

<openmrs:htmlInclude file="/dwr/interface/DWRPatientService.js"/>
<openmrs:htmlInclude file="/dwr/interface/DWRPersonService.js" />
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<openmrs:htmlInclude file="/scripts/jquery/dataTables/css/dataTables_jui.css"/>
<openmrs:htmlInclude file="/scripts/jquery/dataTables/js/jquery.dataTables.min.js"/>
<openmrs:htmlInclude file="/scripts/jquery-ui/js/openmrsSearch.js" />
<openmrs:htmlInclude file="/dwr/util.js" />



	
<style>
	#openmrsSearchTable_wrapper{
	/* Removes the empty space between the widget and the Create New Patient section if the table is short */
	/* Over ride the value set by datatables */
		min-height: 0px; height: auto !important;
	}
</style>
<openmrs:htmlInclude file="/dwr/util.js"/>
<openmrs:htmlInclude file="/dwr/interface/DWRFoodService.js"/>
<openmrs:htmlInclude file="/dwr/interface/DWRPatientService.js"/>
<openmrs:htmlInclude file="/scripts/jquery/dataTables/css/dataTables_jui.css"/>
<openmrs:htmlInclude file="/scripts/jquery/dataTables/js/jquery.dataTables.min.js"/>
<openmrs:htmlInclude file="/scripts/jquery-ui/js/openmrsSearch.js" />
<script type="text/javascript">
	var lastSearch;
	$j(document).ready(function() {
		$j("#tblSelectedPerson").hide();
		new OpenmrsSearch("findPatients", false, doPatientSearch, doSelectionHandler, 
			[	{fieldName:"identifier", header:omsgs.identifier},
				{fieldName:"givenName", header:omsgs.givenName},
				{fieldName:"middleName", header:omsgs.middleName},
				{fieldName:"familyName", header:omsgs.familyName},
				{fieldName:"age", header:omsgs.age},
				{fieldName:"gender", header:omsgs.gender},
				{fieldName:"birthdateString", header:omsgs.birthdate},
			],
			{
			  searchLabel: '<spring:message code="Patient.searchBox" javaScriptEscape="true"/>'
			  <c:if test="${not empty param.phrase}">
			      , searchPhrase: '<spring:message text="${ param.phrase }" javaScriptEscape="true"/>'
			  </c:if>
			});
		
		//set the focus to the first input box on the page(in this case the text box for the search widget)
		var inputs = document.getElementsByTagName("input");
	    if(inputs[0])
	    	inputs[0].focus();
	    		
	    
	});

	function doSelectionHandler(index, data) {
		$j('#divSelect').html('<img src="${pageContext.request.contextPath}/moduleResources/fdm/images/loading.gif"/>');
		$j.get("ports/fdmSelectedPersonHouseholdPort.form?personid=" + data.patientId,
				function(data){
					$j('#divSelect').html(data);
				}
			);
		
	}

	//searchHandler for the Search widget 
	function doPatientSearch(text, resultHandler, getMatchCount, opts) {
		lastSearch = text;
		DWRPatientService.findCountAndPatients(text, opts.start, opts.length, getMatchCount, resultHandler);
	}
	
	function forwardMem(datain){
		$j('#populate').html('<img src="${pageContext.request.contextPath}/moduleResources/fdm/images/loading.gif"/>');
		$j.get("ports/fdmPopulatePrescriptionPort.form?hhmid=" + datain,
				function(data){
					$j('#populate').html(data);
				}
			);
	}
	function selectFdmProvider(userid,provider){
		var providerId=null
		if(provider !=null){
			providerId=provider.systemId;
		}
		$j("#fdmprovider").val(providerId);
		
	}
	
</script>
	
<div id="populate">

	
	<div class="boxHeader">Find Patient:</div>
	<div class="box">				
							
							
		<div class="searchWidgetContainer" id="findPatients"></div>
			
		
		
		
		<div id="divSelect" style="background-color: #EEEEEE; padding:10px 10px; border-radius:10px; -moz-border-radius:10px;">
			
		</div>
	
	
	</div>
	
						
</div>							
	
<%@ include file="/WEB-INF/template/footer.jsp"%>

