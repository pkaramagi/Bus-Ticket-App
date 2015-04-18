<%---This file is used to create a combo--%>


 <c:choose>
 <c:when test="${param.page=='buses'}">
<sql:setDataSource dataSource="${dataSource}"/> 
<sql:query var="items" sql="SELECT a.id as id, b.id AS bus, COUNT( b.id ) as count FROM route a LEFT OUTER JOIN bus b ON b.RouteID = a.id GROUP BY a.id HAVING count <10">
</sql:query>
<c:set var="my">
<c:forEach var="row" items="${items.rows}">


<c:out value="${row.id} ,"/>
</c:forEach>
</c:set>
<c:set var="myvariable">
<c:out value="${my}"/>
</c:set>
</c:when>

<c:otherwise>
<sql:setDataSource dataSource="${dataSource}"/> 
<c:choose>
<c:when test="${param.page=='drivers'}">
<sql:query var="items" sql="SELECT a.id AS id, b.id AS bus, COUNT( b.id ) AS count FROM bus a LEFT OUTER JOIN driver b ON b.busid = a.id GROUP BY a.id HAVING count <2">
</sql:query>
</c:when>
<c:otherwise>
<sql:query var="items" sql="SELECT * FROM bus">
</sql:query>
</c:otherwise>
</c:choose>
<c:set var="my">
<c:forEach var="row" items="${items.rows}">


<c:out value="${row.id} ,"/>


</c:forEach>
</c:set>
<c:set var="myvariable">
<c:out value="${my}"/>
</c:set>
</c:otherwise>
 </c:choose>
<%
String combo="<select name=\"combo\">";
String routecombo = (String)pageContext.getAttribute("myvariable");

String[] result = routecombo.split(",");
for (int x=0; x<result.length; x++)
{
if(result[x]!=""){
combo+="<option >"+result[x]+" </option>";
}


}
combo+="<select>";

%>