<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bus Routes Content Edit</title>
		<link rel="stylesheet" type="text/css" href="style.css" />
		</head>
	<body>


    <sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/bus_routes" user="root" password="" scope="session"/>
 
 <%@include file="/include/route_combo.jsp" %>
 
 <sql:setDataSource dataSource="${dataSource}"/>
     <c:if test="${pageContext.request.method=='POST'}">
         <c:choose>
             <c:when test="${param.submit=='editbus'}">
                 <sql:update  dataSource="${dataSource}">
                    <sql:param value="${param.combo}" />
                    <sql:param value="${param.numberPlate}"/>
                    <sql:param value="${param.id}"/>
                     UPDATE bus SET RouteID =  ?,NumberPlate =  ? WHERE  id =?
                 </sql:update>
             </c:when>
             <c:when test="${param.submit=='editRoute'}">
                 <sql:update dataSource="${dataSource}">
                     <sql:param value="${param.destination}"/>
                     <sql:param value="${param.source}"/>
                     <sql:param value="${param.distance}"/>
                     <sql:param value="${param.id}"/>
                      UPDATE route SET Destination =  ?,Source =  ?,Distance =  ? WHERE  id =?
                 </sql:update>
             </c:when>
             <c:when test="${param.submit=='editDriver'}">
                 <sql:update dataSource="${dataSource}">
                     <sql:param value="${param.driverName}"/>
                     <sql:param value="${param.combo}"/>
                     <sql:param value="${param.id}"/>
                      UPDATE driver SET Name =  ?, BusID =  ? WHERE  id =?
                 </sql:update>
             </c:when>
             <c:when test="${param.submit=='editCollection'}">
                 <sql:update dataSource="${dataSource}">
                     <sql:param value="${param.fuelConsumed}"/>
                     <sql:param value="${param.combo}"/>
                     <sql:param value="${param.amountCollected}"/>
                     <sql:param value="${param.id}"/>
                      UPDATE dailycollection SET fuel =  ?,BusID =  ?, AmountCollected =  ? WHERE  id =?
                 </sql:update>
             </c:when>
         </c:choose>
     </c:if>
     <c:if test="${pageContext.request.method=='GET'}">
      
    <c:choose>
    <c:when test="${param.page =='buses' }">
    <sql:query var="items" sql="SELECT * FROM bus WHERE id = ?" >
        <sql:param value="${param.id}"/>
    </sql:query>
    <c:forEach var="row" items="${items.rows}">
        <fieldset><legend>Edit Bus</legend><form method ="POST" action=""> <label>RouteID</label>
        <%=combo %>
        <br/><label>Number Plate</label><input type="text" name="numberPlate" value="<c:out value="${row.numberplate}" />"/><br/>
	<input type="submit" value="editbus" name="submit"/><br/> </form></fieldset>
    </c:forEach>
    </c:when>
    <c:when test="${param.page =='route' }">
    <sql:query var="items" sql="SELECT * FROM route WHERE id = ?">
        <sql:param value="${param.id}"/>
    </sql:query>

    <c:forEach var="row" items="${items.rows}">
        <fieldset><legend>Edit Route</legend><form method ="POST" action=""> <label>Destination</label><input type="text" name="destination" value="<c:out value='${row.destination}'/>"/> <br/><label>Source</label><input type="text" name="source" value="<c:out value='${row.source}'/>"/><br/> <label>Distance</label><input type="text" name="distance" value="<c:out value='${row.distance}'/>"/><br/> <input type="submit" value="editRoute" name="submit"/><br/> </form></fieldset>
    </c:forEach>
     </c:when>
    <c:when test="${param.page =='drivers'}">
    <sql:query var="items" sql="SELECT * FROM driver WHERE id = ?">
        <sql:param value="${param.id}"/>
    </sql:query>
        <c:forEach var="row" items="${items.rows}">
            <fieldset><legend>Edit Driver Details</legend><form method ="POST" action=""> <label>Diver's Name</label><input type="text" name="driverName" value="<c:out value="${row.Name}" />"/> <br/><label>Bus ID</label><%=combo %><br/> <input type="submit" value="editDriver" name="submit" /><br/> </form></fieldset>
        </c:forEach>
    </c:when>
    <c:when test="${param.page=='collection'}">
            <sql:query var="items" sql="SELECT * FROM dailycollection WHERE id = ?">
                <sql:param value="${param.id}"/>
            </sql:query>
            <c:forEach var="row" items="${items.rows}">
                <fieldset><legend>Edit Daily Collection</legend><form method ="POST" action=""> <label>Bus ID</label><%=combo %><br/><label>Fuel Consumed</label><input type="text" name="fuelConsumed" value="<c:out value="${row.fuel}"/>"/><br/> <label>Amount Collected</label><input type="text" name="amountCollected" value="<c:out value="${row.amountcollected}"/>"/><br/> <input type="submit" value="editCollection" name="submit"/><br/> </form></fieldset>
            </c:forEach> 
    </c:when>        
                <c:otherwise>
                    
                </c:otherwise>
   </c:choose>
   
    

    </c:if>
    
     
    </body>
</html>
