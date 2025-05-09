package Clasess;

import java.sql.*;

public class DB {

	public void add_user_table() {
		try {
			Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
			
			Connection con=DriverManager.getConnection("jdbc:derby:db/project;create=true");
			
			Statement st=con.createStatement();
			
			st.executeUpdate("Create table User (UserName varchar(30), email varchar(50) primary key, password varchar(30), phoneNumber varchar(30), address varchre(30) )");
			
			con.close();
		
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public int add_user(User u) {
		int flag=0;
		
		try {
			Connection con=DriverManager.getConnection("jdbc:derby:db/project");
			
			PreparedStatement pst=con.prepareStatement("insert into User values(?,?,?,?,?)");
			pst.setString(1, u.getName());
			pst.setString(2, u.getEmail());
			pst.setString(3, u.getPassword());
			pst.setString(4, u.getPhoneNumber());
			pst.setString(5, u.getAddress());
			
			flag= pst.executeUpdate();
			con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
		
		
	}
	
}
