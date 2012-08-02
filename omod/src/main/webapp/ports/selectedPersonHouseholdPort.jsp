<%@ include file="/WEB-INF/template/include.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/foodprescription/js/jquery-1.5.2.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/foodprescription/js/style-table.js" /> --%>
<link href="${pageContext.request.contextPath}/moduleResources/foodprescription/css/css-table.css" type="text/css" rel="stylesheet" />

<table id="tblHouseholds"  class="lineTable">
	<thead>    
    	<tr>
            <th scope="col" rowspan="2">&nbsp;</th>
            <th scope="col" colspan="4">Households this person belongs</th>
        </tr>
        <tr>
            <th scope="col">Identifier:</th>
            <th scope="col">Start Date:</th>
            <th scope="col">End Date:</th>
            <th scope="col"><spring:message code="general.createdBy"/></th>
        </tr>        
    </thead>
    <tbody>
    	<c:forEach var="mem" items="${membership}" varStatus="ind">
			<%-- <form method="POST" name="${mem.id}"> --%>
				<tr valign="top">
					<th>${ind.index + 1}</th>
					<td class="highlight">
						<a href="#" onclick="javascript:forwardMem(${mem.id})">${mem.householdMembershipGroups.householdIdentifier}  - ${mem.householdMembershipGroups.householdDef.householdDefinitionsCode}</a>
					</td>
					<td class="highlight">
						<openmrs:formatDate date="${mem.startDate}"/>
					</td>
					<td class="highlight"><openmrs:formatDate date="${mem.endDate}"/>
					</td>
					<td class="highlight">
						<openmrs:format user="${mem.creator}"/><br />
						<openmrs:formatDate date="${mem.dateCreated}"/>
					</td>
				</tr>
			<!-- </form> -->
		</c:forEach>
    </tbody>
</table>