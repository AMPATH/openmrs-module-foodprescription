<%@ include file="/WEB-INF/template/include.jsp"%>

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
		<form method="POST" name="form${foodSourceMap.id}">
			<c:choose>
				<c:when test="${foodSourceMap.dispensable}">
					<tr valign="top">
						<th><input type="checkbox" id="chkbox${foodSourceMap.id}" onchange="javascript:populatePackage('${foodSourceMap.id}','${foodSourceMap.foodProduct.name}','${foodSourceMap.foodSource.code} ')" /></th>
						<td class="highlight">
							${foodSourceMap.foodProduct.name} 
						</td>
						<td class="highlight">
							<openmrs:format user="${foodSourceMap.creator}"/><br />
							<openmrs:formatDate date="${foodSourceMap.dateCreated}"/><br />
							</td>
						</tr>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
			</form>
		</c:forEach>
    </tbody>
</table>