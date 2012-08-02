<%@ include file="/WEB-INF/template/include.jsp"%>
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
						<a href="#" onclick="javascript:onClickEditEncounterType('${foodSourceItem.id}','${foodSourceItem.name}','${foodSourceItem.description}')">
							<img src="${pageContext.request.contextPath}/moduleResources/fdm/images/edit.gif"/></a>
						<a href="#" onclick="javascript:onClickDeleteEncounterType('${foodSourceItem.id}','${foodSourceItem.name}')">
							<img src="${pageContext.request.contextPath}/moduleResources/fdm/images/trash.gif"/></a>
					</td>
				</tr>
			</form>
		</c:forEach>
    </tbody>
</table>