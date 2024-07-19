package com.mbc.domain;

public class MemberDTO {
	private int no;
	private String id;
	private String pw;
	private String name;
	private int age;
	private String email;
	private String tel;
	
	private String npw;	
	
	// 기본 생성자
	public MemberDTO() {}
	
	// 인자 생성자
	public MemberDTO(int no, String id, String pw, String name, int age, String email, String tel) {
		super();
		this.no = no;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.email = email;
		this.tel = tel;
	}
	
	public String getNpw() {
		return npw;
	}

	public void setNpw(String npw) {
		this.npw = npw;
	}

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}

	@Override
	public String toString() {
		return "MemberDTO [no=" + no + ", id=" + id + ", pw=" + pw + ", name=" + name + ", age=" + age + ", email="
				+ email + ", tel=" + tel + ", npw=" + npw + "]";
	}	
	
}

