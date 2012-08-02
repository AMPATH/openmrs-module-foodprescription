<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="Manage Food Configuration" otherwise="/login.htm" redirect="/module/foodprescription/configuration.form" />
<%@ include file="/WEB-INF/template/header.jsp"%>

<openmrs:htmlInclude file="/scripts/jquery/dataTables/css/dataTables_jui.css"/>
<openmrs:htmlInclude file="/scripts/jquery/dataTables/js/jquery.dataTables.min.js"/>
<openmrs:htmlInclude file="/dwr/util.js"/>
<openmrs:htmlInclude file="/dwr/interface/DWRFoodService.js"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/foodprescription/js/jquery-1.5.2.min.js"></script>
<link href="${pageContext.request.contextPath}/moduleResources/foodprescription/css/css-table.css" type="text/css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/moduleResources/foodprescription/css/vert_tab.css" type="text/css" rel="stylesheet" />
<style>
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
</style>

<script language="JavaScript">
$(document).ready(function() {

    $(".tabs .tab[id^=tab_menu]").click(function() {
        var curMenu=$(this);
        $(".tabs .tab[id^=tab_menu]").removeClass("selected");
        curMenu.addClass("selected");

        var index=curMenu.attr("id").split("tab_menu_")[1];
        $(".curvedContainer .tabcontent").css("display","none");
        $(".curvedContainer #tab_content_"+index).css("display","block");
    });
});

	function passFoodSource(){
		var par = document.getElementById("fsAddEdit").value;
		var par1 = document.getElementById("fsid").value;
		var par2 = document.getElementById("sourceCode").value;
		var par3 = document.getElementById("sourceName").value;
		var par4 = document.getElementById("sourceDescription").value;
		var par5 = document.getElementById("fsidRetire").value;
		
		if((par == "Add") || (par == ""))
			var parArrFS = ["1", par1, par2, par3, par4];
		else if(par == "Edit")
			var parArrFS = ["2", par1, par2, par3, par4];
		else
			var parArrFS = ["3", par1, par2, par3, par4, par5];
		DWRFoodService.addEditFoodSource( parArrFS, returnFS);
	}
	function returnFS(data){
		//alert("Successfully saved \n" + data);
		var checkDelete = document.getElementById("fsAddEdit").value;
		if (checkDelete != "Delete"){
			$j('#addFoodSource').slideToggle('slow');
			event.preventDefault();
		}
			$j.get("ports/foodSourcePort.form?includedRetired=" + false,
					function(dat){
						$j('#idFoodSource').html(dat);
					}
				);
			$j.get("ports/foodPackagePort.form?includedRetired=" + false,
					function(dat1){
						$j("#idFoodPackage").html(dat1);
					}
				);
			$j.get("ports/foodCombinationPort.form?includedVoided=" + false,
					function(dat){
						$j('#idFoodMap').html(dat);
					}
				);
		document.getElementById("fsAddEdit").value = "Add";
		document.getElementById("fsid").value = "";
		document.getElementById("sourceCode").value = "";
		document.getElementById("sourceName").value = "";
		document.getElementById("sourceDescription").value = "";
	}
	
	function passFoodProduct(){
		var par = document.getElementById("fpAddEdit").value;
		var par1 = document.getElementById("fpid").value;
		var par2 = document.getElementById("productName").value;
		var par3 = document.getElementById("fpidRetire").value;
		var isPar4 = document.getElementById("idIndividualized");
		var par4 = "";
		if(isPar4.checked)
			par4="1";
		
		if((par == "Add") || (par == ""))
			var parArrFP = ["1", par1, par2, par3, par4];
		else if(par == "Edit")
			var parArrFP = ["2", par1, par2, par3, par4];
		else
			var parArrFP = ["3", par1, par2, par3, par4];
		DWRFoodService.addEditFoodProduct( parArrFP, returnFP);
	}
	function returnFP(data){
		//alert("Successfully saved \n" + data);
		var checkDelete = document.getElementById("fpAddEdit").value;
		if (checkDelete != "Delete"){
			$j('#addFoodProduct').slideToggle('slow');
			event.preventDefault();
		}
			$j.get("ports/foodProductPort.form?includedRetired=" + false,
					function(dat){
						$j('#idFoodProduct').html(dat);
					}
				);
			$j.get("ports/foodPackagePort.form?includedRetired=" + false,
					function(dat1){
						$j("#idFoodPackage").html(dat1);
					}
				);
			$j.get("ports/foodCombinationPort.form?includedVoided=" + false,
					function(dat2){
						$j('#idFoodMap').html(dat2);
					}
				);
			$j.get("ports/foodWeightRestrictionPort.form?includedRetired=" + false,
					function(dat3){
						$j('#idFoodWeightRestriction').html(dat3);
					}
				);
			
		document.getElementById("fpAddEdit").value = "Add";
		document.getElementById("fpid").value = "";
		document.getElementById("productName").value = "";
	}
	function passFoodMap(){
		var par = document.getElementById("fcAddEdit").value;
		var par1 = document.getElementById("fcid").value;
		var par2 = document.getElementById("foodSource").value;
		var par3 = document.getElementById("foodProduct").value;
		var par4 = document.getElementById("fcidVoid").value;
		
		if((par == "Add") || (par == ""))
			var parArrFC = ["1", par1, par2, par3, par4];
		else if(par == "Dispensible")
			var parArrFc = ["2", par1, par2, par3, par4];
		else
			var parArrFC = ["3", par1, par2, par3, par4];
		DWRFoodService.addEditFoodCombination( parArrFC, returnFC);
	}
	function returnFC(data){
		//alert("Successfully saved \n" + data);
		var checkDelete = document.getElementById("fcAddEdit").value;
		var valSource = document.getElementById("foodSourceChange").value;
		if (checkDelete != "Delete"){
			$j('#addFoodMap').slideToggle('slow');
			event.preventDefault();
		}
			$j.get("ports/foodCombinationPort.form?includedVoided=" + false + "&foodSrc=" + valSource,
					function(dat){
						$j('#idFoodMap').html(dat);
					}
				);
		document.getElementById("fcAddEdit").value = "Add";
		document.getElementById("fcid").value = "";
	}
	
	function submitPackage(){
		var com= document.getElementById("hdnCombination").value;
		var packageName= document.getElementById("txtPackageName").value;
		if (com == ""){
			alert("Please select a combination!")
		}else{
			if(packageName == ""){
				alert("Please provide the Package Name!")
			}else{
				var pack = [com, packageName]
				DWRFoodService.populatePackage(pack,returnPackage);
			}
		}
	}
	function returnPackage(data){
		$j.get("ports/foodPackagePort.form?includedRetired=" + false,
				function(dat){
					$j("#idFoodPackage").html(dat);
				}
			);
		$j("#addFoodPackage").slideToggle('slow');
	}
	
	function onClickFoodPackage(id,pack){
		var r=confirm("Do you really want to remove " + pack + "?");
		if (r==true){
			var reason=prompt("Please enter the reason for removing this package:","");
			if (reason!=null && reason!=""){
				document.getElementById("fwrAddEditFR").value = "Delete";
				document.getElementById("fwrid").value = id;
				document.getElementById("fwridRetireFR").value = reason;
				passFoodWeightRestriction();
			}else{
				alert("Sorry, you never entered the reason for removing this record. Not removed.")
			}
		}else{
			document.getElementById("fwrAddEditFR").value = "";
		}
	}
