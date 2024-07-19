package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.MemberDTO;


// DAO 대신 mapper 인터페이스 사용
//@Mapper //생략가능
public interface MemberMapper {
	public List<MemberDTO> memberList();
	
	public int memberInsert(MemberDTO dto);
	
	public MemberDTO memberInfo(int no);
	
	public int deleteMember(int no);
	
	public int memberUpdate(MemberDTO dto);
	
	public MemberDTO idCheck(String uid);

	public MemberDTO memberLogin(MemberDTO dto);

	public String findId(MemberDTO dto);

	public int findPw(String uid, String uEmail, String tempPw);

	public int updatePw(MemberDTO dto);
}
