package com.mbc.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private int bid;
	private String subject;
	private String contents;
	private int hit;
	private String writer;
	private Date reg_date;
	private int replyCnt;
	
//	//getter/setter
//	public int getReplyCnt() {
//		return replyCnt;
//	}
//	public void setReplyCnt(int replyCnt) {
//		this.replyCnt = replyCnt;
//	}
//	
//	public int getBid() {
//		return bid;
//	}
//	public void setBid(int bid) {
//		this.bid = bid;
//	}
//	public String getSubject() {
//		return subject;
//	}
//	public void setSubject(String subject) {
//		this.subject = subject;
//	}
//	public String getContents() {
//		return contents;
//	}
//	public void setContents(String contents) {
//		this.contents = contents;
//	}
//	public int getHit() {
//		return hit;
//	}
//	public void setHit(int hit) {
//		this.hit = hit;
//	}
//	public String getWriter() {
//		return writer;
//	}
//	public void setWriter(String writer) {
//		this.writer = writer;
//	}
//	public Date getReg_date() {
//		return reg_date;
//	}
//	public void setReg_date(Date reg_date) {
//		this.reg_date = reg_date;
//	}
//	@Override
//	public String toString() {
//		return "BoardDTO [bid=" + bid + ", subject=" + subject + ", contents=" + contents + ", hit=" + hit + ", writer="
//				+ writer + ", reg_date=" + reg_date + "]";
//	}
	
	
}
