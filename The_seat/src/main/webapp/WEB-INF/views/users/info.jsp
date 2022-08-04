<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
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
href="${pageContext.request.contextPath}/resources/css/info.css?ver=10"
type="text/css" />
<!-- 타이틀 고로고 -->
<link rel="shortcut icon" type="image⁄x-icon" href="${pageContext.request.contextPath}/resources/img/summer.jpg">
</head>
<body>
<!------------------------------ navbar 불러오기 --------------------------->
<jsp:include page="/WEB-INF/views/nav/navbar.jsp" />
<div class="container info-container" >
<!--------------------- 마이페이지 상단 프로필 -------------------------->
	<header class="info-header animate__animated animate__fadeInDown">
		<div class="my-page__profile mt-2 mb-2">
			<c:choose>
				<c:when test="${dto.profile eq 'profile' }">
					<img src="${pageContext.request.contextPath}/resources/img/user1.png" alt="프로필 이미지"
						style="width: 150px; height: 150px; border-radius: 100%;">
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}${dto.profile }" alt="프로필 이미지"
						style="width: 150px; height: 150px; border-radius: 100%;">
				</c:otherwise>
			</c:choose>
			<div>
				<h3 style="margin-bottom:20px;">${dto.name}님의 마이페이지
					<c:choose>
						<c:when test="${myStoreList.size() eq 0 }"> 
							<span>(🍽손님)</span>
						</c:when>
						<c:otherwise>
							<span>(💎사장님)</span>
						</c:otherwise>
					</c:choose>
				</h3>
				<h6><span>#</span>${dto.tag }</h6>
				<!---------- 프로필 편집 버튼 ------------------->
				<button type="button" class="text-btn my-page__edit" data-bs-toggle="modal" data-bs-target="#modal-updateForm">
					프로필 편집
					<!-- 버튼 이미지 -->
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
						<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
						<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
					</svg>
				</button>
			</div>
		</div>	
	</header>
