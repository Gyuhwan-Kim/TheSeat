<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.storeName }</title>
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
<!-- css 파일 로딩하기 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/storeDetail.css?ver=2"
	type="text/css" />
<!------------------ 타이틀 로고 -------------------->
<link rel="shortcut icon" type="image⁄x-icon"
	href="${pageContext.request.contextPath}/resources/img/snow.jpg">
</head>
<!---------------------- 네비바를 import 한다. ------------------------->
<jsp:include page="/WEB-INF/views/nav/navbar.jsp" />
<div class="container detail-container" style="width: 100%;">

	<section style="text-align: center; margin-top: 10px;">
		<!---------------------- DB 연동해서 파라미터 값으로 칼럼 값을 받아온다.  --------------------->
		<img src="${pageContext.request.contextPath}${dto.image_logo }"
			alt="storeLogo" style="width: 60px; border-radius: 100%;" /> <span
			style="font-size: 2.5em; font-weight: bold; color: rgb(85, 152, 252); text-shadow: 2px 6px 2px #d3d3d3; text-align: center;">
			${dto.storeName }</span>
	</section>
	<div class="row row1" style="display: flex; justify-content: center;">
		<!--------------------- 매장의 대표 이미지 4개를 Carousel 로 띄우기  -------------------------->
		<div id="carouselExampleDark" class="col carousel carousel-dark slide"
			data-bs-ride="carousel"
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
			<div class="carousel-inner"
				style="width: 100%; height: 500px; overflow: auto; box-shadow: 10px 7px 7px #999;">
				<div class="carousel-item active" data-bs-interval="10000">
					<img src="${pageContext.request.contextPath}${dto.image_1 }"
						class="d-block w-100 mainImg" alt="매장대표이미지1">
				</div>
				<div class="carousel-item" data-bs-interval="2000">
					<img src="${pageContext.request.contextPath}${dto.image_2 }"
						class="d-block w-100 mainImg" alt="매장대표이미지2">
				</div>
				<div class="carousel-item">
					<img src="${pageContext.request.contextPath}${dto.image_3 }"
						class="d-block w-100 mainImg" alt="매장대표이미지3">
				</div>
				<div class="carousel-item">
					<img src="${pageContext.request.contextPath}${dto.image_4 }"
						class="d-block w-100 mainImg" alt="매장대표이미지4">
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
		</div>
		<!------------------------------ 매장 상세 정보 카드 ----------------------------------->
		<div class="col card text-center"
			style="width: 550px; height: 400px; padding: 5px 0px 2px 30px; border: none;">
			<!--------------- 파라미터 값으로 매장 정보를 받아온다. ----------------------->

			<div class="card-header bg-transparent border-dark-light">
				<h4 style="line-height: 3.5;">
					별점 : ⭐${dto.avgStar }
					<c:if test="${dto.reviewCount gt 10 }">
							 (10+)
						</c:if>
				</h4>
				<h3>
					<c:if test="${not empty tagList  }">
						<c:forEach var="tmp" items="${tagList }">
							<span>#${tmp } </span>
						</c:forEach>
					</c:if>

				</h3>
			</div>
			<div class="card-body" style="margin-top: 10px;">
				<h4 class="card-title m-0" style="line-height: 2;">
					매장 주소 : <span>${dto.storeAddr }</span>
				</h4>
				<h4 class="card-title" style="line-height: 2;">
					영업 시간 : <span>${dto.openingTime }</span>
				</h4>
				<h4 class="card-title" style="line-height: 2;">
					남은 자리 : <span id="emptySeatNum"></span> / <span id="totalSeatNum"></span>
				</h4>
				<button type="button" id="reviewBtn" data-bs-toggle="modal"
					data-bs-target="#staticBackdrop">리뷰 : ${dto.reviewCount }개
				</button>
			</div>
			<div class="card-footer bg-transparent border-dark-light">
				<button type="button" id="seatBtn" data-bs-toggle="modal"
					data-bs-target="#Modalgrid">자리 잡으러 가기 ❕</button>
			</div>
		</div>
	</div>
	<!---------------------------------------- 메뉴판 만들기 ------------------------------------------->
	<!-- 베스트 메뉴 4가지 -->
	<p
		style="font-size: 35px; font-weight: bold; color: rgb(84, 84, 84); text-shadow: 2px 6px 2px #d3d3d3;">Best
		Menu</p>
	<div id="bestMenu">
		<c:forEach var="tmp" items="${menuList }">
			<c:if test="${tmp.best == 'yes' }">
				<div class="banner_img" style="width: 300px; overflow: hidden;">
					<img src="${pageContext.request.contextPath}${tmp.menuImage }"
						style="width: 100%; object-fit: cover; border-radius: 20px;" />
					<p class="hover_text">${tmp.menuName }
						<br>
						<fmt:formatNumber value="${tmp.price }" pattern="#,###" />
						원
					</p>
				</div>
			</c:if>
		</c:forEach>
	</div>

	<!---------------------------------------- 메뉴판 만들기 ------------------------------------------->

	<!-- 메뉴 -->

	<div class="card mb-5"
		style="width: 100%; height: 700px; display: flex; justify-content: center; align-items: center; margin-top: 30px; background-color: rgb(86, 162, 255); box-shadow: 0 17px 20px -18px rgba(0, 0, 0, 1);">
		<p
			style="color: white; font-size: 50px; font-weight: bold; text-shadow: 2px 6px 2px gray; margin: 15px; text-align: left;">Menu</p>
		<div class="card mb-5"
			style="width: 90%; height: 600px; text-align: center; overflow-x: hidden; overflow-y: auto; margin-top: 25px; border-radius: 10px; background-color: #fff;">
			<div class="col" style="margin-bottom: 30px;">
				<!-- 메뉴 리스트 오브잭트 배열 가져와서 꺼내기! -->
				<c:forEach var="cat" items="${categoryList }">
					<h2 style="margin-top: 30px; text-align: center; color: #4fa4f9;">${cat }</h2>
					<c:forEach var="tmp" items="${menuList }">
						<c:if test="${tmp.category == cat }">
							<div class="row"
								style="display: flex; justify-content: center; flex-direction: row;">
								<div class="col">
									<button data-num="${tmp.num }" type="button" id="menuBtn"
										style="margin: 10px;" data-bs-toggle="modal"
										data-bs-target="#exampleModal${tmp.num }">${tmp.menuName }
									</button>
								</div>
								<div class="col">
									<span
										style="font-size: 1.5em; font-weight: bold; color: rgb(96, 92, 99);">
										<fmt:formatNumber value="${tmp.price }" pattern="#,###" /> 원
									</span>
								</div>
							</div>
							<!------------모달창-------------- 메뉴 이름 누르면 그에 맞는 이미지 Modal 활성화 -------------------------------->
							<div class="modal fade" id="exampleModal${tmp.num }"
								tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">${tmp.menuName }</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="card">
												<img
													src="${pageContext.request.contextPath}${tmp.menuImage }"
													class="rounded" alt="MenuImage">
												<div class="card-body text-center">
													<p class="card-text" style="font-size: 18px;">
														<span>상품 구성 : </span>${tmp.content }</p>
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button"
												style="border: none; background-color: #fff; font-size: 20px; font-weight: 500; color: rgb(86, 162, 255); border-bottom: solid 3px rgb(86, 162, 255);"
												data-bs-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<!------------------------------ footer 불러오기 --------------------------->
