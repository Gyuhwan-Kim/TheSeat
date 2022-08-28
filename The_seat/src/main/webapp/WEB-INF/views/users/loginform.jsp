<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/loginform.css?ver-3"
	type="text/css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<!-- 왼쪽 텍스트 -->
			<section class="col col__section">
				<p>이젠, 빈자리 찾아 해매지 말자!</p>
				<span style="font-size: 4em; font-family: 'Do Hyeon', sans-serif;">자리..<br>있어요?
				</span>
			</section>

			<!-- 오른쪽 로그인바 -->
			<section class="col col__section">
				<form id="loginForm"
					action="${pageContext.request.contextPath}/users/login.do?redirect=${redirect}"
					method="post">
					<div>
						<label class="label" for="email">Email</label><br> <input
							id="id" class="form-control" type="text" placeholder="이메일"
							required="required" /><span>@</span> <select name="emailAddr"
							id="emailAddr">
							<option value="naver.com">네이버</option>
							<option value="gmail.com">구글</option>
							<option value="daum.net">다음</option>
						</select> <input type="hidden" id="emailLogin" name="email" />
					</div>
					<div>
						<label class="label" for="password">Password</label><br> <input
							id="loginPwd" class="form-control" type="password" name="pwd"
							placeholder="비밀번호" required="required" />
					</div>
					<button class="text-btn" type="submit" style="font-weight: 500;">Continue</button>
				</form>

				<div class="line-section">
					<div class="line"></div>
					<span>OR</span>
					<div class="line"></div>
				</div>
				<button type="button" style="color: #ffe030; font-weight: 500;" class="text-btn" data-bs-toggle="modal"
									data-bs-target="#modal-signupForm">Signup</button>
			</section>
		</div>
	</div>
	