<!--------------------------- 마이페이지 하단 주문내역 ---------------------------------->
<!--------------------------- 카드로 만들기 c:forEach  사용------------------------------>

	<c:choose>
		<c:when test="${empty list }">
			<h1>아직 이용 내역이 없습니다 😓</h1><span><a href="${pageContext.request.contextPath}/main.do?area=&keyword=">->이용하러가기</a></span>
		</c:when>
		<c:otherwise>
			<div class="row info-row">
			<c:forEach var="tmp" items="${list }">
			  <div style="width:400px; margin-bottom:40px; flex-wrap:wrap;">
			    <div class="card col" style="border-radius: 30px; border: none; ">
			      <div class="card-head">		      	
			      	<p class="mb-0">주문번호 ${tmp.orderNum }</p>
			      	<h3 class="mb-3">${tmp.storeName }</h3>
			      	<p class="mb-0">${tmp.regdate }</p>
			      	<div class="amount-wrapper">
				        <span>결제 금액 :</span><span>${tmp.amount }원</span>
			        </div>
			      </div>
			      <div>
				  <!-- 매장평점 -->
				  <span>매장평점:
					  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill starIcon" viewBox="0 0 16 16">
		                   <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z" />
		              </svg>
		              <c:choose>
		              	<c:when test="${tmp.avgStar == 0 }">
		              		<span data-num2="${tmp.orderNum }" class="avgStar">아직 별점이 없습니다.</span>
		              	</c:when>
		              	<c:otherwise>
		              		<span data-num2="${tmp.orderNum }" class="avgStar">${tmp.avgStar }</span>
		              	</c:otherwise>
		              </c:choose>
		          </span> 
				  <!-- 내가 준 평점 -->
				  <span> / 나의평점:
					  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
		                  	<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z" />
		              </svg>
		              <c:choose>
		              	<c:when test="${tmp.myStar == 0 }">
			              		<span data-num2="${tmp.orderNum }" class="myStar">?</span>
		              	</c:when>
		              	<c:otherwise>
		              		<span data-num2="${tmp.orderNum }" class="myStar">${tmp.myStar }</span>
		              	</c:otherwise>
		              </c:choose>
		          </span>
		   		  </div>
		   		  <div class="mt-3">
		   		  	<img src="${pageContext.request.contextPath}${tmp.storeLogo }" class="card-img-top" alt="...">
		   		  </div>
			      <div class="card-body pb-0">
			      	<button class="orderDetailBtn" value="${tmp.orderNum }" style="display:block">주문내역 상세 보기</button>
			      	<button class="orderDetailOffBtn" style="display:none">주문내역 상세 접기</button>
			      	<table class="orderTable" style="display:none;">
			      		<thead style="display:flex; margin:5px 0;">
			      			<tr style="row; display: flex; justify-content: space-evenly; width: 100%; text-align:center;">
				      			<th class="col">메뉴</th>
				      			<th class="col">수량</th>
				      			<th class="col">가격</th>
			      			</tr>
			      		</thead>
			      		<tbody class="orderDetail" style="display: flex; flex-direction: column; font-size:14px;">
			      		
			      		</tbody>
			      	</table>
			        <div class="circle-btn__wrapper">
					<!-- 리뷰작성 Btn -->
					<!-- 리뷰보기 Btn -->
					<c:choose>
						<c:when test="${tmp.cancel == 'CONFIRM' }">
							<button data-num="${tmp.orderNum }" class="cancelConfirmOn circle-btn" disabled>주문 취소 완료</button>
						</c:when>
						<c:when test="${tmp.confirm == 'NO' }">
							<c:choose>
								<c:when test="${tmp.cancel == 'YES' }">
									<button data-num="${tmp.orderNum }" class="cancelIngBtn circle-btn" disabled>주문 취소 중..</button>
								</c:when>
								<c:when test="${tmp.cancel == 'NO' }">
									<button data-num="${tmp.orderNum }" class="cancelBtn circle-btn" >주문 취소</button>
									<button data-num="${tmp.orderNum }" class="cancelIngBtn circle-btn" style="display:none">주문 취소 중..</button>
									<button data-num="${tmp.orderNum }" class="cancelConfirmBtn circle-btn" disabled>주문 확인 중..</button>
								</c:when>
							</c:choose>
							
						</c:when>
						<c:when test="${tmp.confirm == 'YES' }">
							<c:choose>
								<c:when test="${tmp.reviewExist == 'YES' }">
									<button data-num="${tmp.num }" class="reviewListBtn circle-btn" data-bs-toggle="modal" data-bs-target="#modal-reviewList">리뷰 보기</button>
									<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="reviewBtn circle-btn" data-bs-toggle="modal" data-bs-target="#reviewModal" style="display:none">리뷰 작성</button>
									<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="reviewUpdateBtn circle-btn" data-bs-toggle="modal" data-bs-target="#reviewUpdateModal">리뷰 수정</button>
								</c:when>
								<c:when test="${tmp.reviewExist == 'NO' }">
									<button data-num="${tmp.num }" class="reviewListBtn circle-btn" data-bs-toggle="modal" data-bs-target="#modal-reviewList">리뷰 보기</button>
									<c:choose>
										<c:when test="${tmp.owner == 'yes' }">
											<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="reviewBtn circle-btn" data-bs-toggle="modal" data-bs-target="#reviewModal" disabled>리뷰 작성</button>
										</c:when>
										<c:when test="${tmp.owner == 'no' }">
											<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="reviewBtn circle-btn" data-bs-toggle="modal" data-bs-target="#reviewModal">리뷰 작성</button>
										</c:when>
									</c:choose>
									<button data-num="${tmp.num }" data-num2="${tmp.orderNum }" class="reviewUpdateBtn circle-btn" data-bs-toggle="modal" data-bs-target="#reviewUpdateModal" style="display:none">리뷰 수정</button>
								</c:when>
							</c:choose>
						</c:when>
					</c:choose>
							
					</div>
				  </div>
				</div>
		      </div>
			</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
	<div class="page-ui clearfix">
      <ul>
         <c:if test="${startPageNum ne 1 }">
            <li>
               <a href="${pageContext.request.contextPath}/users/info.do?pageNum=${startPageNum-1 }">Prev</a>
            </li>
         </c:if>
         <c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
            <li>
               <c:choose>
                  <c:when test="${pageNum eq i }">
                     <a  class="active" href="${pageContext.request.contextPath}/users/info.do?pageNum=${i }">${i }</a>
                  </c:when>
                  <c:otherwise>
                     <a href="${pageContext.request.contextPath}/users/info.do?pageNum=${i }">${i }</a>
                  </c:otherwise>
               </c:choose>
            </li>
         </c:forEach>
         <c:if test="${endPageNum lt totalPageCount }">
            <li>
               <a href="${pageContext.request.contextPath}/users/info.do?pageNum=${endPageNum+1 }">Next</a>
            </li>
         </c:if>
      </ul>
   </div>
</div>

