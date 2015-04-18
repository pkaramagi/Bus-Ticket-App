<%--Two Tag Libraries, downloaded sun.com, are used
One for SQL functions(sql)
The other for manipulation of data like conditional statements
--%>
<%@ taglib uri="WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="WEB-INF/tld/sql.tld" prefix="sql"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost/bus_routes" user="root" password=""
	scope="session" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bus Routes </title>
<link rel="stylesheet" type="text/css" href="style.css" />

<script>

// Wait for the document to finish loading
window.onload = function(){
// Get the form and watch for a submit attempt.
document.getElementsByTagName("form")[0].onsubmit = function(){
// Get an input element to check
var elem = document.getElementById("destination");

// Make sure that the required age field has been checked
if ( ! checkRequired( elem ) ) {
// Display an error and keep the form from submitting.
alert( "Required field is empty – " +
"you must be over 13 to use this site." );
return false;
}


};

};

</script>
</head>



<html>
<body>
<%-- Conditional Statements to detect what value is in the submit parameter
This value is used to choose what query to execute when adding data to the database
adddriver, addroute, addbuses, amountcollected --%>

<c:if test="${pageContext.request.method=='POST'}">
 <c:choose>
      <c:when test="${param.submit=='routes'}">
	  
<sql:update dataSource="${dataSource}" var="count">
INSERT INTO route (source,destination,distance) VALUES (?, ?, ?)
            <sql:param value="${param.destination}" />
			<sql:param value="${param.source}" />
			<sql:param value="${param.distance}" />
		</sql:update>
   </c:when>
       <c:when test="${param.submit=='collection'}">
	  
<sql:update dataSource="${dataSource}" var="count">
INSERT INTO dailycollection (fuel,busid,amountcollected) VALUES (?, ?, ?)
            <sql:param value="${param.fuelConsumed}" />
			<sql:param value="${param.combo}" />
			<sql:param value="${param.amountCollected}" />
		</sql:update>
   </c:when>
   
 <c:when test="${param.submit=='adddriver'}">
	  
<sql:update dataSource="${dataSource}" var="count">
INSERT INTO driver (name,busid) VALUES (?, ?)
            <sql:param value="${param.driverName}" />
			<sql:param value="${param.combo}" />
		
		</sql:update>
   </c:when> 

 <c:when test="${param.submit=='AddBus'}">
	  
<sql:update dataSource="${dataSource}" var="count">
INSERT INTO bus (numberplate,routeid) VALUES (?, ?)
            <sql:param value="${param.numberPlate}" />
			<sql:param value="${param.combo}" />
		
		</sql:update>
   
   </c:when>    
   
<c:otherwise>
otherquery
</c:otherwise>
   </c:choose>
 </c:if>
 
<%@include file= 'include/route_combo.jsp'%>

<%
    String current_page = request.getParameter("page");
    String action = request.getParameter("action");
    if(current_page == null  || current_page.equals("")){
     current_page ="default";
    }
%>



<%!

 private String routeForm(){
   return("<fieldset><legend>Add new Route</legend><form method =\"POST\" action=\"\"> <label>Destination</label><input type=\"text\" name=\"destination\" id=\" destination\"/> <br/><label>Source</label><input type=\"text\" name=\"source\"/><br/> <label>Distance</label><input type=\"text\" name=\"distance\"/><br/> <input type=\"submit\" value=\"routes\" name=\"submit\"/><br/> </form></fieldset>");

 }
  private String collectionForm(String combo){
   return("<fieldset><legend>Add new Collection</legend><form method =\"POST\" action=\"\"> <label>Bus ID</label>"+combo+"<br/><label>Fuel Consumed</label><input type=\"text\" name=\"fuelConsumed\"/><br/> <label>Amount Collected</label><input type=\"text\" name=\"amountCollected\"/><br/> <input type=\"submit\" value=\"collection\" name=\"submit\"/><br/> </form></fieldset>");

 }
  private String busForm(String combo){

   return("<fieldset><legend>Add New Bus</legend><form method =\"POST\" action=\"\"> <label>RouteID</label>"+combo+"<br/><label>Number Plate</label><input type=\"text\" name=\"numberPlate\"/><br/> <input type=\"submit\" value=\"AddBus\" name=\"submit\"/><br/> </form></fieldset>");

 }
   private String driverForm(String combo){
   return("<fieldset><legend>Add new Driver</legend><form method =\"POST\" action=\"\"> <label>Diver's Name</label><input type=\"text\" name=\"driverName\"/> <br/><label>Bus ID</label>"+combo+"<br/> <input type=\"submit\" value=\"adddriver\" name=\"submit\"/><br/> </form></fieldset>");

 }

 private String driverMenu() {
    return("<li><a href=\"?page=drivers&&action=add\" title=\"#\">adddrivers</a></li><li><a href=\"?page=drivers&&action=view\" title=\"#\">View drivers</a></li>");
  }

 private String collectionMenu() {
    return("<li><a href=\"?page=collection&&action=add\" title=\"#\">Add DailyCollection</a></li><li><a href=\"?page=collection&&action=view\" title=\"#\">View DailyCollection</a></li>");
  }
  private String busesMenu() {
    return("<li><a href=\"?page=buses&&action=add\" title=\"#\">Add Buses</a></li><li><a href=\"?page=buses&&action=view\" title=\"#\">View Buses</a></li>");
  }


%>


<body>
<div id="wrap">
<div id="header_top">
<div id="navigation">
<ul>
<li style="margin-left: 1px;"><a href="?page=routes">Routes</a></li>
<li><a href="?page=drivers">Drivers</a></li>
<li><a href="?page=buses" >Buses</a></li>
<li><a href="?page=collection" >Daily Collection</a></li>

