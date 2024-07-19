<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container w-50 mt-5 p-5 shadow">
	<h4>글 상세보기</h4>
	  <div class="form-group">
	     	<label for="bid">번호</label>        
	  	<input class="form-control" type="text" id="bid" 
	  		name="bid" value="${dto.bid}" disabled >
	  </div> 
	  <div class="form-group">
	     	<label for="subject">제목</label>     
	  	<input class="form-control" type="text" id="subject" 
	  		name="subject" value='<c:out value="${dto.subject}"/>' disabled >      
	     </div>
	     <div class="form-group">
	     	<label for="contents">내용</label>
	     	<textarea class="form-control mt-2" 
	     		name="contents" id="contents" disabled>${dto.contents}</textarea>
	     </div>
	     <div class="form-group">
	     	<label for="writer">글쓴이</label>
	     	<input class="form-control mt-2" type="text" 
	     		id="writer" name="writer" value="${dto.writer}" disabled>
	     </div>
	     
	     <div class="text-center mt-3">
	        <button id="btn-modify" class="btn btn-primary me-2">수정하기</button>   
	        <button id="btn-list" class="btn btn-primary">리스트</button>   
	     </div>
	     
	 <!--------------- 댓글 UI ------------------------>
	 <div class="mt-5 mb-3 d-flex justify-content-between">
     	<h6><i class="fa fa-comments-o"></i> 댓글</h6>
     	<button id="btn-addReply" class="btn btn-sm btn-outline-secondary" 
     	   data-bs-target="#replyModal" data-bs-toggle="modal">새댓글</button>
     </div>
     <!-- 댓글 리스트 영역 -->
     <ul class="p-0 replyArea" style="list-style:none;">
     	<!-- <li class="mb-2">
     		<div class="form-control">
     			<div class="d-flex justify-content-between">
     				<h6>홍길동</h6><span>2023-12-05</span>
     			</div>
     			<p>댓글 테스트.................</p>
     		</div>
     	</li>
     	<li class="mb-2">
     		<div class="form-control">
     			<div class="d-flex justify-content-between">
     				<h6>홍길동</h6><span>2023-12-05</span>
     			</div>
     			<p>댓글 테스트.................</p>
     		</div>
     	</li> -->
     </ul>
     <!--------------- Pagenation Area ------------------------>
     <ul class="pagination justify-content-center my-5">
		<li class="page-item">
			<a class="page-link">이전</a>
		</li>

		<li class="page-item">
			<a class="page-link">1</a>
		</li>

		<li class="page-item">
			<a class="page-link">다음</a>
		</li>
	</ul>   
     
     
     
     
     
</div>

<!------------------ Modal UI ------------------------>
<div class="modal fade" id="replyModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title">댓글 달기</h5>
      </div>

      <!-- Modal body -->
      <div class="modal-body p-4">
      	<div class="mb-3">
      		<label>댓글 내용</label>
      		<textarea class="form-control" id="r_contents"></textarea>
      	</div>
      	<div class="mb-3">
      		<label>댓글 작성자</label>
      		<input type="text" id="replyer" name="replyer" class="form-control"/>
      	</div>      	
      	<div class="mb-3">
      		<label>등록일</label>
      		<input type="text" id="r_date" name="r_date" class="form-control"/>
      	</div>      	
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" id="btn-modal-modify" class="btn btn-sm btn-success">수정</button>
        <button type="button" id="btn-modal-remove" class="btn btn-sm btn-danger">삭제</button>
        <button type="button" id="btn-modal-register" class="btn btn-sm btn-primary">등록</button>
        <button type="button" id="btn-modal-close" class="btn btn-sm btn-secondary">닫기</button>
      </div>
    </div>
  </div>
</div> 

<!------------------ Modal UI End------------------------>

