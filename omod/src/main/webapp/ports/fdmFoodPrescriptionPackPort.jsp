<%@ include file="/WEB-INF/template/include.jsp"%>

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
					<img onclick="javascript:showDivHere('${foodpack.foodCombination.id}')" src="${pageContext.request.contextPath}/moduleResources/fdm/images/individual.png" alt="Populate individuals" />
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
									onclick="javascript:putIndividualized('${foodpack.foodCombination.id}','${householdMembers.householdMembershipMember.personId}')" /></td>
								<td>
									<c:choose>
		                                <c:when test="${householdMembers.householdMembershipHeadship }">
		                                    <img src="${pageContext.request.contextPath}/moduleResources/fdm/images/tick.png" alt="[HEAD/INDEX]" />
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