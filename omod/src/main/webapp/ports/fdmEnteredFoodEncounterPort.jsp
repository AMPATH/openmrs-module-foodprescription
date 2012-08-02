<%@ include file="/WEB-INF/template/include.jsp"%>
<table border="0" class="lineTable">
	<thead>
		<tr>
            <th scope="col" colspan="3">Previous Prescriptions:</th>
        </tr>
		<tr>
			<th></th>
			<th>Date</th>
			<th>Provider</th>
		</tr>
	</thead>
	<c:forEach var="foodEnc" items="${foodEncounters}" varStatus="ind">
	<tr>
		<th>${ind.index + 1}</th>
		<td class="highlight"><a href="#" onClick="javascript:popPrescrip('${foodEnc.id}')">${foodEnc.serialno}:${fn:substring(foodEnc.encounterDatetime,0,10)}&nbsp;(${foodEnc.location.name})</a></td>
		<td class="highlight">
			<openmrs:format person="${foodEnc.provider}"/>
		</td>
	</tr>
	</c:forEach>
</table>