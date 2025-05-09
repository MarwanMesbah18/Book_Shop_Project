package Clasess;


import java.util.*;

public class Admin {
	String AdminName;
	String Password;
	List<Books> book;
	List<User> users;
	public String getAdminName() {
		return AdminName;
	}
	public void setAdminName(String adminName) {
		AdminName = adminName;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public List<Books> getBook() {
		return book;
	}
	public void setBook(List<Books> book) {
		this.book = book;
	}
	public List<User> getUsers() {
		return users;
	}
	public void setUsers(List<User> users) {
		this.users = users;
	}
 
}
