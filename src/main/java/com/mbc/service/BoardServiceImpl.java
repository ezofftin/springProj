package com.mbc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.BoardDTO;
import com.mbc.domain.PageDTO;
import com.mbc.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void register(BoardDTO dto) {
		mapper.insert(dto);
		
	}

	@Override
//	public List<BoardDTO> getList() {
	@Transactional
	public List<BoardDTO> getList(PageDTO pDto) {
		
//		int totalCnt = mapper.totalCnt();
		
		// 검색이 되는 경우
		// xml에 searchType, keyword를 전달해야
		// WHERE절 처리가 됨, 즉, pDTO를 전달해야 함
		int totalCnt = mapper.totalCnt(pDto);
		
		// setValue호출시 startIndex 셋팅됨 		
		pDto.setValue(totalCnt, pDto.getCntPerPage());
		
//		List<BoardDTO> list = mapper.getList();
//		return list;
		
		return mapper.getList(pDto);
	}

	@Override
	public BoardDTO view(int bid, String mode) {
		
		if(mode.equals("v")) {
			// 조회수 추가
			mapper.hitAdd(bid);
		}
		
		return mapper.view(bid);
	}

	@Override
	public void modify(BoardDTO dto) {		
		mapper.update(dto);
	}

	@Override
	public void remove(int bid) {
		mapper.delete(bid);
		
	}
	
}