<!----------------------------회원가입 모달 ----------------------------------------->
<div class="modal animate__animated animate__bounce animate__fadeInDown"
    tabindex="-1" id="modal-signupForm" aria-labelledby="signupForm"
    aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">
                    <strong>회원가입</strong>
                </h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="signupForm"
                    action="${pageContext.request.contextPath}/users/signup.do"
                    method="post" class="needs-validation" style="max-width:500px;">
                    <div>

                        <input id="idSignup" class="form-control" type="text"
                            placeholder="이메일" required="required" /><span>@</span> <select
                            name="emailAddrSignup" id="emailAddrSignup">
                            <option value="naver.com">네이버</option>
                            <option value="gmail.com">구글</option>
                            <option value="daum.net">다음</option>
                        </select> <input type="hidden" name="email" id="email">
                        <div class="invalid-feedback">사용할수 없는 이메일 입니다.</div>
                    </div>
                    <div style="display: flex; flex-direction: column; align-items: center;">
                        <input class="form-control" type="password" name="pwd" id="pwd"
                            placeholder="비밀번호 (5~10글자 이내)" required="required"> 
                        <div class="invalid-feedback">비밀번호를 확인 하세요.</div>
                            <small
                            class="form-text">5글자~10글자 이내로 입력하세요.</small>
                    </div>
                    <div>
                        <input class="form-control" type="password" name="pwd2"
                            id="pwd2" placeholder="비밀번호를 한번 더 입력해주세요" required="required">
                        <div class="invalid-feedback">비밀번호를 확인 하세요.</div>
                    </div>
                    <div>
                        <input class="form-control" type="text" name="name" id="name"
                            placeholder="이름" required="required"> <input
                            class="form-control" type="hidden" name="profile" id="profile"
                            value="profile">
                    </div>
                    <div>
                        <input class="form-control" type="text" pattern="[0-9]+"
                            maxlength="11" name="phoneNumber" id="phoneNumber"
                            placeholder="'-'을 제외한 휴대폰번호" required="required">
                    </div>
                    <div class="line mt-2 mb-2"
                        style="background-color: #2e8eff; width: 100%; height: 2px;"></div>
                    <div class="row signup__menu">
                        <input class="form-control " type="text" name="tag"
                            id="signup__menu-like" style="width: 25vw;"
                            placeholder="죽기전에 먹고죽을 딱한가지 음식은?">
                    </div>
                    <button type="submit" class="submit-btn mt-2 mb-2">가입완료</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
   //----------------------------------로그인---------------------------------------------
   
   // email 입력 폼
   document.querySelector("#id").addEventListener("change",function(){
   	let emailAddr = document.querySelector("#emailAddr").value;
   	let email = this.value + "@" + emailAddr;
   	document.querySelector("#emailLogin").value = email;
   });
   
   document.querySelector("#emailAddr").addEventListener("change",function(){
   	let id = document.querySelector("#id").value;
   	let email = id + "@" + this.value
   	document.querySelector("#emailLogin").value = email;
   });
  
   	//continue 버튼 누르면 ajax 로그인
   	document.querySelector("#loginForm").addEventListener("submit",function(e){
      	//폼 제출 막고
      	e.preventDefault();
      
      	ajaxFormPromise(this)
      		.then(function(response){
               	return response.json();
            }).then(function(data){
            	if(data.isExist){
                   	if(data.isValid){
                      	swal('로그인 성공!',data.result.name+"님 로그인되었습니다.",'success')
                      	.then(function(){
                      		if(data.redirect != null){
                      			location.href = data.redirect;
                      		} else {
                      			location.href="${pageContext.request.contextPath}/main.do?area=&keyword=";
                      		}
                      	})
                   	} else {
                   		swal('로그인 실패!',"아이디와 비밀번호를 확인해 주세요",'warning');
                   	};	
            	} else {
            		swal('로그인 실패!',"아이디가 존재하지 않습니다. 다시 확인해 주세요.",'error');
            	}
            });
      });

   
   //---------------------------------회원가입--------------------------------------------
   
   //email 입력 폼
   document.querySelector("#idSignup").addEventListener("change",function(){
   	let emailAddr = document.querySelector("#emailAddrSignup").value;
   	let email = this.value + "@" + emailAddr;
   	document.querySelector("#email").value = email;
   });
   
   document.querySelector("#emailAddrSignup").addEventListener("change",function(){
   	let id = document.querySelector("#idSignup").value;
   	let email = id + "@" + this.value
   	document.querySelector("#email").value = email;
   });
   
   
  //아이디, 비밀번호, 이메일의 유효성 여부를 관리한 변수 만들고 초기값 대입
  let isEmailValid=false;
  let isPwdValid=false;

  //이메일 입력했을때(input) 실행할 함수 등록 
  document.querySelector("#idSignup").addEventListener("change", function(){
     //일단 is-valid,  is-invalid 클래스를 제거한다.
     document.querySelector("#idSignup").classList.remove("is-valid");
     document.querySelector("#idSignup").classList.remove("is-invalid");
     
     //1. 입력한 이메일 value 값 읽어오기  
     let inputEmail=document.querySelector("#email").value;
     
     //2. util 에 있는 함수를 이용해서 ajax 요청하기
     ajaxPromise("${pageContext.request.contextPath}/users/checkemail.do", "get", "inputEmail="+inputEmail)
     .then(function(response){
        return response.json();
     })
     .then(function(data){
        //data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
        if(data.isExist){//만일 존재한다면
           //사용할수 없는 아이디라는 피드백을 보이게 한다. 
           isEmailValid=false;
           // is-invalid 클래스를 추가한다. 
           document.querySelector("#idSignup").classList.add("is-invalid");
        }else{
           isEmailValid=true;
           document.querySelector("#idSignup").classList.add("is-valid");
        };
     });
  });
  
  document.querySelector("#emailAddrSignup").addEventListener("change", function(){
     //일단 is-valid,  is-invalid 클래스를 제거한다.
     document.querySelector("#idSignup").classList.remove("is-valid");
     document.querySelector("#idSignup").classList.remove("is-invalid");
     
     //1. 입력한 이메일 value 값 읽어오기
     let inputEmail=document.querySelector("#email").value;
     
     //2. util 에 있는 함수를 이용해서 ajax 요청하기
     ajaxPromise("${pageContext.request.contextPath}/users/checkemail.do", "get", "inputEmail="+inputEmail)
     .then(function(response){
        return response.json();
     })
     .then(function(data){
        //data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
        if(data.isExist){//만일 존재한다면
           //사용할수 없는 아이디라는 피드백을 보이게 한다. 
           isEmailValid=false;
           // is-invalid 클래스를 추가한다. 
           document.querySelector("#idSignup").classList.add("is-invalid");
        }else{
           isEmailValid=true;
           document.querySelector("#idSignup").classList.add("is-valid");
        };
     });
  });
  
  //비밀 번호를 확인 하는 함수 
  function checkPwd(){
     
     document.querySelector("#pwd").classList.remove("is-valid");
     document.querySelector("#pwd").classList.remove("is-invalid");
     
     const pwd=document.querySelector("#pwd").value;
     const pwd2=document.querySelector("#pwd2").value;
     
     // 최소5글자 최대 10글자인지를 검증할 정규표현식
     const reg_pwd=/^.{5,10}$/;
     if(!reg_pwd.test(pwd)){
        isPwdValid=false;
        document.querySelector("#pwd").classList.add("is-invalid");
        return; //함수를 여기서 종료
     };
     
     if(pwd != pwd2){//비밀번호와 비밀번호 확인란이 다르면
        //비밀번호를 잘못 입력한것이다.
        isPwdValid=false;
        document.querySelector("#pwd").classList.add("is-invalid");
     }else{
        isPwdValid=true;
        document.querySelector("#pwd").classList.add("is-valid");
     };
  };
  
  //비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
  document.querySelector("#pwd").addEventListener("input", checkPwd);
  document.querySelector("#pwd2").addEventListener("input", checkPwd);
  
  
  // signupForm ajax 요청하기 
  document.querySelector('#signupForm').addEventListener("submit", function(e){
     e.preventDefault();
     
     const signupForm = document.querySelector('#signupForm');
     const isFormValid = isEmailValid && isPwdValid ;
        
     if(!isFormValid) {
        swal('회원가입 실패',"입력이 올바르지 않습니다. 다시 회원가입 해주세요.",'error');
     } else {
        ajaxFormPromise(signupForm)
        .then(function(response){
           return response.json();
        })
        .then(function(data){
           swal('회원가입 성공!',"회원 가입을 축하드립니다.", 'success')
           .then(function(){
            location.href="${pageContext.request.contextPath}/users/loginform.do";	
           })
        });                        
     };
  });
</script>
</body>
</html>