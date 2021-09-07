<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<!-- 스타일 링크 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/order.css"
	type="text/css" />
<!-- 타이틀 로고 -->
<link rel="shortcut icon" type="image⁄x-icon"
	href="${pageContext.request.contextPath}/resources/img/summer.jpg">

<style>
	/* 주문하기 옆에 위치한 전 페이지로 이동하는 버튼 css */
	#backBtn {
		border: none;
		background-color: white;
	}
	
	/* 메뉴 카테고리 css */
	#categories {
		display: flex;
		margin-top: 20px;
	}
	
	#categories a {
		margin-left: 15px;
		text-decoration: none;
		color: black;
		font-size: 30px;
	}
	
	#categories a:hover, a:focus {
		padding-bottom: 5px;
		border-bottom: 3px solid rgb(114, 149, 255);
		color: #636363;
	}
	
	/* 메뉴 이름 버튼 css */
	#orderMenu {
		border: none;
		background-color: rgb(176, 215, 252); 
		color: rgb(104, 104, 104);
		font-weight: bold;
	}
	
	/* 메뉴 정보가 보이는 카드 css */
	.card {
		width: 100% !important;
		height: 400px !important;
		overflow: auto;
	}
	
	/* 주문내역 영수증 문구 위치 및 모양 css */
	.orderR {
 		position: relative;
 		margin-left: 180px;
	}

	.orderR .text_top {
  		position: absolute;
  		top: 50px;
  		left: 90px;
	}
	
	.text_top {
		display: flex;
	}
	
	.text_middle {
		position: absolute;
		top: 120px;
		left: 100px;
	}
	
	.text_bottom {
		position: absolute;
		bottom: 200px;
		right: 180px;
	}
	
	/* 다시담기 버튼 css */
	#reset {
  		position: absolute;
  		bottom: 130px;
  		left : 90px;
  		background-color: #fc5555;
  		border: none;
  		color: #ffffff;
  		cursor: pointer;
	 	display: inline-block;
  		font-size: 22px;
  		line-height: 1em;
	  	outline: none;
	  	padding: 12px 30px 10px;
	  	text-transform: uppercase;
	  	font-weight: 700;
	}
	
	#reset:before,
	#reset:after {
  		border-color: transparent;
	  	-webkit-transition: all 0.25s;
	  	transition: all 0.25s;
	  	border-style: solid;
	  	border-width: 0;
	  	content: "";
	  	height: 24px;
	  	position: absolute;
	  	width: 24px;
	}
	#reset:before {
  		border-color: #fc5555;
  		border-right-width: 2px;
  		border-top-width: 2px;
  		right: -5px;
  		top: -5px;
	}
	#reset:after {
	  	border-bottom-width: 2px;
	  	border-color: #fc5555;
	  	border-left-width: 2px;
	  	bottom: -5px;
	  	left: -5px;
	}
	#reset:hover,
	#reset.hover {
  		background-color: #fc5555;
	}
	#reset:hover:before,
	#reset.hover:before,
	#reset:hover:after,
	#reset.hover:after {
  		height: 100%;
 	 	width: 100%;
	}
	
	/* 주문하기 버튼 css */
	#goOrder {
		position: absolute;
  		bottom: 130px;
  		right : 120px;
  		background-color: #fc5555;
  		border: none;
  		color: #ffffff;
  		cursor: pointer;
	 	display: inline-block;
  		font-size: 22px;
  		line-height: 1em;
	  	outline: none;
	  	padding: 12px 30px 10px;
	  	text-transform: uppercase;
	  	font-weight: 700;
	}
	
	#goOrder:before,
	#goOrder:after {
  		border-color: transparent;
	  	-webkit-transition: all 0.25s;
	  	transition: all 0.25s;
	  	border-style: solid;
	  	border-width: 0;
	  	content: "";
	  	height: 24px;
	  	position: absolute;
	  	width: 24px;
	}
	#goOrder:before {
  		border-color: #fc5555;
  		border-right-width: 2px;
  		border-top-width: 2px;
  		right: -5px;
  		top: -5px;
	}
	#goOrder:after {
	  	border-bottom-width: 2px;
	  	border-color: #fc5555;
	  	border-left-width: 2px;
	  	bottom: -5px;
	  	left: -5px;
	}
	#goOrder:hover,
	#goOrder.hover {
  		background-color: #fc5555;
	}
	#goOrder:hover:before,
	#goOrder.hover:before,
	#goOrder:hover:after,
	#goOrder.hover:after {
  		height: 100%;
 	 	width: 100%;
	}
	
	/* 메뉴 수량 input 박스 css*/
	#menuCount {
		text-align-last: center;
      	text-align: center;
      	border: none;
      	border-radius: 7px;
      	font-size: 20px;
      	font-weight: bold;
      	color: rgb(104, 104, 104);
	}
	
	#menuCount:focus {
		outline: none;
	}
	
	
