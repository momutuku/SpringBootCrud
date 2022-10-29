package sai.controllers;
import lombok.Setter;
import lombok.Getter;
@Setter
@Getter
public class AddUser {
	private  String username;
	private String email;
	private String password;
	private String created;

	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}



}