<!------------모달창------------------프로필 편집------------------------------------->

<div class="modal animate__animated animate__bounce animate__fadeInDown" tabindex="-1" id="modal-updateForm" aria-labelledby="updateForm" aria-hidden="true">
	<div class="modal-dialog" style="text-align: center;">
		<div class="modal-content" style="width: 90%; border: none" >
			<div class="modal-header" style="background-color:#598eff; color:white; border-radius: 30px;
    		margin: 10px; margin-top: 20px;">
				<h4 class="modal-title">
					<strong>프로필 편집</strong>
				</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close" style="color:white;"></button>
			</div>

			<div class="modal-body">
				<!-- 프로필 이미지 변경 -->
				<a id="profileLink" href="javascript:" >
					<c:choose>
						<c:when test="${dto.profile eq 'profile'}">
							<div class="profileImage-wrapper">
								<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
									  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
									  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
								</svg>
								<label for="image">클릭해서 이미지 변경!</label>
							</div>
						</c:when>
						<c:otherwise>
							<div class="profileImage-wrapper">
								<img id="profileImage" src="${pageContext.request.contextPath}${dto.profile}" />
								<label for="image">클릭해서 이미지 변경!</label>						
							</div>
						</c:otherwise>
					</c:choose>
				</a>
				<!-- 정보 변경 -->
				<form id="updateForm" action="${pageContext.request.contextPath}/users/update.do" method="post" class="needs-validation">
					<div>
			         	<input type="hidden" name="profile" 
								value="${dto.profile eq 'profile' ? 'profile' : dto.profile}"/>
					</div>
					<div>
						<input class="form-control" type="text" name="name" id="name"
							value="${dto.name}" required="required">
					</div>
					<div>
						<input name="email" id="email" class="form-control"
							value="${dto.email}" disabled />
					</div>
					<div>
						<input class="form-control" type="tel" maxlength="13"
							name="phoneNumber" id="phoneNumber"
							value="${dto.phoneNumber}" required="required">
					</div>
					<div>
						<input class="form-control" type="tel" maxlength="13"
							name="tag" id="tag"
							value=" ${dto.tag}" required="required">
					</div>
					<div class="profileSubmitBtn">
						<button type="submit">정보 수정</button>
					</div>
				</form>
				<!-- 비밀번호 변경 -->
				<form id="pwdUpdate" method="post" action="${pageContext.request.contextPath}/users/pwd_update.do">
					<div>
						<input class="form-control" type="password" name="pwd"
							placeholder="기존 비밀번호" required="required">
					</div>
					<div>
						<input class="form-control" type="password" name="newPwd" id="newPwd"
							placeholder="새 비밀번호" required="required"> <small
							class="form-text">5글자~10글자 이내로 입력하세요.</small>
						<div class="invalid-feedback">비밀번호를 확인 하세요.</div>
					</div>
					<div>
						<input class="form-control" type="password" name="newPwd2" id="newPwd2"
							placeholder="새 비밀번호 재입력" required="required">
						<div class="invalid-feedback">비밀번호를 확인 하세요.</div>
					</div>
					<div class="profileDeleteBtn">
						<button type="submit">비밀번호 변경</button>
					</div>
				</form>
				<div style="display: flex; justify-content:flex-end;" >
					<button id="withdrawal">회원탈퇴</button>
				</div>
			</div>
			
		</div>
	</div>
</div>

<!------------모달창------------- 마이페이지 하단 주문내역 (리뷰 확인) ---------------------------->

<!-- 리뷰 작성 modal -->
<div data-num="" class="modal" tabindex="-1" id="reviewModal" aria-labelledby="menuAddForm" aria-hidden="true">
    <div class="modal-dialog" style="display:flex; justify-content:center;">
		<div class="modal-content" style="width: 90%; border: none" >
			<div class="modal-header" style="background-color:#598eff; color:white; border-radius: 30px;
    		margin: 10px; margin-top: 20px;">
                <h4 class="modal-title"><strong>리뷰 등록</strong> </h4>
                <button id="addCloseBtn" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" style=" display:flex; flex-direction:column; align-items: center; justify-content: center;">
            	<a id="reviewImgLink" href="javascript:">
	           		<img src="${pageContext.request.contextPath}/resources/img/clickme1.png" alt="" id="reviewImg" name="review" class="image mt-3"
                		style="width: 150px; height: 150px; "/>
	            </a>
                <form data-num2="" id="reviewAddForm" action="${pageContext.request.contextPath}/store/addReview.do" method="post" enctype="multipart/form-data">                 
                    <select id="insertStarSelect" name="star">
                    	<c:forEach var="tmp" items="1,2,3,4,5">
                    		<option class="insertStar" name="starOption" value="${tmp }">
                    			<c:forEach begin="1" end="${tmp }">
                    				⭐
                    			</c:forEach>
                    		</option>
                    	</c:forEach>
                    </select>
                    <input id="inputImg" name="imageFile" type="file" style="display:none;"/>
                    <input type="hidden" name="storeNum" id="insertNum" value="" />
                    <input type="hidden" name="orderNum" id="insertOrderNum" value="" />
                    <textarea name="content" id="inputContent" cols="30" rows="5" style="resize:none; padding:10px;" placeholer="리뷰를 작성해주세요."></textarea>
                    <button id="addBtn" type="submit" class="reviewSubmitBtn">작성 완료</button>
                </form>
            </div>
        </div>
    </div>