<script src="../js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 게시글 번호 가져오기
		let bidVal = "${dto.bid}";
		
		let viewPage = 1; // 최초의 페이지		
		
		// 댓글 리스트 출력
		displayList(viewPage);		
		// --------------- PageNation 처리 -----------------
		let pageArea = $(".pagination");
		
		function shwoPageNavi(data){
			let prevPage = data.prevPage;
			let nextPage = data.nextPage;
			let blockStart = data.blockStart;
			let blockEnd = data.blockEnd;
			
			let totalPage = data.totalPage;
			let viewPage = data.viewPage;
			
			let str="";
			
			if(prevPage){
				str +='<li class="page-item">'				
				+'<a class="page-link" href="'+prevPage+'">이전</a></li>';
			}
			
			for(let i = blockStart; i<=blockEnd; i++){
				let active = viewPage == i ? "active":"";	
			
				str +='<li class="page-item '+active+'">'				
					+'<a class="page-link" href="'+i+'">'+i+'</a></li>';
			}
			
			if(blockEnd < totalPage){
				str +='<li class="page-item">'				
				+'<a class="page-link" href="'+nextPage+'">다음</a></li>';
			}
			
			pageArea.html(str);
		}
		
		// 이벤트 위임, 발생한 기본 이벤트를 차단
	      pageArea.on("click", "li a", function(e){
	         e.preventDefault(); // a 태그의 기본 이벤트(링크 href)를 차단  
	         
	         let viewPage= $(this).attr("href");
	         
	         displayList(viewPage);
	      });
		
		
		//----------------Modal & Event 처리----------------
		let modalWindow = $(".modal"); // modal 창
		
		let taReplyContents = $("#r_contents");
		let inputReplyer = $("#replyer");
		let inputReplyDate = $("#r_date");
		
		let modifyBtn = $("#btn-modal-modify");
		let removeBtn = $("#btn-modal-remove");
		let registerBtn = $("#btn-modal-register");
		
		// Modal 닫기
		$("#btn-modal-close").on("click", ()=>{
			modalWindow.modal("hide"); //modal()함수 사용
		})
		
		// 새댓글 
		$("#btn-addReply").on("click", ()=>{
			taReplyContents.val("");
			inputReplyer.val("");
			
			// 등록일 숨기기, div 부모중에 가장 가까운 div를 선택해서 감추기
			inputReplyDate.closest("div").hide();
			
			registerBtn.show();
			modifyBtn.hide();
			removeBtn.hide();
		});	
		
		// 댓글 수정
		modifyBtn.on("click", ()=>{
			
			let reply={rno:modalWindow.data("rno"), r_contents:taReplyContents.val()};
			
			replyFunc.update(reply, (result)=>{
				modalWindow.modal("hide");
				// 수정 후 댓글리스트 갱신
				displayList();
			});
		});
		
		
		// 댓글 삭제
		removeBtn.on("click", ()=>{
			// modalWindow 태그에 저장된(data-rno) rno값을 가져온다.
			let rno = modalWindow.data("rno");
			
			replyFunc.remove(rno, (result)=>{
				modalWindow.modal("hide");
				// 삭제 후 댓글리스트 갱신
				displayList();
			});
		});
		
		
		let replyArea = $(".replyArea");
		
		
		
		//function displayList(){			
		function displayList(viewPage){
			let str="";
			// viewPage || 1 는 viewPage가 null일때 1로 대체
			replyFunc.getList({bid:bidVal, viewPage:viewPage || 1}, function(data){
				
				console.log(data);
				// 댓글 리스트만 가져옴
				let list = data.replyList;
				
				for(let i=0; i<list.length; i++){
					str +='<li class="mb-2" data-rno="'+list[i].rno+'">'
			     		+'<div class="form-control">'
	     				+'<div class="d-flex justify-content-between">'
	     				+'<h6>'+list[i].replyer+'</h6><span>'+replyFunc.showDateTime(list[i].r_date)+'</span>'
	     				+'</div>'
	     				+'<p>'+list[i].r_contents+'</p>'
	     				+'</div></li>'
				}
				replyArea.html(str);
				shwoPageNavi(data);
			});
		}
		
		// modal의 등록버튼 클릭
		registerBtn.on("click", ()=>{
			
			if(taReplyContents.val().trim() == ""){
				alert("댓글 입력하세요!!");
				taReplyContents.focus();
				return;
			}
			
			if(inputReplyer.val().trim() == ""){
				alert("작성자를 입력하세요!!");
				taReplyContents.focus();
				return;
			}
			
			
			let reply = {bid:bidVal, 
					r_contents:taReplyContents.val(), 
					replyer:inputReplyer.val()};
			
			replyFunc.register(reply, function(result){
				modalWindow.modal("hide");				
				displayList(); 
			});
			
		});
		
		// 댓글 상세보기 - 댓글 클릭
		// 이벤트 위임(delegation) : jquery에서는 on() 함수를 사용
		// 항상 존재하는 ul(.replyArea) 태그에 이벤트 주고, 댓글이 추가될때
		// 존재하게될 li에게 그 이벤트를 전달(전가) 즉, 실제 이벤트 대상에게 전달
		
		// 댓글이 없으면 li는 존재하지 않는다. 따라서, 처음부터 li에게는 이벤트를 지정할 수 없음
		// 항상 존재하는 ul(부모)에 이벤트를 지정하고, 클릭된 자식li에게 지정된 이벤트를 전달
		
		// jQuery 이벤트 핸들러에서 this를 사용하려면 
		// 일반 함수를 사용해야 이벤트가 발생한 요소를 this로 바인딩할 수 있음.
		
		// 만일 화살표 함수를 사용한다면 아래와 같이 이벤트 정보를 갖는 객체(e)를 
		// 매개변수로 받아서 currentTarget 속성을 활용한다.  
		$(".replyArea").on("click", "li", function(){	
		//$(".replyArea").on("click", "li", (e)=>{
			
			// 일반함수 사용하는 경우
			// rno : 댓글 식별자 가져오기, this는 click이벤트 대상(실제 클릭한 li)
			let rno = $(this).data("rno");
			
			// 화살표 연산자를 사용하는 경우
			//let rno = $(e.currentTarget).data("rno");
					
			replyFunc.read(rno, (reply)=>{
				taReplyContents.val(reply.r_contents);
				inputReplyer.val(reply.replyer).attr("readonly", true);
				inputReplyDate.val(reply.r_date).attr("readonly", true);
				
				inputReplyDate.closest("div").show();
				
				// 모달창에 선택한 댓글의 rno값을 저장
				modalWindow.data("rno", rno);
				
				registerBtn.hide();
				modifyBtn.show();
				removeBtn.show();
			});
			
			modalWindow.modal("show");
		});
		
		
		
		
		
		// 댓글 리스트 테스트
		// replyFunc.getList(bidVal, (result)=>{console.log(result);})
	});
	
</script>

<script type="text/javascript">
	$("#btn-list").click(()=>{
		location.href="<c:url value='list.do?viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	});
	
	$("#btn-modify").click(()=>{
		location.href="<c:url value='modify.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	});
</script>

<%@ include file="../include/footer.jsp" %>

