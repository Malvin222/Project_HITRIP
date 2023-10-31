
 ## ✈Project_HITRIP
 <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/6b16103e-ed41-4b14-919c-e08cd448c75e" width="300">

<br>

 * 개발기간
   - 2023-08-01 ~ 2023-09-01
 * 설계 배경
   - 여행자들을 위한 편리한 여행 계획 및 공유 플랫폼을 제공
 * 설계 목적 
   - 여행자들에게 국내여행지, 국내 식당 정보 공유
   - 여행 계획 수립이 어려운 사람들을 위해 패키지 여행의 정보를 제공하며 그 후기를 공유
 * 기능 요약
   - 국내여행지,국내 식당 정보제공
   - 패키지 여행 정보 제공
  
  ### 🔧개발환경
  * Front-End : HTML5, CSS3, JS, jQuery
  * Back-End : Java, ibatis, eGovFrame
  * Database : Oracle
  * Server : Apache
  * API : TourAPI, kakaomap MapsAPI
  * Tool : Eclipse, GitHub

  ### ⚙담당 핵심 기능
  * 기능 글씨 클릭시 해당 코드로 이동됩니다.
  * 기능 이미지 클릭시 크게 출력됩니다.
  <table>
    <tr>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/fddbc64a628c7fde00452c14c79fb6e1eae0104f/src/main/java/egov/hitrip/web/PackReviewController.java#L211C3-L279C5"> 게시판 CRUD .gif
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/fddbc64a628c7fde00452c14c79fb6e1eae0104f/src/main/java/egov/hitrip/web/BsnmController.java#L65-L116">사업자 회원가입 및 로그인 .gif</a>
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/fddbc64a628c7fde00452c14c79fb6e1eae0104f/src/main/webapp/bab/babDetail.jsp#L101-L141"> MapAPI
    </th>
    <th>
      <a href="https://github.com/Malvin222/Project_HITRIP/blob/fddbc64a628c7fde00452c14c79fb6e1eae0104f/src/main/java/egov/hitrip/web/PackReviewController.java#L138-L185"> 사진업로드
    </th>
   </tr>
   <tr>
     <td>
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/52c6633f-6ad0-4be2-9059-c10ed150fda0" width="250" height="300">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/61b758e8-cd6b-4568-8414-2ca830c26b58" width="200" height="300">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/3ae61f8b-12a6-405d-84fb-2d8ef776d834" width="200" height="300">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/eb72c466-f951-4209-8c3c-0d2731319c14" width="200">
     </td>
   </tr>
   <tr>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/bc1ecf7efa27e3ad0501f0bac624378d7c9a0c1a/src/main/webapp/trip/tripList.jsp#L93-L233"> 국내 여행지 및 국내 맛집
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/48e4e2919751bf391cd7f6f6081b6e6d22117d15/src/main/java/egov/hitrip/web/PackController.java#L249C1-L270">댓글 CRUD</a>
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/ec9875e2f63984b958f14f5e025e91d4eef99c8b/src/main/java/egov/hitrip/web/PackController.java#L310-L346"> 추천 .gif
    </th>
    <th>
      <a href="https://github.com/Malvin222/Project_HITRIP/blob/bc1ecf7efa27e3ad0501f0bac624378d7c9a0c1a/src/main/java/egov/hitrip/web/PackReviewController.java#L38C1-L51C3"> 패키지참여 연동 .gif
    </th>
   </tr>
   <tr>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/e774fe36-1727-4edb-9ba1-3c7d3b40ea42" width="250" height="300">
    </td>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/2bf4898a-7ea6-4816-9bfc-cb08aef33634" width="200" height="300">
    </td>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/f01dd117-dfee-4262-be90-359f07a4aa73" width="200" height="300">
    </td>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/c2959b35-28ab-4285-be3e-b1268fb046bf" width="200" height="300">
    </td>
   </tr>
  </table>

   ### 🛠트러블 슈팅 (해결을 누르면 해당 코드로 이동됩니다.)
   - 후기작성시 후기가 등록된 패키지여행 선택시 초기화 오류
     
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/a6926ce0-ecfa-4d72-8cb9-7a72eec4b379" width="200">
    
     - 원인 :
       패키지 제목의 input 상자의 id값을 packtitle_area_input으로 설정하고
       jquery를 이용하여 패키지제목의 value값에 공백을 입력하여 select 상자를 초기화 시키려 했지만
       이러한 방식으로 화면에 출력되는 select 상자는 초기화 되지 않는것을 확인
       
       <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/1619be5e-83b6-4a7a-a46d-a6d82d18c605" width="300">
       
     - [해결](https://github.com/Malvin222/Project_HITRIP/blob/4c27180659330a559bf25e4329bc2ca1a3ce9d30/src/main/webapp/packreview/packReviewWrite.jsp#L191-L200) :
        패키지제목 select상자가 초기화 되게 jqury에서 $(“#pack”).val(“”) 코드로 수정하고
        옵션 “패키지를 선택해주세요”의 속성으로 value=“” 와 기본값으로 선택되게 disabled selected 를 추가
        후기가 작성된 패키지를 선택하면 select상자가 초기화 되며 “패키지를 선택해주세요” 가 됨을 확인

        <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/30422c58-fcfa-483f-9ecd-9c05115769d5" width="300">
        <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/2ab8cd06-9302-4477-966e-224523a0b22e" width="300">


  ### 프로젝트 후기
  첫 프로젝트인 만큼 초기 DB설계가 부족했던점을 느끼었습니다. 
   초기 DB설계로 핵심 기능을 참고하여 관련 DB와 컬럼을 만들어서 시작하였으나, 프로젝트 진행중 기능 구현을 위한 DB로 부족한게 많음을 알았고
    나중에 추가적으로 테이블과 컬럼들이 작성 하였으며 최종적으로는 여러 테이블이 추가적으로 생성되어 지저분해졌습니다.
    프로젝트 종료 후 ERD를 훑어보니, 추가적인 테이블 작성 없이 기존 존재하는 테이블에 컬럼만 추가해도 기능 구현하는데있어 충분하다고 생각이 들었고 
    프로젝트의 기반이 되는 초기 DB설계의 중요성과, 기능확장을 고려하여 유연한 구조로 DB를 설계하여 명확하고 구체적인 ERD를 작성하여 앞으로의 프로젝트시 
    좀 더 나은 DB설계를 해야함을 다짐했습니다.

   ### 🥇프로젝트 포트폴리오 발표회 최우수상 수상

  <p align="center">
  <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/923f9c2d-8b93-41df-bb11-4f98c990b262" width="300">
  </p>



