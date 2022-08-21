<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문페이지</title>
<!-- 부트스트랩 링크 불러오기 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous"></script>
<!-- 애니메이션 링크 불러오기 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<!-- 스타일 링크 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/order.css"
	type="text/css" />
<!-- 타이틀 로고 -->
<link rel="shortcut icon" type="image⁄x-icon"
	href="${pageContext.request.contextPath}/resources/img/summer.jpg">
</head>
<body style="margin-top: 150px;">
	<!-- 네비바 import 하기 -->
	<jsp:include page="/WEB-INF/views/nav/navbar.jsp" />
	<div class="container order-container">
		<div class="container">
			<button id="backBtn"
				onclick="location.href='javascript:history.back();'">
				<img src="${pageContext.request.contextPath}/resources/img/back.png"
					alt="back" style="margin-bottom: 15px; width: 48px; height: 50px;" />
			</button>
			<span
				style="color: rgb(84, 84, 84); font-size: 2.5em; font-weight: bold; text-shadow: 2px 6px 2px #d3d3d3;">주문하기</span>
			<span
				style="margin-left: 20px; font-size: 25px; font-weight: 500; color: rgb(89, 89, 89);">${dto.storeName }에서
				${tableNum }번 자리 👨‍🍳 </span> <br /> <span class="total_Menu">전체
				메뉴 🍴</span>
		</div>
		<!----------------- 주문페이지에서 메뉴 고르기 ------------------>
		<div class="row row2">
			<div class="col text-center" style="margin-top: 45px;">
				<div class="row row-cols-1 row-cols-md-2 g-4 foodMenu"
					style="width: 650px; height: 800px; overflow: auto;">
					<c:forEach var="cat" items="${dto.category }">
						<c:forEach var="tmp" items="${menuList }">
							<c:if test="${tmp.category == cat }">
								<form class="orderMenu"
									action="${pageContext.request.contextPath}/order/insert.do">
									<input type="hidden" name="orderNum" value="${orderNum }" /> <input
										type="hidden" name="email" value="${email }" /> <input
										type="hidden" name="storeName" value="${dto.storeName }" /> <input
										type="hidden" name="storeLogo" value="${dto.image_logo }" />
									<input type="hidden" name="menu" value="${tmp.menuName }" /> <input
										type="hidden" name="tableNum" value="${tableNum }" /> <input
										type="hidden" name="price" value="${tmp.price}" /> <input
										type="hidden" name="num" value="${dto.num }" />

									<div class="col">
										<div class="card">
											<img
												src="${pageContext.request.contextPath}${tmp.menuImage }"
												class="card-img-top" alt="menuImage"
												style="width: 100%; height: 230px; object-fit: fill;">
											<div class="card-body"
												style="background-color: rgb(176, 215, 252); color: rgb(104, 104, 104); font-weight: bold;">
												<h5 class="card-title">
													<button type="submit" id="orderMenu">${tmp.menuName }</button>
												</h5>
												<p class="card-text" style="font-size: 20px;">
													<fmt:formatNumber value="${tmp.price }" pattern="#,###" />
													원
												</p>
												<input type="number" id="menuCount" name="menuCount" min="1"
													max="9" value="1">
											</div>
										</div>
									</div>
								</form>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>
			</div>

			<!--------------------------- 주문내역 영수증 ---------------------------->
			<div class="col orderR" style="width: 650px; margin: auto;">
				<img src="${pageContext.request.contextPath}/resources/img/p.svg"
					alt="receipt" class="img2" style="width: 100%; height: 700px;">
				<div class="text_top row"
					style="width: 100%; display: flex; justify-content: space-evenly">
					<h3 class="col-2">메뉴</h3>
					<h3 class="col-2">수량</h3>
					<h3 class="col-2">금액</h3>
				</div>
				<div class="text_middle">
					<h5 id="orderList"></h5>
				</div>
				<div class="text_bottom">
					<h4>
						총 결제 금액 <span id="amount"
							style="font-size: 25px; color: rgb(71, 150, 255);">0</span>
					</h4>
				</div>
				<div style="display: flex; justify-content: space-between;">
				<button id="reset">다시 담기</button>
				<button id="goOrder">주문 하기</button>
				</div>
			</div>
		</div>
	</div>
	<!------------------------------ footer 불러오기 --------------------------->
	<jsp:include page="/WEB-INF/views/nav/footer.jsp" />

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
	<script>
	let orderList = [];
	let amountList = [];
	let orderMenu={};
	let amount = 0;
	let tableNum = ${tableNum };
	let emptySeat = [];
	emptySeat.push(${sDto.emptySeat });
	let notEmptySeat = [];
	notEmptySeat.push(${sDto.notEmptySeat });
	let index1 = emptySeat.indexOf(tableNum); 
	if (index1 > -1) {
		emptySeat.splice(index1,1);
	} else {
		alert("이미 이용중인 자리 입니다. 다시 선택해 주세요!");
		location.href="${pageContext.request.contextPath}/store/storeDetail.do?num=${dto.num}";
	}
	let index2 = notEmptySeat.indexOf(tableNum); 
	if (index2 <= -1) {
		notEmptySeat.push(tableNum);
	};
	let objSeat = {num:${dto.num }, emptySeat:emptySeat.toString(), notEmptySeat:notEmptySeat.toString()};
	// 다시담기
	document.querySelector("#reset").addEventListener("click",function(){
		orderList = [];
		amountList = [];
		amount=0;
		document.querySelector("#amount").innerText=amount;
		const orderParent = document.querySelector("#orderList");
		while (orderParent.hasChildNodes()) {	
			orderParent.removeChild(orderParent.firstChild );
		}
	});
	
	let allMenu = document.querySelectorAll(".orderMenu");
	for(let i=0; i<allMenu.length; i++){
		allMenu[i].addEventListener("submit",function(e){
			e.preventDefault();
			let orderNum = this.orderNum.value;
			let email = String(this.email.value);
			let storeName = this.storeName.value;
			let storeLogo = this.storeLogo.value;
			let tableNum = this.tableNum.value;
			let num = this.num.value;
			let menu = this.menu.value;
			let menuCount = this.menuCount.value;
			let a = Number(this.price.value);
			let b = Number(this.menuCount.value);
			let price = a*b;
			
			let span = document.createElement('span');
			span.setAttribute('class','orderMenuList col-4');
			span.innerText=menu;
			document.querySelector("#orderList").appendChild(span);
			
			let span2 = document.createElement('span');
			span2.setAttribute('class','orderMenuCount col-2');
			span2.innerText=" "+menuCount+"개 ";
			document.querySelector("#orderList").appendChild(span2);
			
			let span3 = document.createElement('span');
			span3.setAttribute('class','orderMenuPrice col-3');
			span3.innerText=(price.toString()
			  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))+"원";
			document.querySelector("#orderList").appendChild(span3);
			
			let newDiv=document.createElement("div");
			newDiv.setAttribute('class', 'row menuListWrapper');
			newDiv.appendChild(span);
			newDiv.appendChild(span2);
			newDiv.appendChild(span3);
			document.querySelector("#orderList").appendChild(newDiv);
			
			let br = document.createElement('br');
			document.querySelector("#orderList").appendChild(br);
			
			

			orderMenu = {orderNum,email,storeName,storeLogo,num,tableNum,menu,menuCount,price};
			
		//	let two = orderList.indexOf(orderMenu.menu);
			orderList.push(orderMenu);
			let priceInt = Number(price);
			amountList.push(priceInt);
			document.querySelector("#amount").innerText='';
			amount=0;
			amountList.forEach( (item) => {
			  amount += item;
			});
			
			document.querySelector("#amount").innerText=(amount.toString()
					  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))+" 원";
		});
	}
	
	// 주문하기
	document.querySelector("#goOrder").addEventListener("click",function(){
		//주문할때 시간정보전달
		let today = new Date();
		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 일
		let day; // 요일
		if(today.getDay()==0){ day="일요일" }
		else if(today.getDay()==1){ day="월요일"}
		else if(today.getDay()==2){ day="화요일"}
		else if(today.getDay()==3){ day="수요일"}
		else if(today.getDay()==4){ day="목요일"} 
		else if(today.getDay()==5){ day="금요일"}
		else if(today.getDay()==6){ day="토요일"}
		let hours = today.getHours(); // 시
		let minutes = today.getMinutes(); //분
		let regdate = year + " 년 " + month + " 월 " + date + " 일 " + day + " " + hours + " 시 " + minutes+ " 분";
		let jsonData = {};
		for(let i=0; i<orderList.length; i++){
			//주문할때 시간정보 regdate로 넣어주기
			orderList[i].regdate=regdate;
			// {orderNum:"123",email:"123",storeName:"근영식당",storeLogo:"/images/kim1.png",num:"201",tableNum:"1",menu:"보리굴비",menuCount:"1",price:"13000"}
			orderList[i].amount=amount;
			
			jsonData[i] = orderList[i];
			if(i == orderList.length-1){
				jsonData[i+1] = objSeat;
			}
		}

		let url = "${pageContext.request.contextPath}/order/insert.do";
		let promise = fetch(url,{
			method:"POST",
			headers:{"Content-Type":"application/json"},
			body: JSON.stringify(jsonData)
		});
		
		promise.then(function(response){
			return response.json();
		}).then(function(data){
			if(data.isSuccess){
				swal("주문 완료!", "마이페이지에서 주문상태를 확인해주세요.!", "success")
				.then(function(){
					location.href="${pageContext.request.contextPath}/main.do?area=&keyword=";
				});
			} else {
				alert("주문에 실패했습니다. 문제가 반복된다면 문의 바랍니다.");
			}
		});		
	})
</script>
</body>
</html>