package com.mbc.domain;

import java.util.Date;

public class ReplyDTO {
	private int rno;
	private int bid;
	
	private String r_contents;
	private String replyer;
	private Date r_date;
	private Date update_date;
	
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getR_contents() {
		return r_contents;
	}
	public void setR_contents(String r_contents) {
		this.r_contents = r_contents;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public Date getR_date() {
		return r_date;
	}
	public void setR_date(Date r_date) {
		this.r_date = r_date;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	
	@Override
	public String toString() {
		return "ReplyDTO [rno=" + rno + ", bid=" + bid + ", r_contents=" + r_contents + ", replyer=" + replyer
				+ ", r_date=" + r_date + ", update_date=" + update_date + "]";
	}
	
	
	
}
