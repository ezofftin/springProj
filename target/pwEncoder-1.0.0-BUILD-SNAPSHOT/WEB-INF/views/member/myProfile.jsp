<%@page import="com.mbc.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ include file="../include/header.jsp" %> 
<div class='container mt-5 d-flex'>
	<aside class="border-end" style="width:200px">
		<h4>마이 프로필</h4>
		<ul>
			<li><a href="">비밀번호 변경</a></li>
			<li><a href="">기타메뉴</a></li>
		</ul> 
	</aside>  
	<div class="container w-50">
		<h4>비밀번호 변경</h4>
		<input type="hidden" id="memberId" value="${sessionScope.loginDTO.id}"/>
		<input type="text" value="${sessionScope.loginDTO.pw}"/>
		
		<p id="pwChkMsg" style="color:red; font-size:12px;"></p>
		<input class="form-control mb-2" type="text" id="pw" name="pw" placeholder="현재비밀번호">
		<input class="form-control mb-2" type="text" id="newPw" name="newPw" placeholder="새비밀번호">
		<input class="form-control mb-2" type="text" id="confirmPw" name="confirmPw" placeholder="새비밀번호 확인">
		
		<div class="text-center">
			<button id="pwChangeBtn" class="btn btn-sm btn-success">비밀번호 변경</button>
		</div>
	</div>                                       
</div>                                                        

<script>

/////////////////// 현재 비밀번호 체크 /////////////////////
let current_pw = "";
let cur_pw_chk="";

function pwCheck(){
	current_pw = $("#pw").val();
	
	$.ajax({
		url:"<c:url value='pwCheck.do'/>",
		type: "post",
		data: {"pw":current_pw},
		async:false, // 기본값 true, 동기화처리 설정
		success:function(result){
			if(result == "ok"){
				alert("현재 비밀번호 확인 완료!!");
				cur_pw_chk=true;
			}else{
				alert("현재 비밀번호 다시 확인 요망!!");
				cur_pw_chk=false;
			}
		},
		error:function(){alert("현재 비밀번호 체크 요청 실패!!")}
	});
}

let npw = "";
let npw_chk = "";
let cpw_chk = "";

////////////////// 새비밀번호 유효성 검사(실시간 유효성 검사) ///////////////////
$("#newPw").on("keyup", function(){
	npw = $("#newPw").val();
	let cpw = $("#confirmPw").val();
	
	if(npw == ""){
		$("#pwChkMsg").text("새 비밀번호를 입력하세요!!");
		npw_chk = false;
	}else if(npw.length < 4){
		$("#pwChkMsg").text("4자리 이상 입력하세요!!");
		npw_chk = false;
	}else{
		if(cpw){ // 새비밀번호 확인값이 있으면
			if(cpw !=npw){			
				$("#pwChkMsg").text("비밀번호가 일치하지 않습니다.!!");
				npw_chk = false;
				return;
			}else{
				$("#pwChkMsg").text("");	
				npw_chk = true;
				cpw_chk = true;	
			}			
		}else{  //새비밀번호 확인값이 없는 경우
			//alert("새비밀번호 확인 입력하세요!!");
			$("#pwChkMsg").text("새비밀번호 확인란을 입력하세요!!");
			cpw_chk = false;
		}
	}
}); 

$("#confirmPw").on("keyup", function(){
	let cpw = $("#confirmPw").val();
	let npw = $("#newPw").val()
	if(cpw == ""){
		$("#pwChkMsg").text("새확인 비밀번호를 입력하세요!!");
		npw_chk = false;
	}else if(npw !=cpw){
		$("#pwChkMsg").text("비밀번호가 일치하지 않습니다.!!");
		cpw_chk = false;
	}else if(npw == cpw){
		$("#pwChkMsg").text("");
		npw_chk = true;
		cpw_chk = true;
	}
});


$("#pwChangeBtn").on("click", function(){
	pwCheck();

	/* -------  새비밀번호 유효성 검사 ----------
	
	npw = $("#newPw").val();
	let cpw = $("#confirmPw").val();
	
	if(npw == ""){
		$("#pwChkMsg").text("새 비밀번호를 입력하세요!!");
		npw_chk = false;
	}else if(npw.length < 4){
		$("#pwChkMsg").text("4자리 이상 입력하세요!!");
		npw_chk = false;
	}else{
		if(cpw){ // 새비밀번호 확인값이 있으면
			if(cpw !=npw){
				alert("새 비밀번호 일치하지 않습니다!!");
				npw_chk = false;
				return;
			}
			//alert("새비밀번호 확인완료!!");
			npw_chk = true;
			cpw_chk = true;
			
		}else{  
			//alert("새비밀번호 확인 입력하세요!!");
			$("#pwChkMsg").text("");
			cpw_chk = false;
		}
	}
	*/
	
	///////// 비밀번호 변경 처리 //////////
	let id = $("#memberId").val();
	// member 객체(자바스크립트 객체)
	let member = {"id":id, "pw":current_pw, "npw":npw}
	
	if(!cur_pw_chk){
		alert("현재 비밀번호를 확인하세요!!");
	}else if(!npw_chk){
		alert("새 비밀번호를 확인하세요!!");		
	}else if(!cpw_chk){
		alert("새 비밀번호가 일치하지 않습니다.. 다시 확인하세요");
	}else if(cur_pw_chk && npw_chk && cpw_chk){		
		$.ajax({
			url:"<c:url value='pwChange.do'/>",
			type:"post",
			// 자바스크립트 객체를 JSON으로 변환해야 네트워크 전송할 수 있음 --> JSON API
			data:JSON.stringify(member),
			contentType:"application/json; charset=utf8",
			success:function(result){
				if(result > 0){
					alert("비밀번호 변경 완료!! 새 비밀번호로 로그인 하세요!!");
					location.href="<c:url value='logout.do'/>"
				}
			},
			error:function(){alert("비밀번호 변경 요청 실패!!")}		
		});
	}
	
	
	
	
});

</script>
                                                   
<%@ include file="../include/footer.jsp" %>