<jsp:include page="/WEB-INF/views/nav/footer.jsp" />

<!--------------모달창-------------- 리뷰 보기 Modal -------------------------------->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">리뷰 보기 ⭐</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<c:choose>
					<c:when test="${empty reviewList }">
						<p style="text-align: center; font-size: 20px;">아직 작성된 리뷰가
							없습니다 😥</p>
					</c:when>
					<c:otherwise>
						<c:forEach var="tmp" items="${reviewList }">
							<c:choose>
								<c:when test="${tmp.targetNum==0 }">
									<div class="card mb-3" style="max-width: 540px; border: none;">
										<div class="row g-0">
											<div class="col-md-4">
												<h5>${tmp.writer }님</h5>
												<img
													src="${pageContext.request.contextPath}${tmp.imagePath}"
													class="img-fluid rounded-start" alt="TwosomeReview">
											</div>
											<div class="col-md-8">
												<div class="card-body">
													<!-- 별점 출력 -->
													<div class="card-title fiveStar">
														<c:forEach begin="1" end="${tmp.star }">
															<i class="card-title">★</i>
														</c:forEach>
													</div>
													<p class="card-text">${tmp.content }</p>
													<p class="card-text">
														<small class="text-muted">등록일 : ${tmp.regdate }</small>
													</p>
												</div>
											</div>
											<!-- 버튼 클릭시 글 작성 가능한 사장님 답글 말풍선 생성-->
											<button data-num="${tmp.groupNum }" href="javascript:"
												class="userReview"
												style="text-align: center; width: 70px; height: 70px; margin-left: 200px; margin-top: 10px; font-weight: 600; border: none; border-radius: 100%; color: #fff; background-color: #96caff;">
												<span class="user-review__reply">답글 <br /> 보기
												</span>
											</button>
										</div>
									</div>
									<!-- 사장님 답글 -->
									<div class="owner-review ownerReview" style="display: none;">
										<div class="owner-review__title">
											<small class="ownerRegdate"></small>
										</div>
										<div class="owner-review__body arrow_box-owner">
											<div class="edit-btn">
												<i class="fas fa-edit" style="display: none;"></i>

											</div>
											<div class="owner-review__text">
												<h5>
													<strong>사장님</strong>
												</h5>
												<p class="ownerComment" name="#" id=""></p>
											</div>
										</div>
									</div>
								</c:when>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="modal-footer">
				<button type="button"
					style="border: none; background-color: #fff; font-size: 20px; font-weight: 500; color: rgb(86, 162, 255); border-bottom: solid 3px rgb(86, 162, 255);"
					data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-----------------모달창------------- 자리 잡기 Modal --------------------------------->