</div>
    
<!--------------------------- 리뷰 수정 modal --------------------------------------->
<div class="modal" tabindex="-1" id="reviewUpdateModal" aria-labelledby="menuAddForm" aria-hidden="true">
    <div class="modal-dialog" style="display:flex; justify-content:center;">
		<div class="modal-content" style="width: 90%; border: none" >
			<div class="modal-header" style="background-color:#598eff; color:white; border-radius: 30px;
    		margin: 10px; margin-top: 20px;">
                <h4 class="modal-title"><strong>리뷰 수정</strong></h4>
                <button data-num="" data-num2="" id="reviewDeleteBtn">리뷰 삭제</button>
            </div>
            <div class="modal-body" style=" display:flex; flex-direction:column; align-items: center; justify-content: center;">
            	<a id="updateImgLink" href="javascript:">
	                <img src="#" alt="" id="updateImg" name="review" class="image mb-3"
	                style="width: 150px; height: 150px; "/>
	            </a>
                <form id="reviewUpdateForm" style="display:flex; flex-direction:column;" action="${pageContext.request.contextPath}/store/updateReview.do" method="post" enctype="multipart/form-data">                 
                    <select id="updateStarSelect" name="star">
                    	<c:forEach var="tmp" items="1,2,3,4,5">
                    		<option class="updateStar" name="starOption" value="${tmp }">
                    			<c:forEach begin="1" end="${tmp }">
                    				⭐
                    			</c:forEach>
                    		</option>
                    	</c:forEach>
                    </select>
                    <input id="inputUpdateImg" name="imageFile" type="file" style="display:none;"/>
                    <input type="hidden" name="storeNum" id="updateNum" value="" />
                    <input type="hidden" name="orderNum" id="updateOrderNum" value="" />
                    <textarea name="content" id="updateContent" cols="30" rows="5" style="resize:none;"></textarea>
                    <button id="updateBtn" type="submit" class="reviewSubmitBtn">수정 완료</button>
                </form>
                <button id="updateCloseBtn" type="button" data-bs-dismiss="modal">창 닫기</button>
            </div>
        </div>
    </div>
</div>
   
<!----------------------------- 리뷰 list modal ------------------------------------------------>
<div class="modal" tabindex="-1" id="modal-reviewList" aria-labelledby="modal-reviewList" aria-hidden="true">
    <div class="modal-dialog">
		<div class="modal-content" style="width: 90%; border: none" >
			<div class="modal-header" style="background-color:#598eff; color:white; border-radius: 30px;
    		margin: 10px; margin-top: 20px;">
                <h4 class="modal-title"><strong>리뷰 목록</strong> </h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div id="reviewBox" class="modal-body">
            	
            </div>
        </div>
    </div>
</div>

<!-- 프로필 이미지 넣는용 지우지마용 -->
<form action="${pageContext.request.contextPath}/users/ajax_profile_upload.do" method="post" 
	  id="imageForm" enctype="multipart/form-data" style="visibility:hidden;'">
	<input type="file" name="image" id="image" 
		accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
