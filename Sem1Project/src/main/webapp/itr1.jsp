<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
p {
	background-color: #4CAF50;
	font-size: 30px;
}
</style>
<meta charset="UTF-8">
<title>Income Tax Return</title>
</head>
<body>
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
	<p>
		Your taxable amount is &#8377
		<%=Amounttax%></p>
	<%
	if (Amounttax < 700000) {
	%>
	<p>Your Income is below taxation limit so no tax Required</p>
	<%
	tax = 0;
	} else if (Amounttax > 700000 && Amounttax < 1000000) {
	tax = ((500000 * 5) / 100) + (((Amounttax - 500000) * 10) / 100);
	} else if (Amounttax > 1000000) {
	tax = ((500000 * 5) / 100) + (((Amounttax - 500000) * 10) / 100) + (((Amounttax - 1000000) * 20) / 100);
	}

	} else {
	%>
	<p>No tax require</p>
	<%
	tax = 0;
	}
	%>
	<p>
		You have to pay &#8377 <b>
			<%
			out.print(tax);
			%>
		</b> taxes to Government
	</p>
	<a href="taxformula.html">Tax Generated Formula</a>
</body>
</html>