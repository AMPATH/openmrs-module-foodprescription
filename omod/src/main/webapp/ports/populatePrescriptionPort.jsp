<%@ include file="/WEB-INF/template/include.jsp"%>
	
<c:if test="${empty DO_NOT_INCLUDE_JQUERY}">
	<openmrs:htmlInclude file="/scripts/jquery/jquery.min.js" />
	<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui.custom.min.js" />
          <openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-timepicker-addon.js" />
	<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-datepicker-i18n.js" />
	<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-timepicker-i18n.js" />
	<link href="<openmrs:contextPath/>/scripts/jquery-ui/css/<spring:theme code='jqueryui.theme.name' />/jquery-ui.custom.css" type="text/css" rel="stylesheet" />
</c:if>
<link href="${pageContext.request.contextPath}/moduleResources/foodprescription/css/css-table.css" type="text/css" rel="stylesheet" />
<style>
	#cont, #cont2{
		padding:10px 10px; 
		border-radius:10px;
		-moz-border-radius:10px;
		margin-top:2px; 
	}
	
	#openmrsSearchTable_wrapper{
	/* Removes the empty space between the widget and the Create New Patient section if the table is short */
	/* Over ride the value set by datatables */
		min-height: 0px; height: auto !important;
	}
	.dataTables_wrapper {
	    clear: both;
	    min-height: 0px;
	    position: relative;
	}
	.evencol {
        border-left: 1px solid #E8E8E9;
        border-right: 1px solid #E8E8E9;
        padding-left: 3px;
    }
    .oddcol {
        padding-left: 3px;
    }
</style>

<script type="text/javascript">
$j(document).ready(function() {
	$j('#householdMembers1').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"bPaginate": false,
	    "bLengthChange": false,
	    "bFilter": false,
	    "bSort": false,
	    "bInfo": true,
	    "bAutoWidth": false
	});
});

function selectProvider(userid,provider){
	var proHouseholdId = null;
	if(provider != null){
		proHouseholdId=provider.personId;
	}
	$j("#userProvider").val(proHouseholdId);
	
}
function getFoodPack(){
	var packageID = document.getElementById("pack").value;
	$j.get("ports/foodPackagePort.form?foodPack=" + packageID + "&hhmid=" + ${membershipID},
			function(data){
				$j('#divPack').html(data);
			}
		);
}

function savePrescription(){
	var householdID = ${hid};
	var loci = document.getElementById("site").value;
	var foodpac = document.getElementById("pack").value;
	var prov = document.getElementById("userProvider").value;
	var capDate = document.getElementById("captureDate").value;
	var pop = document.getElementById("popComb").value;
	var individualized = document.getElementById("hdnTEXTindividualized").value;
	var serial = document.getElementById("serialNo").value;
	
	var arrCol = [householdID, loci, foodpac, prov, capDate, pop, individualized, serial];
	DWRFoodService.addFoodPrescription( arrCol, returnPrescription);
}
function returnPrescription(data){
	var householdID = ${hid};
	$j.get("ports/enteredFoodEncounterPort.form?householdID=" + householdID,
			function(dat){
				$j('#cont2').html(dat);
			}
		);
	$j('#postPrescription').slideToggle('slow');
	document.getElementById("userProvider").value = "";
	document.getElementById("captureDate").value = "";
	document.getElementById("userProviders_id_selection").value = "";
	document.getElementById("hdnTEXTindividualized").value = "";
	document.getElementById("serialNo").value = ""
	getFoodPack();
}

function pullVoidedFC(){
	var valSource = document.getElementById("foodSourceChange").value;
	
	$j.get("ports/foodAdditionPickPort.form?includedVoided=" + false + "&foodSrc=" + valSource,
			function(dat){
				$j('#idFoodMap').html(dat);
			}
		);
	
}

