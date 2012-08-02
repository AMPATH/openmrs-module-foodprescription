<%@ include file="/WEB-INF/template/include.jsp"%>

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
    	<c:if test="${not empty foodMapm}">
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
    	</c:if>
    	
    </tbody>
</table>
