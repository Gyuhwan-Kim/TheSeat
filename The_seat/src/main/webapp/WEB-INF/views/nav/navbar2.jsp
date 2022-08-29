<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;500&display=swap"
	rel="stylesheet">

<style>

body {
	font-family: 'IBM Plex Sans KR', sans-serif;
	background-color: #598eff;
	display: flex;
	justify-content: center;
	align-items: center;
}

.nav_icon {
	color: white;
}

.navbarTwo {
	width: 30%;
	padding-bottom: 30px;
	display: flex;
	justify-content: space-between;
	flex-direction: row;
}

#home {
	cursor: pointer;
}

.nav-link, .store, #addBtn0 {
	color: black;
	text-decoration: none;
}

.offcanvas {
	transform: translateX(100%);
	transition: transform 0.5s ease-out;
	background-color: #fff;
	box-shadow: -5px 0 10px #fff;
}

.offcanvas h5 {
	color: #000;
	margin-top: 20px;
	display: inline-block;
	width: 100%;
	text-align: center;
}

.offcanvas a {
	text-decoration: none;
	font-size: 25px;
	font-weight: 500;
	color: #3fa2ff;
	display: block;
	transition: 0.3s ease-in-out;
	display: inline-block;
}

.offcanvas .a1:hover {
	color: #000;
	transform: scale(1.3);
	-webkit-transform: scale(1.3);
	font-weight: 500;
}

.offcanvas .a2:hover {
	color: #000;
	transform: scale(1.3);
	-webkit-transform: scale(1.3);
	font-weight: 500;
}

#dropdownMenuLink:hover {
	color: #000;
	font-weight: 500;
}

.offcanvas ul .li_ {
	list-style: none;
	text-align: center;
	box-shadow: 1px 1px 11px rgba(172, 172, 172, 0.699);
	width: 200px;
	margin-left: 50px;
}

.offcanvas ul .li2 {
	list-style: none;
	text-align: center;
	width: 200px;
	margin-left: 50px;
}

.list_:hover {
	transform: scale(1.3);
	-webkit-transform: scale(1.3);
}

#logoutBtn {
	margin: auto;
	width: 300px;
	height: 45px;
	color: #fff;
	border-radius: 5px;
	padding: 10px 25px;
	font-size: 25px;
	font-weight: 500;
	background: transparent;
	cursor: pointer;
	transition: all 0.3s ease;
	position: relative;
	display: inline-block;
	box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, .5), 7px 7px 20px
		0px rgba(0, 0, 0, .1), 4px 4px 5px 0px rgba(0, 0, 0, .1);
	outline: none;
	position: relative;
	right: 20px;
	bottom: 20px;
	border: none;
	box-shadow: none;
	line-height: 42px;
	-webkit-perspective: 230px;
	perspective: 230px;
}

#logoutBtn span {
	background: rgb(0, 172, 238);
	background: -webkit-linear-gradient(rgba(0, 172, 238, 1) 0%,
		rgba(2, 126, 251, 1) 100%);
	background: -moz-linear-gradient(rgba(0, 172, 238, 1) 0%,
		rgba(2, 126, 251, 1) 100%);
	background: -o-linear-gradient(rgba(0, 172, 238, 1) 0%,
		rgba(2, 126, 251, 1) 100%);
	background: -webkit-gradient(linear, 0 0, 0 100%, from(rgba(0, 172, 238, 1)),
		to(rgba(2, 126, 251, 1)));
	background: linear-gradient(rgba(0, 172, 238, 1) 0%,
		rgba(2, 126, 251, 1) 100%);
	display: block;
	position: absolute;
	width: 300px;
	height: 45px;
	box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, .5), 7px 7px 20px
		0px rgba(0, 0, 0, .1), 4px 4px 5px 0px rgba(0, 0, 0, .1);
	border-radius: 5px;
	margin: 0;
	text-align: center;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-transition: all .3s;
	transition: all .3s;
}

#logoutBtn span:nth-child(1) {
	box-shadow: -7px -7px 20px 0px #fff9, -4px -4px 5px 0px #fff9, 7px 7px
		20px 0px #0002, 4px 4px 5px 0px #0001;
	-webkit-transform: rotateX(90deg);
	-moz-transform: rotateX(90deg);
	transform: rotateX(90deg);
	-webkit-transform-origin: 50% 50% -20px;
	-moz-transform-origin: 50% 50% -20px;
	transform-origin: 50% 50% -20px;
}

#logoutBtn span:nth-child(2) {
	-webkit-transform: rotateX(0deg);
	-moz-transform: rotateX(0deg);
	transform: rotateX(0deg);
	-webkit-transform-origin: 50% 50% -20px;
	-moz-transform-origin: 50% 50% -20px;
	transform-origin: 50% 50% -20px;
}

