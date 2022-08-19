<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>매장 자리 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" 
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" 
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" 
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/storeSeat.css?ver=6"
	type="text/css" />
</head>
<body>
<!------------------------------- navbar -------------------------------->
<jsp:include page="../nav/navbar2.jsp" />
<div class="myStore_container">
	<div class="myStore_container_inner">
     <!------------------------ 주문내역 텍스트 및 박스 -------------------------------->
        <div id="inner" class="inner_container"> 
            <div class="display-box">
                <section class="seat">
                        <span class="seat-title" style="font-size: 13px;">
                           매장 자리 이미지를 등록해 주세요
                        </span>
                        <div class="seat__box">
                        	<a id="seatLink" href="javascript:" >
	                        	<c:choose>
									<c:when test="${sDto.seatImage eq null}">
										<p>클릭해서 이미지 등록하기</p>
									</c:when>
									<c:otherwise>
										<img id="seatImage" style="width:100%; height:100%; object-fit: fill;" src="${pageContext.request.contextPath}${sDto.seatImage}" />
									</c:otherwise>
								</c:choose>
							</a>
                        </div>
                        
                        <div class="seat__select">
                        	<c:choose>
	                        	<c:when test="${sDto.notUse eq null && sDto.notEmptySeat eq null}">
	                        		<input type="number" id="totalSeat" min="1" max="30" >
	                        	</c:when>
	                        	<c:otherwise>
	                        		<input type="number" id="totalSeat" min="1" max="30" disabled>
	                        	</c:otherwise>
	                        </c:choose>
                        </div>
                        <div>
                        	<p class="mb-1" style="font-size:14px;">매장 알림사항</p>
                        	<textarea name="seatContent" id="content" cols="30" rows="3">${sDto.seatContent }</textarea>
                        </div>
                </section>
        <!------------------------------ 예약정보 박스 --------------------------------------->
                <section class="select">
                    <div class="select-title">
                        <p><strong>자리번호</strong></p>
                        <p><strong>자리상태</strong></p>
                    </div>
                    <div class="line"></div>
                    <div class="seat-NumState" style="overflow: auto;">
                        
                       	<c:forEach var="tmp" items="${sDto.totalSeat }">
                       		<div>
	                       		<p>${tmp}  번 자리</p>
		                        <select id="${tmp}" class="useState">
                       		
		                        <c:if test="${fn:contains(sDto.emptySeat, tmp) }">
		                        	<option value="emptySeat" selected>이용가능</option>
		                            <option value="notEmptySeat" >이용중</option>
		                            <option value="notUse">이용불가</option>
		                        </c:if>
		                        <c:if test="${fn:contains(sDto.notEmptySeat, tmp) }">
		                        	<option value="emptySeat" >이용가능</option>
		                            <option value="notEmptySeat" selected>이용중</option>
		                            <option value="notUse">이용불가</option>
		                        </c:if>
		                        <c:if test="${fn:contains(sDto.notUse, tmp) }">
		                        	<option value="emptySeat" >이용가능</option>
		                            <option value="notEmptySeat" >이용중</option>
		                            <option value="notUse" selected>이용불가</option>
		                        </c:if>
	                        </select>
	                        </div>
                       	</c:forEach>
                       
                    </div>
                </section>
            </div>
            <form id="updateForm" action="${pageContext.request.contextPath}/store/updateSeat.do" method="post">
            	<input type="hidden" name="num" 
								value="${sDto.num}"/>
				<input type="hidden" name="totalSeat" 
								value="${sDto.totalSeat }"/>			
            	<input type="hidden" name="seatImage" 
								value="${sDto.seatImage}"/>
				<input type="hidden" id="seatContent" name="seatContent" 
								value="${sDto.seatContent}"/>
				<input type="hidden" name="emptySeat" 
								value="${sDto.emptySeat}"/>
				<input type="hidden" name="notEmptySeat" 
								value="${sDto.notEmptySeat}"/>
				<input type="hidden" name="notUse" 
								value="${sDto.notUse}"/>
            	<button type="submit" id="updateStateBtn" class="submit-btn">배치 변경</button>
            </form>
            
        </div>
    </div>
        <!------------------------------------ 옆 사이드바 (매장정보, 메뉴관리 탭) ----------------->
    <aside class="aside">
        <button onclick="location.href='${pageContext.request.contextPath}/store/myStore.do?num=${num}'">매장 정보</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/manageMenu.do?num=${num}'">메뉴 관리</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/storeReview.do?num=${num}'">리뷰 관리</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/storeOrder.do?num=${num}'">주문 확인</button>
        <button onclick="location.href='#'">자리 관리</button>
    </aside>
</div>

<!-- seat 이미지 넣는용 지우지마용 -->
<form action="${pageContext.request.contextPath}/store/ajax_seat_upload.do" method="post" 
	  id="imageForm" enctype="multipart/form-data" style="visibility:hidden;'">
	<input type="file" name="image" id="image" 
		accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
