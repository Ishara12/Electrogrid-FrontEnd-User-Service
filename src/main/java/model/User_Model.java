package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import db_connection.DB;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

public class User_Model {

	private String res;
	
	public String getRes() {
		return res;
	}

	public void setRes(String res) {
		this.res = res;
	}

	public String getUser() {
		PreparedStatement ps;
		String data="";
		
		try {
			
			Connection conn = DB.getConn();
			ps = conn.prepareStatement("SELECT * FROM users");
			
			ResultSet res_Set = ps.executeQuery();
			
			data = "<table style='border: 1px solid black;'>"
		            +"<tr>"
		            +"<th style='border-style: dotted;'>ID</th>"
	                +"<th style='border-style: dotted;'>First Name</th>"
	                +"<th style='border-style: dotted;'>Last Name</th>"
	                +"<th style='border-style: dotted;'>Mobile</th>"
	                +"<th style='border-style: dotted;'>Email</th>"
	                +"<th style='border-style: dotted;'>NIC</th>"
	                +"<th style='border-style: dotted;'>Address</th>"
	                +"<th style='border-style: dotted;'>Account Number</th>"
	                +"<th style='border-style: dotted;'>Edit/Delete</th>"
	                +"</tr>";
			
			while (res_Set.next()) {
				
				
				String button = "<button onclick='edit("+res_Set.getString(1)+")' >Edit</button><button onclick='deletes("+res_Set.getString(1)+")'>Delete</button>";
				data = data+"<tr><td style='border-style: dotted;'>"+res_Set.getString(1)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(2)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(3)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(4)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(5)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(6)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(7)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(9)+"</td>"
						+ "<td style='border-style: dotted;'>"+button+"</td>"
					  + "</tr>";
				
			}
			
			ps.close();
			conn.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return data+"</table>";
	}
	
	public void addUser(String fname,String lname,String mobile,String email,String nic,String address,String password,String account_number) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("insert into users (fname,lname,mobile,email,nic,address,password,account_number) values (?,?,?,?,?,?,?,?)");
			ps.setString(1, fname);
			ps.setString(2, lname);
			ps.setString(3, mobile);
			ps.setString(4, email);
			ps.setString(5, nic);
			ps.setString(6, address);
			ps.setString(7, password);
			ps.setString(8, account_number);
			ps.execute();
			ps.close();
			conn.close();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void editUser(int id,String fname,String lname,String mobile,String email,String nic,String address,String password,String account_number) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
				ps = conn.prepareStatement("UPDATE users SET fname=?,lname=?,mobile=?,email=?,nic=?,address=?,password=?,account_number=? where id=?");
				ps.setString(1, fname);
				ps.setString(2, lname);
				ps.setString(3, mobile);
				ps.setString(4, email);
				ps.setString(5, nic);
				ps.setString(6, address);
				ps.setString(7, password);
				ps.setString(8, account_number);
				ps.setInt(9,id);
				ps.execute();
				ps.close();
				conn.close();
				setRes("Done");
				
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void deleteUser(int id) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("DELETE FROM users WHERE id=?");
			ps.setInt(1, id);
			ps.execute();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}
	
	public JSONObject getOneUsers(int id) {
		Connection connection;
		PreparedStatement preparedStatement;
		JSONObject json = new JSONObject();
		
		try {
			connection = DB.getConn();
			
			preparedStatement = connection.prepareStatement("SELECT * FROM users where id=?");
			preparedStatement.setInt(1, id);
			ResultSet rs = preparedStatement.executeQuery();

			while(rs.next())
			{
				json.put("id", rs.getInt(1));
				json.put("fname", rs.getString(2));
				json.put("lname", rs.getString(3));
				json.put("mobile", rs.getString(4));
				json.put("email", rs.getString(5));
				
				json.put("nic", rs.getString(6));
				json.put("address", rs.getString(7));
				json.put("account_number", rs.getString(9));
			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
		return json;
	}

}
