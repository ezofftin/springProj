package com.mbc.service;

import java.util.List;
import java.util.UUID;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.ReplyDTO;
import com.mbc.domain.ReplyPageDTO;
import com.mbc.mapper.BoardMapper;
import com.mbc.mapper.MemberMapper;
import com.mbc.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	// 댓글 추가
	@Transactional
	@Override
	public int register(ReplyDTO rDto) {
		boardMapper.updateReplyCnt(rDto.getBid(), 1);
		int n = mapper.insert(rDto);		
		return n;
	}

	// 댓글 삭제
	@Transactional
	@Override
	public int remove(int rno) {
		ReplyDTO rDto= mapper.select(rno);
		boardMapper.updateReplyCnt(rDto.getBid(), -1);
		int n = mapper.delete(rno);
		return n;
	}

	@Override
	public int modify(ReplyDTO rDto) {		 
		return mapper.update(rDto);
	}

	@Override
	public ReplyDTO read(int rno) {
		// TODO Auto-generated method stub
		return mapper.select(rno);
	}

	@Override
//	public List<ReplyDTO> getList(int bid, int vp) {
	public ReplyPageDTO getList(int bid, int vp) {
		
		// bid 해당하는 전체 댓글 수를 구하기
		int replyCnt = mapper.replyCnt(bid);
		
		 
		ReplyPageDTO rPageDTO= new ReplyPageDTO();
		// viewPage 바뀔때 마다 새롭게 셋팅 
		rPageDTO.setViewPage(vp);
		
		rPageDTO.setValue(replyCnt);
		
		List<ReplyDTO> rList= mapper.getListByBid(bid
				,rPageDTO.getStartIndex()
				, rPageDTO.getCntPerPage());
		
//		return rList;
		
		// 조회된 댓글 리스트를 DTO에 셋팅을 해줌
		rPageDTO.setReplyList(rList);
		
		return rPageDTO;
	}


}





