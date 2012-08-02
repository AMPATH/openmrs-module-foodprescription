<%@ include file="/WEB-INF/template/include.jsp"%>

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
					<img onclick="javascript:onClickDeleteFoodPackage('${foodPack.id}','${foodPack.name} ')" src="${pageContext.request.contextPath}/moduleResources/fdm/images/trash.gif"/>
				</td>
			</tr>
		</c:forEach>
    </tbody>
   </table>