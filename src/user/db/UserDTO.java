package user.db;

import java.sql.Timestamp;

public class UserDTO {
	private String userName;
	private String ID;
	private String Password;
	private String userEmail;
	private String userGender;
	private int userAdmin;
	private Timestamp userJoinDate;

	
	public Timestamp getUserJoinDate() {
		return userJoinDate;
	}
	public void setUserJoinDate(Timestamp userJoinDate) {
		this.userJoinDate = userJoinDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public int getUserAdmin() {
		return userAdmin;
	}
	public void setUserAdmin(int userAdmin) {
		this.userAdmin = userAdmin;
	}
}