#logoutBtn:hover span:nth-child(1) {
	box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, .5), 7px 7px 20px
		0px rgba(0, 0, 0, .1), 4px 4px 5px 0px rgba(0, 0, 0, .1);
	-webkit-transform: rotateX(0deg);
	-moz-transform: rotateX(0deg);
	transform: rotateX(0deg);
}

#logoutBtn:hover span:nth-child(2) {
	box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, .5), 7px 7px 20px
		0px rgba(0, 0, 0, .1), 4px 4px 5px 0px rgba(0, 0, 0, .1);
	color: transparent;
	-webkit-transform: rotateX(-90deg);
	-moz-transform: rotateX(-90deg);
	transform: rotateX(-90deg);
}

.footer-icons a {
	display: inline-block;
	width: 35px;
	height: 35px;
	cursor: pointer;
	background-color: #92c0fc;
	border-radius: 2px;
	font-size: 25px;
	color: #fff;
	text-align: center;
	line-height: 35px;
	margin-right: 10px;
	margin-bottom: 5px;
	border-radius: 2px;
}

.footer-icons a:hover {
	transform:scale(1.3);
	-webkit-transform:scale(1.3);
}

</style>

<nav class="navbarTwo">

	<i class="fas fa-home fa-2x nav_icon" id="home"></i>

	<button id="bars" data-bs-toggle="offcanvas"
		data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
		<i class="fas fa-bars fa-2x nav_icon"></i>
	</button>

	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar"
		aria-labelledby="offcanvasNavbarLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="offcanvasNavbarLabel">
				<c:choose>
					<c:when test="${email ne null }">
						<img id="userProfile" alt="프로필 이미지"
							style="width: 60px; height: 60px; border-radius: 100%;">
						<span id="userName" style="font-weight: bold; font-size: 33px;"></span> 님 로그인 중..
               		</c:when>
					<c:otherwise>
						<span style="color: #000; font-size: 1.8em;">반갑습니다 😊</span>
					</c:otherwise>
				</c:choose>
			</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<ul>
				<li class="li_" style="margin-top: 20px;"><c:choose>
						<c:when test="${email ne null }">
							<a class="a1"
								href="${pageContext.request.contextPath}/users/info.do"
								style="line-height: 2.5;">마이페이지</a>
						</c:when>
						<c:otherwise>
							<a class="a1"
								href="${pageContext.request.contextPath}/users/loginform.do"
								style="line-height: 2.5;">로그인</a>
						</c:otherwise>
					</c:choose></li>

					<c:if test="${email != null}">
						<div class="dropdown" style="margin-top: 30px;">
							<a class="dropdown-toggle" href="#" role="button"
								id="dropdownMenuLink" data-bs-toggle="dropdown"
								aria-expanded="false"
								style="box-shadow: 1px 1px 11px rgba(172, 172, 172, 0.699); width: 200px; margin-left: 50px; line-height: 2.5; text-align: center;">
								매장 목록 </a>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"
								style="text-align: center; width: 200px; height: 200px; overflow: auto;">
							</ul>
						</div>
					</c:if>
				
				<div style="margin-top: 220px;">
				
				<div class="footer-icons">
					<section style="text-align: center; margin-right: 30px;">
						<a href="https://www.facebook.com/"><i class="fa fa-facebook"></i></a>
						<a href="https://www.google.co.kr/"><i class="fa fa-google"></i></a>
						<a href="https://kr.linkedin.com/"><i class="fa fa-linkedin"></i></a>
						<a href="https://github.com/Keunyeong/The_seat"><i
							class="fa fa-github"></i></a>
					</section>
				</div>
					
				<c:if test="${email ne null }">
					<li style="list-style: none; margin-top: 20px;">
						<button type="button" id="logoutBtn"
							onclick="location.href='${pageContext.request.contextPath}/users/logout.do'">
							<span>정말로 나가실건가요 ? </span><span>로그아웃</span>
						</button>
					</li>
				</c:if>
				<c:if test="${email != null }">
					<li class="li2" style="margin-top: 20px;"><a class="a2"
						data-num="0" id="addBtn0" href="#" style="line-height: 2.5;"><img
							src="${pageContext.request.contextPath}/resources/img/add2.PNG"
							style="width: 40px; height: 40px;" alt="추가버튼" /> 매장 추가</a></li>
				</c:if>
				<div class="container" style="margin-top: 30px; text-align: center;">
				<c:if test="${sessionScope.email ne null }">
						<button id="manageStore">매장관리</button>
						<button id="manageMenu1">메뉴관리</button>
						<button id="storeReview1">리뷰관리</button>
						<br />
						<button id="storeOrder1">주문확인</button>
						<button id="storeSeat1">자리관리</button>
				</c:if>
				</div>
				</div>
			</ul>
		</div>
	</div>
