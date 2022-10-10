package juanlucas.models;

import java.util.ArrayList;

import juanlucas.dao.ProviderDAO;

public class Provider {
	private int id;
	private String name;
	private String address;
	private String phone;
	
	private static ProviderDAO DAO;
	
	public Provider(int id, String name) {
		this.id=id;
		this.name=name;
	}
	
	public static ArrayList<Provider> list(){
		DAO =  new ProviderDAO();	
		return DAO.get();
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
}
