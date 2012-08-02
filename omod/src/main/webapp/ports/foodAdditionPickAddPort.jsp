<%@ include file="/WEB-INF/template/include.jsp"%>

<table id="tblFoodMapAdd"  class="lineTable">
	<thead>    
    	<tr>
            <th scope="col" rowspan="2">&nbsp;</th>
            <th scope="col" colspan="4">Food Source-To-Product mapping</th>
        </tr>
        <tr>
            <th scope="col">Food Product</th>
            <th scope="col">Available</th>
            <th scope="col">Choose</th>
        </tr>        
    </thead>
    <tbody>
    	<c:forEach var="foodSourceMap" items="${foodMapm}" varStatus="ind">
			<%-- <form method="POST" name="${foodSourceMap.id}"> --%>
				<tr valign="top">
					<th>${ind.index + 1}</th>
					<td class="highlight">
						${foodSourceMap.foodProduct.name} 
					
					</td>
					<td class="highlight">
						<c:choose>
							<c:when test="${foodSourceMap.dispensable}">
								<input type="checkbox" id="chkDispensable" checked="checked" readonly="readonly" />
							</c:when>
							<c:otherwise>
								<input type="checkbox" id="chkDispensable" readonly="readonly" />
							</c:otherwise>
						</c:choose>
					</td>
					<td class="highlight">
						<input type="checkbox" id="idSelAdd${foodSourceMap.id}" onchange="javascript:populateNewCombAdd('${foodSourceMap.id}')" value="${foodSourceMap.id}"/>
					</td>
				</tr>
			<!-- </form> -->
		</c:forEach>
    </tbody>
</table>
