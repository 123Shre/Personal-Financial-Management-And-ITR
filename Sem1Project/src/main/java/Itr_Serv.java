import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet("/Itr_Serv")
public class Itr_Serv extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Itr_Serv() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("In do post method of Add Image servlet.");
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
		String imageFileName16 = file16.getSubmittedFileName(); // get selected image file name
		System.out.println("Selected Image File Name : " + imageFileName9);
		System.out.println("Selected Image File Name : " + imageFileName10);
		System.out.println("Selected Image File Name : " + imageFileName11);
		System.out.println("Selected Image File Name : " + imageFileName12);
		System.out.println("Selected Image File Name : " + imageFileName13);
		System.out.println("Selected Image File Name : " + imageFileName14);
		System.out.println("Selected Image File Name : " + imageFileName15);
		System.out.println("Selected Image File Name : " + imageFileName16);

		String uploadPath9 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName9;
		String uploadPath10 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName10;
		String uploadPath11 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName11;
		String uploadPath12 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName12;
		String uploadPath13 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName13;
		String uploadPath14 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName14;
		String uploadPath15 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName15;
		String uploadPath16 = "C:/Users/shrey/eclipse-workspace/ImageUploader/img/" + imageFileName16;
//		System.out.println("Upload Path : "+uploadPath);

		// Uploading our selected image into the images folder

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

		}

		catch (Exception e) {
			e.printStackTrace();
		}
		// **********************

		// getting database connection (jdbc code)
		Connection conn = null;
		try {
			System.out.print("In datbase connection");
//			Class.forName("com.mysql.jdbc.Driver");
//			connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/imageup","root","");
//			PreparedStatement stmt;
//			String query="insert into image(imageFileName) values(?)";
//			stmt=connection.prepareStatement(query);

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sem1project", "root", "");

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

			int row = pstmt.executeUpdate();
			if (row > 0) {
				System.out.println("Image added into database successfully.");
			}

			else {
				System.out.println("Failed to upload image.");
			}

		} catch (Exception e) {
			System.out.println(e);
		}

	}

}