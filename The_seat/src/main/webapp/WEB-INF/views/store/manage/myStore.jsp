<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자리.. 있어요? | ${dto.storeName} </title>
<!--  부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myStore.css?ver=21"
	type="text/css" />
</head>
<body>
<jsp:include page="../../nav/navbar2.jsp" />
<div class="myStore_container pe-0 ps-0">
     <!------------------------------ 매장 로고 관리 영역 -------------------------->
     <div class="inner_container">
     
         <div class="store-top__info">
             <div>
                 <a class="updateImgLink" href="javascript:">
	                 <c:choose>
	             		<c:when test="${empty dto.image_logo}">
	             			<img src="${pageContext.request.contextPath}/resources/img/clickme1.png" id="image_logo" alt="" />
	             		</c:when>
	             		<c:otherwise>
	             			<img src="${pageContext.request.contextPath}${dto.image_logo}" alt="" id="image_logo" name="logo" class="image mt-3"
                     			style="width: 150px; height: 150px; "/>
	             		</c:otherwise>
	             	 </c:choose>
                 </a>
                 <form action="${pageContext.request.contextPath}/uploadImage.do" id="logoForm" method="post" 
                 style="text-align: center;" enctype="multipart/form-data">
                     <label for="image_logo" style="font-size:14px">대표 이미지</label>
                     <input type="hidden" name="num" value="${dto.num }"/>
                     <input type="hidden" name="image_logo" value="check"/>
                     <input type="file" id="logoImage" name="imageFile" style="display:none"/>
                     <button class="updateImgBtn mt-1" type="submit" style="display:none; margin:auto; font-size:14px; font-weight:600">등록</button>
                 </form>
             </div>
         <!------------------------- 매장 정보 관리 영역 ----------------------------->
             <div class="mt-1 mb-1">
                 <form id="updateForm" action="${pageContext.request.contextPath}/store/manage/updateStore.do" 
                 method="post">
                     <a href="javascript:" id="updateBtn" class="mb-2" style="display:block; text-align: end;">
                         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                             <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                             <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
                         </svg>
                     </a>
                     <button id="updateBox" style="display:none; text-align:end; font-size:14px;">
                         <a href="javascript:" id="update">수정완료</a>
                         <a href="javascript:" id="updateCancel">취소</a>
                     </button>
     
                     <input id="storeNum" type="hidden" name="num" value="${dto.num }"/>
                     <p class="m-0">매장 이름 : <strong class="storeData">${dto.storeName } </strong></p>
                     <input type="text" name="storeName" class="updateData" value="${dto.storeName }" style="display:none;"/>
                     <p class="m-0">매장 주소 : <strong class="storeData">${dto.storeAddr } </strong></p>
                     <input type="text" name="storeAddr" class="updateData" value="${dto.storeAddr }" style="display:none;"/>
                     <p class="m-0">매장 번호 : <strong class="storeData">${dto.storePhone } </strong></p>
                     <input type="text" name="storePhone" class="updateData" value="${dto.storePhone }" style="display:none;"/>
                     <p class="m-0">영업 시간 : <strong class="storeData">${dto.openingTime } </strong></p>
                     <input type="text" name="openingTime" class="updateData" value="${dto.openingTime }" style="display:none;"/>
                 </form>
             </div>
         <!--------------------------- 매장 태그 관리 영역 --------------------------->
             <div class="tag_zone">
                 <span style="font-size: 14px; color: lightgray;">매장을 나타내는 태그 추가하기</span>
                 <p id="btns" class="mt-1" style="width:250px;">
                     <c:forEach var="tmp" items="${tagList }">
                         <button data-num="${dto.num }" name="tag" class="btn btn-primary tag allTag" style="margin-bottom:5px; margin-right:5px; font-size:14px;">${tmp}</button>
                     </c:forEach>
                 </p>
                 <div class="tag_input">
                     <input placeholder="태그를 입력해주세요" id="inputTag" style="display:flex;"/>
	                 <a data-num="${dto.num }" href="javascript:" class="plus btn addTag p-3" style="text-decoration:none; display:flex;">
	                     <span>+</span>
	                 </a>        
                 </div>
             </div>     
         </div>
         <!--------------------------- 매장 대표 이미지 관리 영역1 ---------------------->
         <div class="store-bottom__info">
             <div style="text-align: center; width:100%;">
                 <a class="updateImgLink" href="javascript:">
	                 <c:choose>
	             		<c:when test="${empty dto.image_1}">
	             			<img src="${pageContext.request.contextPath}/resources/img/clickme1.png" id="image_1" alt="" />
	             		</c:when>
	             		<c:otherwise>
	             			<img src="${pageContext.request.contextPath}${dto.image_1}" alt="" id="image_1" name="image1" class="image" 
	                     		style="width: 80%; height: 150px;"/>
	             		</c:otherwise>
	             	</c:choose>
                 </a>
                 <form action="${pageContext.request.contextPath}/store/manage/uploadImage.do" id="imageForm1" method="post" enctype="multipart/form-data"
                 		style="height:85px;">
                     <label for="image_1" style="visibility: hidden;">대표 이미지1</label>
                     <input type="hidden" name="num" value="${dto.num }"/>
                     <input type="hidden" name="image_1" value="check"/>
                     <input type="file" id="repImage1" name="imageFile" style="display:none"/>
                     <button class="updateImgBtn" type="submit" style="display:none">등록</button>
                 </form>
             </div>
     
             <div>
                 <!-- 매장 대표 이미지 관리 영역2-->
                 <a class="updateImgLink" href="javascript:">
	                 <c:choose>
	             		<c:when test="${empty dto.image_2}">
	             			<img src="${pageContext.request.contextPath}/resources/img/clickme1.png" id="image_2" alt="" />
	             		</c:when>
	             		<c:otherwise>
	             			<img src="${pageContext.request.contextPath}${dto.image_2}" alt="" id="image_2" name="image2" class="image"/>
	             		</c:otherwise>
	             	</c:choose>
                 </a>
                 
                 <!-- 매장 대표 이미지 관리 영역3-->
                 <a class="updateImgLink" href="javascript:">
	                 <c:choose>
	             		<c:when test="${empty dto.image_3}">
	             			<img src="${pageContext.request.contextPath}/resources/img/clickme1.png" id="image_3" alt="" />
	             		</c:when>
	             		<c:otherwise>
	             			<img src="${pageContext.request.contextPath}${dto.image_3}" alt="" id="image_3" name="image3" class="image"/>
	             		</c:otherwise>
	             	</c:choose>
                 </a>
                 
                 <!-- 매장 대표 이미지 관리 영역4-->
                 <a class="updateImgLink" href="javascript:">
	                 <c:choose>
	             		<c:when test="${empty dto.image_4}">
	             			<img src="${pageContext.request.contextPath}/resources/img/clickme1.png" id="image_4" alt="" />
	             		</c:when>
	             		<c:otherwise>
	             			<img src="${pageContext.request.contextPath}${dto.image_4}" alt="" id="image_4" name="image4" class="image"/>
	             		</c:otherwise>
	             	 </c:choose>
                 </a>
     
     			<div class="form-wrapper" style="display:flex;">
                 <form class="p-0" action="${pageContext.request.contextPath}/uploadImage.do" id="imageForm2" method="post" enctype="multipart/form-data">
                     <label style="visibility : hidden;" for="image_2">대표 이미지2</label>
                     <input type="hidden" name="num" value="${dto.num }"/>
                     <input type="hidden" name="image_2" value="check"/>
                     <input type="file" id="repImage2" name="imageFile" style="display:none"/>
                     <button class="updateImgBtn" type="submit" style="display:none">등록</button>
                 </form>
                 
                 <form class="p-0" action="${pageContext.request.contextPath}/uploadImage.do" id="imageForm3" method="post" enctype="multipart/form-data">
                     <label style="visibility : hidden" for="image_3">대표 이미지3</label>
                     <input type="hidden" name="num" value="${dto.num }"/>
                     <input type="hidden" name="image_3" value="check"/>
                     <input type="file" id="repImage3" name="imageFile" style="display:none"/>
                     <button class="updateImgBtn" type="submit" style="display:none">등록</button>
                 </form>
     
                 <form class=" p-0" action="${pageContext.request.contextPath}/uploadImage.do" id="imageForm4" method="post" enctype="multipart/form-data">
                     <label style="visibility : hidden" for="image_4">대표 이미지4</label>
                     <input type="hidden" name="num" value="${dto.num }"/>
                     <input type="hidden" name="image_4" value="check"/>
                     <input type="file" id="repImage4" name="imageFile" style="display:none"/>
                     <button class="updateImgBtn" type="submit" style="display:none">등록</button>
                 </form>
                </div>
             </div>
     
             <div style="width: 70%; text-align:center; margin-bottom:15px;">
             	<c:choose>
             		<c:when test="${dto.storeOpen == 'no'}">
	                	<button id="storeOnOffBtn" class="btn">매장 열기</button>
	                </c:when>
	                <c:when test="${dto.storeOpen == 'yes'}">
	                	<button id="storeOnOffBtn" class="btn" style="background-color: lightgray;
    					color: white;">매장 닫기</button>
	                </c:when>
             	</c:choose>
	            <button data-num="${dto.num }" class="btn" id="deleteStoreBtn">매장 삭제</button>
             </div>
      </div>
         <!------------------------------------ 사이드바 (매장정보, 메뉴관리 탭) ----------------->
         <aside class="aside">
             <button onclick="location.href='#'">매장 정보</button>
             <button onclick="location.href='${pageContext.request.contextPath}/store/manage/storeMenu.do?num=${dto.num}'">메뉴 관리</button>
             <button onclick="location.href='${pageContext.request.contextPath}/store/manage/storeReview.do?num=${dto.num}'">리뷰 관리</button>
             <button onclick="location.href='${pageContext.request.contextPath}/store/manage/storeOrder.do?num=${dto.num}'">주문 확인</button>
             <button onclick="location.href='${pageContext.request.contextPath}/store/manage/storeSeat.do?num=${dto.num}'">자리 관리</button>
         </aside>
     </div>
