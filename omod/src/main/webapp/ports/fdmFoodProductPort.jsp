<%@ include file="/WEB-INF/template/include.jsp"%>

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
							<img src="${pageContext.request.contextPath}/moduleResources/fdm/images/edit.gif"/></a>
						<a href="#" onclick="javascript:onClickDeleteFoodProduct('${foodProductItem.id}','${foodProductItem.name}')">
							<img src="${pageContext.request.contextPath}/moduleResources/fdm/images/trash.gif"/></a>
						</td>
					</tr>
				</form>
			</c:forEach>
	    </tbody>
	</table>