<div class="modal fade" id="Modalgrid" tabindex="-1" role="dialog"
	aria-labelledby="Modalgrid" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalLabel">
					${dto.storeName } <br /> <span>( </span><span id="emptySeatNum1"></span>
					/ <span id="totalSeatNum1"></span> <span> )</span>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<p
				style="text-align: right; font-size: 20px; font-weight: 500; margin-top: 20px; margin-right: 40px;">자리를
				선택해주세요 😉</p>
			<div class="modal-body">
				<div class="container-fluid">
					<img src="${pageContext.request.contextPath}${sDto.seatImage }"
						class="img-thumbnail" alt="seatImage">
					<hr />
					<p style="font-size: 18px;">
						자리 선택 <select name="자리 선택" id="seatChoice" style="width: auto;">
							<!-- storeSeat 테이블에서 지정한 만큼 -->
							<c:forEach var="tmp" items="${sDto.totalSeat }">
								<c:if test="${fn:contains(sDto.emptySeat, tmp) }">
									<option value="${tmp}">${tmp}(이용가능)</option>
								</c:if>
								<c:if test="${fn:contains(sDto.notEmptySeat, tmp) }">
									<option value="${tmp}" disabled>${tmp}(이용중)</option>
								</c:if>
								<c:if test="${fn:contains(sDto.notUse, tmp) }">
									<option value="${tmp}" disabled>${tmp}(이용불가)</option>
								</c:if>
							</c:forEach>
						</select>
					</p>
					<hr />
					<div class="card">
						<div class="card-header">🔔 알림사항</div>
						<div class="card-body">
							<p class="card-text">${sDto.seatContent }</p>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="orderBtn">
					<span>GO ! GO !</span><span>주문하러 가기 ☺</span>
				</button>
			</div>
		</div>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
	let totalSeat = [];
	let emptySeat = [];
	totalSeat.push(${sDto.totalSeat });
	emptySeat.push(${sDto.emptySeat });
	document.querySelector("#totalSeatNum").innerText = totalSeat.length;
	document.querySelector("#emptySeatNum").innerText = emptySeat.length;
	document.querySelector("#totalSeatNum1").innerText = totalSeat.length;
	document.querySelector("#emptySeatNum1").innerText = emptySeat.length;
	
	//--------------------주문하러 가기(버튼 누르면)
	document.querySelector("#orderBtn").addEventListener("click", function(){
	  let num = ${dto.num};
	  //버튼 눌렀을때 millisecond 을 추출
	  let str = String(Date.now());
	  //너무 길어서 필요한 만큼만 orderNum 으로 가져간다.
	  let orderNum = str.substring(str.length-6, str.length);
	  //선택한 좌석 번호 tableNum 으로 가져간다.
	  let tableNum = document.querySelector("#seatChoice").value;
	  if(tableNum != ""){
		//get 방식으로 매장 고유번호를 num 으로 가져가고 orderNum,tableNum을 가져간다.
		  location.href="${pageContext.request.contextPath}/order/order.do?num="+num+"&tableNum="+tableNum+"&orderNum="+orderNum;
	  } else {
		  alert("자리를 선택해주세요!");
	  };
	})
	
	// 답글 보기 버튼 클릭하면 사장님 답글 창 생성
	let review = document.querySelectorAll('.userReview');
	let ownerReviewBox = document.querySelectorAll('.ownerReview');
	let ownerRegdates=document.querySelectorAll(".ownerRegdate");
	let ownerComments=document.querySelectorAll(".ownerComment");
	
	for (let i = 0; i < review.length; i++) {
		review[i].addEventListener('click', function() {
			let dummy=ownerReviewBox[i];
			if(dummy.style.display == "block"){
				dummy.style.display = "none";
			} else {
				// DB에 있는 review num 이것을 사용해서 targetNum에 있는지 없는지 여부 판독할 것
				// 없으면 작성하라는 멘트
				// 있으면 내용을 출력할 수 있도록
				let num=this.getAttribute("data-num");
				
				ajaxPromise("${pageContext.request.contextPath}/store/getMyReview.do", "post", "num="+num)
				.then(function(response){
					return response.json();
				}).then(function(data){
					if(!data.beChecked){
						ownerComments[i].innerText="아직 사장님의 답글이 없습니다.";
					} else {
						ownerRegdates[i].innerText=data.ownerReviewData.regdate;
						ownerComments[i].innerText=data.ownerReviewData.content;
					}
				});
				dummy.style.display = "block";
			}
		});
	}
</script>
</body>
</html>