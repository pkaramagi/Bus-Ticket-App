<%@page import="java.sql.*,java.io.*" %>
<html><body>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/","root","");
PreparedStatement ps=con.prepareStatement("create database bus_routes");
ps.executeUpdate();
PreparedStatement ps1=con.prepareStatement("use bus_routes");
ps1.executeUpdate();
PreparedStatement ps2=con.prepareStatement("create table bus(`id` int(11) NOT NULL AUTO_INCREMENT,`RouteID` int(11) NOT NULL,`NumberPlate` varchar(20) NOT NULL,PRIMARY KEY (`id`))");
ps2.executeUpdate();
PreparedStatement ps3=con.prepareStatement("create table dailycollection(`id` int(11) NOT NULL AUTO_INCREMENT,`fuel` int(11) NOT NULL,`BusID` int(11) NOT NULL,`AmountCollected` int(11) NOT NULL,PRIMARY KEY (`id`))");
ps3.executeUpdate();
PreparedStatement ps4=con.prepareStatement("create table route(`id` int(11) NOT NULL AUTO_INCREMENT,`Destination` varchar(20) NOT NULL,`Source` varchar(20) NOT NULL,`Distance` int(20) NOT NULL,PRIMARY KEY (`id`))");
ps4.executeUpdate();
PreparedStatement ps5=con.prepareStatement("create table driver(`Id` int(11) NOT NULL AUTO_INCREMENT,`Name` varchar(30) NOT NULL,`BusID` int(11) NOT NULL,PRIMARY KEY (`Id`))");
ps5.executeUpdate();
PreparedStatement ps6=con.prepareStatement("INSERT INTO `bus`  VALUES(NULL, 1, 'UAE515g'),(NULL, 2, 'UAA212G'),(NULL, 1, 'UAE212G')");
ps6.executeUpdate();
PreparedStatement ps7=con.prepareStatement("INSERT INTO `dailycollection` (`id`, `fuel`, `BusID`, `AmountCollected`) VALUES(1, 10, 1, 10),(2, 0, 1, 0),(3, 0, 1, 0),(4, 200, 27, 20),(5, 0, 27, 0),(6, 200, 2, 20000)");
ps7.executeUpdate();
PreparedStatement ps8=con.prepareStatement("INSERT INTO `driver` (`Id`, `Name`, `BusID`) VALUES(1, 0, 1)");
ps8.executeUpdate();
PreparedStatement ps9=con.prepareStatement("INSERT INTO `route` (`id`, `Destination`, `Source`, `Distance`) VALUES(1, 'qw', 'qw', 0),(2, 'Start', 'go', 12),(15, 'Fort', 'Kampala', 24),(16, 'Fort', 'Kampala', 24),(21, '', '', 0),(20, '', '', 0),(19, 'Fort', 'Kampala', 24)");
ps9.executeUpdate();




%>
</body></html>