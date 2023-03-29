<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
	background-color: white;
	margin: 0;
	padding: 0;
}

#navbar {
	background-color: #1a1a1a;
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 30px;
}

#navbar a {
	color: #ffffff;
	text-decoration: none;
	padding: 0 20px;
	font-size: 18px;
	font-weight: 500;
	transition: 0.2s ease;
}

#navbar a:hover {
	color: #bfbfbf;
}

.container {
	margin: 50px;
	color: #ffffff;
	font-size: 24px;
	font-weight: 500;
	text-align: center;
}

.a1 {
	color: #ffffff;
	font-size: 18px;
	font-weight: bold;
	text-decoration: none;
	background-color: #ff8c00;
	padding: 10px 20px;
	border-radius: 10px;
	transition: 0.2s ease;
	text-shadow: 2px 2px 4px #000000;
}

.a1:hover {
	background-color: #bfbfbf;
	color: #000000;
}

table {
	border-collapse: collapse;
	width: 80%;
	margin: 0 auto;
	margin-top: 30px;
	margin-bottom: 30px;
	border: 1px solid #fff;
}

th, td {
	text-align: left;
	padding: 8px;
	border: 1px solid #fff;
}

th {
	background-color: #FFA500;
	color: white;
	font-weight: bold;
	text-align: center;
}

tr {
	background-color: #f2f2f2;
}

h1 {
	text-align: center;
	color: orange;
}

h1 {
	text-align: center;
	color: #FFFFFF;
}

form {
	padding: 50px;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-shadow: 2px 2px 10px #ddd;
	width: 500px;
	margin: 50px auto;
	background-color: #ff8c00;
}

label {
	font-weight: bold;
	display: block;
	margin-bottom: 20px;
	color: #FFFFFF;
}

select, input[type="text"], input[type="number"], input[type="date"] {
	padding: 10px;
	border: 1px solid #FF69B4;
	border-radius: 5px;
	margin-bottom: 40px;
	width: 100%;
	background-color: #E5E5E5;
	color: #0077BE;
}


input[type="submit"] {
	background-color: #000000;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	width: 100%;
}

p {
  color: #FFFFFF;
}

p.dark-orange {
  color: darkorange;
  font-size:30px
}

</style>
<meta charset="UTF-8">
<title>Income Tax Return</title>
</head>
<body style="background-color: white">
	<div id="navbar">
	<a href="dash2.html"><img style="border-radius: 10px" src="imgs/logo.png" width="90" height="60"></a>		 
        <a class="a1" href="Income.html">Income</a> 
		 <a	class="a1" href="Expense.html">Expenses</a>
		 <a class="a1" href="contactus.html">Contact US</a>
		  <a class="a1" href="logout.jsp">Logout</a>
	</div>
	<%
	Class.forName("com.mysql.jdbc.Driver");
	String Email = (String) session.getAttribute("Email");
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project");
	PreparedStatement ps1 = connection.prepareStatement("select Sum(Amount) from income where email=?");
	PreparedStatement ps2 = connection.prepareStatement("select Sum(Amount) from expenses where email=?");
	ps1.setString(1, Email);
	ps2.setString(1, Email);
	ResultSet rs1 = ps1.executeQuery();
	ResultSet rs2 = ps2.executeQuery();

	if (rs1.next()) {
		int income = rs1.getInt(1);
		session.setAttribute("incom", income);
	}
	if (rs2.next()) {
		int expense = rs2.getInt(1);
		session.setAttribute("expens", expense);
	}

	int income = (int) session.getAttribute("incom");
	int expense = (int) session.getAttribute("expens");
	int tax = 0;
	if (income > expense) {
		int Amounttax = income - expense;
	%>
	<p class="dark-orange">
		Your taxable amount is &#8377
		<%=Amounttax%></p>
	<%
	if (Amounttax < 700000) {
	%>
	<p class="dark-orange">Your Income is below taxation limit so no tax Required</p>
	<%
	tax = 0;
	} else if (Amounttax > 700000 && Amounttax < 1000000) {
	tax = ((500000 * 5) / 100) + (((Amounttax - 500000) * 10) / 100);
	} else if (Amounttax > 1000000) {
	tax = ((500000 * 5) / 100) + (((Amounttax - 500000) * 10) / 100) + (((Amounttax - 1000000) * 20) / 100);
	}

	} else {
	%>
	<p class="dark-orange">No tax require</p>
	<%
	tax = 0;
	}
	%>
	<p class="dark-orange">
		You have to pay &#8377 <b> <%
 out.print(tax);
 %>
		</b> taxes to Government
	</p>
	<a class="a1" href="taxformula1.html">Tax Generated Formula</a>
</body>
</html>