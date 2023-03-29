<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String uname = request.getParameter("email");
	String pass = request.getParameter("password");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");
		PreparedStatement ps = con.prepareStatement("select Name from users where Email=? and pass=?");
		ps.setString(1, uname);
		ps.setString(2, pass);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			RequestDispatcher rd = request.getRequestDispatcher("dash2.html");
			session.setAttribute("Email", uname);
			rd.forward(request, response);
		} else {
			response.sendRedirect("logAle.html");
		}
	} catch (Exception e) {
		out.println(e);
	}
	%>
</body>
</html>