</form>
<script src="https://kit.fontawesome.com/2ebe86210e.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
	let num = ${sDto.num};
	let notUse = [];
	notUse.push(${sDto.notUse});
	let notEmptySeat = [];
	notEmptySeat.push(${sDto.notEmptySeat});
	let emptySeat = [];
	emptySeat.push(${sDto.emptySeat});
	let totalSeat = [];
	totalSeat.push(${sDto.totalSeat});
	let totalNum = totalSeat.length;
	document.querySelector("#totalSeat").value=totalNum;
	//자리 이미지 링크를 클릭하면 
	document.querySelector("#seatLink").addEventListener("click", function(){
		// input type="file" 을 강제 클릭 시킨다. 
		document.querySelector("#image").click();
	});
	//자리 이미지를 새롭게 넣으면
	document.querySelector("#image").addEventListener("change", function(){
		
		let form=document.querySelector("#imageForm");
		
		// gura_util.js 에 정의된 함수를 호출하면서 ajax 전송할 폼의 참조값을 전달하면 된다. 
		ajaxFormPromise(form)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			// 클릭하는 자리에 이미지 넣어주기
			let img=`<img id="seatImage" style="width:100%; height:100%; object-fit: fill;" src="${pageContext.request.contextPath}\${data.imagePath}"/>`;
			
			document.querySelector("#seatLink").innerHTML=img;
			// input name="seatImage" 요소의 value 값으로 이미지 경로 넣어주기
			document.querySelector("#updateForm").seatImage.value=data.imagePath;
		});
	});
	
	document.querySelector("#content").addEventListener("keyup",function(){
		document.querySelector("#seatContent").value=this.value;
	})
	document.querySelector("#totalSeat").addEventListener("input",function(){
		totalNum = this.value;
		emptySeat = [];
		totalSeat = [];
		for(let i=1; i<=totalNum; i++){
			emptySeat.push(i);
			totalSeat.push(i);
		}
		document.querySelector("#updateForm").emptySeat.value=emptySeat;
		document.querySelector("#updateForm").totalSeat.value=totalSeat;
	})
	
	// 자리 정보 수정 ajax 요청하기 
	document.querySelector("#updateForm").addEventListener("submit",function(e) {
		e.preventDefault();
		ajaxFormPromise(this)
		.then(function(response) {
			return response.json();
		})
		.then(function(data) {
			if(data.isSuccess){
				alert("자리 정보가 수정되었습니다.");
				location.href="${pageContext.request.contextPath}/store/storeSeat.do?num="+num;
			} else {
				alert("자리 정보를 수정할 수 없습니다. 문제가 반복된다면 문의 바랍니다.");
			}
		});
	});
	
	let state = document.querySelectorAll(".useState");
	for(let i=0; i<state.length; i++){
		state[i].addEventListener("change",function(){
			let seatNum = Number(state[i].id);
			let seatState = state[i].value;
			if(seatState == "emptySeat"){
				let index1 = emptySeat.indexOf(seatNum); 
				if (index1 <= -1) {
					emptySeat.push(seatNum);
				};
				let index2 = notEmptySeat.indexOf(seatNum); 
				if (index2 > -1) {
					notEmptySeat.splice(index2,1);
				};
				let index3 = notUse.indexOf(seatNum); 
				if (index3 > -1) {
					notUse.splice(index3, 1);
				};
			} else if (seatState == "notEmptySeat"){
				let index1 = emptySeat.indexOf(seatNum); 
				if (index1 > -1) {
				  emptySeat.splice(index1, 1);
				};
				let index2 = notEmptySeat.indexOf(seatNum); 
				if (index2 <= -1) {
					notEmptySeat.push(seatNum);
				};
				let index3 = notUse.indexOf(seatNum); 
				if (index3 > -1) {
				  notUse.splice(index3, 1);
				};
				
			} else if (seatState == "notUse"){
				let index1 = emptySeat.indexOf(seatNum); 
				if (index1 > -1) {
				  emptySeat.splice(index1,1);
				};
				let index2 = notEmptySeat.indexOf(seatNum); 
				if (index2 > -1) {
					notEmptySeat.splice(index2,1);
				};
				let index3 = notUse.indexOf(seatNum); 
				if (index3 <= -1) {
				  notUse.push(seatNum);
				};
			}
			document.querySelector("#updateForm").emptySeat.value=emptySeat;
			document.querySelector("#updateForm").notEmptySeat.value=notEmptySeat;
			document.querySelector("#updateForm").notUse.value=notUse;
			document.querySelector("#updateStateBtn").click();
			location.href="${pageContext.request.contextPath}/store/storeSeat.do?num="+num;
		});
	};
</script>
</body>
</html>