package sai.controllers;
import lombok.Setter;
import lombok.Getter;
@Setter
@Getter
public class ImageUrl {
	private  String url;

	
	public ImageUrl(String string) {
		// TODO Auto-generated constructor stub
		this.url = string;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	



}