</div>
<script src="https://kit.fontawesome.com/2ebe86210e.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
	// 태그 안에 x 버튼 넣어서 로딩하기
	// 페이지 로딩되는 시점에 작동할 함수
	window.onload=function(){
		// 태그에 해당하는 버튼들의 array
		let btns=document.querySelectorAll(".tag");
		for(let i=0; i<btns.length; i++){
			// 버튼의 data-num 성분의 값을 가져옴
			let dataNum=btns[i].getAttribute("data-num");
			//새로운 버튼을 만듦(취소 버튼)
			let deleteBtn=document.createElement("button");
			// 새로운 버튼에 class와 data-num 정보를 지정
			deleteBtn.setAttribute("class", "btn-close del-tag allTag");
			deleteBtn.setAttribute("data-num", dataNum);
			// 각 버튼에 자식 요소로 넣어줌
			btns[i].appendChild(deleteBtn);
		}
		// 새로 만들어진 취소 버튼에 삭제 이벤트를 부여
		deleteTag(".del-tag", ".tag");
	};

	// 태그를 추가하는 method
	document.querySelector(".plus").addEventListener("click", function(e){
		e.preventDefault();
		// 태그를 추가하는 input 요소를 보이게 함
		document.querySelector("#inputTag").style.display="block";
		// 태그 추가 링크의 class를 변경
		this.setAttribute("class", "addTag p-3");

		// 해당 class에 해당하는 링크에 태그 추가 이벤트 부여
		addTagEvent(".addTag");
	});
	
	// 태그를 추가하는 함수
	function addTagEvent(rel){
		document.querySelector(rel).addEventListener("click", test, {once:true});
	};
	
	// 태그를 추가하는 함수에 들어갈 함수
	function test(e){
		e.preventDefault();
		// 태그를 추가할 버튼의 data-num 성분을 읽어옴
		let num=this.getAttribute("data-num");
		// 추가하고 싶은 태그를 작성한 input 요소의 값을 읽어옴
		let storeTag=document.querySelector("#inputTag").value;
		if(storeTag==""){
			alert("태그를 작성해주세요.");
		} else {
			// 두 정보를 object로 만들어서 전달할 준비
			let obj={num, storeTag};
			
			// 해당 링크를 요청하면서 object를 전달하고
			ajaxPromise("${pageContext.request.contextPath}/store/manage/addTag.do", "post", obj)
			.then(function(response){
				return response.json();
			}).then(function(data){
				// 데이터를 받으면
				if(data.isAdded){
					// 태그 추가 input 창을 reset하고, 화면에서 숨김
					document.querySelector("#inputTag").value="";
					document.querySelector("#inputTag").style.display="none";
					// 해당 매장의 DB 번호를 받아서
					let dataNum=${dto.num};
					// 새로운 태그 버튼을 만들고 성분과 값을 부여함
					let newBtn=document.createElement("button");
					newBtn.innerText=storeTag;
					newBtn.setAttribute("class", "btn btn-primary add-tag allTag");
					newBtn.setAttribute("data-num", dataNum);
					// 붙어서 생기는 것을 방지하기 위해 야매
					newBtn.style.marginRight="5px";
					newBtn.style.marginBottom="5px";
					newBtn.style.fontSize="14px";
					// 새로운 취소 버튼을 만들고 성분과 값을 부여함
					let newDeleteBtn=document.createElement("button");
					newDeleteBtn.setAttribute("class", "btn-close add-del-tag del");
					newDeleteBtn.setAttribute("data-num", dataNum);
					// 새 버튼의 자식 요소로 취소 버튼을 넣고, 태그 버튼 또한 태그 공간의 자식 요소로 넣어줌
					newBtn.appendChild(newDeleteBtn);
					document.querySelector("#btns").appendChild(newBtn);
					document.querySelector(".addTag").setAttribute("class", "plus addTag");
					// 새롭게 만든 삭제 버튼에 태그 삭제 이벤트 부여
					deleteTag(".add-del-tag", ".add-tag");
					// 다시 버튼의 class를 원래대로 돌려놓음
					newBtn.setAttribute("class", "btn btn-primary tag allTag");
					newDeleteBtn.setAttribute("class", "btn-close del-tag");
				} else {
					alert("태그 추가에 실패했습니다. 문제가 반복된다면 문의 바랍니다.");
				}
			});
		}
	}
	
	// 태그를 삭제하는 함수 (추가된 삭제 버튼, 추가된 태그 버튼)
	function deleteTag(addDeleteTag, addTag){
		// 추가된 삭제 버튼, 태그버튼들
		let deleteBtns=document.querySelectorAll(addDeleteTag);
		let tags=document.querySelectorAll(addTag);
		// 버튼의 개수만큼 반복
		for(let i=0; i<deleteBtns.length; i++){
			// 버튼의 data-num 성분의 값과 태그 값을 얻어서 object로 담음
			let num=deleteBtns[i].getAttribute("data-num");
			let storeTag=tags[i].innerText;
			let obj={num, storeTag};
			// 삭제 버튼을 눌렀을 때 작동할 이벤트
			deleteBtns[i].addEventListener("click", function(){
				let toDelete=confirm("이 태그를 삭제하시겠습니까?");
				if(toDelete){
					// 해당 경로를 요청하면서 object 전달
					ajaxPromise("${pageContext.request.contextPath}/store/manage/deleteTag.do", "post", obj)
					.then(function(response){
						return response.json();
					}).then(function(data){
						if(data.isDeleted){
							// 해당 태그 버튼과 삭제버튼을 지움.
							tags[i].remove();
							deleteBtns[i].remove();
						} else {
							alert("태그 삭제에 실패했습니다. 문제가 반복된다면 문의 바랍니다.");
						}
					});	
				}
			});
		}
	}
	
	// 매장 정보 수정
	// 수정완료, 취소 링크 영역
	let updateBox=document.querySelector("#updateBox");
	// 뿌려주는 정보(매장 이름, 주소, 영업시간)
	let storeDatas=document.querySelectorAll(".storeData");
	// 수정 form input들
	let updateInputs=document.querySelectorAll(".updateData");
	
	// 수정 form 매장정보수정 -> 수정완료, 취소 변환 method
	document.querySelector("#updateBtn").addEventListener("click", function(){
		// 정보 수정 링크를 숨김
		this.style.display="none";
		// 수정완료, 취소 링크를 보이게 함
		updateBox.style.display="block";
		// input들을 보이게 함
		for(let i=0; i<updateInputs.length; i++){
			updateInputs[i].style.display="block";
		}
	});
	
	let updateBtn=document.querySelector("#updateBtn");
	// 수정 form 수정완료, 취소 변환 -> 매장정보수정 method
	document.querySelector("#updateCancel").addEventListener("click", function(){
		// 수정완료, 취소 링크를 숨김
		updateBox.style.display="none";
		// 매장정보수정 링크를 보이게 함
		updateBtn.style.display="block";
		// input들을 숨김
		for(let i=0; i<updateInputs.length; i++){
			updateInputs[i].style.display="none";
		}
	});
	
	// 수정 완료 버튼 눌렀을 때 동작하는 method
	document.querySelector("#update").addEventListener("click", function(){
		// 수정 폼의 참조값을 얻어옴
		let updateForm=document.querySelector("#updateForm");
		ajaxFormPromise(updateForm)
		.then(function(response){
			return response.json();
		}).then(function(data){
			if(data.isUpdated){
				// 알람창을 띄우고
				alert("매장 정보를 수정했습니다.");
				// 수정완료, 취소 링크를 숨김
				updateBox.style.display="none";
				// 매장 정보 수정 링크를 보이게 함
				updateBtn.style.display="block";
				// input 창의 값을 수정값으로 바꾸고 input창을 숨김
				for(let i=0; i<updateInputs.length; i++){
					storeDatas[i].innerText=updateInputs[i].value;
					updateInputs[i].style.display="none";
				}
			} else {
				alert("매장 정보 수정에 실패했습니다. 문제가 반복된다면 문의 바랍니다.");
			}
		});
	});
	
	// 이미지를 눌렀을 때 동작하는 영역
	let imgLinks=document.querySelectorAll(".updateImgLink");
	let updateImgBtns=document.querySelectorAll(".updateImgBtn");
	
	let imageInputs=["#logoImage", "#repImage1", "#repImage2", "#repImage3", "#repImage4"];
	let imageForms=["#logoForm", "#imageForm1", "#imageForm2", "#imageForm3", "#imageForm4"];
	let imageList=["#image_logo", "#image_1", "#image_2", "#image_3", "#image_4"];
	
	for(let i=0; i<imageList.length; i++){
		imgLinks[i].addEventListener("click", function(e){
			e.preventDefault();
			
			document.querySelector(imageInputs[i]).click();
			updateImgBtns[i].style.display="block";
		});
		viewThumbNail(imageInputs[i], imageList[i]);
		updateImage(imageForms[i], i);
	}
	
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
	        	console.log(e);
	            let previewImg=document.querySelector(imageID);
	            previewImg.src=e.target.result;
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	// 매장 로고 등록 시 동작하는 method
	function updateImage(rel, i){
		document.querySelector(rel).addEventListener("submit", function(e){
			// 일단 form 제출을 막음
			e.preventDefault();
			ajaxFormPromise(this)
			.then(function(response){
				return response.json();
			}).then(function(data){
				if(data.isUpdated){
					updateImgBtns[i].style.display="none";
					alert("이미지를 수정하였습니다.");
				} else {
					alert("이미지를 수정하지 못했습니다. 문제가 반복된다면 문의 바랍니다.");
				}
			});
		});
	}
		
	let storeOnOffBtn = document.querySelector('#storeOnOffBtn');

	// 매장 열기 or 닫기 작업
	storeOnOffBtn.addEventListener("click", function(e){
		e.preventDefault();

		let self=this;
		let num=${dto.num}
		let storeOpen="no";
		if(this.innerText=="매장 열기"){
			let switchOn=confirm("매장을 열겠습니까?");
			if(switchOn){
				storeOpen="yes";
				onoff(num, storeOpen, self);	
			}
		} else if(this.innerText=="매장 닫기"){
			let switchOff=confirm("매장을 닫겠습니까?");
			if(switchOff){
				storeOpen="no";
				onoff(num, storeOpen, self);
			}
		}
	});
	
	function onoff(num, storeOpen, self){
		let obj={num, storeOpen}
		
		ajaxPromise("${pageContext.request.contextPath}/store/manage/storeOnOff.do", "post", obj)
		.then(function(response){
			return response.json();
		}).then(function(data){
			if(data.isSwitched && storeOpen=="yes"){
				self.innerText="매장 닫기";
				storeOnOffBtn.style.backgroundColor="lightGray";
				storeOnOffBtn.style.color="white";
			} else if(data.isSwitched && storeOpen=="no"){
				self.innerText="매장 열기";
				storeOnOffBtn.style.backgroundColor="white";
				storeOnOffBtn.style.color="#598eff";
			} else if(!data.isSwitched){
				alert("매장 on/off 작업에 문제가 발생했습니다. 문제가 반복된다면 문의 바랍니다.");
			}
		});
	}
	
	// 매장 정보를 삭제하는 method
	document.querySelector("#deleteStoreBtn").addEventListener("click", function(e){
		e.preventDefault();
		
		let wantDelete=confirm("이 매장의 정보를 삭제하시겠습니까?");
		if(wantDelete){
			// 이 매장의 DB 번호
			let num=this.getAttribute("data-num");
			ajaxPromise("${pageContext.request.contextPath}/store/manage/deleteStore.do", "post", "num="+num)
			.then(function(response){
				return response.json();
			}).then(function(data){
				if(data.isDeleted){
					alert("매장 정보를 삭제하였습니다.");
					location.href="${pageContext.request.contextPath}/main.do?area=&keyword=";
				}
			});
		}
	});
</script>
</body>
</html>