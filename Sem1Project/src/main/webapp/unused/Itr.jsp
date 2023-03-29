<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8" >
<title>ITR JSP</title>
</head>
<body>
	@MultipartConfig
	@WebServlet("/Itr.jsp")
	<%

	String Gender = request.getParameter("gender");
	String PAN = request.getParameter("PAN");
	String DOB = request.getParameter("DOB");
	String Address = request.getParameter("addr");
	String Aadhaar = request.getParameter("Aadhaar");
	String Status = request.getParameter("status");
	String Email = request.getParameter("email");
	String Income = request.getParameter("Income");
	

	Part file9 = request.getPart("Photo");
	Part file10 = request.getPart("Sign");
	Part file11 = request.getPart("Form16");
	Part file12 = request.getPart("InterestCert");
	Part file13 = request.getPart("TaxSvInPr");
	Part file14 = request.getPart("LifeInsPP");
	Part file15 = request.getPart("SalSlp");
	Part file16 = request.getPart("HomeLoSB");

	String imageFileName9 = file9.getSubmittedFileName();
	String imageFileName10 = file10.getSubmittedFileName();
	String imageFileName11 = file11.getSubmittedFileName();
	String imageFileName12 = file12.getSubmittedFileName();
	String imageFileName13 = file13.getSubmittedFileName();
	String imageFileName14 = file14.getSubmittedFileName();
	String imageFileName15 = file15.getSubmittedFileName();
	String imageFileName16 = file16.getSubmittedFileName();
	String uploadPath9 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName9;
	String uploadPath10 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName10;
	String uploadPath11 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName11;
	String uploadPath12 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName12;
	String uploadPath13 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName13;
	String uploadPath14 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName14;
	String uploadPath15 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName15;
	String uploadPath16 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName16;
	try {

		FileOutputStream fos9 = new FileOutputStream(uploadPath9);
		FileOutputStream fos10 = new FileOutputStream(uploadPath10);
		FileOutputStream fos11 = new FileOutputStream(uploadPath11);
		FileOutputStream fos12 = new FileOutputStream(uploadPath12);
		FileOutputStream fos13 = new FileOutputStream(uploadPath13);
		FileOutputStream fos14 = new FileOutputStream(uploadPath14);
		FileOutputStream fos15 = new FileOutputStream(uploadPath15);
		FileOutputStream fos16 = new FileOutputStream(uploadPath16);

		InputStream is9 = file9.getInputStream();
		InputStream is10 = file10.getInputStream();
		InputStream is11 = file11.getInputStream();
		InputStream is12 = file12.getInputStream();
		InputStream is13 = file13.getInputStream();
		InputStream is14 = file14.getInputStream();
		InputStream is15 = file15.getInputStream();
		InputStream is16 = file16.getInputStream();

		byte[] data9 = new byte[is9.available()];
		byte[] data10 = new byte[is10.available()];
		byte[] data11 = new byte[is11.available()];
		byte[] data12 = new byte[is12.available()];
		byte[] data13 = new byte[is13.available()];
		byte[] data14 = new byte[is14.available()];
		byte[] data15 = new byte[is15.available()];
		byte[] data16 = new byte[is16.available()];

		is9.read(data9);
		is10.read(data10);
		is11.read(data11);
		is12.read(data12);
		is13.read(data13);
		is14.read(data14);
		is15.read(data15);
		is16.read(data16);
		fos9.write(data9);
		fos10.write(data10);
		fos11.write(data11);
		fos12.write(data12);
		fos13.write(data13);
		fos14.write(data14);
		fos15.write(data15);
		fos16.write(data16);
		fos9.close();
		fos10.close();
		fos11.close();
		fos12.close();
		fos13.close();
		fos14.close();
		fos15.close();
		fos16.close();

	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");
	
		PreparedStatement pstmt = conn.prepareStatement(
		"insert into itrform(Gender,Pan_Number,Birth_Date,Address,Aadhaar_no,Status,Email,Income_sal,Pass_Photo,Signature,Form_16,Interest_Cert,Tax_saving,Life_Insurance,Salary_slip,Home_Loan) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		pstmt.setString(1, Gender);
		pstmt.setString(2, PAN);
		pstmt.setString(3, DOB);
		pstmt.setString(4, Address);
		pstmt.setString(5, Aadhaar);
		pstmt.setString(6, Status);
		pstmt.setString(7, Email);
		pstmt.setString(8, Income);
		pstmt.setString(9, imageFileName9);
		pstmt.setString(10, imageFileName10);
		pstmt.setString(11, imageFileName11);
		pstmt.setString(12, imageFileName12);
		pstmt.setString(13, imageFileName13);
		pstmt.setString(14, imageFileName14);
		pstmt.setString(15, imageFileName15);
		pstmt.setString(16, imageFileName16);


		out.print(pstmt);
		int i = pstmt.executeUpdate();
		if (i > 0) {
			out.print("Record inserted Successfully");
		} else {
			out.print("Records not inserted");
		}
		if (conn != null) {
			out.print("Connection establish");
		}

		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>