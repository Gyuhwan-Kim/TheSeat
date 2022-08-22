<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>매장 주문 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/storeOrder.css?ver=10"
	type="text/css" />
</head>
<body>
<!------------------------------- navbar 추가 -------------------------------->
<jsp:include page="../nav/navbar2.jsp" />
<div class="myStore_container-gray">
<div class="wrapper">
    <!-------------------------- 주문내역 타이틀 및 날짜 검색 ---------------------------->
    <header class="store__order-header">
        <h4>주문 내역</h4><p><span id="refresh">10</span>초 후 다시 주문내역을 확인합니다.</p>
    </header>
    <!------------------------------ 주문내역 텍스트 및 박스 --------------------------------------->
    <div class="box">
    	<c:choose>
    		<c:when test="${empty orderList }">
    			<h2>주문내역이 없습니다.</h2>
    			<h3>매장을 잘 관리해 주세요!!</h3>
    		</c:when>
    		<c:otherwise>
    			<c:forEach var="tmp" items="${orderList }">
				    <div id="inner" class="inner_container" style="display: flex;"> 
				        <div class="store__order-user">
				        	<p>주문번호 ${tmp.orderNum }</p><span class="orderNum" style="display:none;">${tmp.orderNum }</span>
				            <h5 class="name"></h5><span class="email" style="display:none;">${tmp.email }</span>
				            <h6>${tmp.amount } (결제완료)</h6>
				        </div>
				        <div class="white-box">
				            <section class="order">
				                <div class="order__body">
				                    <h5 class="box-title">주문내역</h5>
				                    <div class="line"></div>
				                    <div style="height:300px; text-overflow: hidden; overflow-x: auto;">
					                    <table style="width:100%;">
					                    	<thead class="mb-2">
					                    		<tr class="row" style="display:flex; align-items:center;
					                    		margin:10px 0; text-align:center">
					                    			<th class="col">메뉴명</th>
					                    			<th class="col">수량</th>
					                    			<th class="col">가격</th>
					                    		</tr>
					                    	</thead>
					                    	<tbody class="orderDetail col ps-3 pe-3">
					                    		
					                    	</tbody>
					                    </table>
				                   
				                    <div class="dot mt-3 mb-3"></div>
				                    <ul>
				                        <li class="row">
				                            <span class="col">총 금액</span>
				                            <span class="col">${tmp.amount }</span>
				                        </li>
				                    </ul>
				                    </div>
				                </div>
				            </section>
				    <!------------------------------ 예약정보 박스 --------------------------------------->
				            <section class="reserve">
				                <h5 class="box-title">예약정보</h5>
				                <div class="reserve-body">
				                    <div class="reserve-info">
				                        <span>전화번호</span>
				                        <strong class="phone"></strong>
				                    </div>
				                    <div class="reserve-info">
				                        <span>좌석정보</span>
				                        <strong>${tmp.tableNum }번 좌석</strong>
				                    </div>
				                    <div class="reserve-info">
				                        <span>주문시간</span>
				                        <strong>${tmp.regdate }</strong>
				                    </div>
				                </div>
		                		<c:choose>
				                	<c:when test="${tmp.confirm eq 'NO' }">
				                		<c:choose>
				                			<c:when test="${tmp.cancel eq 'NO' }">
				                				<button class="reserve-btn confirm">주문 확인</button>
				                			</c:when>
				                			<c:when test="${tmp.cancel eq 'YES' }">
				                				<button class="reserve-btn cancel">취소 확인</button>
				                			</c:when>
				                			<c:when test="${tmp.cancel eq 'CONFIRM' }">
				                				<button class="reserve-btn cancel" disabled>취소 확인 완료</button>
				                			</c:when>
				                		</c:choose>
				                	</c:when>
				                	<c:when test="${tmp.confirm eq 'YES' }">
				                		<button class="reserve-btn confirm" disabled>확인 완료</button>
				                	</c:when>
				                </c:choose>
				            </section>
				        </div>
				    </div>
				    <div class="line" style="margin: 40px 0;"></div>
				</c:forEach>
    		</c:otherwise>
    	</c:choose>
	    
    </div>
