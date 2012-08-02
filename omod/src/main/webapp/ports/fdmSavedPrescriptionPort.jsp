<%@ include file="/WEB-INF/template/include.jsp"%>
<div>
	<span style="float: right;"><a href="#" onclick="javascript:closeThis()" >[x]</a> </span>
	<table id="tblFoodPack"  class="lineTable">
		<thead>    
	    	<tr>
	            <th scope="col" rowspan="2">&nbsp;</th>
	            <th scope="col" colspan="4">Prescription [${serialno} - ${foodPrescDetails}] </th>
	        </tr>
	        <tr>
	            <th scope="col">Source-to-Product</th>
	            <th scope="col">Quantity(kg)</th>
	            <th scope="col"><spring:message code="general.createdBy"/></th>
	            <th scope="col">Pick</th>
	        </tr>        
	    </thead>
	    <tbody>
	    	<c:forEach var="foodPack" items="${foodPresc}" varStatus="ind">
		    	<tr valign="top">
					<th>${ind.index + 1}</th>
					<td class="highlight">
						${foodPack.foodCombination.foodProduct.name} - ${foodPack.foodCombination.foodSource.code}
						<img onclick="javascript:showDivDisp('${foodPack.id}')" src="${pageContext.request.contextPath}/moduleResources/fdm/images/detail.png" alt="Members" title="Members who received food" align="right"/>
						<div id="hdnDispl${foodPack.id}" style="display: none; background-color: #F8EEEE; padding:1px 1px; border-radius:3px; -moz-border-radius:3px;">
							<c:forEach var="entry" items="${prescPersons}">
								<c:if test="${entry.key == foodPack.id}">
							  		<c:forEach var="foodPP" items="${entry.value}" varStatus="indx">
							  			<openmrs:format person="${foodPP}"/><br />
						  			</c:forEach>
							  </c:if>
							</c:forEach>
						</div>
					</td>
					<td align="right"> 
						 ${foodPack.quantity} &nbsp;
						 <c:choose>
	                        <c:when test="${not prescEncounterPicked}">
						 		<img onclick="javascript:showDiv('${foodPack.id}')" src="${pageContext.request.contextPath}/moduleResources/fdm/images/edit.gif" alt="Edit" />
						 	</c:when>
	                        <c:otherwise>
	                        </c:otherwise>
                        </c:choose>
                        <div id="hdnQuan${foodPack.id}" style="display: none;">
                        	<input type="text" id="idTxtQuan${foodPack.id}" value="${foodPack.quantity}"/><br/>
                        	<input type="button" id="btnSave${foodPack.id}" onclick="javascript:saveQuanVal('${foodPack.id}')" value="Save"/><input type="button" id="btnCancel${foodPack.id}" onclick="javascript:hideDiv('${foodPack.id}')" value="Cancel"/>
                        </div>
					</td>
					<td class="highlight">
						<openmrs:format user="${foodPack.creator}"/><br />
						<openmrs:formatDate date="${foodPack.dateCreated}"/><br />
					</td>
					<td class="highlight">
						<c:choose>
	                        <c:when test="${prescEncounterPicked}">
	                        	<c:choose>
			                        <c:when test="${foodPack.picked}">
			                        
			                            <img src="${pageContext.request.contextPath}/moduleResources/fdm/images/tick.png" alt="[Picked]" />
			                            
			                        </c:when>
			                        <c:otherwise>
										<img src="${pageContext.request.contextPath}/moduleResources/fdm/images/minus.png" alt="[Picked]" />
			                        </c:otherwise>
		                        </c:choose>
	                            
	                        </c:when>
	                        <c:otherwise>
								<input type="checkbox" id="chkPickedPresc${foodPack.id}" onchange="javascript:populatePick('${foodPack.id}')"/>
	                        </c:otherwise>
                        </c:choose>
						
					</td>
				</tr>
			</c:forEach>
		   <tr>
	    		<td colspan="4">
	    		<span style="float: right;">
	    			<c:choose>
                        <c:when test="${prescEncounterPicked}">
                        </c:when>
                        <c:otherwise>
                        	<a href="#" id ="lnkAltered" >Altered Pickup</a> &nbsp;<!-- onclick="javascript:alteredPresc()" -->
                            <input type="button" id ="btnPicked" value="Picked All" onclick="javascript:pickedAll('${prescUuid}')"/>
    						<input type="button" id ="btnSavePick" value="Selected Pick" onclick="javascript:pickedSome('${prescUuid}')"/>
                        </c:otherwise>
                     </c:choose>
	    			
	    		</span></td>
	    	</tr>
	    </tbody>
	</table>
	<input type="hidden" id="hdnConfirmedPick"/>
	<input type="hidden" id="hdnPickedEnc" value="${prescEncounterID}"/>
	
	<script type="text/javascript">
		function closeThis(){
	        $j('#popPrescription').hide();
	    }
	    
	    function populatePick(pas){
			var pop = document.getElementById("hdnConfirmedPick").value;
			var chkSel = document.getElementById("chkPickedPresc" + pas);
			if (chkSel.checked == 1){
				if(pop == ""){
					$j("#hdnConfirmedPick").val(pas);
				}else
					$j("#hdnConfirmedPick").val(pop + "," + pas);
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
				$j("#hdnConfirmedPick").val(strOut);
			}
		}
	    
	    function pickedAll(inUuid){
	    	var r=confirm("Are you sure you want to select picked all?");
	    	if (r==true){
	    		DWRFoodService.pickedAllPrescription( inUuid, returnAllPick);
	    	}
	    }
	    function returnAllPick(data){
	    	var pop = document.getElementById("hdnPickedEnc").value;
			picked(pop);
	    }
	    
		function pickedSome(inUuid){
			var r=confirm("Are you sure you want to select picked some?");
	    	if (r==true){
				var pop = document.getElementById("hdnConfirmedPick").value;
				var arrData = [inUuid, pop];
				DWRFoodService.pickedSomePrescription( arrData, returnSomePick);
	    	}
	    }
		function returnSomePick(data){
			var pop = document.getElementById("hdnPickedEnc").value;
			picked(pop);
	    }
		
		function picked(id){
			$j('#popPrescription').hide();
			$j.get("ports/fdmSavedPrescriptionPort.form?encounter=" + id,
					function(dat){
						$j('#popPrescription').html(dat);
						$j('#popPrescription').show();
					}
				);
		}
		
		$j(document).ready(function() {
			$j('#idAlteredPick').dialog({
				autoOpen: false,
				modal: true,
				title: 'Actual picked prescription',
				width: '80%'
			});
					
			$j('#lnkAltered').click(function() {
				$j("#popCombAdd").val("");
				$j('#idAlteredPick').dialog('open');
			});
		});
		
		function isBtnSavePickedAltered(){
			$j('#idAlteredPick').dialog('close');
			var r=confirm("Are you sure you want to add a different pick-up?");
	    	if (r==true){
				var pop = document.getElementById("hdnPickedEnc").value;
				var pop1 = document.getElementById("popCombAdd").value;
				var pop2 = document.getElementById("userProviderHere").value;
				var pop3 = document.getElementById("capDate").value;
				var arrData = [pop,pop1,pop2,pop3];
				DWRFoodService.pickedNewPrescription( arrData, returnNewPickup);
	    	}
		}
		function returnNewPickup(data){
			if(data){
				var id = document.getElementById("hdnPickedEnc").value;
				$j.get("ports/fdmSavedPrescriptionPort.form?encounter=" + id,
						function(dat){
							$j('#popPrescription').html(dat);
							//$j('#popPrescription').show();
						}
					);
			}
		}
		
		function showDiv(inDiv){
			var id = "#hdnQuan" + inDiv;
		    $j(id).show();
		}
		function hideDiv(inDiv){
			var id = "#hdnQuan" + inDiv;
		    $j(id).hide();
		}
		function saveQuanVal(inId){
			var val = document.getElementById("idTxtQuan" + inId).value;
			hideDiv(inId);
			var arrQuan = [inId, val];
			DWRFoodService.saveEditedQuantity(arrQuan, returnNewPickup);
		}
		function showDivDisp(inDiv){
			$j("#hdnDispl" + inDiv).slideToggle('slow');
		}
	
	</script>
</div>