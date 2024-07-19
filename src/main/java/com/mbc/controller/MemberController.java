package com.mbc.controller;

import java.util.List;
import java.util.UUID;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.mapper.MemberMapper;
import com.mbc.service.MemberService;
import com.mbc.domain.MemberDTO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@PostMapping("pwChange.do")
	@ResponseBody
	public int pwChange(@RequestBody MemberDTO dto) {
//		System.out.println(dto);
		int n = service.modifyPw(dto);
		
		return n;
	}
	
	
	@PostMapping("pwCheck.do")
	@ResponseBody
	public String pwCheck(String pw, HttpSession session) {
		// 로그인 시 세션에 저장된 loginDTO를 활용하면 DB에 접근하지 않아도
		// DB의 비밀번호를 알 수 있다.
		MemberDTO dto = (MemberDTO)session.getAttribute("loginDTO");
		
		String dbPw = dto.getPw();
		
		String chkResult = "";
		if(dbPw.equals(pw)) {
			chkResult = "ok";
		}else {
			chkResult = "no";
		}
		
		return chkResult;
	}
	
	@GetMapping("/myProfile.do")
	public String myProfile() {
		return "member/myProfile";
	}
	
	// 비밀번호 찾기
	@PostMapping("/findPw.do")
	@ResponseBody
	public int findPw(String uid, String uEmail) {
		System.out.println("uid = " + uid);
		System.out.println("uEmail = " + uEmail);
		int n = service.findPw(uid, uEmail);
		
		return n;
	}
	
	@RequestMapping("/memberEmailCheck.do")
	@ResponseBody
	public String emailCheck(@RequestParam("uEmail") String uEmail) {
		
//		String uuid = UUID.randomUUID().toString();
//		System.out.println(uuid);				
		
		// 인증코드 생성
		String uuid = UUID.randomUUID().toString().substring(0,6);
		
		// MimeMessage 객체 생성 : 데이터 전송
		MimeMessage mail = mailSender.createMimeMessage();
		
		// 메일 내용
		String mailContents = "<h3>이메일 주소 확인</h3><br/>"
				+ "<span>사용자가 본인임을 확인하려고 합니다. 아래의 코드를 입력하세요!!</span>"
				+ "<h2>"+uuid+"</h2>";
		
		// 이메일이 유효하면 try블럭은 에러없이 수행되고
		// uuid를 제대로 반환, 이메일이 유효하지 않으면 예외발생
		
		try {			
			// 메일 제목 
			mail.setSubject("jh아카데미 [이메일 인증]", "utf-8");
			// 메일 내용 셋팅
			mail.setText(mailContents, "utf-8", "html");
			
			// 수신자 셋팅, 인터넷 주소체계로 변환
			mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
			mailSender.send(mail);
			
			return uuid;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "fail";
	}
	
	
//	아이디 찾기
	@PostMapping("findId.do")
	@ResponseBody
	public String findId(MemberDTO dto) {
		System.out.println(dto);
		String findId = service.findId(dto);
				
		return findId;
	}
	
	@GetMapping("idPwFind.do")
	public String idPwFind(String find, Model model) {
		model.addAttribute("find", find);
		
		return "login/idPwFind";
	}
	
	@GetMapping("login.do")
	public String loginForm(String moveUrl, Model model) {
		model.addAttribute("moveUrl", moveUrl);
		return "login/loginForm";
	}
	
	@GetMapping("logout.do")
	public String memberLogout(HttpSession session) {
		session.invalidate(); // 세션 초기화
		
		return "redirect:/";
	}
	
	@PostMapping("login.do")
	public String memberLogin(String moveUrl, MemberDTO dto, HttpServletRequest req) {
		boolean result = service.memberLogin(dto, req);
		
		if(!result) { // 로그인 실패
			// redirect은 get방식
			return "redirect:login.do";
		}
		
		if(!moveUrl.equals("")) {
			return "redirect:"+moveUrl;
		}
		
		return "redirect:/";
	}
	
    //@Autowired
	//private ProductDAO pDao;

	// Message Converter API : jackson
	// ==> JSON형식의 데이터를 자바객체로, 반대로 자바객체 JSON형식으로 변환해줌
	
	// Ajax 전송 데이터는 HTTP Message의 body에 담아서 전송한다.
	// @ResponseBody : 서버 --> 클라이언트
	// @RequestBody : 클라이언트 --> 서버
	
	// ID 중복체크
	@RequestMapping("/memberIdCheck.do")
	@ResponseBody
	public String memberIdCheck(@RequestParam("uid") String uid) {
		System.out.println("uid : " + uid );
		
		MemberDTO dto = service.idCheck(uid);
		// 아이디가 DB에 있거나 빈값이 넘어왔을때
		if(dto !=null || "".equals(uid.trim())) {
			return "no";
		}
		
		// 아이디가 없는 경우
		return "yes";
	}
	
	
	// 회원리스트 Ajax요청 처리
	@RequestMapping("/memberAjaxList.do")	
	public @ResponseBody List<MemberDTO> memberAjaxList(){
		List<MemberDTO> memberList = service.memberList();
		
		return memberList;
	}
	
	// 회원 수정
	@RequestMapping("/memberUpdate.do")
	public String memberUpdate(MemberDTO dto) {
		service.memberModify(dto);
		
		return "redirect:memberList.do";
	}
	
	// 회원 상세정보
	@RequestMapping("/memberInfo.do")
	public String memberInfo(int no, Model model) {
		MemberDTO dto = service.memberInfo(no);
		model.addAttribute("dto", dto);
		return "member/memberInfo";
	}
	
	// 회원 삭제
	@RequestMapping("/memberDelete.do")
	public String memberDelete(int no) {
//		dao.deleteMember(no);
		service.memberRemove(no);
		
		return "redirect:memberList.do";		
	}
	
	// 회원가입폼
	@RequestMapping("/memberRegister.do")
	public String memberRegister() {
		return "member/register";
	}
	
	// 회원 리스트
	@RequestMapping("/memberList.do")
	public String memberList(Model model) {
		List<MemberDTO> memberList = service.memberList();
		model.addAttribute("list", memberList);
		return "member/memberList";
	}
	
	// 회원 가입
	@RequestMapping("/memberInsert.do")
	public String memberInsert(MemberDTO dto) {
		int cnt = service.memberRegister(dto);
		
		return "redirect:memberList.do";
	}
	

	
	
	
	
}
