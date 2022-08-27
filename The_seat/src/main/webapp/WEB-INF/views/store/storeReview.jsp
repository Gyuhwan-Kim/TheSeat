<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>매장 리뷰 관리</title>
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
	href="${pageContext.request.contextPath}/resources/css/storeReview.css?ver=6"
	type="text/css" />
</head>
<body>
<jsp:include page="../nav/navbar2.jsp" />

<div class="myStore_container">
	<div class="myStore_container_inner">

		<!------------------------ 주문내역 텍스트 및 박스 -------------------------------->
		<div id="inner" class="inner_container">
			<div class="display-box">
				<div class="scroll-zone">
					<!------------------------------ USER 리뷰 리스트 (테스트용 1 ) -------------------------->
					<c:choose>
						<c:when test="${empty reviewList }">
							<p>아직 작성된 리뷰가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="tmp" items="${reviewList }">
								<c:choose>
									<c:when test="${tmp.targetNum == 0 }">
										<div class="user-review">
											<div class="user-review__title">
												<p>
													<strong>${tmp.writer }</strong>
												</p>
												<small>${tmp.regdate }</small>
											</div>
											<div class="user-review__body arrow_box-user">
												<div class="user-review__text">
													<!-- 별점이랑 리뷰내용 출력하기 -->
													<div class="fiveStar">
														<c:forEach begin="1" end="${tmp.star }">
															<i class="starIcon fas fa-star"></i>
														</c:forEach>
														<c:forEach begin="1" end="${5-tmp.star }">
															<i class="starIcon far fa-star"></i>
														</c:forEach>
													</div>
													<p>${tmp.content }</p>
													<!-- 버튼 클릭시 글 작성 가능한 사장님 답글 말풍선 생성-->
													<button data-num="${tmp.groupNum }" href="javascript:" class="userReview">
														<c:choose>
															<c:when test="${tmp.reviewCheck == 'no' }">
																<span class="user-review__reply">답글 작성</span>
															</c:when>
															<c:when test="${tmp.reviewCheck == 'yes' }">
																<span class="user-review__reply">답글 보기</span>
															</c:when>
														</c:choose>
													</button>
												</div>
												<div class="img__wrapper">
													<img src="${pageContext.request.contextPath}${tmp.imagePath}" alt="" id="image_logo" name="logo"
														class="image" />
												</div>
											</div>
										</div>
										<!-- 사장님 답글 -->
										<div class="owner-review ownerReview"
											style="display: none;">
											<div class="owner-review__title">
												<small class="ownerRegdate"></small>
											</div>
											<div class="owner-review__body arrow_box-owner">
												<div class="edit-btn">
													<i class="fas fa-edit" style="display: none;"></i>
													<c:choose>
														<c:when test="${tmp.reviewCheck == 'no'}">
															<button class="addBtn">댓글 작성</button>
															<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="updateBtn"style="display:none">수정</button>
															<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="deleteBtn" style="display:none">삭제</button>
														</c:when>
														<c:when test="${tmp.reviewCheck == 'yes'}">
															<button class="addBtn" style="display:none">댓글 작성</button>
															<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="updateBtn">수정</button>
															<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="deleteBtn">삭제</button>
														</c:when>
													</c:choose>	
												</div>
												<div class="owner-review__text">
													<h5><strong>사장님</strong></h5>
													<p class="ownerComment" name="#" id=""></p>
												</div>
											</div>
										</div>
										<!-- 답글 작성 form -->
										<div class="owner-review ownerReviewFormBox"
											style="display: none;">
											<div class="owner-review__body arrow_box-owner">
												<form class="ownerReviewForm" action="${pageContext.request.contextPath}/store/addReview.do" method="post">
													<div class="edit-btn">
														<i class="fas fa-edit" style="display: none;"></i>
														<button class="addReview">작성 완료</button>
														<button class="addCancelBtn">취소</button>
													</div>
													<div class="owner-review__text">
														<h5>
															<strong>사장님</strong>
														</h5>
														<input type="hidden" name="num" value="${tmp.num }"/>
														<input type="hidden" name="storeNum" value="${tmp.storeNum }" />
		                    							<input type="hidden" name="orderNum" value="${tmp.orderNum }" />
														<textarea class="ownerAddComment" name="content"></textarea>
													</div>
												</form>
											</div>
										</div>
										<!-- 답글 수정 form -->
										<div class="owner-review ownerReviewUpdateFormBox"
											style="display: none;">
											<div class="owner-review__body arrow_box-owner">
												<form class="ownerReviewUpdateForm" action="${pageContext.request.contextPath}/store/updateReview.do" method="post">
													<div class="edit-btn">
														<i class="fas fa-edit" style="display: none;"></i>
														<button class="updateReview">수정 완료</button>
														<button class="updateCancelBtn">취소</button>
													</div>
													<div class="owner-review__text">
														<h5>
															<strong>사장님</strong>
														</h5>
														<input type="hidden" name="num" value="${tmp.num }"/>
														<input type="hidden" name="storeNum" value="${tmp.storeNum }" />
		                    							<input type="hidden" name="orderNum" value="${tmp.orderNum }" />
														<textarea class="ownerUpdateComment" name="content" placeholder="답글을 입력해 주세요 :)"></textarea>
													</div>
												</form>
											</div>
										</div>
									</c:when>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<!------------------------------------ 옆 사이드바 (매장정보, 메뉴관리 탭) ----------------->
	<aside class="aside">
        <button onclick="location.href='${pageContext.request.contextPath}/store/myStore.do?num=${reviewList[0].storeNum}'">매장 정보</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/manageMenu.do?num=${reviewList[0].storeNum}'">메뉴 관리</button>
        <button onclick="location.href='#'">리뷰 관리</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/storeOrder.do?num=${reviewList[0].storeNum}'">주문 확인</button>
        <button onclick="location.href='${pageContext.request.contextPath}/store/storeSeat.do?num=${reviewList[0].storeNum}'">자리 관리</button>
    </aside>