</script>
<div class="boxHeader">Prescription Section:</div>
<div id="showprescription">
	<table width="100%"><tr><td valign="top" style="width:33%;">
		<div style="width:100%; background-color: #EFEFEF; padding:10px 10px; border-radius:10px; -moz-border-radius:10px; border:1px solid #a1a1a1;" >
			<script type="text/javascript">
				$j(document).ready(function() {
					$j('.toggleCollapseInfo').click(function(event) {
						$j('#collapseInfo').slideToggle('slow');
						event.preventDefault();
					});
				});
			</script>
			<div style="border: 1px white gray; background-color: #FFFFFF; padding:5px 5px; border-radius:5px; -moz-border-radius:5px; float: right;" >
				<a class="toggleCollapseInfo" href="#">Toggle Household Summary</a>
			</div>
			<div id="collapseInfo">
			<table>
				<tr><td><b>Household:</b> </td><td><i> ${hidentifier}</i></td></tr>
				<tr><td><b>Last prescription Date:</b></td><td><i>${fn:substring(lastEncounterDate,0,11)}</i></td></tr>
			</table>
			<br />
				<b>Active Members</b>
			<br />
			
			<table border="0" id="householdMembers1" cellpadding="0" cellspacing="5">
				<thead>
			  		<tr>
			  			<th class="tbClass">&nbsp;</th>
			  			<th class="tbClass">Names</th>
			  			<!-- <th class="tbClass">Gender</th> -->
			  			<!-- <th class="tbClass">Birth Date</th> -->
			  			<th class="tbClass">Start</th>
			  		</tr>
				 </thead>
				 <tbody>	
			  		<c:forEach var="householdMembers" items="${members}">
				  		
				  		<tr>
				  			<td class="tdClass">
				  				 <c:choose>
	                                <c:when test="${householdMembers.householdMembershipHeadship }">
	                                    <img src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/tick.png" alt="[HEAD/INDEX]" />
	                                </c:when>
	                                <c:otherwise>
	                                </c:otherwise>
		                        </c:choose>
				  			</td>
				  			<td class="tdClass">
								[${householdMembers.householdMembershipMember.gender}]
					  			<a href="${pageContext.request.contextPath}/patientDashboard.form?patientId=${householdMembers.householdMembershipMember.personId}">
						  			<c:choose>
										<c:when test="${not empty householdMembers.householdMembershipMember.givenName }">
											${householdMembers.householdMembershipMember.givenName} &nbsp;
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${not empty householdMembers.householdMembershipMember.middleName }">
											${householdMembers.householdMembershipMember.middleName} &nbsp;
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${not empty householdMembers.householdMembershipMember.familyName }">
											${householdMembers.householdMembershipMember.familyName} &nbsp;
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</a>
				  			</td>
				   			<!-- <td class="tdClass" align="center"></td> -->
				  			<%-- <td class="tdClass" align="center">${fn:substring(householdMembers.householdMembershipMember.birthdate,0,10)}</td> --%>
				  			<td class="tdClass" align="center">${fn:substring(householdMembers.startDate,0,10)}</td>
				  		</tr>
			  		</c:forEach>
				 </tbody> 		
				</table>
			
			</div>
			<div id="cont2">
				
					
					<br />
					<table border="0" class="lineTable">
						<thead>
							<tr>
					            <th scope="col" colspan="3">Previous Prescriptions:</th>
					        </tr>
							<tr>
								<th></th>
								<th>Date</th>
								<th>Provider</th>
							</tr>
						</thead>
						<c:forEach var="foodEnc" items="${foodEncounters}" varStatus="ind">
						<tr>
							<th>${ind.index + 1}</th>
							<td class="highlight"><a href="#" onClick="javascript:popPrescrip('${foodEnc.id}')">${fn:substring(foodEnc.encounterDatetime,0,10)}&nbsp;(${foodEnc.location.name})</a></td>
							<td class="highlight">
								<openmrs:format person="${foodEnc.provider}"/>
							</td>
						</tr>
						</c:forEach>
					</table>
			</div>
			<script type="text/javascript">
				$j(document).ready(function() {	
					$j('#idAlteredPick').hide();
				});
				function popPrescrip(id){
					$j.get("ports/savedPrescriptionPort.form?encounter=" + id,
							function(dat){
								$j('#popPrescription').html(dat);
								$j('#popPrescription').show();
							}
						);
				}
				function populateNewCombAdd(pas){
					var pop = document.getElementById("popCombAdd").value;
					var chkSel = document.getElementById("idSelAdd" + pas);
					if (chkSel.checked == 1){
						if(pop == ""){
							$j("#popCombAdd").val(pas);
						}else
							$j("#popCombAdd").val(pop + "," + pas);
					}else{
						var strOut = "";
						var noSeleted = pop.split(",");
						for(var x=0; x<(noSeleted.length); x++){
					            if(noSeleted[x]!=pas){
					                if(strOut=="")
					                	strOut = noSeleted[x];
					                else
					                	strOut = strOut + "," + noSeleted[x];
					            }
						}
						//$j("#popComb").val("");
						$j("#popCombAdd").val(strOut);
					}
				}
				function pullVoidedFCAdd(){
					var valSource = document.getElementById("foodSourceAdd").value;
					
					$j.get("ports/foodAdditionPickAddPort.form?includedVoided=" + false + "&foodSrc=" + valSource,
							function(dat){
								$j('#idFoodMapAdd').html(dat);
							}
						);
					
				}
				function selectProviderHere(userid,provider){
					var proHouseholdId = null;
					if(provider != null){
						proHouseholdId=provider.personId;
					}
					$j("#userProviderHere").val(proHouseholdId);
				}
			</script>
			
			<br />
					
			<div id="idAlteredPick" style="background-color: #EEEEEE; padding:10px 10px; border-radius:10px; -moz-border-radius:10px;">
				Source: <select name="foodSourceAdd" id="foodSourceAdd" varStatus="state" onchange="javascript:pullVoidedFCAdd()">
							<c:forEach var="sourceChange" items="${allFoodsSource}" varStatus="ind">
								<option id="${state.index + 1 }" value="${sourceChange.uuid}" >${sourceChange.code}</option>
							</c:forEach>
						</select>
						
				<input type="hidden" id="popCombAdd" />
				<br />
				<div id="idFoodMapAdd">
					
					<table id="tblFoodMapAdd"  class="lineTable">
						<thead>    
					    	<tr>
					            <th scope="col" rowspan="2">&nbsp;</th>
					            <th scope="col" colspan="4">Food Source-To-Product mapping</th>
					        </tr>
					        <tr>
					            <th scope="col">Food Product</th>
					            <th scope="col">Available</th>
					            <th scope="col">Choose</th>
					        </tr>        
					    </thead>
					    <tbody>
					    	<c:forEach var="foodSourceMap" items="${foodMapm}" varStatus="ind">
								<%-- <form method="POST" name="${foodSourceMap.id}"> --%>
									<tr valign="top">
										<th>${ind.index + 1}</th>
										<td class="highlight">
											${foodSourceMap.foodProduct.name} 
										
										</td>
										<td class="highlight">
											<c:choose>
												<c:when test="${foodSourceMap.dispensable}">
													<input type="checkbox" id="chkDispensable" checked="checked" readonly="readonly" />
												</c:when>
												<c:otherwise>
													<input type="checkbox" id="chkDispensable" readonly="readonly" />
												</c:otherwise>
											</c:choose>
										</td>
										<td class="highlight">
											<input type="checkbox" id="idSelAdd${foodSourceMap.id}" onchange="javascript:populateNewCombAdd('${foodSourceMap.id}')" value="${foodSourceMap.id}"/>
										</td>
									</tr>
								<!-- </form> -->
							</c:forEach>
					    </tbody>
					</table>
				</div>
				<br/>
				<table>
					<tr>
						<td colspan="5">Provider: <openmrs_tag:userField formFieldName="userProvidersHere" roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectProviderHere" />
						<input type="hidden" id="userProviderHere" size="10" />&nbsp;&nbsp;&nbsp;&nbsp; Date of Capture: &nbsp;
						<input type="text" name="capDate" id="capDate" onClick="showCalendar(this)" />
						</td>
					</tr>
					<tr>
						<td colspan="5"><input type="button" id="btnSavePickedAltered" value="Save" onclick="javascript:isBtnSavePickedAltered()"/></td>
					</tr>
				</table>
			</div>
		</div>
		</td><td style="width:2%; "></td><td valign="top" style="width:95%; ">
		<div>
			<div id="cont" style="border: 1px white solid; background-color: #EFEFEF; ">
				
					<br />
					<script type="text/javascript">
						$j(document).ready(function() {
							$j('.togglePostPrescription').click(function(event) {
								$j('#postPrescription').slideToggle('slow');
								event.preventDefault();
							});
						});
					</script>
					<div style="border: 1px white solid; background-color: #FFFFFF; padding:5px 5px; border-radius:5px; -moz-border-radius:5px; float: right;" >
						<a class="togglePostPrescription" href="#">New Presciption</a>
					</div>
					<br /><br />
					<div id="postPrescription" style="border: 1px white solid; display: none; background-color: #EEEEEE; padding:10px 10px; border-radius:10px; -moz-border-radius:10px;">
						Distribution Site: <select name="site" id="site">
									<c:forEach var="fs" items="${foodSites}" varStatus="ind">
										<option id="${ind.index + 1 }" value="${fs.locationId}" >${fs.name}</option>
									</c:forEach>
								</select>
								
						&nbsp;&nbsp;&nbsp;&nbsp;
						Food Package: <select name="pack" id="pack" onchange="javascript:getFoodPack()">
									<c:forEach var="fpack" items="${allFoodPackage}" varStatus="ind">
										<option id="${ind.index + 1 }" value="${fpack.id}" >${fpack.name}</option>
									</c:forEach>
								</select>
						
						<br />
						<div id="divPack">
						
						
						
							<input type="hidden" id="hdnTEXTindividualized"/>
							
							
							
							<table border="0" class="lineTable">
								<thead>
									<tr>
							            <th scope="col" rowspan="2">&nbsp;</th>
							            <th scope="col" colspan="3">Products:</th>
							        </tr>
									<tr>
										<th>Product</th>
										<th>Food Source</th>
										<th>Available</th>
									</tr>
								</thead>
								<c:forEach var="foodpack" items="${foodPackCombination}" varStatus="ind">
								<tr>
									<th>${ind.index + 1}
										<c:choose>
					                        <c:when test="${foodpack.foodCombination.foodProduct.individualized}">
										 		<img onclick="javascript:showDivHere('${foodpack.foodCombination.id}')" src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/individual.png" alt="Populate individuals" />
										 	</c:when>
					                        <c:otherwise>
					                        </c:otherwise>
				                        </c:choose>
				                    </th>
									<td class="highlight">${foodpack.foodCombination.foodProduct.name}
										<div id="divHDN${foodpack.foodCombination.id}" style="display: none; background-color: #F4CAF2; padding:1px 1px; border-radius:3px; -moz-border-radius:3px;">
										<c:choose>
											<c:when test="${foodpack.foodCombination.foodProduct.individualized}">
												<table>
													<c:forEach var="householdMembers" items="${members}">
														<tr>
															<td><input type="checkbox" id="chkbx${foodpack.foodCombination.id}${householdMembers.householdMembershipMember.personId}" 
																onclick="javascript:putIndividualized('${foodpack.foodCombination.id}','${householdMembers.householdMembershipMember.personId}')"/></td>
															<td>
																<c:choose>
									                                <c:when test="${householdMembers.householdMembershipHeadship }">
									                                    <img src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/tick.png" alt="[HEAD/INDEX]" />
									                                </c:when>
									                                <c:otherwise>
									                                </c:otherwise>
										                        </c:choose>
										                        <c:choose>
																	<c:when test="${not empty householdMembers.householdMembershipMember.givenName }">
																		${householdMembers.householdMembershipMember.givenName} &nbsp;
																	</c:when>
																	<c:otherwise>
																	</c:otherwise>
																</c:choose>
																<c:choose>
																	<c:when test="${not empty householdMembers.householdMembershipMember.middleName }">
																		${householdMembers.householdMembershipMember.middleName} &nbsp;
																	</c:when>
																	<c:otherwise>
																	</c:otherwise>
																</c:choose>
																<c:choose>
																	<c:when test="${not empty householdMembers.householdMembershipMember.familyName }">
																		${householdMembers.householdMembershipMember.familyName} &nbsp;
																	</c:when>
																	<c:otherwise>
																	</c:otherwise>
																</c:choose>
									                        </td>
														</tr>
													</c:forEach>
												</table>
										 	</c:when>
							                <c:otherwise>
							                </c:otherwise>
							            </c:choose>
							            </div>
									</td>
									<td class="highlight">
										${foodpack.foodCombination.foodSource.code}
									</td>
									<td class="highlight">
										<c:choose>
											<c:when test="${foodpack.foodCombination.dispensable}">
												<input type="checkbox" id="chkDispensable" checked="checked" disabled="disabled" />
											</c:when>
											<c:otherwise>
												<input type="checkbox" id="chkDispensable" disabled="disabled" />
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								</c:forEach>
								
							</table>
						</div>
							<script type="text/javascript">
								$j(document).ready(function() {
									$j('.toggleAddFoodMap').click(function(event) {
										$j('#idAdditionalCombination').slideToggle('slow');
										event.preventDefault();
									});
								});
								
								function populateNewComb(pas){
									var pop = document.getElementById("popComb").value;
									var chkSel = document.getElementById("idSel" + pas);
									if (chkSel.checked == 1){
										if(pop == ""){
											$j("#popComb").val(pas);
										}else
											$j("#popComb").val(pop + "," + pas);
									}else{
										var strOut = "";
										var noSeleted = pop.split(",");
										for(var x=0; x<(noSeleted.length); x++){
									            if(noSeleted[x]!=pas){
									                if(strOut=="")
									                	strOut = noSeleted[x];
									                else
									                	strOut = strOut + "," + noSeleted[x];
									            }
										}
										//$j("#popComb").val("");
										$j("#popComb").val(strOut);
									}
								}
								function showDivHere(inDiv){
									var id = "#divHDN" + inDiv;
								    $j(id).show();
								}
								function hideDivHere(inDiv){
									var id = "#divHDN" + inDiv;
								    $j(id).hide();
								}
								function putIndividualized(comb, patID){
									var chkSel = document.getElementById("chkbx" + comb + patID);
									var va = document.getElementById("hdnTEXTindividualized").value;
									var co = comb + ":" + patID;
									if (chkSel.checked == false){
										var strOut = "";
										var noSeleted = va.split(",");
										for(var x=0; x<(noSeleted.length); x++){
								            if(noSeleted[x] != co){
								                if(strOut == "")
								                	strOut = noSeleted[x];
								                else
								                	strOut = strOut + "," + noSeleted[x];
								            }
										}
										$j("#hdnTEXTindividualized").val(strOut) ;
									}else{
										if(va == ""){
											$j("#hdnTEXTindividualized").val(co);
										}else
											$j("#hdnTEXTindividualized").val(va + "," + co);
									}
								}
							</script>
							
							<a href="#" class="toggleAddFoodMap">Additional pick</a>
							<div id="idAdditionalCombination" style="border: 1px white solid; display: none; background-color: #EFEFEF; padding:10px 10px; border-radius:10px; -moz-border-radius:10px;">
								Source: <select name="foodSourceChange" id="foodSourceChange" varStatus="state" onchange="javascript:pullVoidedFC()">
									<c:forEach var="sourceChange" items="${allFoodsSource}" varStatus="ind">
										<option id="${state.index + 1 }" value="${sourceChange.uuid}" >${sourceChange.code}</option>
									</c:forEach>
								</select>
								
								<input type="hidden" id="popComb" />
								<br />
								<div id="idFoodMap">
									
									<table id="tblFoodMap"  class="lineTable">
										<thead>    
									    	<tr>
									            <th scope="col" rowspan="2">&nbsp;</th>
									            <th scope="col" colspan="4">Food Source-To-Product mapping</th>
									        </tr>
									        <tr>
									            <th scope="col">Food Product</th>
									            <th scope="col">Available</th>
									            <th scope="col">Choose</th>
									        </tr>        
									    </thead>
									    <tbody>
									    	<c:forEach var="foodSourceMap" items="${foodMapm}" varStatus="ind">
												<form method="POST" name="${foodSourceMap.id}">
													<tr valign="top">
														<th>${ind.index + 1}</th>
														<td class="highlight">
															${foodSourceMap.foodProduct.name} 
														
														</td>
														<td class="highlight">
															<c:choose>
																<c:when test="${foodSourceMap.dispensable}">
																	<input type="checkbox" id="chkDispensable" checked="checked" readonly="readonly" />
																</c:when>
																<c:otherwise>
																	<input type="checkbox" id="chkDispensable" readonly="readonly" />
																</c:otherwise>
															</c:choose>
														</td>
														<td class="highlight">
															<input type="checkbox" id="idSel${foodSourceMap.id}" onchange="javascript:populateNewComb('${foodSourceMap.id}')" value="${foodSourceMap.id}"/>
														</td>
													</tr>
												</form>
											</c:forEach>
									    </tbody>
									</table>
								</div>
							</div>
						<table>
							<tr>
								<td>Serial No:</td><td><input type="text" name="serialNo" id="serialNo"/></td>
							</tr> 
							<tr>
								<td>Provider</td>
								<td><openmrs_tag:userField formFieldName="userProviders" roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectProvider" /></td>
								<td><input type="hidden" id="userProvider" size="10" />
							</tr>
							<tr>
								<td>Capture Date:</td><td><input type="text" name="captureDate" id="captureDate" onClick="showCalendar(this)" /></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><input type="button" value="Prescribe" onclick="javascript:savePrescription()"/></td>
							</tr>
						</table>
					</div>
					<div id="popPrescription" style="background-color: #EEEEEE; padding:10px 10px; border-radius:10px; -moz-border-radius:10px;"></div>
					<script type="text/javascript">
						$j(document).ready(function() {	
							$j('#popPrescription').hide();
						});
					</script>
				</div>
		</div>
		
	</td></tr></table>
</div>