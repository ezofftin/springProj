package com.mbc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mbc.domain.BoardDTO;
import com.mbc.domain.PageDTO;
import com.mbc.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;
	
	@GetMapping("/register.do")
	public String register() {
		return "board/register";
	}
	
	@PostMapping("/register.do")
	public String register(BoardDTO dto) {
		
//		for(int i=1; i<=123; i++) {
//			BoardDTO bDto = new BoardDTO();
//			bDto.setSubject(i + "번째 제목입니다~~~");
//			bDto.setContents(i + "번째 내용입니다~~~");
//			bDto.setWriter("아무개 " + (i%10));
//			service.register(bDto);
//		}
		
		service.register(dto);
		return "redirect:/board/list.do";
	}
	
//	@GetMapping("/list.do")
//	public String list(Model model) {
//		List<BoardDTO> list = service.getList();
//		model.addAttribute("list", list);
//		
//		return "board/boardList";
//	}
	
	// 게시글 리스트 페이징 처리 
//	@GetMapping("/list.do")
////	public String list(@RequestParam(name="viewPage", defaultValue="1") int viewPage, Model model) {
//	public String list(PageDTO pDto, Model model) {		
//		List<BoardDTO> list = service.getList(pDto);
//		model.addAttribute("list", list);
//		
//		// serviceImpl에서 셋팅된 pDto
//		model.addAttribute("pDto", pDto);
//		
//		return "board/boardList";
//	}
	
	@RequestMapping("/list.do")
	public String list(PageDTO pDto, Model model) {		
		List<BoardDTO> list = service.getList(pDto);
		model.addAttribute("list", list);
		
		// serviceImpl에서 셋팅된 pDto
		model.addAttribute("pDto", pDto);
		
		return "board/boardList";
	}
	

	
	// 글상세보기
	@GetMapping("/view.do")
	public String view(int bid, PageDTO pDto, Model model) {
		BoardDTO dto = service.view(bid, "v");
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);
		
		return "board/view";
	}
	
	// 수정페이지 이동
	@GetMapping("/modify.do")
	public String modifyForm(PageDTO pDto, int bid, Model model) {
		System.out.println("vp : " + pDto.getViewPage());
		BoardDTO dto = service.view(bid, "m");
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);
		System.out.println("vp2 : " + pDto.getViewPage());
		
		return "board/modify";
	}
	
	@PostMapping("/modify.do")
	public String modify(PageDTO pDto, BoardDTO dto, Model model) {
		service.modify(dto);
		
		int viewPage = pDto.getViewPage();
		System.out.println("vp ======> " +viewPage);
		model.addAttribute("viewPage", viewPage);
		model.addAttribute("searchType", pDto.getSearchType());
		model.addAttribute("keyword", pDto.getKeyword());
		model.addAttribute("cntPerPage", pDto.getCntPerPage());
		
		return "redirect:list.do";
	}
	
	// 게시글 삭제
	@GetMapping("/remove.do")
	public String remove(PageDTO pDto, int bid, Model model) {
		service.remove(bid);		
		model.addAttribute("viewPage", pDto.getViewPage());
		 
		// redirect 시 model에 바인딩된 값은 queryString으로 전달된다.
		// PageDTO 객체는 queryString으로 전달될 수 없음(int, String은 가능)
		return "redirect:list.do";
	}
}