</ul>
</div>
</div>
<div id="header">
<div id="logo">

    <%

    if(action== null || action.equals("")){
    action = "default";
    
    }

        
     %>
 </div>
</div>
<div id="left">
<h3>Quick Links</h3>
<ul>
    <% if(current_page.equals("buses")){
    out.println (busesMenu());

    }
    else if(current_page.equals("collection")){
    out.println (collectionMenu());
    }
    else if(current_page.equals("drivers")){
    out.println (driverMenu());
    }
    else if(current_page.equals("default")){%>



   <li><a href="?page=route&&action=add" title="#">Add New Route</a></li>
<li><a href="?page=route&&action=view" title="#">View Routes</a></li>
   <% }

    else{
    %>

<li><a href="?page=route&&action=add" title="#">Add New Route</a></li>
<li><a href="?page=route&&action=view" title="#">View Routes</a></li>
<% }%>
</ul>
</div>
<div id="main">

<h2><%=current_page %></h2>
	

<%

if(current_page.equals("route")){
    if(action.equals("add")){
     out.println (routeForm());
    }

    else if(action.equals("edit")){
%>


	<jsp:include page="edit.jsp" />

    <% 
    }
    else if(action.equals("view")){
	%>
<sql:query dataSource="${dataSource}" var="result">
   SELECT * from route;
</sql:query>
 
<table  width="100%">
<tr>
<th>ID</th>
<th>SOURCE</th>
<th>DESTINATION</th>
<th>DISTANCE</th>
<th>EDIT</th>

</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td><c:out value="${row.id}"/></td>
<td><c:out value="${row.Destination}"/></td>
<td><c:out value="${row.Source}"/></td>
<td><c:out value="${row.Distance}"/></td>
<td><a href="index.jsp?page=route&&action=edit&&id=<c:out value="${row.id}"/>">Edit</a></td>

</tr>
</c:forEach>
</table>
	
	
	<%
	
	
	}

    else if(action.equals("default")){
     out.println (routeForm());
    }
    else{
    out.println (routeForm());
    }

}
 else if(current_page.equals("buses")){

      if(action.equals("add")){
     out.println (busForm(combo));
    }

    else if(action.equals("edit")){
%>
	<jsp:include page="edit.jsp" />
 <%
    }
    else if(action.equals("view")){
	
	%>
<sql:query dataSource="${dataSource}" var="result">
SELECT a.id,a.destination,a.source,b.Numberplate from bus b,route a where b.routeid=a.id;
</sql:query>
 <table  width="100%">
<tr>
<th>ID</th>
<th>DESTINATION</th>
<th>SOURCE</th>
<th>NUMBER PLATE</th>
<th>EDIT</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td><c:out value="${row.id}"/></td>
<td><c:out value="${row.destination}"/></td>
<td><c:out value="${row.source}"/></td>
<td><c:out value="${row.Numberplate}"/></td>
<td><a href="index.jsp?page=buses&&action=edit&&id=<c:out value="${row.id}"/>">Edit</a></td>
</tr>
</c:forEach>
</table>
	
	<%	
	
	}

    else if(action.equals("default")){
     out.println (busForm(combo));
    }
    else{
    out.println (busForm(combo));
    }

 }

    else if(current_page.equals("drivers")){

      if(action.equals("add")){
     out.println (driverForm(combo));
    }

    else if(action.equals("edit")){
%>
	<jsp:include page="edit.jsp" />
 <%
 }
    else if(action.equals("view")){
	%>
	
<sql:query dataSource="${dataSource}" var="result">
   SELECT a.id,a.name,b.NumberPlate from driver a, bus b where b.id=a.busid ;
</sql:query>
 <table  width="100%">
<tr>

<th>NAME</th>
<th>BUS NUMBER PLATE</th>
<th>EDIT</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>

<td><c:out value="${row.name}"/></td>
<td><c:out value="${row.NumberPlate}"/></td>
<td><a href="index.jsp?page=drivers&&action=edit&&id=<c:out value="${row.id}"/>">Edit</a></td>
</tr>
</c:forEach>
</table>
	
	
	
	<%
	
	}

    else if(action.equals("default")){
     out.println (driverForm(combo));
    }
      }
    
    else if(current_page.equals("collection")){
    if(action.equals("add")){
     out.println (collectionForm(combo));
    }

    else if(action.equals("edit")){
	%>
	<jsp:include page="edit.jsp" />
 <%
	}
    else if(action.equals("view")){
	%>
<sql:query dataSource="${dataSource}" var="result">
SELECT a.id,a.amountcollected,a.fuel,b.Numberplate from bus b,dailycollection a where b.id=a.busid;
</sql:query>
 <table  width="100%">
<tr>
<th>AMOUNT COLLECTED</th>
<th>FUEL</th>
<th>NUMBER PLATE</th>
<th>EDIT</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td><c:out value="${row.amountcollected}"/></td>
<td><c:out value="${row.fuel}"/></td>
<td><c:out value="${row.Numberplate}"/></td>
<td><a href="index.jsp?page=collection&&action=edit&&id=<c:out value="${row.id}"/>">Edit</a></td>
</tr>
</c:forEach>
</table>
	<%
	}

    else if(action.equals("default")){
     out.println (collectionForm(combo));
    }
    else{
    out.println(collectionForm(combo));
    }
      }

    else{
    out.println (routeForm());
    }
%>

<br/>
</div>

<div id="footer">
copyright &copy; 2012 by: :  designed by: Group.
</div>
<div class="clear"></div>
</div>
</body>
</html>
