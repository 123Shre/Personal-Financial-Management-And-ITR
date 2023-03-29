<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration form</title>
</head>
<body>

	<%
	String name = request.getParameter("Name");
	String email = request.getParameter("email");
	String pass = request.getParameter("pass");
	String cpass = request.getParameter("cpass");
	String DOB = request.getParameter("DOB");
	try {

		if (pass.equals(cpass)) {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");
			PreparedStatement pstmt = conn.prepareStatement("insert into users(Name,Email,pass,Birth_Date) values (?,?,?,?)");
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, pass);
		//	pstmt.setString(4, cpass);
			pstmt.setString(4, DOB);
			int i = pstmt.executeUpdate();
			conn.close();
			if(i>0){
				RequestDispatcher rd = request.getRequestDispatcher("dash1.html");
				session.setAttribute("Name", name);
				rd.forward(request, response);
			}

		} else {
			out.print("Password Mismatch");
		}
	} catch (Exception e) {
		System.out.println(e);
		e.printStackTrace();
	}
	%>

</body>
</html>