</div>
<script src="https://kit.fontawesome.com/2ebe86210e.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
	//각 버튼들이 동작하는곳
	// 댓글달기 버튼 클릭하면 사장님 답글 창 생성
	let review = document.querySelectorAll('.userReview');
	let ownerReviewBox = document.querySelectorAll('.ownerReview');
	let ownerRegdates=document.querySelectorAll(".ownerRegdate");
	let ownerComments=document.querySelectorAll(".ownerComment");
	// 댓글 작성
	let addBtns=document.querySelectorAll(".addBtn");
	// 댓글 수정
	let updateBtns=document.querySelectorAll(".updateBtn");
	// 댓글 작성 box
	let ownerReviewFormBoxes=document.querySelectorAll(".ownerReviewFormBox");
	// 댓글 수정 box
	let ownerReviewUpdateFormBoxes=document.querySelectorAll(".ownerReviewUpdateFormBox");
	// 작성 취소
	let addCancelBtns=document.querySelectorAll(".addCancelBtn");
	// 작성한 멘트
	let ownerAddComments=document.querySelectorAll(".ownerAddComment");
	// 수정 취소
	let updateCancelBtns=document.querySelectorAll(".updateCancelBtn");
	// 수정한 멘트
	let ownerUpdateComments=document.querySelectorAll(".ownerUpdateComment");
	// 작성 form
	let ownerReviewForms=document.querySelectorAll(".ownerReviewForm");
	// 수정 form
	let ownerReviewUpdateForms=document.querySelectorAll(".ownerReviewUpdateForm");
	// 삭제 버튼
	let deleteBtns=document.querySelectorAll(".deleteBtn");
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
						ownerComments[i].innerText="사장님의 답글을 작성해주세요~";
					} else {
						ownerRegdates[i].innerText=data.ownerReviewData.regdate;
						ownerComments[i].innerText=data.ownerReviewData.content;
						ownerUpdateComments[i].innerText=data.ownerReviewData.content;
					}
				});
				dummy.style.display = "block";
			}
		});
	}
	for(let i=0; i<addBtns.length; i++){
		// 댓글 작성 버튼을 눌렀을 때 동작하는 곳
		addBtns[i].addEventListener("click", function(e){
			e.preventDefault();
			
			ownerReviewBox[i].style.display="none";
			ownerReviewFormBoxes[i].style.display="block";
		});
		// 댓글 수정 버튼을 눌렀을 때 동작하는 곳
		updateBtns[i].addEventListener("click", function(e){
			e.preventDefault();
			
			ownerUpdateComments[i].innerText=ownerComments[i].innerText;
			ownerReviewBox[i].style.display="none";
			ownerReviewUpdateFormBoxes[i].style.display="block";
		});
		// 등록 취소 버튼을 눌렀을 때 동작하는 곳
		addCancelBtns[i].addEventListener("click", function(e){
			e.preventDefault();
			
			ownerReviewBox[i].style.display="block";
			ownerReviewFormBoxes[i].style.display="none";
		});
		// 수정 취소 버튼을 눌렀을 때 동작하는 곳
		updateCancelBtns[i].addEventListener("click", function(e){
			e.preventDefault();
			
			ownerReviewBox[i].style.display="block";
			ownerReviewUpdateFormBoxes[i].style.display="none";
		});
		// 등록 완료 버튼을 눌렀을 때 동작하는 곳
		ownerReviewForms[i].addEventListener("submit", function(e){
			e.preventDefault();
			
			if(ownerAddComments[i].value==""){
				alert("댓글을 입력해주세요.");
			} else {
				ajaxFormPromise(this)
				.then(function(response){
					return response.json();
				}).then(function(data){
					if(data.beAdded){
						alert("리뷰에 대한 댓글을 추가하였습니다.");
						ownerComments[i].innerText=ownerAddComments[i].value;
						addBtns[i].style.display="none";
						updateBtns[i].style.display="block";
						deleteBtns[i].style.display="block";
						ownerReviewBox[i].style.display="block";
						ownerReviewFormBoxes[i].style.display="none";
						review[i].innerText="답글 보기";
					}
				});
			}
		});
		// 삭제를 눌렀을 때 동작하는 곳
		deleteBtns[i].addEventListener("click", function(e){
			e.preventDefault();
			
			let wantDelete=confirm("리뷰에 대한 댓글을 삭제하시겠습니까?");
			if(wantDelete){
				// 해당 리뷰의 번호를 들고와서 targetNum이 이것인 것을 삭제
				let num=this.getAttribute("data-num");
				
				ajaxPromise("${pageContext.request.contextPath}/store/deleteOwnerReview.do", "post", "num="+num)
				.then(function(response){
					return response.json();
				}).then(function(data){
					if(data.beDeleted){
						alert("댓글을 삭제하였습니다.");
						ownerComments[i].innerText="사장님의 답글을 작성해주세요~";
						addBtns[i].style.display="block";
						updateBtns[i].style.display="none";
						deleteBtns[i].style.display="none";
						ownerReviewBox[i].style.display="block";
						ownerReviewUpdateFormBoxes[i].style.display="none";
						review[i].innerText="답글 작성";
					}
				});
			}
		});
		
		// 수정 완료를 눌렀을 때 동작하는 곳
		ownerReviewUpdateForms[i].addEventListener("submit", function(e){
			e.preventDefault();
			
			ajaxFormPromise(this)
			.then(function(response){
				return response.json();
			}).then(function(data){
				alert("댓글을 수정하였습니다.");
				ownerReviewBox[i].style.display="block";
				ownerReviewUpdateFormBoxes[i].style.display="none";
				ownerComments[i].innerText=ownerUpdateComments[i].value;
			})
		});
	}
	
</script>
</body>
</html>