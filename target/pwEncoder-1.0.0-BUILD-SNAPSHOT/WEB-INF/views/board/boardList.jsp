<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container mt-5">
	<h4>스프링 게시판</h4>
	<!-- 검색 -->
	<div>
		<form action="list.do" id="searchForm" method="post">
			<!-- 게시글 개수를 먼저 선택하고 검색할 경우 선택된 게시글 수 넘겨줌 -->
			<input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}">
			
			<div class="d-flex justify-content-center">
				<select class="form-select form-select-sm me-2" style="width:200px" 
							name="searchType">
					<option value="">선택</option>
					<option value="S" ${pDto.searchType == 'S' ? 'selected': ''}>제목</option>
					<option value="C" ${pDto.searchType == 'C' ? 'selected': ''}>내용</option>
					<option value="W" ${pDto.searchType == 'W' ? 'selected': ''}>글쓴이</option>
					<option value="SC" ${pDto.searchType == 'SC' ? 'selected': ''}>제목 + 내용</option>
					<option value="SW" ${pDto.searchType == 'SW' ? 'selected': ''}>제목 + 글쓴이</option>
					<option value="SCW" ${pDto.searchType == 'SCW' ? 'selected': ''}>제목 + 내용 + 글쓴이</option>
				</select>
				<input type="text" id="keyword" name="keyword" placeholder="검색어입력"
					class="form-control rounded-0 rounded-start" style="width:300px"
					value="${pDto.keyword}">
				<button class="btn rounded-0 rounded-end" style="background:#1384aa; color:white"><i class="fa fa-search"></i></button>
			</div>
		</form>
	</div>
	
	<div class="d-flex my-3 justify-content-between">
		<div><b>${pDto.viewPage}</b> / ${pDto.totalPage} pages</div>
		
		<!-- 검색이 없는 경우 게시글 개수 선택 -->
      	<c:if test="${pDto.searchType == null || pDto.searchType ==''}">
		<div>
			<select class="form-select form-select-sm" id="cntPerPage">
				<option value="5" ${pDto.cntPerPage == 5 ? 'selected': ''}>게시글 5개</option>
				<option value="10" ${pDto.cntPerPage == 10 ? 'selected': ''}>게시글 10개</option>
				<option value="20" ${pDto.cntPerPage == 20 ? 'selected': ''}>게시글 20개</option>
			</select>
		</div>
		</c:if>
		
		<!-- 검색이 있는 경우 게시글 개수 선택 -->
      	<c:if test="${pDto.searchType != null && pDto.searchType !=''}">
      	<div>
      		<select class="form-select form-select-sm" id="cntPerPage">
      			<c:choose>
      				<c:when test="${pDto.totalCnt <= 5}">
      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>선택없음</option>
      				</c:when>
      				
      				<c:when test="${pDto.totalCnt > 5 && pDto.totalCnt < 10}">
      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>게시글 5개</option>
		      			<option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>게시글 10개</option>
      				</c:when>
      				
      				<c:when test="${pDto.totalCnt >=10 && pDto.totalCnt < 20}">
      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>게시글 5개</option>
		      			<option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>게시글 10개</option>
      				</c:when>
      				
      				<c:otherwise>
      					<option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>게시글 5개</option>
		      			<option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>게시글 10개</option>
		      			<option value="20" ${pDto.cntPerPage== 20 ? 'selected':''}>게시글 20개</option>
      				</c:otherwise>
      			</c:choose>
      		</select>
      	</div>
      	</c:if>
		
		
	</div>
	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>글쓴이</th>
				<th>등록일</th>
			</tr>			
		</thead>
		<tbody>
		<!-- 
			XSS(cross-site Scripting 공격 : 웹사이트에 스크립트 코드를 주입시켜서 공격하는 해킹 기법)
			
			JSP에서 XSS 공격 차단방법:
		-->
			
<%-- jsp 주석으로 처리 
	<c:out /> 를 사용하여 입력된 스크립트 태그를 브라우저가 인식하지 못하도록 문자열로 변환시켜 방어를 함. 
--%>
	
			<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.bid}</td>
					<td><a href="<c:url value="view.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}"/>"><c:out value="${dto.subject}"/> <b>[${dto.replyCnt}]</b></a></td>
					<td>${dto.hit}</td>
					<td><c:out value="${dto.writer}"/></td>
					<td>${dto.reg_date}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5" class="text-center">
					<button class="btn btn-primary" id="btn-write">글쓰기</button>
				</td>
			</tr>
		</tbody>
	</table>
	<!-- ----------------------페이지 네이션------------------------- -->
	<ul class="pagination justify-content-center">
	  <li class="page-item ${pDto.prevPage <=0 ? 'disabled':''}">
	  	<a class="page-link" href="list.do?viewPage=${pDto.prevPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">이전</a>
	  </li>
	  
	  <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
		  <li class="page-item ${pDto.viewPage == i ? 'active':''}">
		  	<a class="page-link" href="list.do?viewPage=${i}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">${i}</a>
		  </li>
	  </c:forEach>
	  
	  <li class="page-item ${pDto.blockEnd >= pDto.totalPage ? 'disabled':''}">
	  	<a class="page-link" href="list.do?viewPage=${pDto.nextPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">다음</a>
	  </li>
	</ul>
</div>
	
<script type="text/javascript">
		// $("#btn-write").click(function(){})
		$("#btn-write").click(()=>{
			location.href="<c:url value='register.do'/>";
		});
		
		$("#cntPerPage").change(()=>{
			var cntVal = $("#cntPerPage").val();
			//alert(cntVal);
			
			location.href="list.do?viewPage=1&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage="+cntVal; 
		})
</script>
	
<%@ include file="../include/footer.jsp" %>
