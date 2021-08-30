<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>storeDetail.jsp</title>
<!-- 외부 css 링크 로딩하기 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>
<style>
input {
	text-align: center;
}

#reviewBtn {
	background-color: #2e8eff;
	color: white;
	margin-top: 10px;
	width: auto;
	height: 40px;
	border-radius: 10px;
	border: none;
}

#seatBtn {
	background-color: #2e8eff;
	color: white;
	margin-top: 30px;
	width: auto;
	height: 60px;
	border-radius: 10px;
	border: none;
}

#menuBtn {
	background-color: white;
	border: none;
	font-size: 1.5em;
	font-wight: bolder;
	color: rgb(96, 92, 99);
}
</style>
</head>
<body>
	<div class="container">
		<!---------------------- 네비바를 import 한다. ------------------------->
		<jsp:include page="nav/navbar.jsp" />
		<section class="gap-2 col-3 mx-auto">
			<!---------------------- DB 연동해서 파라미터 값으로 칼럼 값을 받아온다.  --------------------->
			<img src="${pageContext.request.contextPath}${dto.image_logo }"
				alt="storeLogo" width="60px;" /> <span
				style="font-size: 2.5em; font-weight: bold; color: rgb(85, 152, 252); text-shadow: 2px 6px 2px #d3d3d3; text-align: center;">${dto.storeName }</span>
		</section>
		<div class="row">
			<!--------------------- 매장의 베스트 메뉴 4가지를 Carousel 로 띄우기  -------------------------->
			<div id="carouselExampleDark"
				class="col carousel carousel-dark slide" data-bs-ride="carousel"
				style="width: 500px; margin-top: 50px; margin-bottom: 30px;">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="3" aria-label="Slide 4"></button>
				</div>
				<div class="carousel-inner" style="min-height: 500px;">
					<div class="carousel-item active" data-bs-interval="10000">
						<img src="${pageContext.request.contextPath}${dto.image_1 }"
							class="d-block w-100" alt="FirstBestmenu">
						<div class="carousel-caption d-none d-md-block">
							<h5>First Best Menu</h5>
						</div>
					</div>
					<div class="carousel-item" data-bs-interval="2000">
						<img src="${pageContext.request.contextPath}${dto.image_2 }"
							class="d-block w-100" alt="SecondBestmenu">
						<div class="carousel-caption d-none d-md-block">
							<h5>Second Best Menu</h5>
						</div>
					</div>
					<div class="carousel-item">
						<img src="${pageContext.request.contextPath}${dto.image_3 }"
							class="d-block w-100" alt="ThirdBestmenu">
						<div class="carousel-caption d-none d-md-block">
							<h5>Third Best Menu</h5>
						</div>
					</div>
					<div class="carousel-item">
						<img src="${pageContext.request.contextPath}${dto.image_4 }"
							class="d-block w-100" alt="ThirdBestmenu">
						<div class="carousel-caption d-none d-md-block">
							<h5>Fourth Best Menu</h5>
						</div>
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
				
			<!------------------------------ 매장 상세 정보 카드 ----------------------------------->
			</div>
			<div class="col card text-center"
				style="width: 100px; margin-top: 30px; margin-bottom: 30px; margin-left: 90px; border: none;">
				<!-- 파라미터 값으로 매장 정보를 받아온다. -->
				<section class="d-grid gap-2 col-12 mx-auto"
					style="margin-top: 60px;">
					<div class="card-header bg-transparent border-dark-light">
						<h5>별점 : ⭐ 4.9 (100+)</h5>
						<h3>${dto.storeTag }</h3>
					</div>
					<div class="card-body">
						<h5 class="card-title">
							주소 : <span>${dto.storeAddr }</span>
						</h5>
						<h5 class="card-title">
							운영 시간 : <span>${dto.openingTime }</span>
						</h5>
						<h5 class="card-title">남은 자리 : 6 / 8</h5>
						<button type="button" class="btn btn-primary" id="reviewBtn"
							data-bs-toggle="modal" data-bs-target="#staticBackdrop">리뷰
							: 123개</button>
					</div>
					<div class="card-footer bg-transparent border-dark-light">
						<button type="button" id="seatBtn" data-bs-toggle="modal"
							data-bs-target="#Modalgrid">자리 잡으러 가기 ❕</button>
					</div>
				</section>
			</div>

			<!------------------------------ 리뷰 보기 Modal -------------------------------->
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
				data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="staticBackdropLabel">리뷰 보기 ⭐</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="card mb-3" style="max-width: 540px; border: none;">
								<div class="row g-0">
									<div class="col-md-4">
										<h5>신현미 님</h5>
										<!-- <p>★★★★★ 등록일 : 2021.08.19</p> -->
										<img
											src="${pageContext.request.contextPath}/resources/img/review1.jpg"
											class="img-fluid rounded-start" alt="TwosomeReview">
									</div>
									<div class="col-md-8">
										<div class="card-body">
											<h5 class="card-title">★★★★★</h5>
											<p class="card-text">케이크가 정말 맛있어요 ๑❤‿❤๑</p>
											<p class="card-text">
												<small class="text-muted">등록일 : 2021.08.19</small>
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<hr />
						<div class="modal-body">...</div>
						<hr />
						<div class="modal-body">...</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">창닫기</button>
						</div>
					</div>
				</div>
			</div>

			<!--------------------------------- 자리 잡기 Modal --------------------------------->
			<div class="modal fade" id="Modalgrid" tabindex="-1" role="dialog"
				aria-labelledby="Modalgrid" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="ModalLabel">
								${dto.storeName } <br />( 6 / 8 )
							</h5>
							<p>자리를 선택해 주세요!</p>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="container-fluid">
								<div class="gridmodal">
									<div class="row">
										<div class="col-md-4">
											<input class="form-control" placeholder="1" aria-label="City"
												disabled>
										</div>
										<div class="col-md-4 ml-auto">
											<input class="form-control" placeholder="2" aria-label="City"
												disabled>
										</div>
									</div>
									<div class="row">
										<div class="col-md-3 ml-auto">
											<input class="form-control" placeholder="3" aria-label="City"
												disabled>
										</div>
										<div class="col-md-2 ml-auto">
											<input class="form-control" placeholder="4" aria-label="City"
												disabled>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 ml-auto">
											<input class="form-control" placeholder="5" aria-label="City"
												disabled>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-9">
											<input class="form-control" placeholder="6" aria-label="City"
												disabled>
											<div class="row">
												<div class="col-8 col-sm-6">
													<input class="form-control" placeholder="7"
														aria-label="City" disabled>
												</div>
												<div class="col-4 col-sm-6">
													<input class="form-control" placeholder="8"
														aria-label="City" disabled>
												</div>
											</div>
										</div>
									</div>
								</div>
								<hr />
								<!------------------- Modal 에서 선택한 자리 정보를 주문 페이지에 get 방식으로 값을 전달해준다. ----------------->
								<form action="${pageContext.request.contextPath}/order.do"
									method="get">
									<p>
										자리 선택 <select name="자리 선택" id="seatChoice">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
										</select>
									</p>
								</form>
								<hr />
								<div class="card">
									<div class="card-header">✦ 알림사항</div>
									<div class="card-body">
										<p class="card-text">5, 6번 좌석은 4인 이상부터 이용이 가능합니다.</p>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">창닫기</button>
							<button type="button" class="btn btn-warning"
								onclick="location.href='${pageContext.request.contextPath}/order.do'">주문하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!---------------------------------------- 메뉴판 만들기 ------------------------------------------->
		<div class="card mb-5"
			style="max-width: auto; height: 700px; margin-top: 30px; background-color: rgb(86, 162, 255);">
			<span
				style="color: white; font-size: 45px; text-shadow: 2px 6px 2px gray; margin-left: 85px; margin-top: 25px;">Menu</span>
			<div class="card mb-5"
				style="max-width: 1130px; height: 600px; margin-top: 30px; margin-left: 80px; border-radius: 10px; background-color: white;">
				<div class="col">
					<c:forEach var="tmp" items="${list }">
						<button data-num="${tmp.num }" type="button" id="menuBtn"
							data-bs-toggle="modal" data-bs-target="#exampleModal"
							style="width: 400px; margin-left: 70px; margin-top: 50px;">${tmp.menuName }</button>
						<span
							style="width: 300px; margin-left: 300px; font-size: 1.5em; color: rgb(96, 92, 99);">${tmp.price }</span>
					</c:forEach>
				</div>
			</div>
		</div>

		<!-------------------------------- 메뉴 이름 누르면 그에 맞는 이미지 Modal 활성화 -------------------------------->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"></h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="card" style="width: 18rem;">
							<img src="${pageContext.request.contextPath}"
								class="card-img-top" alt="MenuImage">
							<div class="card-body">
								<p class="card-text"></p>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">창닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	document.querySelector("#menuBtn").addEventListenter("click", function(){
		
	});
</script>
</body>
</html>