let replyFunc = (() => {
	// 댓글 리스트 요청
	/*
	function getList(bid, callback){
		$.ajax({
			url:"/reply2/replies/list/"+bid,
			type:"get",				
			success:(result)=>{
				callback(result);
			},
			error:()=>{alert("요청 실패!!")}
		});
	}
	*/
	// param = json형식
	function getList(param, callback){
		let bid = param.bid;
		let viewPage = param.viewPage;
		
		$.ajax({
			url:"/reply2/replies/list/"+bid+"/"+viewPage,
			type:"get",				
			success:(result)=>{
				callback(result);
			},
			error:()=>{alert("요청 실패!!")}
		});
	}
	
	// 댓글 조회 요청
	function read(rno, callback){		
		$.ajax({
			url:"/reply2/replies/"+rno,
			type:"get",				
			success:(result)=>{
				callback(result);
			},
			error:()=>{alert("요청 실패!!")}
		});
	}
	
	
	// 댓글 수정 요청
	function update(reply, callback){
		$.ajax({
			url:"/reply2/replies/"+reply.rno,
			type:"put",				
			data:JSON.stringify(reply), 
			contentType: "application/json; charset=utf8",
			success:(result)=>{
				callback(result);
			},
			error:()=>{alert("요청 실패!!")}
		});
	}
	
	
	// reply는 JSON형태의 자바스크립트 객체
	function register(reply, callback){
		$.ajax({
			url:"/reply2/replies/new",
			type:"post",
			// JSON : 자바스크립트 API(라이브러리), 자바스크립트 객체는 네트웍 전송 불가
			data:JSON.stringify(reply), // JSON형태의 문자열(텍스트)로 변환
			contentType: "application/json; charset=utf8",
			success:(result)=>{
				callback(result);
			},
			error:()=>{alert("요청 실패!!")}
		});
	}
	
	// 댓글 삭제 요청
	function remove(rno, callback){
		$.ajax({
			url:"/reply2/replies/"+rno,
			type:"delete",				
			success:(result)=>{
				callback(result);
			},
			error:()=>{alert("요청 실패!!")}
		});
	}
	
	
	// 댓글 등록 날짜/시간 표시 함수
	function showDateTime(replyTime){ // replyTime:댓글 등록시간
	
		console.log("replyTime :"+replyTime);
		
		// 현재 시간 구하고
		let now = new Date();
		
		// 현재시간과 댓글 등록시간의 갭(gap:차이)
		let gap = now.getTime() - replyTime; 
		
		// 댓글 등록시간을 Date객체로 생성		
		let rDate = new Date(replyTime);
		console.log("rDate : " + rDate); 

		// gap이 24시간 이상이면 날짜로 표시, 24시간 미만이면 시간으로 표시
		if(gap < (1000 * 60 * 60 * 24)){ // 24시간 미만이면
			let hh = rDate.getHours();
			let mi = rDate.getMinutes();
			let ss = rDate.getSeconds();
			
			return [(hh >= 10 ? '': '0')+hh, ":", (mi >= 10 ? '': '0')+mi, ":", (ss >= 10 ? '': '0')+ss].join(''); // [09,":",03,":",23] ==> "09:03:23", 배열 ==> 문자열 바꾸는 함수 join(구분자)
			
		}else{ // 24시간 이상
			let yy =rDate.getFullYear();
			let mm =rDate.getMonth() + 1; // 0(1월) ~ 11
			let dd =rDate.getDate();
			console.log("mm:"+mm);
			return [yy, '-', (mm >= 10 ? '': '0')+mm, '-',(dd >= 10 ? '': '0')+dd].join('');
		}
	}
	
	
	return {
		register : register,
		remove : remove,
		update : update,
		read : read,
		getList : getList,
		showDateTime : showDateTime
	}
})();