</form>
<!------------------------------ footer 불러오기 --------------------------->
<jsp:include page="/WEB-INF/views/nav/footer.jsp" />
<script src="https://kit.fontawesome.com/2ebe86210e.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>

	//------------------------ 프로필 전송폼 ---------------------------------
	
	//프로필 이미지 링크를 클릭하면 
	document.querySelector("#profileLink").addEventListener("click", function(){
		// input type="file" 을 강제 클릭 시킨다. 
		document.querySelector("#image").click();
	});
	  
	//프로필 이미지를 새롭게 넣으면
	document.querySelector("#image").addEventListener("change", function(){
		
		let form=document.querySelector("#imageForm");
		
		// gura_util.js 에 정의된 함수를 호출하면서 ajax 전송할 폼의 참조값을 전달하면 된다. 
		ajaxFormPromise(form)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			// 클릭하는 자리에 이미지 넣어주기
			let img=`<div class="profileImage-wrapper">
						<img id="profileImage" src="${pageContext.request.contextPath}\${data.imagePath}"/>
						<span>변경될 프로필 이미지</span>
						</div>`;
			
			document.querySelector("#profileLink").innerHTML=img;
			// input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
			document.querySelector("input[name=profile]").value=data.imagePath;
		});
	});
	
	// 회원 정보 수정 ajax 요청하기 
	document.querySelector("#updateForm").addEventListener("submit",function(e) {
		e.preventDefault();
		const updateForm = document.querySelector('#updateForm');
		ajaxFormPromise(updateForm)
		.then(function(response) {
			return response.json();
		})
		.then(function(data) {
			if(data.isUpdated){
				alert("회원 정보가 수정되었습니다.");
				location.href = "${pageContext.request.contextPath}/users/info.do";
			} else {
				alert("회원 정보 수정에 실패하였습니다. 다시 시도해주시고, 반복해서 실패 시 문의 바랍니다.");
			}
		});
	});
	
	//비밀 번호를 확인 하는 함수 
	let isPwdValid = false;
	function checkPwd() {

		document.querySelector("#newPwd").classList.remove("is-valid");
		document.querySelector("#newPwd").classList.remove("is-invalid");

		const pwd = document.querySelector("#newPwd").value;
		const pwd2 = document.querySelector("#newPwd2").value;

		// 최소5글자 최대 10글자인지를 검증할 정규표현식
		const reg_pwd = /^.{5,10}$/;
		if (!reg_pwd.test(pwd)) {
			isPwdValid = false;
			document.querySelector("#newPwd").classList.add("is-invalid");
			return; //함수를 여기서 종료
		};

		if (pwd != pwd2) {//비밀번호와 비밀번호 확인란이 다르면
			//비밀번호를 잘못 입력한것이다.
			isPwdValid = false;
			document.querySelector("#newPwd").classList.add("is-invalid");
		} else {
			isPwdValid = true;
			document.querySelector("#newPwd").classList.add("is-valid");
		};
	};
	
	// 비밀번호 변경 ajax
	document.querySelector("#pwdUpdate").addEventListener("submit",function(e) {
		e.preventDefault();
		if(isPwdValid){
			const pwdUpdateForm = document.querySelector('#pwdUpdate');
			
			ajaxFormPromise(pwdUpdateForm)
			.then(function(response) {
				return response.json();
			})
			.then(function(data) {
				alert("비밀번호가 변경 되었습니다. 다시 로그인 해주세요.");
				location.href = "${pageContext.request.contextPath}/users/loginform.do";
			});
		} else {
			alert("비밀번호가 동일하지 않습니다.");
		}
	});

	//비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
	document.querySelector("#newPwd").addEventListener("input", checkPwd);
	document.querySelector("#newPwd2").addEventListener("input", checkPwd);

	//------------------------------회원 탈퇴--------------------------------------------
	
	document.querySelector("#withdrawal").addEventListener("click",function(){
		
		ajaxPromise("${pageContext.request.contextPath}/users/delete.do")
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			if(data.isDeleted){
				alert(data.email+" 님이 탈퇴 되었습니다! 그동안 이용해주셔서 감사합니다.");
				location.href="${pageContext.request.contextPath}/main.do?area=&keyword=";
			} else {
				alert(data.email+" 님의 탈퇴 처리가 정상적으로 수행되지 않았습니다. 관련 사항 문의 부탁드립니다.");
			}
		});
	});

	//---------------------------연락처 자동 하이픈---------------------------------

	const autoHypenPhone = function(str) {
		str = str.replace(/[^0-9]/g, '');
		let tmp = '';
		if (str.length < 4) {
			return str;
		}
		if (str.length < 7) {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3);
			return tmp;
		} else if (str.length < 11) {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 3);
			tmp += '-';
			tmp += str.substr(6);
			return tmp;
		} else {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 4);
			tmp += '-';
			tmp += str.substr(7);
			return tmp;
		}
		return str;
	}

	let phoneNum = document.querySelector('#phoneNumber');

	phoneNum.onkeyup = function() {
		this.value = autoHypenPhone(this.value);
	}
	
	//--------------------------------주문 내역 상세정보 띄우기-----------------
	let orderDetailBtn = document.querySelectorAll(".orderDetailBtn");
	let orderDetailOffBtn = document.querySelectorAll(".orderDetailOffBtn");
	let orderDetail = document.querySelectorAll(".orderDetail");
	let orderTable = document.querySelectorAll(".orderTable");
	
	for(let i=0; i<orderDetailBtn.length; i++){
		
		//클릭하면
		orderDetailBtn[i].addEventListener("click",function(){
			let orderNum = this.value;
			//버튼이 갖고 있던 ordernum 정보를 ajax 로 넘겨주고
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
					 td.setAttribute('class', 'col-4');
				     td.innerHTML = menu;  
				     let td1 = document.createElement( "TD" );
				     td1.setAttribute('class', 'col-3');
				     td1.innerHTML = menuCount; ; 
				     let td2 = document.createElement( "TD" );
				     td2.setAttribute('class', 'col-4');
				     td2.innerHTML = price; 
				 //    td.style.border = "1px solid #92acbb"; 
				 //    td.style.padding = "3px"; 
				     
					let tr = document.createElement( "TR" );
						 tr.setAttribute('class', 'tdWrapper row')
					     tr.appendChild( td );
					     tr.appendChild( td1 ); 
					     tr.appendChild( td2 ); 
					orderDetail[i].appendChild( tr ); 
				};
				// 테이블을 보이게 한다.
				orderTable[i].style.display="block";
				orderDetailOffBtn[i].style.display="block";
				orderDetailBtn[i].style.display="none";
			});
		});
		
		orderDetailOffBtn[i].addEventListener("click",function(){
			// 클릭하면 생성되었던 td 를 전부 지우고
			while (orderDetail[i].hasChildNodes()) {	
				orderDetail[i].removeChild(orderDetail[i].firstChild );
			};
			//테이블을 안보이게 한다.
			orderTable[i].style.display="none";
			orderDetailOffBtn[i].style.display="none";
			orderDetailBtn[i].style.display="block";
		});
		
	}
	
	
	//--------------------------리뷰-----------------------------------------------------
	document.querySelector("#reviewImgLink").addEventListener("click", function(){
		document.querySelector("#inputImg").click();
	});
	document.querySelector("#updateImgLink").addEventListener("click", function(){
		document.querySelector("#inputUpdateImg").click();
	});
	
	viewThumbNail("#inputImg", "#reviewImg");
	viewThumbNail("#inputUpdateImg", "#updateImg");
	
	// 이미지 파일을 선택했을 때 동작하는 method
	function viewThumbNail(rel, imageID){
		document.querySelector(rel).addEventListener("change", function(e){
			readImage(e.target, imageID);
		});
	}
	
	function readImage(input, imageID) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        let reader=new FileReader();
	        // 이미지가 로드가 된 경우
	        reader.onload=function(e){
	            let previewImg=document.querySelector(imageID);
	            previewImg.src=e.target.result;
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	addReview("#reviewAddForm");
	
	// 리뷰 등록 버튼을 클릭했을 때 발생하는 동작
	let reviewBtns=document.querySelectorAll(".reviewBtn");
	for(let i=0; i<reviewBtns.length; i++){
		reviewBtns[i].addEventListener("click", function(e){
			e.preventDefault();
			
			// 버튼에 있는 해당 매장의 DB 번호 정보
			let num=this.getAttribute("data-num");
			// 주문 번호
			let num2=this.getAttribute("data-num2");
			// 번호정보를 form에서 넘기는 값에 저장
			document.querySelector("#insertNum").value=num;
			document.querySelector("#insertOrderNum").value=num2;
			document.querySelector("#reviewAddForm").setAttribute("data-num2", num2);
		});
	}
	
	// 매장에 대한 리뷰 등록 시 동작하는 method
	function addReview(rel){
		document.querySelector(rel).addEventListener("submit", function(e){
			// 일단 form 제출을 막음
			e.preventDefault();
			
			let num=this.getAttribute("data-num2");
			
			ajaxFormPromise(this)
			.then(function(response){
				return response.json();
			}).then(function(data){
				if(data.beAdded){
					document.querySelector("#addCloseBtn").click();
					alert("리뷰를 등록하였습니다.");
					document.querySelector("button.reviewBtn[data-num2=\'"+num+"\']").style.display="none";
					document.querySelector("button.reviewUpdateBtn[data-num2=\'"+num+"\']").style.display="block";
					let newMyStar=document.querySelector("#insertStarSelect").value;
					document.querySelector("span.myStar[data-num2=\'"+num+"\']").innerText=newMyStar;
					document.querySelector("span.avgStar[data-num2=\'"+num+"\']").innerText=data.newAvgStar;
				}
			});
		});
	}
	
	let test=``;
	// 마이페이지 해당 매장의 리뷰 목록을 불러오는 method
	let reviewListBtns=document.querySelectorAll(".reviewListBtn");
	for(let i=0; i<reviewListBtns.length; i++){
		reviewListBtns[i].addEventListener("click", function(e){
			//e.preventDefault();
			
			// 기존 내용을 reset
			let reviewBox=document.querySelector("#reviewBox");
			while (reviewBox.hasChildNodes()) {	
				reviewBox.removeChild(reviewBox.firstChild );
			}
			test=``;
			
			// 버튼에 저장된 매장의 번호를 불러옴
			let storeNum=this.getAttribute("data-num");
			
			ajaxPromise("${pageContext.request.contextPath}/store/getReview.do", "post", "storeNum="+storeNum)
			.then(function(response){
				return response.json();
			}).then(function(data){
				if(data.beTaken){
					let reviewList=data.reviewList;
					if(reviewList.length==0){
						test=`<p>아직 작성된 리뷰가 없습니다.</p>`
					} else {
						for(let j=0; j<reviewList.length; j++){
							if(reviewList[j].targetNum==0){
								let path="${pageContext.request.contextPath}"+reviewList[j].imagePath;
								let star=reviewList[j].star;
								let starTest=``;
								for(let i=0; i<star; i++){
									starTest=starTest+`<i class="starIcon fas fa-star"></i>`;
								}
								for(let i=0; i<5-star; i++){
									starTest=starTest+`<i class="starIcon far fa-star"></i>`;
								}
								let ownerComment="";
								if(reviewList[j+1]==null || reviewList[j+1].targetNum==0){
									ownerComment="사장님의 댓글이 아직 없습니다.";
								} else if(reviewList[j+1]!=null && reviewList[j+1].targetNum!=0){
									ownerComment=reviewList[j+1].content;
								}
								let testPrime=
									`
										<div class="user-review">
											<div class="user-review__title">
												<p class="mb-0">
													<strong>`+reviewList[j].writer+`</strong>
												</p>
												<small>`+reviewList[j].regdate+`</small>
											</div>
											<div class="user-review__body arrow_box-user">
												<div class="user-review__text">
													<div class="img__wrapper">
														<img src=`+path+` alt="" id="image_logo" name="logo"
													class="image" />
													</div>
													<!-- 별점이랑 리뷰내용 출력하기 -->
													<div class="fiveStar mt-2 mb-2">
														`+starTest+`
													</div>
													<p>`+reviewList[j].content+`</p>
													<!-- 버튼 클릭시 글 작성 가능한 사장님 답글 말풍선 생성-->
													<button data-num="${tmp.groupNum }" href="javascript:" class="userReview">
														<span class="user-review__reply">답글 보기</span>
													</button>
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
												</div>
												<div class="owner-review__text">
													<h5>
														<strong>사장님</strong>
													</h5>
													<p class="ownerComment" name="#" id="">`+ownerComment+`</p>
												</div>
											</div>
										</div>
									`;
								test=test+testPrime;
							}
						}
					}
					document.querySelector("#reviewBox").innerHTML=test;
					
					// 댓글보기 버튼 클릭하면 사장님 답글 창 생성
					let review = document.querySelectorAll('.userReview');
					let ownerReviewBox = document.querySelectorAll('.ownerReview');
					
					for (let i=0; i<review.length; i++) {
					    review[i].addEventListener('click', function(){
					    	let dummy=ownerReviewBox[i];
							if(dummy.style.display == "block"){
								dummy.style.display = "none";
							} else {
								dummy.style.display = "block";
							}
					    });
					}
				}
			});
		});	
	}
	
	// 리뷰 수정 버튼을 눌렀을 때 동작하는 부분
	let reviewUpdateBtns=document.querySelectorAll(".reviewUpdateBtn");
	let myStars=document.querySelectorAll(".myStar");
	for(let i=0; i<reviewUpdateBtns.length; i++){
		reviewUpdateBtns[i].addEventListener("click", function(e){
			e.preventDefault();
			
			// 버튼에 있는 해당 매장의 DB 번호 정보
			let num=this.getAttribute("data-num");
			// 주문 번호
			let num2=this.getAttribute("data-num2");
			// 번호정보를 form에서 넘기는 값에 저장
			document.querySelector("#updateNum").value=num;
			document.querySelector("#updateOrderNum").value=num2;
			document.querySelector("#reviewUpdateForm").setAttribute("data-num2", num2);
			document.querySelector("#reviewDeleteBtn").setAttribute("data-num", num);
			document.querySelector("#reviewDeleteBtn").setAttribute("data-num2", num2);
			
			// ajax로 해당 리뷰의 내용을 가져옴
			ajaxPromise("${pageContext.request.contextPath}/store/getReviewData.do", "post", "orderNum="+num2)
			.then(function(response){
				return response.json();
			}).then(function(data){
				if(data.beSuccess){
					let path="${pageContext.request.contextPath}"+data.reviewData.imagePath;
					document.querySelector("#updateImg").setAttribute("src", path);
					document.querySelector("#updateOrderNum").value=data.reviewData.orderNum;
					document.querySelector("#updateContent").innerText=data.reviewData.content;
					document.querySelector("option.updateStar[value=\'"+data.reviewData.star+"\']").selected=true;
				}
			});
		});
	}
	
	updateReview("#reviewUpdateForm");
	
	// 수정 완료 버튼을 눌렀을 때 동작하는 부분
	function updateReview(rel){
		document.querySelector(rel).addEventListener("submit", function(e){
			// 일단 form 제출을 막음
			e.preventDefault();
			
			let num=this.getAttribute("data-num2");
			
			ajaxFormPromise(this)
			.then(function(response){
				return response.json();
			}).then(function(data){
				if(data.beUpdated){
					document.querySelector("#updateCloseBtn").click();
					alert("리뷰를 수정하였습니다.");
					let newMyStar=document.querySelector("#updateStarSelect").value;
					document.querySelector("span.myStar[data-num2=\'"+num+"\']").innerText=newMyStar;
					document.querySelector("span.avgStar[data-num2=\'"+num+"\']").innerText=data.newAvgStar;
				}
			});
		});
	}
	
	// 리뷰 삭제 버튼을 눌렀을 때 동작하는 부분
	let reviewDeleteBtn=document.querySelector("#reviewDeleteBtn");
	reviewDeleteBtn.addEventListener("click", function(e){
		e.preventDefault();
		
		let wantDelete=confirm("이 주문에 대한 리뷰를 삭제하시겠습니까?");
		if(wantDelete){
			let orderNum=this.getAttribute("data-num2");
			
			ajaxPromise("${pageContext.request.contextPath}/store/deleteReview.do", "post", "orderNum="+orderNum)
			.then(function(response){
				return response.json();
			}).then(function(data){
				if(data.beDeleted){
					alert("리뷰를 삭제하였습니다.");
					document.querySelector("#updateCloseBtn").click();
					document.querySelector("button.reviewBtn[data-num2=\'"+orderNum+"\']").style.display="block";
					document.querySelector("button.reviewUpdateBtn[data-num2=\'"+orderNum+"\']").style.display="none";
					document.querySelector("span.myStar[data-num2=\'"+orderNum+"\']").innerText="리뷰를 작성해서 별점을 주세요.";
					if(data.newAvgNum==0){
						document.querySelector("span.avgStar[data-num2=\'"+orderNum+"\']").innerText="아직 별점이 없습니다.";
					} else {
						document.querySelector("span.avgStar[data-num2=\'"+orderNum+"\']").innerText=data.newAvgStar;
					}
				}			
			});	
		}
	});
	
	//주문 취소버튼 눌렀을 때 주문 정보 취소로 변경
	let cancel = document.querySelectorAll(".cancelBtn");
	let cancelIng = document.querySelectorAll(".cancelIngBtn");
	let cancelConfirm = document.querySelectorAll(".cancelConfirmBtn");
	for(let i=0; i<cancel.length; i++){
		cancel[i].addEventListener("click",function(){
			let orderNum = this.getAttribute("data-num");
			ajaxPromise("${pageContext.request.contextPath}/order/updateState.do","post","orderNum="+orderNum+"&confirm=NO"+"&cancel=YES")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				if(data.isSuccess == true){
					cancel[i].style.display="none";
					cancelIng[i].style.display="block";
					cancelConfirm[i].style.display="none";
				}
			})
		});
	}
</script>
</body>
</html>