</style>
</head>
<body style="margin-top:150px;">
	<jsp:include page="/WEB-INF/views/nav/navbar.jsp" />
	<div class="container">
		<div class="container">
			<button id="backBtn"
				onclick="location.href='javascript:history.back();'">
				<img src="${pageContext.request.contextPath}/resources/img/back.png"
					alt="back" style="margin-bottom: 15px; width: 48px; height: 50px;" />
			</button>
			<span style="font-size: 2.5em;">주문하기</span> 
			<span style="margin-left: 20px; font-size: 20px; color: rgb(89, 89, 89);">${dto.storeName }에서 ${tableNum }번 자리 👨‍🍳
			</span>
		</div>
		<div class="order">
			<section>
				<!------ 카테고리에 따라 메뉴 다르게 보이기 ------->
				<ul id="categories">
					<li><a
						href="${pageContext.request.contextPath}/order/order.do?num=${dto.num}&storeName=${dto.storeName}">전체</a>
					</li>
					<c:forEach var="tmp" items="${categoryList }">
						<li data-num="${dto.num }" class="category"><a
							href="${pageContext.request.contextPath}/order/order.do?num=${dto.num}&storeName=${dto.storeName}&category=${tmp}">${tmp }</a></li>
					</c:forEach>
				</ul>
				
				<!----------------- 주문페이지에서 메뉴 고르기 ------------------>
				<div class="row">
					<div class="col text-center" style="margin-top: 45px;">
						<div class="row row-cols-1 row-cols-md-2 g-4" style="width:100%; height: 800px; !important; overflow: auto;">
							<c:forEach var="tmp" items="${menuList }">
								<c:if test="${tmp.best == 'yes' }">
									<form class="orderMenu" action="${pageContext.request.contextPath}/order/insert.do">
										<input type="hidden" name="orderNum" value="${orderNum }" />
									 	<input type="hidden" name="email" value="${email }" /> 
									 	<input type="hidden" name="storeName" value="${dto.storeName }" /> 
										<input type="hidden" name="storeLogo" value="${dto.image_logo }" /> 
										<input type="hidden" name="menu" value="${tmp.menuName }" /> 
										<input type="hidden" name="tableNum" value="${tableNum }" /> 
										<input type="hidden" name="price" value="${tmp.price}" /> 
										<input type="hidden" name="num" value="${dto.num }" />
										
										<div class="col">
											<div class="card">
												<img src="${pageContext.request.contextPath}${tmp.menuImage }" class="card-img-top" alt="menuImage">
												<div class="card-body" style="background-color: rgb(176, 215, 252); color: rgb(104, 104, 104); font-weight: bold;">
													<h5 class="card-title"><button type="submit" id="orderMenu">${tmp.menuName }</button></h5>
													<p class="card-text">${tmp.price } ￦</p>
													<input type="number" id="menuCount" name="menuCount" min="1" max="9" value="1">
												</div>
											</div>
										</div>
									</form>
								</c:if>
							</c:forEach>
						</div>
					</div>
					
					<!--------------------------- 주문내역 영수증 ---------------------------->
					<div class="col orderR" style="margin-top: 45px;">
						<img src="${pageContext.request.contextPath}/resources/img/p.svg" alt="receipt"
					 		style="width: 90%; height: 700px;">
			 			<div class="text_top">
							<h3>메뉴</h3>
							<h3 style="margin-left: 90px;">수량</h3>
							<h3 style="margin-left: 110px;">금액</h3>
						</div>
						<div class="text_middle">
							<h5 id="orderList"></h5>
						</div>
    					<div class="text_bottom">
	      					<h4>
								총 결제 금액 <span id="amount" style="font-size: 25px; color: rgb(71, 150, 255);">0</span>
							</h4>
    					</div>
						<button id="reset">다시 담기</button>
						<button id="goOrder">주문 하기</button>
					</div>
				</div>
				
				
				<!--
				<h3>베스트 메뉴</h3> 
				<div>
					<c:forEach var="tmp" items="${menuList }">
						<c:if test="${tmp.best == 'yes' }">
							<form class="orderMenu" action="${pageContext.request.contextPath}/order/insert.do">
								<input type="hidden" name="orderNum" value="${orderNum }" />
							 	<input type="hidden" name="email" value="${email }" /> 
							 	<input type="hidden" name="storeName" value="${dto.storeName }" /> 
								<input type="hidden" name="storeLogo" value="${dto.image_logo }" /> 
								<input type="hidden" name="menu" value="${tmp.menuName }" /> 
								<input type="hidden" name="tableNum" value="${tableNum }" /> 
								<input type="hidden" name="price" value="${tmp.price}" /> 
								<input type="hidden" name="num" value="${dto.num }" />
								<button type="submit" id="orderMenu">${tmp.menuName }</button>
								<input type="number" name="menuCount" min="1" max="9" value="1">
							</form>
						</c:if>
					</c:forEach>
				</div>
				-->
				<!--
				<h3>전체 메뉴</h3>

				<div>
					<c:forEach var="tmp" items="${menuList }">
						<form class="orderMenu" action="${pageContext.request.contextPath}/order/insert.do">
							<input type="hidden" name="orderNum" value="${orderNum }" />
							<input type="hidden" name="email" value="${email }" />
							<input type="hidden" name="storeName" value="${dto.storeName }" /> 
							<input type="hidden" name="storeLogo" value="${dto.image_logo }" /> 
							<input type="hidden" name="menu" value="${tmp.menuName }" />
							<input type="hidden" name="tableNum" value="${tableNum }" /> 
							<input type="hidden" name="price" value="${tmp.price}" /> 
							<input type="hidden" name="num" value="${dto.num }" />
							<button type="submit" id="orderMenu">${tmp.menuName }</button>
							<input type="number" name="menuCount" min="1" max="9" value="1">
						</form>
					</c:forEach>
				</div>
			</section>
			
			<section>
				<h2>주문 목록</h2>

				<div id="orderList"></div>
				<div>
					<p>
						총 결제 금액: <span id="amount" style="font-size: 30px;">0</span>
					</p>
				</div>
				<div>
					<button id="reset">다시 담기</button>
				</div>
				<div>
					<button id="goOrder">주문하기</button>
				</div>

			</section>
			-->
		</div>
	</div>
		<!------------------------------ footer 불러오기 --------------------------->
		<jsp:include page="/WEB-INF/views/nav/footer.jsp" />

	<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
	<script>
	let orderList = [];
	let amountList = [];
	let orderMenu={};
	let amount = 0;
	
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
			span.setAttribute('class','orderMenuList');
			span.innerText=menu;
			document.querySelector("#orderList").appendChild(span);
			
			let span2 = document.createElement('span');
			span2.setAttribute('class','orderMenuCount');
			span2.innerText=" "+menuCount+"개 ";
			document.querySelector("#orderList").appendChild(span2);
			
			let span3 = document.createElement('span');
			span3.setAttribute('class','orderMenuPrice');
			span3.innerText=(price.toString()
			  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))+"원";
			document.querySelector("#orderList").appendChild(span3);
			
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
		for(let i=0; i<orderList.length; i++){
			//주문할때 시간정보 regdate로 넣어주기
			orderList[i].regdate=regdate;
			// {orderNum:"123",email:"123",storeName:"근영식당",storeLogo:"/images/kim1.png",num:"201",tableNum:"1",menu:"보리굴비",menuCount:"1",price:"13000"}
			orderList[i].amount=amount;
			ajaxPromise("${pageContext.request.contextPath}/order/insert.do","post",orderList[i])
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				if(data.isSuccess && i==orderList.length-1){
					alert("주문이 완료 되었습니다.");
					location.href="${pageContext.request.contextPath}/main.do";
					
				}
			});
		}
	})
</script>
</body>
</html>