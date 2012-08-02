<%@ include file="/WEB-INF/template/include.jsp"%>

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
					<img onclick="javascript:onClickEditFoodWeightRestriction('${foodRestriction.id}','${foodRestriction.foodProduct.id}','${foodRestriction.quantity}','${foodRestriction.startAge}','${foodRestriction.stopAge}')" src="${pageContext.request.contextPath}/moduleResources/fdm/images/edit.gif"/>
					<img onclick="javascript:onClickDeleteFoodWeightRestriction('${foodRestriction.id}','${foodRestriction.foodProduct.name} ')" src="${pageContext.request.contextPath}/moduleResources/fdm/images/trash.gif"/>
				</td>
			</tr>
		</c:forEach>
    </tbody>
   </table>