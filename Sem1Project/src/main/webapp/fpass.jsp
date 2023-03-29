<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forget password</title>
</head>
<body>
	<%
	String email = request.getParameter("email");
	String bday = request.getParameter("bday");
	String pass = request.getParameter("pass");
	String passrepeat = request.getParameter("cpass");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");
		if (conn != null) {
			 out.println("Conn not null");
		}
		
			PreparedStatement ps = conn.prepareStatement("select * from users where Email=? and Birth_Date=?");
			ps.setString(1, email);
			ps.setString(2, bday);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
		String Email1 = rs.getString("Email");
		String bday1 = rs.getString("Birth_Date");
		if (pass.equals(passrepeat) || bday.equals(bday1)) {
			PreparedStatement ps1 = conn.prepareStatement("Update users set pass=? where Email=?");
			ps1.setString(1, pass);
			ps1.setString(2, email);
			int i = ps1.executeUpdate();
			out.println("Updated successfully");
		} else {
			out.println("pass not match");
		}
			}
		

		

	} catch (Exception e) {
		System.out.print(e);
		e.printStackTrace();
	}
	%>

</body>
</html>