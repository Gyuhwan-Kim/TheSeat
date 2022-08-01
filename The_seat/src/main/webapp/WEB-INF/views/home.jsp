<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자리.. 있어요?</title>
<!-- bootstrap 외부 링크 참조 -->
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
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<style>
	body {
		background-color: #2e8eff;
		color: #fff;
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	#area {
		color: rgb(73, 73, 73);
		font-size: 18px;
		font-weight: 500;
		width: 125px;
		margin-right: 40px;
		height: 50px;
		margin-top: 45px;
		border: none;
		border-radius: 7px;
		text-align-last: center;
		text-align: center;
	}
	
	#area:focus {
		outline: none;
	}
	
	#keyword {
		height: 50px;
		margin-top: 30px;
		outline: none;
		border: none;
		border-radius: 7px;
		text-align: center;
		font-size: 17px;
		font-weight: 500;
	}
	
	#searchBtn {
		width: 400px;
		color: rgb(73, 73, 73);
		font-size: 20px;
		font-weight: 500;
		height: 50px;
		margin-top: 20px;
		border-radius: 7px;
	}
	
	#loginBtn {
		width: 400px;
		color: rgb(73, 73, 73);
		font-size: 20px;
		font-weight: 500;
		height: 50px;
		margin-top: 30px;
		outline: none;
		border: none;
		border-radius: 7px;
	}
	
	.col__section {
		display: flex;
    	flex-direction: column;
    	justify-content: center;
    	align-items: center;
	}
	
</style>
</head>
<body>
	<div class="container-fluid" style="vertical-align: middle; position: absolute; top: 20%;">
	
		<section class="col__section">
			<p style="font-size: 20px; font-weight: 500;">이젠, 빈자리 찾아 헤매지 말자!</p>
			<span style="font-size: 3.5em; font-family: 'Do Hyeon', sans-serif;">자리..<br>있어요?
			</span>
		</section>
		
		<!-- get 방식을 활용해 메인 페이지 URL 에 select & option 태그 설정 -->
		<form action="${pageContext.request.contextPath}/main.do" method="get">
			<div style="text-align: center;">
				<select name="area" id="area">
					<option value="">지역</option>
					<option value="강남">강남구</option>
					<option value="강동">강동구</option>
					<option value="서초">서초구</option>
					<option value="송파">송파구</option>
					<option value="은평">은평구</option>
				</select>
				<input type="text" id="keyword" name="keyword"
					placeholder="오늘은 뭐 먹을까?"/>
			</div>
			<br />
			<div style="text-align: center;">
				<button id="searchBtn" type="submit" class="btn btn-warning">검색</button>
			</div>
		</form>
		
		<c:if test="${sessionScope.email eq null }">
			<div style="text-align: center;">
				<button id="loginBtn" style="background-color: #d4d4d4;"
					onclick="location.href='${pageContext.request.contextPath}/users/loginform.do'">로그인</button>
			</div>
		</c:if>
		
	</div>
</body>
</html>