package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.ReplyDTO;


// DAO 대신 mapper 인터페이스 사용
//@Mapper //생략가능
public interface ReplyMapper {
//	List<ReplyDTO> getListByBid(int bid, int si, int cp);
	List<ReplyDTO> getListByBid(@Param("bid")int bid,  @Param("startIndex") int si, 
@Param("cntPerPage") int cp);
	
	ReplyDTO select(int rno);
	
	int update(ReplyDTO rDto);
	
	int insert(ReplyDTO rDto);
	
	int delete(int rno); 
	
	int replyCnt(int bid); 
}
