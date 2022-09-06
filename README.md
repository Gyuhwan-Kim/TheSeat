# TheSeat (부제 : 자리 있어요?)
1. [개요](#개요)
2. [팀원 및 개발 기간](#팀원-및-개발-기간)
3. [개발 환경](#개발-환경)
4. [디자인 시안](#디자인-시안)
5. [페이지 및 주요 기능](#페이지-및-주요-기능)

## 개요
한여름의 땡볕 더위에 빈자리가 없을 수 있는 매장을 방문하는 불안함, 실제로 자리가 없어 다른 곳을 찾아 가는 안타까움을 겪고 만들게 된 페이지.

등록된 매장에 현재 자리가 있는지 여부를 알 수 있고 자리에 앉거나 방문 전에 미리 자리를 지정하고 주문을 할 수 있는 페이지.

유저가 운영하는 매장에 대한 정보를 만들어 매장 정보, 메뉴, 좌석, 주문 내용을 관리할 수 있음.

## 팀원 및 개발 기간
- 총원 : 4명
- Front-end : 고지은, 신현미
- Back-end : **김규환**, 이근영
- UI Design : 고지은
- 개발 기간 : 2021.08.19. ~ 2021.09.13.
---
- 리팩토링 : **김규환**
- 리팩토링 기간 : 2022.07.29. ~ 2022.09.02.

## 개발 환경
- 개발환경(IDE) : Eclipse

- 서버 : Apach Tomcat v8.5

- DB : oracleDB(mybatis v1.2.0), DBdiagram

- 협업 : Git Hub, Notion

- 디자인 툴 : figma

- Frontend : html5, css, javascript, sweetalert, bootstrap

- Backend : Java 8, SpringFramework v4.0.0, jstl v1.2

## 디자인 시안
![image](https://user-images.githubusercontent.com/83267231/188367437-35155626-b30b-40cf-8750-a5a4a4f11626.png)

## 페이지 및 주요 기능
<details>
  <summary>인덱스 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188368454-9d4ad5ed-2bc0-4cbd-83fe-09c581ceb5d5.png)
  
  </div>
</details>

### 1. 인덱스 페이지
- 매장 검색 기능 (지역, 검색 키워드 필터)
- 메인 페이지로의 이동
- 로그인 페이지로의 이동

---
<details>
  <summary>로그인 페이지 & 회원 가입 form 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188370856-38c89067-a569-41e9-b6bc-f854f4b4a9b8.png)
  ![image](https://user-images.githubusercontent.com/83267231/188370914-72593ee4-c37d-4fee-978c-b06e689f6605.png)
  ![image](https://user-images.githubusercontent.com/83267231/188370991-3bcc83f0-a9e1-40ba-aa8d-1f8254dcaa18.png)
  
  </div>
</details>

### 2. 로그인 페이지 & 회원 가입 form
- 로그인
- 유효성 검사를 통한 회원 가입(form modal)

---
<details>
  <summary>메인 페이지 & 사이드 바 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188372406-77503302-eb63-4a73-94c7-169acfabcbec.png)
  ![image](https://user-images.githubusercontent.com/83267231/188372882-e3640a0b-1ba4-4934-9c14-412ef1315581.png)
  
  </div>
</details>

### 3. 메인 페이지 & 사이드 바
- 지역이나 검색 키워드에 맞는 매장 정보를 카드 형식으로 보여줌
- 사이드 바 (로그인/마이 페이지, 매장 관리 목록, 로그 아웃)

---
<details>
  <summary>매장 관리 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188373882-6283d425-5efb-499c-a1d6-ac62cb2ffbfb.png)
  
  </div>
</details>

### 4-1. 매장 관리 페이지
- 매장의 정보를 관리 (상호명, 주소, 전화번호, 영업시간, 태그, 대표 이미지, 매장 정보 삭제)
- 매장이 검색에 노출시킬지 여부 결정 (매장 열기/닫기)
- 매장의 메뉴, 리뷰, 주문, 자리를 관리하는 페이지로의 이동

---
<details>
  <summary>매장 메뉴 관리 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188377037-41ea3ae3-5531-48fd-b082-1f361f44bd98.png)
  ![image](https://user-images.githubusercontent.com/83267231/188377334-d5428113-00ab-42da-9244-3567b948d6ee.png)
  ![image](https://user-images.githubusercontent.com/83267231/188377519-0c963f64-0edc-49c1-9b3c-2a4582d7f16d.png)
  
  </div>
</details>

### 4-2. 매장 메뉴 관리 페이지
- 매장 메뉴의 카테고리 추가/제거
- 매장 메뉴 추가/제거
- 매장 대표 메뉴 설정 (4개까지)

---
<details>
  <summary>매장 리뷰 관리 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188378886-afe3e838-455e-4cb2-bb65-464ac00ca1ee.png)
  
  </div>
</details>

### 4-3. 매장 리뷰 관리 페이지
- 매장 이용자의 리뷰 확인
- 매장 관리자의 답글 작성

---
<details>
  <summary>매장 주문 관리 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188379812-1460bd27-7933-4983-81b8-5f6249b6d6a3.png)
  
  </div>
</details>

### 4-4. 매장 주문 관리 페이지
- 이용자의 주문 정보를 확인 (이용자의 이름, 주문 내역, 결제 금액)
- 주문 내용을 관리자가 승인
- 페이지 새로고침을 통한 주문 내역 업데이트

---
<details>
  <summary>매장 자리 관리 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188380933-4d3e99f0-91b3-4a6c-98e0-30809faa4189.png)
  
  </div>
</details>

### 4-5. 매장 자리 관리 페이지
- 매장 좌석 배치도 이미지 업로드
- 매장 좌석 정보 변경

---
<details>
  <summary>매장 상세 정보 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188382220-9a887bd3-9027-48e7-a39c-0259d6eb2105.png)
  ![image](https://user-images.githubusercontent.com/83267231/188382279-d1899dcf-d972-4aee-86d5-eccb62ff285c.png)
  ![image](https://user-images.githubusercontent.com/83267231/188382944-b805a2b3-757f-46dc-97fb-ca28db27517b.png)
  
  </div>
</details>

### 5. 매장 상세 정보 페이지
- 매장 정보 확인 (상호명, 평균 별점, 태그, 주소, 전화번호, 영업 시간)
- 매장 자리 확인
- 매장 리뷰 확인
- 매장 메뉴 확인
- 주문 페이지로 이동 전에 자리 선택

---
<details>
  <summary>주문 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188382983-8c35adca-d75d-42ef-ad0d-0c79895270f8.png)
  
  </div>
</details>

### 6. 주문 페이지
- 자리 선택 후 주문 페이지로 이동
- 메뉴와 수량 선택
- 총 결제 금액 확인 후 주문

---
<details>
  <summary>마이 페이지 이미지</summary>
  <div markdown="1"> 
  
  ![image](https://user-images.githubusercontent.com/83267231/188381384-a229fa00-7d18-40c0-914a-c58161363f47.png)
  ![image](https://user-images.githubusercontent.com/83267231/188383573-db70057b-1747-4116-b47d-2d39f636bf3b.png)
  
  </div>
</details>

### 7. 마이 페이지
- 계정 정보 변경 (프로필 사진, 이름, 비밀번호, 관심 태그 정보)
- 이용 내역 확인 (상호명, 이용 시간, 주문 내역, 결제 금액)
- 주문 매장 리뷰 확인
- 주문 내역에 대한 리뷰 작성/수정/삭제

## 관련 볼거리 (Readme 기반)
1. [프로젝트를 정리한 team notion](https://www.notion.so/The-Seat-abd4658d30f7479d90483f2b135f5ec3)
2. [발표 영상](https://www.youtube.com/watch?v=WDNLef7isgw)
