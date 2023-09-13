
 ## ✈Project_HITRIP
 <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/fa66fd79-7d18-4626-97d4-1ba96adc029f" width="300">

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
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/fddbc64a628c7fde00452c14c79fb6e1eae0104f/src/main/java/egov/hitrip/web/PackReviewController.java#L211C3-L279C5"> 게시판 및 댓글 CRUD
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/fddbc64a628c7fde00452c14c79fb6e1eae0104f/src/main/java/egov/hitrip/web/BsnmController.java#L65-L116">사업자 회원가입 및 로그인</a>
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
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/fa8cc54c-87a8-4451-9cd4-89c548971d18" width="250" height="250">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/f5fec20f-8d70-46dd-8b9e-208c30ff7786" width="200">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/3ae61f8b-12a6-405d-84fb-2d8ef776d834" width="200">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/123f23fc-712a-44b3-b3e6-0f3ca1428be2" width="200">
     </td>
   </tr>
   <tr>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/bc1ecf7efa27e3ad0501f0bac624378d7c9a0c1a/src/main/webapp/trip/tripList.jsp#L93-L233"> 국내 여행지 및 국내 맛집
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/48e4e2919751bf391cd7f6f6081b6e6d22117d15/src/main/java/egov/hitrip/web/PackController.java#L249C1-L270">댓글</a>
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_HITRIP/blob/ec9875e2f63984b958f14f5e025e91d4eef99c8b/src/main/java/egov/hitrip/web/PackController.java#L310-L346"> 추천
    </th>
    <th>
      <a href="https://github.com/Malvin222/Project_HITRIP/blob/bc1ecf7efa27e3ad0501f0bac624378d7c9a0c1a/src/main/java/egov/hitrip/web/PackReviewController.java#L38C1-L51C3"> 패키지참여 연동
    </th>
   </tr>
   <tr>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/bb1d9270-5501-4404-a2e4-11ee6153c45e" width="250" height="250">
    </td>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/84959ee1-1a26-4e75-b078-260a7013bfe7" width="200">
    </td>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/2d52994d-73cb-4a3d-acfe-0987538d7ea0" width="200">
    </td>
    <td>
     <img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/0f6b2a21-d874-48b4-83bf-b38783cdea4f" width="200">
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




   ### 🥇프로젝트 포트폴리오 발표회 최우수상 수상

  <p align="center"><img src="https://github.com/Malvin222/Project_HITRIP/assets/127707299/6cbfbeb6-5620-4416-ac66-03537b308a25" width="350"></p>



