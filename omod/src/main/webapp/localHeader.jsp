<ul id="menu">
	<li class="first">
		<a href="${pageContext.request.contextPath}/admin"><spring:message code="admin.title.short"/></a>
	</li>
	<openmrs:hasPrivilege privilege="Manage Food Configuration">
		<li <c:if test='<%= request.getRequestURI().contains("foodprescriptionConfiguration") %>'>class="active"</c:if>>
			<a href="${pageContext.request.contextPath}/module/foodprescription/configuration.form">
				Configuration
			</a>
		</li>
	</openmrs:hasPrivilege>
	<openmrs:hasPrivilege privilege="Manage Food Prescriptions">
		<li <c:if test='<%= request.getRequestURI().contains("foodprescriptionPrescription") %>'>class="active"</c:if>>
			<a href="${pageContext.request.contextPath}/module/foodprescription/prescription.form">
				Prescription
			</a>
		</li>
	</openmrs:hasPrivilege>
	<openmrs:hasPrivilege privilege="View Food Statistics">
		<li <c:if test='<%= request.getRequestURI().contains("foodprescriptionStatistic") %>'>class="active"</c:if>>
			<a href="${pageContext.request.contextPath}/module/foodprescription/statistic.form">
				Statistic
			</a>
		</li>
	</openmrs:hasPrivilege>
</ul>