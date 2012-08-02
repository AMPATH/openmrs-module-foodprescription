<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="View Food Statistics" otherwise="/login.htm" redirect="/module/fdm/fdmStatistic.form" />
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="localHeader.jsp"%>

<link href="${pageContext.request.contextPath}/moduleResources/fdm/css/css-table.css" type="text/css" rel="stylesheet" />

<style>
	#openmrsSearchTable_wrapper{
	/* Removes the empty space between the widget and the Create New Patient section if the table is short */
	/* Over ride the value set by datatables */
		min-height: 0px; height: auto !important;
	}
</style>


<style>
	#content1 section1, #content1 article1 { 
		/* border: 2px solid #cdcdcd; */
		-webkit-border-radius: 10px;
		-moz-border-radius: 10px;
		border-radius: 10px;
		display: block; 
		float: left; 
		width: 96%;
		padding-left:15px;
		margin-bottom:10px;
		margin-left:10px;
		-webkit-box-shadow: 0px 4px 4px 6px #cdcdcd;
		-moz-box-shadow: 0px 4px 4px 6px #cdcdcd;
		box-shadow: 0px 4px 4px 6px #cdcdcd;
	}
	
	#content1 { 
		/*width: 200px;*/ 
		height: 75px;
		border: 2px solid;
	}
	
	#openmrsSearchTable_wrapper{
	/* Removes the empty space between the widget and the Create New Patient section if the table is short */
	/* Over ride the value set by datatables */
		min-height: 0px; height: auto !important;
	}
	.dataTables_wrapper {
	    clear: both;
	    min-height: 0px;
	    position: relative;
	}
	.evencol {
        border-left: 1px solid #E8E8E9;
        border-right: 1px solid #E8E8E9;
        padding-left: 3px;
    }

    .oddcol {
        padding-left: 3px;
    }
</style>

<table width="100%">
<tr><td>
<div>
	<div style="width:95%;">
		<section1 id="content1">

			<article1>
				<div id="dataDisplay" style="background-color: #EEEEEE; padding:10px 10px; border-radius:10px; -moz-border-radius:10px;">
					<table class="lineTable">
						<thead>    
					    	<tr>
					            <th scope="col" rowspan="2">&nbsp;</th>
					            <th scope="col" colspan="5">Data Entry Statistics</th>
					        </tr>
					        <tr>
					            <th scope="col">Data Assistant:</th>
					            <th scope="col">Today:</th>
					            <th scope="col">Last 5 Days:</th>
					            <th scope="col">Last 30 Days:</th>
					        </tr>        
					    </thead>
					    <tbody>
							<c:forEach var="person" items="${listMap}" varStatus="ind">
								<tr>
									<th>${ind.index + 1}</th>
									<td><openmrs:format person="${person.key}"/></td>
									<c:forEach var="i" items="${person.value}">
										<td>${i}</td>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</article1>
	
	   </section1>
	
	</div>

</div>
<!-- <script type="text/javascript">
	setInterval( "SANAjax();", 5000 );  ///////// 10 seconds
	
	$j(function() {
	SANAjax = function(){
		$j.get("ports/fdmFoodPackagePort.form?includedRetired=" + false,
				function(dat1){
					$j("#dataDisplay").html(dat1);
				}
			);
	}
	 });
</script> -->
</td></tr></table>
<%@ include file="/WEB-INF/template/footer.jsp"%>