</script>
<%@ include file="localHeader.jsp" %>

	<div class="boxHeader">FDS</div>
	<div class="box">
		<table><tr><td>
		<div class="tabscontainer">
		     <div class="tabs">
		         <div class="tab selected first" id="tab_menu_1">
		             <div class="link">Food Source</div>
		             <div class="arrow"></div>
		         </div>
		         <div class="tab" id="tab_menu_2">
		             <div class="link">Food Product</div>
		             <div class="arrow"></div>
		         </div>
		         <div class="tab" id="tab_menu_3">
		             <div class="link">Source-To-Product</div>
		             <div class="arrow"></div>
		         </div>
		         <div class="tab" id="tab_menu_4">
		             <div class="link">Packaging</div>
		             <div class="arrow"></div>
		         </div>
		         <div class="tab" id="tab_menu_5">
		             <div class="link">Weight Restriction</div>
		             <div class="arrow"></div>
		         </div>
		         <div class="tab last" id="tab_menu_6">
		             <div class="link">General Properties</div>
		             <div class="arrow"></div>
		         </div>
	         </div>
	         <div class="curvedContainer">
				<div class="tabcontent" id="tab_content_1" style="display:block">
				
					<script type="text/javascript">
						$j(document).ready(function() {
							$j('.toggleAddFoodSource').click(function(event) {
								$j('#addFoodSource').slideToggle('slow');
								event.preventDefault();
							});
						});
					</script>
					<span style="float: right"> 
						<label for="includeRetiredFS">
							<input type="checkbox" id="includeRetiredFS" value="0" onchange="javascript:pullRetiredFS()"/>
							Included Retired
						</label>
					</span>
					<a class="toggleAddFoodSource" href="#">Add/Edit Food Source</a><br />
					<div id="addFoodSource" style="border: 1px black solid; background-color: #e0e0e0; display: none; width: 70%;">
						<form method="post">
							<table>
								<tr>
									<th>Source Code</th>
									<td>
										<input type="hidden" name="fsid" id="fsid"/>
										<input type="hidden" name="fsAddEdit" id="fsAddEdit"/>
										<input type="hidden" name="fsidRetire" id="fsidRetire"/>
										<input type="text" name="sourceCode" id="sourceCode"/>
										<span class="required">*</span>
									</td>
								</tr>
								<tr>
									<th>Name</th>
									<td>
										<input type="text" name="sourceName" id="sourceName"/>
										<span class="required">*</span>
									</td>
								</tr>
								<tr>
									<th>Description</th>
									<td><textarea name="sourceDescription" id="sourceDescription" rows="3" cols="72"></textarea></td>
								</tr>
								<tr>
									<th></th>
									<td>
										<input type="button" onclick="javascript:passFoodSource()" value="<spring:message code="general.save"/>" />
										<input type="button" value="<spring:message code="general.cancel"/>" class="toggleAddFoodSource" />
									</td>
								</tr>
							</table>
						</form>
					</div>
					<br />
				
				
				
					<div id="idFoodSource">
						<table id="tblFoodSource"  class="lineTable">
							<thead>    
						    	<tr>
						            <th scope="col" rowspan="2">&nbsp;</th>
						            <th scope="col" colspan="5">Food Sources</th>
						        </tr>
						        <tr>
						            <th scope="col">Code</th>
						            <th scope="col">Name</th>
						            <th scope="col">Description</th>
						            <th scope="col"><spring:message code="general.createdBy"/></th>
						            <th scope="col">Action</th>
						        </tr>        
						    </thead>
						    <tbody>
						    	<c:forEach var="foodSourceItem" items="${foodSource}" varStatus="ind">
									<form method="POST" name="${foodSourceItem.id}">
										<tr valign="top">
											<th>${ind.index + 1}</th>
											<td class="highlight">
												${foodSourceItem.code} 
											
											</td>
											<td class="highlight">
												${foodSourceItem.name} 
											
											</td>
											<td class="highlight">${foodSourceItem.description}<br />
												<c:choose>
													<c:when test="${not empty foodSourceItem.dateRetired}">
														<span style="color: orange; font-style: italic;">RETIRED : Reason - ${foodSourceItem.retireReason} </span>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											
											</td>
											<td class="highlight">
												<openmrs:format user="${foodSourceItem.creator}"/><br />
												<openmrs:formatDate date="${foodSourceItem.dateCreated}"/><br />
												<c:choose>
													<c:when test="${not empty foodSourceItem.dateRetired}">
														<span style="color: orange;">
															Retired by: <openmrs:format user="${foodSourceItem.retiredBy}"/><br />
															Retired on: <openmrs:formatDate date="${foodSourceItem.dateRetired}"/>
														</span>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="highlight">
												<a href="#" onclick="javascript:onClickEditFoodSource('${foodSourceItem.id}','${foodSourceItem.code}','${foodSourceItem.name}','${foodSourceItem.description}')">
													<img src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/edit.gif"/></a>
												<a href="#" onclick="javascript:onClickDeleteFoodSource('${foodSourceItem.id}','${foodSourceItem.name}')">
													<img src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/trash.gif"/></a>
											</td>
										</tr>
									</form>
								</c:forEach>
						    </tbody>
						</table>
					</div>
					<script type="text/javascript">
				
						function onClickEditFoodSource(id,sourceCode,sourceName,sourceDescription ){
							document.getElementById("fsAddEdit").value = "Edit";
							document.getElementById("fsid").value = id;
							document.getElementById("sourceCode").value = sourceCode;
							document.getElementById("sourceName").value = sourceName;
							document.getElementById("sourceDescription").value = sourceDescription;
							$j('#addFoodSource').slideToggle('slow');
							event.preventDefault();
						}
						function onClickDeleteFoodSource(id,sourceName){
							var r=confirm("Do you really want to remove " + sourceName + " as a source?");
							if (r==true){
								var reason=prompt("Please enter the reason for retiring this food source","");
								if (reason!=null && reason!=""){
									document.getElementById("fsAddEdit").value = "Delete";
									document.getElementById("fsid").value = id;
									document.getElementById("fsidRetire").value = reason;
									passFoodSource();
								}else{
									alert("Sorry, you never entered the reason for retiring this record. Not retired.")
								}
							}else{
								document.getElementById("fsAddEdit").value = "";
							}
						}
						function pullRetiredFS(){
							var val = document.getElementById("includeRetiredFS");
							if(val.checked){
								$j.get("ports/foodSourcePort.form?includedRetired=" + true,
										function(dat){
											$j('#idFoodSource').html(dat);
										}
									);
							}else{
								$j.get("ports/foodSourcePort.form?includedRetired=" + false,
										function(dat){
											$j('#idFoodSource').html(dat);
										}
									);
							}
						}
					</script>
					
					
					
				</div>
				<div class="tabcontent" id="tab_content_2">
					
					<script type="text/javascript">
						$j(document).ready(function() {
							$j('.toggleAddFoodProduct').click(function(event) {
								$j('#addFoodProduct').slideToggle('slow');
								event.preventDefault();
							});
						});
					</script>
					<span style="float: right"> 
						<label for="includeRetiredFP">
							<input type="checkbox" id="includeRetiredFP" value="0" onchange="javascript:pullRetiredFP()"/>
							Included Retired
						</label>
					</span>
					<a class="toggleAddFoodProduct" href="#">Add/Edit Food Product</a><br />
					<div id="addFoodProduct" style="border: 1px black solid; background-color: #e0e0e0; display: none; width: 70%;">
						<form method="post">
							<table>
								<tr>
									<th>Name</th>
									<td>
										<input type="hidden" name="fpid" id="fpid"/>
										<input type="hidden" name="fpAddEdit" id="fpAddEdit"/>
										<input type="hidden" name="fpidRetire" id="fpidRetire"/>
										<input type="text" name="productName" id="productName"/>
										<span class="required">*</span>
									</td>
								</tr>
								<tr>
									<th>Individualized</th>
									<td>
										<input type="checkbox" id="idIndividualized"/>
									</td>
								</tr>
								<tr>
									<th></th>
									<td>
										<input type="button" onclick="javascript:passFoodProduct()" value="<spring:message code="general.save"/>" />
										<input type="button" value="<spring:message code="general.cancel"/>" class="toggleAddFoodProduct" />
									</td>
								</tr>
							</table>
						</form>
					</div>
					<br />
				
				
				
					<div id="idFoodProduct">
						<table id="tblFoodProduct"  class="lineTable">
							<thead>    
						    	<tr>
						            <th scope="col" rowspan="2">&nbsp;</th>
						            <th scope="col" colspan="4">Food Products</th>
						        </tr>
						        <tr>
						            <th scope="col">Name</th>
						            <th scope="col">Individualized</th>
						            <th scope="col"><spring:message code="general.createdBy"/></th>
						            <th scope="col">Action</th>
						        </tr>        
						    </thead>
						    <tbody>
						    	<c:forEach var="foodProductItem" items="${foodProduct}" varStatus="ind">
									<form method="POST" name="${foodProductItem.id}">
										<tr valign="top">
											<th>${ind.index + 1}</th>
											<td class="highlight">
												${foodProductItem.name} 
												<c:choose>
													<c:when test="${not empty foodProductItem.dateRetired}">
														<span style="color: orange; font-style: italic;">RETIRED : Reason - ${foodProductItem.retireReason} </span>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="highlight">
												<c:choose>
													<c:when test="${foodProductItem.individualized}">
														<input type="checkbox" id="idIndividualizedResult" disabled="disabled" checked="checked"/>
													</c:when>
													<c:otherwise>
														<input type="checkbox" id="idIndividualizedResult" disabled="disabled"/>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="highlight">
												<openmrs:format user="${foodProductItem.creator}"/><br />
												<openmrs:formatDate date="${foodProductItem.dateCreated}"/><br />
												<c:choose>
													<c:when test="${not empty foodProductItem.dateRetired}">
														<span style="color: orange;">
															Retired by: <openmrs:format user="${foodProductItem.retiredBy}"/><br />
															Retired on: <openmrs:formatDate date="${foodProductItem.dateRetired}"/>
														</span>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="highlight">
												<a href="#" onclick="javascript:onClickEditFoodProduct('${foodProductItem.id}','${foodProductItem.name}','${foodProductItem.individualized}')">
													<img src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/edit.gif"/></a>
												<a href="#" onclick="javascript:onClickDeleteFoodProduct('${foodProductItem.id}','${foodProductItem.name}')">
													<img src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/trash.gif"/></a>
											</td>
										</tr>
									</form>
								</c:forEach>
						    </tbody>
						</table>
					</div>
					<script type="text/javascript">
				
						function onClickEditFoodProduct(id,productName,isInd ){
							document.getElementById("fpAddEdit").value = "Edit";
							document.getElementById("fpid").value = id;
							document.getElementById("productName").value = productName;
							if(isInd == "1")
								document.getElementById("idIndividualized").checked = true;
							$j('#addFoodProduct').slideToggle('slow');
							event.preventDefault();
						}
						function onClickDeleteFoodProduct(id,productName){
							var r=confirm("Do you really want to remove " + productName + " as a product?");
							if (r==true){
								var reason=prompt("Please enter the reason for retiring this food product","");
								if (reason!=null && reason!=""){
									document.getElementById("fpAddEdit").value = "Delete";
									document.getElementById("fpid").value = id;
									document.getElementById("fpidRetire").value = reason;
									passFoodProduct();
								}else{
									alert("Sorry, you never entered the reason for retiring this record. Not retired.")
								}
							}else{
								document.getElementById("fpAddEdit").value = "";
							}
						}
						function pullRetiredFP(){
							var val = document.getElementById("includeRetiredFP");
							if(val.checked){
								$j.get("ports/foodProductPort.form?includedRetired=" + true,
										function(dat){
											$j('#idFoodProduct').html(dat);
										}
									);
							}else{
								$j.get("ports/foodProductPort.form?includedRetired=" + false,
										function(dat){
											$j('#idFoodProduct').html(dat);
										}
									);
							}
						}
					</script>
					
					
				</div>
				<div class="tabcontent" id="tab_content_3">
					<script type="text/javascript">
						$j(document).ready(function() {
							$j('.toggleAddFoodMap').click(function(event) {
								$j('#addFoodMap').slideToggle('slow');
								event.preventDefault();
							});
						});
					</script>
					<span style="float: right"> 
						<label for="includeVoidedFC">
							<input type="checkbox" id="includeVoidedFC" value="0" onchange="javascript:pullVoidedFC()"/>
							Included Voided
						</label>
					</span>
					<a class="toggleAddFoodMap" href="#">Add/Edit Food Source-Product Mapping</a><br />
					<div id="addFoodMap" style="border: 1px black solid; background-color: #e0e0e0; display: none; width: 70%;">
						<form method="post">
							<table>
								<tr>
									<th>Food Source:</th>
									<td>
										<input type="hidden" name="fcid" id="fcid"/>
										<input type="hidden" name="fcAddEdit" id="fcAddEdit"/>
										<input type="hidden" name="fcidVoid" id="fcidVoid"/>
										<select name="foodSource" id="foodSource" varStatus="state">
											<c:forEach var="source" items="${allFoodSource}" varStatus="ind">
												<option id="${state.index + 1 }" value="${source.id}" >${source.code}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>Food Product</th>
									<td>
										<select name="foodProduct" id="foodProduct" varStatus="state">
											<c:forEach var="product" items="${allFoodProduct}" varStatus="ind">
												<option id="${state.index + 1 }" value="${product.id}" >${product.name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th></th>
									<td>
										<input type="button" onclick="javascript:passFoodMap()" value="<spring:message code="general.save"/>" />
										<input type="button" value="<spring:message code="general.cancel"/>" class="toggleAddFoodMap" />
									</td>
								</tr>
							</table>
						</form>
					</div>
					<br />
				
				
				
					<br />
					
					
					Source: <select name="foodSourceChange" id="foodSourceChange" varStatus="state" onchange="javascript:pullVoidedFC()">
								<c:forEach var="sourceChange" items="${allFoodSource}" varStatus="ind">
									<option id="${state.index + 1 }" value="${sourceChange.uuid}" >${sourceChange.code}</option>
								</c:forEach>
							</select>
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
						            <th scope="col"><spring:message code="general.createdBy"/></th>
						            <th scope="col">Action</th>
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
														<input type="checkbox" id="chkDispensable" checked="checked" onchange="javascript:clickDispensable('0')" />
													</c:when>
													<c:otherwise>
														<input type="checkbox" id="chkDispensable" onchange="javascript:clickDispensable('1')" />
													</c:otherwise>
												</c:choose>
											</td>
											<td class="highlight">
												<openmrs:format user="${foodSourceMap.creator}"/><br />
												<openmrs:formatDate date="${foodSourceMap.dateCreated}"/><br />
												<c:choose>
													<c:when test="${foodSourceMap.voided}">
														<span style="color: orange;">
															Voided by: <openmrs:format user="${foodSourceMap.voidedBy}"/><br />
															Voided on: <openmrs:formatDate date="${foodSourceMap.dateVoided}"/>
														</span>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="highlight">
												<a href="#" onclick="javascript:onClickDeleteFoodMap('${foodSourceMap.id}','${foodSourceMap.foodSource.code} - ${foodSourceMap.foodProduct.name}')">
													<img src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/trash.gif"/></a>
											</td>
										</tr>
									</form>
								</c:forEach>
						    </tbody>
						</table>
					</div>
					<script type="text/javascript">
						function onClickDeleteFoodMap(id,combination){
							var r=confirm("Do you really want to remove " + combination + " as a map?");
							if (r==true){
								var reason=prompt("Please enter the reason for voiding this food source-product map:","");
								if (reason!=null && reason!=""){
									document.getElementById("fcAddEdit").value = "Delete";
									document.getElementById("fcid").value = id;
									document.getElementById("fcidVoid").value = reason;
									passFoodMap();
								}else{
									alert("Sorry, you never entered the reason for voiding this record. Not voided.")
								}
							}else{
								document.getElementById("fcAddEdit").value = "";
							}
						}
						function pullVoidedFC(){
							var val = document.getElementById("includeVoidedFC");
							var valSource = document.getElementById("foodSourceChange").value;
							if(val.checked){
								$j.get("ports/foodCombinationPort.form?includedVoided=" + true + "&foodSrc=" + valSource,
										function(dat){
											$j('#idFoodMap').html(dat);
										}
									);
							}else{
								$j.get("ports/foodCombinationPort.form?includedVoided=" + false + "&foodSrc=" + valSource,
										function(dat){
											$j('#idFoodMap').html(dat);
										}
									);
							}
						}
						function clickDispensable(disp){
							if (disp == "0"){
								
							}else if (disp == "1"){
								
							}
						}
					</script>
				</div>
				<div class="tabcontent" id="tab_content_4">
					
					<script type="text/javascript">
						$j(document).ready(function() {
							$j('.toggleAddFoodPackage').click(function(event) {
								$j('#addFoodPackage').slideToggle('slow');
								event.preventDefault();
							});
						});
						function pullRetiredFPack(){
							var val = document.getElementById("includeRetiredFRest");
							if(val.checked){
								$j.get("ports/foodPackagePort.form?includedRetired=" + true,
										function(dat){
											$j("#idFoodPackage").html(dat);
										}
									);
							}else{
								$j.get("ports/foodPackagePort.form?includedRetired=" + false,
										function(dat){
											$j("#idFoodPackage").html(dat);
										}
									);
							}
						}
					</script>
					<span style="float: right"> 
						<label for="includeRetiredFPack">
							<input type="checkbox" id="includeRetiredFPack" value="0" onchange="javascript:pullRetiredFPack()"/>
							Included Retired
						</label>
					</span>
					<a class="toggleAddFoodPackage" href="#">Add Food Package</a><br />
					
					
					<div id="addFoodPackage" style="display: none;">
						Source: <select name="foodSourcePackage" id="foodSourcePackage" varStatus="state" onchange="javascript:pullListFC()">
								<c:forEach var="sourcePackage" items="${allFoodSource}" varStatus="ind">
									<option id="${state.index + 1 }" value="${sourcePackage.uuid}" >${sourcePackage.code}</option>
								</c:forEach>
							</select>
						<br />
						<div id="idFoodPackageMap">
							<table id="tblFoodMapPackage"  class="lineTable">
								<thead>    
							    	<tr>
							            <th scope="col" rowspan="2">&nbsp;</th>
							            <th scope="col" colspan="2">Food Combination Available:</th>
							        </tr>
							        <tr>
							            <th scope="col">Food Product</th>
							            <th scope="col"><spring:message code="general.createdBy"/></th>
							        </tr>        
							    </thead>
							    <tbody>
							    	<c:forEach var="foodSourceMap" items="${foodMapCom}" varStatus="ind">
										<form method="POST" name="from${foodSourceMap.id}">
											<c:choose>
												<c:when test="${foodSourceMap.dispensable}">
													<tr valign="top">
														<th><input type="checkbox" id="chkbox${foodSourceMap.id}" onchange="javascript:populatePackage('${foodSourceMap.id}','${foodSourceMap.foodProduct.name}','${foodSourceMap.foodSource.code} ')" /></th>
														<td class="highlight">
															${foodSourceMap.foodProduct.name} 
														</td>
														<td class="highlight">
															<openmrs:format user="${foodSourceMap.creator}"/><br />
															<openmrs:formatDate date="${foodSourceMap.dateCreated}"/>
														</td>
													</tr>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
										</form>
									</c:forEach>
							    </tbody>
							</table>
						</div>
						Package Name:<input type="text" id="txtPackageName"/>
						<br />
						<div class="clear"></div>
						<table id="tblSelectedProd" class="lineTable">
							<thead>
								<tr>
									<th colspan="3">Populated Package</th>
								</tr>
								<tr>
									<th>Name:</th>
									<th>Source:</th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody id="bdySelectedProduct">
								
							</tbody>
						</table>
						<input type="hidden" id="hdnCombination"/>
						
						<script type="text/javascript">
							$j(document).ready(function() {
								productComTable = $j('#tblSelectedProd').dataTable({
									"sDom": 'T<"clear">lfrtip',
									"bPaginate": false,
							        "bLengthChange": false,
							        "bFilter": false,
							        "bSort": false,
							        "bInfo": false,
							        "bAutoWidth": true
								});
							});
							function pullListFC(){
								var valSource = document.getElementById("foodSourcePackage").value;
								
								$j.get("ports/foodComPort.form?includedVoided=" + false + "&foodSrc=" + valSource,
										function(dat){
											$j('#idFoodPackageMap').html(dat);
										}
									);
							}
							function onClickDeleteFoodPackage(id,pack){
								var r=confirm("Do you really want to remove " + pack + "?");
								if (r==true){
									var reason=prompt("Please enter the reason for removing this package:","");
									if (reason!=null && reason!=""){
										var arr = [id, reason];
										DWRFoodService.purgeFoodPackage(arr, refreshFoodPackage);
									}else{
										alert("Sorry, you never entered the reason for removing this record. Not removed.")
									}
								}
							}
							function refreshFoodPackage(data){
								$j.get("ports/foodPackagePort.form?includedRetired=" + false,
										function(dat){
											$j('#idFoodPackage').html(dat);
										}
									);
							}
							function populatePackage(comid, name, source){
								var ctrHdn = document.getElementById("chkbox" + comid);
								
								var hdnCom = document.getElementById("hdnCombination").value;
								
								var noSeleted = [];
								var hasVal = "";
						        var oldComD = hdnCom;
						        if (oldComD.indexOf(",", 0) < 0)
						        	noSeleted = [oldComD];
						        else
						        	noSeleted = oldComD.split(",");
								for(var x=0; x<(noSeleted.length); x++){
						            if(noSeleted[x]==comid){
						            	hasVal += noSeleted[x]; 
						            }
								}
								
								if(hasVal == ""){
									if(ctrHdn.checked){
										if (hdnCom == ""){
											hdnCom = comid;
										}else{
											hdnCom +=  "," + comid;
										}
										dwr.util.setValue("hdnCombination", hdnCom);
										
										//chkID = document.getElementById(comid).value;
										productComTable.fnAddData([name, source,"<input type='button' value='x' onclick='javascript:removeClicked(" + comid + ")' />"]);
									}
								}
							}
							function removeClicked(comID){
								var strComId="";
								var noSeleted = [];
								var intPlace= -1;
						        var oldComD= document.getElementById("hdnCombination").value;
						        if (oldComD.indexOf(",", 0) < 0)
						        	noSeleted = [oldComD];
						        else
						        	noSeleted = oldComD.split(",");
								for(var x=0; x<(noSeleted.length); x++){
						            if(noSeleted[x]==comID){
						                intPlace = x;
						                productComTable.fnDeleteRow(intPlace);
						                if(noSeleted.length == 1)
						                	productComTable.fnClearTable();
						                productComTable.fnDraw();
						            }else{
						                if(strComId=="")
						                    strComId = noSeleted[x];
						                else
						                    strComId += "," + noSeleted[x];
						                productComTable.fnDraw();
						            }
								}
								$j("#hdnCombination").val("");
								$j("#hdnCombination").val(strComId);
							}
						</script>
						<br />
						
						<input type="button" id="idBtnPackage" value="Save Package" onclick="javascript:submitPackage()"/>
						
					
					</div>
					
					<div id="idFoodPackage">
						
						<table id="tblFoodPackage"  class="lineTable">
							<thead>    
						    	<tr>
						            <th scope="col" rowspan="2">&nbsp;</th>
						            <th scope="col" colspan="4">Available Food Packages</th>
						        </tr>
						        <tr>
						            <th scope="col">Name</th>
						            <th scope="col">Source-to-Product</th>
						            <th scope="col"><spring:message code="general.createdBy"/></th>
						            <th scope="col">Action</th>
						        </tr>        
						    </thead>
						    <tbody>
						    	<c:forEach var="foodPack" items="${foodPackage}" varStatus="ind">
							    	<tr valign="top">
										<th>${ind.index + 1}</th>
										<td class="highlight">
											${foodPack.name} 
										</td>
										<td class="highlight">
											<c:forEach var="foodPackMap" items="${foodPack.foodPackageCombination}" varStatus="ind1">
											 	${foodPackMap.foodCombination.foodSource.code} - ${foodPackMap.foodCombination.foodProduct.name} <br />
											</c:forEach>
										</td>
										<td class="highlight">
											<openmrs:format user="${foodPack.creator}"/><br />
											<openmrs:formatDate date="${foodPack.dateCreated}"/><br />
										</td>
										<td class="highlight">
											<img onclick="javascript:onClickDeleteFoodPackage('${foodPack.id}','${foodPack.name} ')" src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/trash.gif"/>
										</td>
									</tr>
								</c:forEach>
						    </tbody>
					    </table>
				    </div>
					
					
					
				</div>
				<div class="tabcontent" id="tab_content_5">
					
					
					<script type="text/javascript">
						$j(document).ready(function() {
							$j('.toggleAddFoodWeightRestriction').click(function(event) {
								$j('#addFoodWeightRestriction').slideToggle('slow');
								event.preventDefault();
							});
						});
						
						function passFoodWeightRestriction(){
							var par = document.getElementById("fwrAddEditFR").value;
							var par1 = document.getElementById("fwrid").value;
							var par2 = document.getElementById("foodProductRestriction").value;
							var par3 = document.getElementById("txtQuantity").value;
							var par4 = document.getElementById("txtStartAge").value;
							var par5 = document.getElementById("txtStopAge").value;
							var par6 = document.getElementById("fwridRetireFR").value;
							
							if((par == "Add") || (par == ""))
								var parArrFP = ["1", par1, par2, par3, par4, par5, par6];
							else if(par == "Edit")
								var parArrFP = ["2", par1, par2, par3, par4, par5, par6];
							else
								var parArrFP = ["3", par1, par2, par3, par4, par5, par6];
							DWRFoodService.addEditFoodWeightRestriction( parArrFP, returnFoodWeightRestriction);
						}
						function returnFoodWeightRestriction(data){
							$j.get("ports/foodWeightRestrictionPort.form?includedRetired=" + false,
									function(dat3){
										$j('#idFoodWeightRestriction').html(dat3);
									}
								);
							document.getElementById("fwrAddEditFR").value = "Add";
							document.getElementById("fwrid").value = "";
							document.getElementById("txtQuantity").value = "";
							document.getElementById("txtStartAge").value = "";
							document.getElementById("txtStopAge").value = "";
							$j("#addFoodWeightRestriction").slideToggle('slow');
						}
						function onClickDeleteFoodWeightRestriction(id,restrict){
							var r=confirm("Do you really want to remove " + restrict + "?");
							if (r==true){
								var reason=prompt("Please enter the reason for removing this restriction:","");
								if (reason!=null && reason!=""){
									document.getElementById("fwrAddEditFR").value = "Delete";
									document.getElementById("fwrid").value = id;
									document.getElementById("fwridRetireFR").value = reason;
									passFoodWeightRestriction();
								}else{
									alert("Sorry, you never entered the reason for removing this record. Not removed.")
								}
							}else{
								document.getElementById("fwrAddEditFR").value = "";
							}
						}
						function onClickEditFoodWeightRestriction(id,product,quantity,startAge,stopAge ){
							document.getElementById("fwrAddEditFR").value = "Edit";
							document.getElementById("fwrid").value = id;
							document.getElementById("foodProductRestriction").value = product;
							document.getElementById("txtQuantity").value = quantity;
							document.getElementById("txtStartAge").value = startAge;
							document.getElementById("txtStopAge").value = stopAge;
							$j('#addFoodWeightRestriction').slideToggle('slow');
						}
						function pullRetiredFRest(){
							var val = document.getElementById("includeRetiredFRest");
							if(val.checked){
								$j.get("ports/foodWeightRestrictionPort.form?includedRetired=" + true,
										function(dat){
											$j('#idFoodWeightRestriction').html(dat);
										}
									);
							}else{
								$j.get("ports/foodWeightRestrictionPort.form?includedRetired=" + false,
										function(dat){
											$j('#idFoodWeightRestriction').html(dat);
										}
									);
							}
						}
					</script>
					<span style="float: right"> 
						<label for="includeRetiredFRest">
							<input type="checkbox" id="includeRetiredFRest" value="0" onchange="javascript:pullRetiredFRest()"/>
							Included Retired
						</label>
					</span>
					<a class="toggleAddFoodWeightRestriction" href="#">Add/Edit Food Weight Restriction</a><br />
					<div id="addFoodWeightRestriction" style="border: 1px black solid; background-color: #e0e0e0; display: none; width: 70%;">
						<form method="post">
							<table>
								<tr>
									<th>Food Product</th>
									<td>
										<input type="hidden" name="fwrid" id="fwrid"/>
										<input type="hidden" name="fwrAddEditFR" id="fwrAddEditFR"/>
										<input type="hidden" name="fwridRetireFR" id="fwridRetireFR"/>
										<select name="foodProductRestriction" id="foodProductRestriction" varStatus="state">
											<c:forEach var="product" items="${allFoodProduct}" varStatus="ind">
												<option id="${state.index + 1 }" value="${product.id}" >${product.name}</option>
											</c:forEach>
										</select>
										<span class="required">*</span>
									</td>
								</tr>
								<tr>
									<th>Quantity(in Kgs)</th>
									<td>
										<input type="text" id="txtQuantity"/>
									</td>
								</tr>
								<tr>
									<th>Min Start Age (in Years)</th>
									<td>
										<input type="text" id="txtStartAge"/>
									</td>
								</tr>
								<tr>
									<th>Max Stop Age (in Years)</th>
									<td>
										<input type="text" id="txtStopAge"/>
									</td>
								</tr>
								<tr>
									<th></th>
									<td>
										<input type="button" onclick="javascript:passFoodWeightRestriction()" value="<spring:message code="general.save"/>" />
										<input type="button" value="<spring:message code="general.cancel"/>" class="toggleAddFoodWeightRestriction" />
									</td>
								</tr>
							</table>
						</form>
					</div>
					<br />
					
					
					<div id="idFoodWeightRestriction">
						
						<table id="tblFoodWeightRestriction"  class="lineTable">
							<thead>    
						    	<tr>
						            <th scope="col" rowspan="2">&nbsp;</th>
						            <th scope="col" colspan="6">Food Weight Restrictions</th>
						        </tr>
						        <tr>
						            <th scope="col">Product</th>
						            <th scope="col">Quantity</th>
						            <th scope="col">Start Age(yrs)</th>
						            <th scope="col">Stop Age(&lt;yrs)</th>
						            <th scope="col"><spring:message code="general.createdBy"/></th>
						            <th scope="col">Action</th>
						        </tr>        
						    </thead>
						    <tbody>
						    	<c:forEach var="foodRestriction" items="${foodWeightRestriction}" varStatus="ind">
							    	<tr valign="top">
										<th>${ind.index + 1}</th>
										<td class="highlight">
											${foodRestriction.foodProduct.name} 
										</td>
										<td class="highlight">
											${foodRestriction.quantity}
										</td>
										<td class="highlight">
											${foodRestriction.startAge}
										</td>
										<td class="highlight">
											${foodRestriction.stopAge}
										</td>
										<td class="highlight">
											<openmrs:format user="${foodRestriction.creator}"/><br />
											<openmrs:formatDate date="${foodRestriction.dateCreated}"/><br />
										</td>
										<td class="highlight">
											<img onclick="javascript:onClickEditFoodWeightRestriction('${foodRestriction.id}','${foodRestriction.foodProduct.id}','${foodRestriction.quantity}','${foodRestriction.startAge}','${foodRestriction.stopAge}')" src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/edit.gif"/>
											<img onclick="javascript:onClickDeleteFoodWeightRestriction('${foodRestriction.id}','${foodRestriction.foodProduct.name} ')" src="${pageContext.request.contextPath}/moduleResources/foodprescription/images/trash.gif"/>
										</td>
									</tr>
								</c:forEach>
						    </tbody>
					    </table>
				    </div>
					
				</div>
				<div class="tabcontent" id="tab_content_6">
					<strong>General Properties</strong>
					<br><br>
					<openmrs:portlet url="globalProperties"
					parameters="propertyPrefix=foodprescription|excludePrefix=foodprescription.started;foodprescription.mandatory;"/>
				</div>
			</div>
		</div>
		</td></tr></table>
	</div>
	
<%@ include file="/WEB-INF/template/footer.jsp"%>


