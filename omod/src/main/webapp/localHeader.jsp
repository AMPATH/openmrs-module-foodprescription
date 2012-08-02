<ul id="menu">
	<li class="first">
		<a href="${pageContext.request.contextPath}/admin"><spring:message code="admin.title.short"/></a>
	</li>
	<openmrs:hasPrivilege privilege="Manage Food Configuration">
		<li <c:if test='<%= request.getRequestURI().contains("fdmConfiguration") %>'>class="active"</c:if>>
			<a href="${pageContext.request.contextPath}/module/fdm/fdmConfiguration.form">
				Configuration
			</a>
		</li>
	</openmrs:hasPrivilege>
	<openmrs:hasPrivilege privilege="Manage Food Prescriptions">
		<li <c:if test='<%= request.getRequestURI().contains("fdmPrescription") %>'>class="active"</c:if>>
			<a href="${pageContext.request.contextPath}/module/fdm/fdmPrescription.form">
				Prescription
			</a>
		</li>
	</openmrs:hasPrivilege>
	<openmrs:hasPrivilege privilege="View Food Statistics">
		<li <c:if test='<%= request.getRequestURI().contains("fdmStatistic") %>'>class="active"</c:if>>
			<a href="${pageContext.request.contextPath}/module/fdm/fdmStatistic.form">
				Statistic
			</a>
		</li>
	</openmrs:hasPrivilege>
</ul>