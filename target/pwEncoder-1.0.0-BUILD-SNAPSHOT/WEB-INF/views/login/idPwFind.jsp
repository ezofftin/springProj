<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container w-50 mt-5 p-5">
	<!-- Nav tabs -->
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link ${find=='id' ? 'active':''}" data-bs-toggle="tab" href="#menu1">아이디 찾기</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link ${find=='pw' ? 'active':''}" data-bs-toggle="tab" href="#menu2">비밀번호 찾기</a>
	  </li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content mt-5">
	
	 <!-- 아이디 찾기 container -->
	  <div class="tab-pane container fade ${find=='id' ? 'show active':''}" id="menu1">
	  	<div id="findIdSuccess" style="display:none">
		  	<p>가입시 아이디 <b><span id="findId"></span></b> 입니다.</p>
		  	<a href="" class = "btn btn-primary mt-3 w-100">로그인</a>
	  	</div>
		
		<div id="findIdBefore">
		  	<p>이름과 휴대폰 번호를 입력하세요.</p>
		  	<input type="text" class="form-control mb-2" id="name" name="name" placeholder="이름"/>
		  	<input type="text" class="form-control mb-2" id="tel" name="tel" placeholder="전화번호"/>
		  	<input type="text" class="btn btn-primary mt-3 w-100" type="button" value="아이디 찾기" onclick="idFind()"/>
		</div>	  
	  </div>
	 
	 <!-- 비밀번호 찾기 container -->
	  <div class="tab-pane container fade ${find=='pw' ? 'show active':''}" id="menu2">	  
	   	<div id="findPwSuccess" style="display:none">
		  	<p>
		  		<small>해당 이메일로 임시 비밀번호를 보냈습니다. <br/>
		  			로그인 후 마이페이지에서 비밀번호를 변경하시기 바랍니다.
		  		</small>
		  	</p>
		  	<a href="" class = "btn btn-primary mt-3 w-100">로그인</a>
	  	</div>
	  	<div id="findPwBefore">
		  	<p>가입시 아이디와 이메일을 입력하세요.</p>
		  	<input type="text" class="form-control mb-2" id="id" name="id" placeholder="아이디"/>
		  	<input type="text" class="form-control mb-2" id="email" name="email" placeholder="이메일"/>
		  	<input type="text" class="btn btn-primary mt-3 w-100" type="button" value="비밀번호 찾기" onclick="pwFind()"/>
	  	</div>
	  </div>
	</div>
	<script type="text/javascript">
		function idFind(){
			let name = $("#name").val();
			let tel = $("#tel").val();
			
			$.ajax({
				url:"<c:url value='findId.do?name='/>"+name+"&tel="+tel,
				type:"post",
				
				success:function(data){
					if(data == false){
						alert("이름 및 전화번호를 다시 확인하세요!!")
					}else{
						$("#findIdBefore").css("display", "none");
						$("#findIdSuccess").css("display", "block");
						$("#findId").text(data);
					}
				},
				error:function(){alert("아이디 찾기 요청 실패!!")}
			});
		}
		
		function pwFind(){
			let uid = $("#id").val();
			let uEmail = $("#email").val();
			console.log("@@@@@@@" + uid);
			console.log("@@@@@@@" + uEmail);
			
			
			$.ajax({
				url:"<c:url value='findPw.do?uid='/>"+uid+"&uEmail="+uEmail,
				type:"post",
				
				success:function(data){
					if(data == 0){
						alert("아이디와 이메일을 다시 확인하세요!!")
					}else{ // 비번 찾기 성공
						$("#findPwBefore").css("display", "none");
						$("#findPwSuccess").css("display", "block");
					}
				},
				error:function(){alert("비밀번호 찾기 요청 실패!!")}
			});
		}
	
	</script>	
</div>
<%@ include file="../include/footer.jsp" %>




















