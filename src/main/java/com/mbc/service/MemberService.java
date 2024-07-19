package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.mbc.domain.MemberDTO;

public interface MemberService {
	public List<MemberDTO> memberList();
	
	public int memberRegister(MemberDTO dto);
	
	public MemberDTO memberInfo(int no);
	
	public int memberRemove(int no);
	
	public int memberModify(MemberDTO dto);
	
	public MemberDTO idCheck(String uid);

	public boolean memberLogin(MemberDTO dto, HttpServletRequest req);

	public String findId(MemberDTO dto);

	public int findPw(String uid, String uEmail);

	public int modifyPw(MemberDTO dto);
}
