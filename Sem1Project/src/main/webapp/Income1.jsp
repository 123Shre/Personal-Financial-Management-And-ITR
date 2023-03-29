<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Income</title>
</head>
<body>
	<%
	String Email = (String) session.getAttribute("Email");
	String cat = request.getParameter("category");
	String note = request.getParameter("notes");
	String date = request.getParameter("date");
	String amt = request.getParameter("amount");
	String oc = request.getParameter("other-category");
	try {
	
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");
		if (cat.equals("other")) {
			Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");
			PreparedStatement ps1 = con1
			.prepareStatement("insert into income(Date,Category,Amount,Notes,Email) values (?,?,?,?,?)");
			
			ps1.setString(1, date);
			ps1.setString(2, oc);
			ps1.setString(3, amt);
			ps1.setString(4, note);
			ps1.setString(5, Email);
			int j = ps1.executeUpdate();
			con.close();
			if (j > 0) {
				out.print("inserted");
		response.sendRedirect("IncAler.html");
			}
			else{
				out.print("Not inserted");
			}
		} else {
			try{
			PreparedStatement ps = con
			.prepareStatement("insert into income(Date,Category,Amount,Notes,Email) values (?,?,?,?,?)");
			ps.setString(1, date);
			ps.setString(2, cat);
			ps.setString(3, amt);
			ps.setString(4, note);
			ps.setString(5, Email);
			int i = ps.executeUpdate();
			out.println(i);
			con.close();
			if (i > 0) {
		response.sendRedirect("IncAler.html");
			}}
			catch(Exception e){e.printStackTrace();}
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>