</nav>
<script
	src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://kit.fontawesome.com/2ebe86210e.js"
	crossorigin="anonymous"></script>
<script>
	document.querySelector("#manageStore").addEventListener("click",function(){
		location.href="${pageContext.request.contextPath}/store/myStore.do?num=${num}";
	});
	document.querySelector("#manageMenu1").addEventListener("click",function(){
		location.href="${pageContext.request.contextPath}/store/manageMenu.do?num=${num}";
	});
	document.querySelector("#storeReview1").addEventListener("click",function(){
		location.href="${pageContext.request.contextPath}/store/storeReview.do?num=${num}";
	});
	document.querySelector("#storeOrder1").addEventListener("click",function(){
		location.href="${pageContext.request.contextPath}/store/storeOrder.do?num=${num}";
	});
	document.querySelector("#storeSeat1").addEventListener("click",function(){
		location.href="${pageContext.request.contextPath}/store/storeSeat.do?num=${num}";
	});
   if(${sessionScope.email ne null }){
      // session 정보로 이름 정보 가져오기
      ajaxPromise("${pageContext.request.contextPath}/users/getData.do").then(
            function(response) {
               return response.json()
            }).then(function(data) {
         document.querySelector("#userName").innerText = data.dto.name;
         if(data.dto.profile == 'profile'){
        	 document.querySelector("#userProfile").setAttribute("src","${pageContext.request.contextPath}/resources/img/user1.png");
        	 document.querySelector("#userProfile").setAttribute('style','width: 55px; height: 50px;');
         }else{
        	 document.querySelector("#userProfile").setAttribute("src","${pageContext.request.contextPath}"+data.dto.profile);
         }
      });
      
      let storePath = "${pageContext.request.contextPath}/store/manage/myStore.do?num=";
      
      // 매장 관리 페이지로의 이동을 위한 항목 만들기
      let url = "${pageContext.request.contextPath}/store/getMyStores.do";
      let promise = fetch(url, {
			method: "POST",
			headers: {"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"}
      });
      
      promise.then(function(response){
    	  return response.json();
      }).then(function(data){
    	  if(data.length == 0){
    		  document.querySelector(".dropdown").remove();
    	  } else {
        	  let ul = document.querySelector(".dropdown-menu");
    		  data.forEach((tmp) => {
    				  let li = document.createElement("li");
    				  let anchor = document.createElement("a");
    				  anchor.setAttribute("class", "list_");
    				  anchor.setAttribute("style", "color: rgb(71, 71, 71);");
    				  anchor.setAttribute("href", storePath + tmp.num);
    				  anchor.innerText = tmp.storeName;
    				  li.appendChild(anchor);
    				  ul.appendChild(li);
    		  });  
    	  }
      });
   }
   
   document.querySelector("#home").addEventListener("click", function() {
      location.href = "${pageContext.request.contextPath}/main.do?area=&keyword=";
   });
   
   
   // 매장 추가 관리 영역
   let dataNum = 0;
   
   document.querySelector("#addBtn0").addEventListener("click", function(e) {
      // 일단 링크 이동을 막고
      e.preventDefault();
      // 매장 추가 여부를 확인하고
      let callAdd = confirm("매장을 추가하시겠습니까?");
      // 확인을 눌렀다면
      if (callAdd) {
         dataNum++;
         let strDataNum = dataNum.toString();
         
         // ajax 응답으로 새 매장 정보를 DB에 추가
         
         ajaxPromise("${pageContext.request.contextPath}/newStore.do")
         .then(function(response){
            return response.json();
         }).then(function(data){
         });
         
         
         let newAnchor = document.createElement("a");
         newAnchor.innerText = "Default Name";
         newAnchor.setAttribute("data-num", dataNum);
         newAnchor.setAttribute("class", "store");
         
         newAnchor.setAttribute("id", "addBtn" + strDataNum);
         document.querySelector(".toggle").appendChild(newAnchor);
         resetDataNum();
      }
   });
   
   // 전체의 data-num을 조정하는 function
   function resetDataNum() {
      let array = document.querySelectorAll("a[class='store']");
      for (let i = 0; i < array.length; i++) {
         let num=i+1;
         array[i].setAttribute("data-num", num);
         array[i].setAttribute("href", storePath + num);
      }
   }   
</script>