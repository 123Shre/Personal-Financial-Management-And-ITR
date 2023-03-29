<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>

<HTML>
<HEAD>
<TITLE>The View Of Database Table</TITLE>
<style>
body {
	
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

#navbar .a1 {
	color: #ffffff;
	text-decoration: none;
	padding: 0 20px;
	font-size: 18px;
	font-weight: 500;
	transition: 0.2s ease;
}

#navbar .a1:hover {
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

h1 {
	font-size: 24px;
	margin-bottom: 20px;
	color: #333;
}

table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 30px;
	border: 2px solid #ccc;
}

th, td {
	text-align: left;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

th {
	background-color: #4CAF50;
	color: white;
}

p {
	text-align: center;
	font-size: 30px;
}

#s {
	background-color: red;
}

#h {
	background-color: #4CAF50;
}

#m {
	background-color: yellow;
}

.sort {
	background-color: white;
	font-size: 25px;
	width: 20%;
	color: black;
	border: 2px solid #4CAF50;
	color: black;
}

.sort:hover {
	background-color: #4CAF50;
	color: white;
}
</style>
</HEAD>

<body>
	<div id="navbar">
		<a href="dash2.html"><img style="border-radius: 10px" src="imgs/logo.png" width="90"
			height="60"></a> <a class="a1" href="dash2.html">Home</a> <a
			class="a1" href="Income.html">Income</a> <a class="a1"
			href="Expense.html">Expenses</a> <a class="a1" href="itr.jsp">ITR</a>

	</div>
	<H1>Your Income</H1>
	<%
	Class.forName("com.mysql.jdbc.Driver");
	String Email = (String) session.getAttribute("Email");
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");
	PreparedStatement stmt1 = connection.prepareStatement("select Date,Category,Amount,Notes,No from income where email=?");
	PreparedStatement pss = connection.prepareStatement("select Sum(Amount) from income where email=?");
	stmt1.setString(1, Email);
	pss.setString(1, Email);
	ResultSet resultset = stmt1.executeQuery();
	ResultSet rss = pss.executeQuery();
	%>
	<TABLE id="result1">
		<thead>
			<TR>
				<th>Date</th>
				<th>Category</th>
				<th>Amount</th>
				<th>Notes</th>
			</TR>
		</thead>
		<tbody>
			<%
			while (resultset.next()) {
			%>
			<TR>
				<TD><%=resultset.getString(1)%></td>
				<TD><%=resultset.getString(2)%></TD>
				<TD><%=resultset.getString(3)%></TD>
				<TD><%=resultset.getString(4)%></TD>
				<TD><a href="delete1.jsp?id=<%=resultset.getString(5)%>">
						<button style="background-color: red; color:white;" type="button" class="delete">Delete</button>
				</a></TD>
			</TR>
			<%
			}
			while (rss.next()) {
			int sum1 = rss.getInt(1);
			%><tr>
				<th>Total</th>
				<td colspan="2">
					<%
					out.println("&#8377; " + sum1);
					session.setAttribute("income", sum1);
					%>
				</td>
				<%
				}
				%>
			
		</tbody>
	</TABLE>
	<button id="sort1" class="sort">Sort</button>
	<br>

	<SCRIPT>
		function convertDate(d) {
			var p = d.split("-");
			return +(p[0] + p[1] + p[2]);
		}

		function sortByDate() {
			console.log("Sort");
			var tbody = document.querySelector("#result1 tbody");
			// get trs as array for ease of use
			var rows = [].slice.call(tbody.querySelectorAll("tr"));

			rows.sort(function(a, b) {
				return convertDate(a.cells[0].innerHTML)
						- convertDate(b.cells[0].innerHTML);
			});

			rows.forEach(function(v) {
				tbody.appendChild(v);
			});
		}
		document.getElementById('sort1').addEventListener("click", sortByDate);
	</SCRIPT>

	<h1>Your Expenses</h1>

	<%
	PreparedStatement stmt2 = connection
			.prepareStatement("select Date,Category,Amount,Notes,ExNo from expenses where email=?");
	PreparedStatement ps1 = connection.prepareStatement("select Sum(Amount) from expenses where email=?");
	stmt2.setString(1, Email);
	ps1.setString(1, Email);
	ResultSet rs1 = stmt2.executeQuery();
	ResultSet rs2 = ps1.executeQuery();
	%>
	<TABLE id="results">
		<thead>
			<TR>
				<th>Date</th>
				<th>Category</th>
				<th>Amount</th>
				<th>Notes</th>
			</TR>
		</thead>
		<tbody>
			<%
			while (rs1.next()) {
			%>
			<TR>
				<TD><%=rs1.getString(1)%></td>
				<TD><%=rs1.getString(2)%></TD>
				<TD><%=rs1.getString(3)%></TD>
				<TD><%=rs1.getString(4)%></TD>
				<TD><a href="delete2.jsp?id=<%=rs1.getString(5)%>"><button style="background-color: red; color:white;"
							type="button" class="delete">Delete</button></a></TD>
			</TR>
			<%
			}
			while (rs2.next()) {
			int sum2 = rs2.getInt(1);
			%><tr>
				<th>Total</th>
				<td colspan="2">
					<%
					out.println("&#8377; " + sum2);
					session.setAttribute("expense", sum2);
					%>
				</td>
				<%
				}
				%>
			
		</tbody>
	</TABLE>
	<button id="sort" class="sort">Sort</button>
	<br>
	<%
	int income = (int) session.getAttribute("income");
	int expense = (int) session.getAttribute("expense");

	if (income > expense) {
	%>
	<p id="h">You are in Good Condition</p>
	<p>
		Your Savings are
		<%
	out.print("&#8377; " + (income - expense));
	%>
	</p>
	<%
	} else if (income == expense) {
		if(income>0){
	%>
	<p id="m">You are in Safe Financial Condition</p>
	<%
		}else{
			%>
			<p id="m">You Have 0 Transaction</p>
			<%
		}} else {
	%>
	<p id="s">You are in bad condition</p>
	<p>
		Your debt is
		<%
	out.print("&#8377; " + (expense - income));
	%>
	</p>
	<%
	} ;
	%>
	<SCRIPT>
		function convertDate(d) {
			var p = d.split("-");
			return +(p[0] + p[1] + p[2]);
		}

		function sortByDate() {
			console.log("Sort");
			var tbody = document.querySelector("#results tbody");
			// get trs as array for ease of use
			var rows = [].slice.call(tbody.querySelectorAll("tr"));

			rows.sort(function(a, b) {
				return convertDate(a.cells[0].innerHTML)
						- convertDate(b.cells[0].innerHTML);
			});

			rows.forEach(function(v) {
				tbody.appendChild(v);
			});
		}

		document.getElementById('sort').addEventListener("click", sortByDate);
	</SCRIPT>
</BODY>
</HTML>