</div>
        <!------------------------------------ 옆 사이드바 (매장정보, 메뉴관리 탭) ----------------->
        <aside class="aside">
        <button onclick="location.href='${pageContext.request.contextPath}/store/myStore.do?num=${orderList[0].num}'">매장 정보</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/manageMenu.do?num=${orderList[0].num}'">메뉴 관리</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/storeReview.do?num=${orderList[0].num}'">리뷰 관리</button>
        <button onclick="location.href='#'">주문 확인</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/storeSeat.do?num=${orderList[0].num}'">자리 관리</button>
    </aside>
</div>
<script src="https://kit.fontawesome.com/2ebe86210e.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
	let orderEmail = document.querySelectorAll(".email");
	let orderName = document.querySelectorAll(".name");
	let phone = document.querySelectorAll(".phone");
	let orderNumber = document.querySelectorAll(".orderNum");
	let orderDetail = document.querySelectorAll(".orderDetail");
	let orderCheck = document.querySelectorAll(".reserve-btn")
	
	
	for(let i=0; i<orderEmail.length; i++){
		let email = orderEmail[i].innerText;
		ajaxPromise("${pageContext.request.contextPath}/users/getOrderData.do","post","email="+email)
		.then(function(response) {
			return response.json();
		})
		.then(function(data) {
			let name = data.dto.name;
			let phoneNumber = data.dto.phoneNumber;
			orderName[i].innerText=name+"님이 주문하셨습니다.";
			phone[i].innerText=phoneNumber;
		});
		
		let orderNum = orderNumber[i].innerText;
		
		ajaxPromise("${pageContext.request.contextPath}/order/orderMenu.do","post","orderNum="+orderNum)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			// orderNum 이 일치하는 메뉴와 수량, 가격을 리스트로 받아온다.
			let td;
			for(let j=0; j<data.list.length; j++){
				// orderTable 에 td로 차례로 넣어주고
				let menu = data.list[j].menu;
				let menuCount = data.list[j].menuCount;
				let price = data.list[j].price;
				let td = document.createElement( "TD" );
				td.setAttribute('class', 'col');
			     td.innerHTML = menu;  
			     let td1 = document.createElement( "TD" );
			     td1.setAttribute('class', 'col');
			     td1.innerHTML = menuCount; ; 
			     let td2 = document.createElement( "TD" );
			     td2.setAttribute('class', 'col');
			     td2.innerHTML = price; 
			     
				let tr = document.createElement( "TR" ); 
				     tr.setAttribute('class', 'row');
				     tr.appendChild( td );
				     tr.appendChild( td1 ); 
				     tr.appendChild( td2 ); 
				orderDetail[i].appendChild( tr ); 
			};
		});
	
	
		if(orderCheck[i].classList.contains("confirm")){
			//주문 확인 버튼 눌렀을 때 
			orderCheck[i].addEventListener("click", function(){
				
				ajaxPromise("${pageContext.request.contextPath}/order/updateState.do","post","orderNum="+orderNum+"&confirm=YES"+"&cancel=NO")
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					if(data.isSuccess == true){
						orderCheck[i].innerText = '완료';
						orderCheck[i].setAttribute('disabled',true);
					};
				});
			});
		} else if(orderCheck[i].classList.contains("cancel")){
			//주문 취소 완료 버튼 눌렀을 때 
			orderCheck[i].addEventListener("click", function(){
				
				ajaxPromise("${pageContext.request.contextPath}/order/updateState.do","post","orderNum="+orderNum+"&confirm=NO"+"&cancel=CONFIRM")
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					if(data.isSuccess == true){
						orderCheck[i].innerText = '취소 완료';
						orderCheck[i].setAttribute('disabled',true);
					};
				});
			});
		}
	}
	
	
	
	function countDown2(){
		let count = Number(document.querySelector("#refresh").innerText);
		count = count-1;
		document.querySelector("#refresh").innerText= count;
		setTimeout(countDown, 1000);
	}
	
	function countDown1(){
		let count = Number(document.querySelector("#refresh").innerText);
		count = count-1;
		document.querySelector("#refresh").innerText= count;
		setTimeout(countDown2, 1000);
	}
	
	function countDown(){
		let count = Number(document.querySelector("#refresh").innerText);
		count = count-1;
		document.querySelector("#refresh").innerText= count;
		setTimeout(countDown1, 1000);
	}
	function refresh(){
		location.reload(true);
	}
	let countNum = setTimeout(countDown, 1000);
	let timer = setTimeout(refresh, 10000);
</script>
</body>
</html>