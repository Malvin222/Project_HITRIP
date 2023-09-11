package egov.hitrip.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egov.hitrip.service.DefaultVO;
import egov.hitrip.service.ReviewService;
import egov.hitrip.service.ReviewVO;

@Controller
public class ReviewController {

   @Resource(name = "reviewService")
   ReviewService reviewService;

   /** EgovPropertyService */
   @Resource(name = "propertiesService")
   protected EgovPropertyService propertiesService;

   // 여행 후기 목록 출력
   @RequestMapping("/reviewList.do")
   public String reviewList(DefaultVO defaultVO, ModelMap model, ReviewVO vo) throws Exception {

      // 총데이터 개수, 하단에서 각종 계산에 쓰이고 화면으로 올린다.
      int total = reviewService.selectReviewTotal(defaultVO);

      // 화면출력 단위, 각종 계산에 쓰임
      int pageUnit = defaultVO.getPageUnit();

      // 페이징출력 단위, 계산에 쓰임
      int pageSize = defaultVO.getPageSize();

      /*
       * 현재페이지 번호, 각종 계산에 쓰임 기본은 1이고 사용자가 출력번호를 클릭하면 그 값을 받는다.
       */
      int pageIndex = defaultVO.getPageIndex();
      /*
       * 전체데이터에서 출력범위설정의 시작번호, SQL에서 사용 현재페이지번호가 1이면 결과가 1 현재페이지번호가 2이면 결과가 11
       * 현재페이지번호가 3이면 결과가 21 (나와야함) 현재페이지번호-1 결과를 출력단위와 곱하고 최종 +1 처리한다.
       **/
      int firstIndex = (pageIndex - 1) * pageUnit + 1;

      /*
       * 전체데이터에서 출력범위설정의 끝번호, SQL에서 사용 현재페이지번호에서 출력단위를 곱한다.
       */
      int lastIndex = pageIndex * pageUnit;

      // 화면출력시 각 페이지의 시작번호
      int recordCountPerPage = total - ((pageIndex - 1) * pageUnit);

      /*
       * { 페이징 설정 } 시작번호/끝번호/마지막번호 세팅 (현재페이지번호와 페이징나열개수를 이용)
       */  
      int startPage = ((pageIndex - 1) / pageSize) * pageSize + 1;
      int endPage = startPage + (pageSize - 1);
      int lastPage = (int) Math.ceil((double) total / pageUnit);
      if (endPage > lastPage)
         endPage = lastPage;
      int nextPage = endPage + 1;
      int beforePage = startPage - 1;
      
      /** 모든 변수는 SQL로 전달 또는 화면으로 전달을 위해 defaultVO에 담는다. */
      defaultVO.setFirstIndex(firstIndex);
      defaultVO.setLastIndex(lastIndex);
      defaultVO.setRecordCountPerPage(recordCountPerPage);
      defaultVO.setLastPage(lastPage);
      defaultVO.setStartPage(startPage);
      defaultVO.setEndPage(endPage);
      defaultVO.setNextPage(nextPage);
      defaultVO.setBeforePage(beforePage);
      defaultVO.setTotal(total);

      List<?> reviewList = reviewService.selectReviewList(defaultVO);
      model.addAttribute("resultList", reviewList);
      model.addAttribute("vo", defaultVO);
      
      
      // 최신글 new 날짜 설정
      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
      Calendar cal = Calendar.getInstance(); 
      cal.add(Calendar.DAY_OF_MONTH, -3); // 오늘 일자 -3일부터
      String nowday = format.format(cal.getTime());
      model.addAttribute("nowday",nowday);
      
   


      return "review/reviewList";
   }

   // 여행 후기 작성 화면
   @RequestMapping("/reviewWrite.do")
   public String reviewWrite(ModelMap model) throws Exception {

      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
      Calendar cal = Calendar.getInstance(); 
      String nowday = format.format(cal.getTime());
      model.addAttribute("nowday",nowday);
      
      return "review/reviewWrite";
   }

   // 여행 후기 작성 처리
   @RequestMapping("/reviewWriteSave.do")
   @ResponseBody
   public String insertReviewSave(@RequestParam Map<String, Object> map1, MultipartHttpServletRequest multiRequest)
         throws Exception {

      // map --> {"title":"12121121212","content":"aaaaaa"}

      String str = "ok";
      String path = propertiesService.getString("Globals.fileStorePath2");

      // 파일업로드는 아래 메소드에서 진행
      Map<String, String> map2 = uploadProcess(multiRequest, path);
      if (map2.get("file1") != null && !map2.get("file1").equals("")) {
         map1.put("reviewsrc", map2.get("file1"));
      }

      String result = reviewService.insertReviewSave(map1);
      if (result != null)
         str = "error";
      
   

      return str;
   }

   public static Map<String, String> uploadProcess(MultipartHttpServletRequest multiRequest, String path)
         throws Exception {
      String filePath = "";

      /*
       * multiRequest 변수를 통해 파일 정보들을 가져와 Map에 넣음
       */
      Map<String, MultipartFile> files = multiRequest.getFileMap();
      Map<String, String> map1 = new HashMap<String, String>();

      Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
      int number = 1;
      while (itr.hasNext()) {
         Entry<String, MultipartFile> entry = itr.next();
         MultipartFile file = entry.getValue();
         String orgname = file.getOriginalFilename();
         if (orgname.length() > 10) {
             orgname = orgname.substring(orgname.length() - 10);
         }
          //UUID는 범용 고유 식별자
         //UUID가 중복이 전혀 없는 것은 아니지만, 중복될 확률은 희박하다고 한다
         UUID uuid = UUID.randomUUID();
         String fileName = uuid + "_" + orgname;
         
         if (orgname != null && !orgname.equals("")) {
             filePath = path + "/" + fileName;
             file.transferTo(new File(filePath));
             map1.put("file" + number, fileName);
             number++;
          }
      }

      return map1;
   }

   // 여행 리뷰 삭제 처리
   @RequestMapping("/reviewDelete.do")
   @ResponseBody
   public String deleteReview(ReviewVO vo) throws Exception {

      String str = "";
      int result = reviewService.deleteReview(vo);
      if (result == 1)
         str = "ok";

      return str;
   }

   // 여행 리뷰 디테일 화면
   @RequestMapping("/reviewDetail.do")
   public String selectReviewDetail(String reviewunq, ReviewVO vo1, ModelMap model) throws Exception {

      // 조회수 증가
      reviewService.updateReviewHits(reviewunq);
      
      // 좋아요 취소
      int likeCancle = reviewService.selectReviewLike(vo1);
      model.addAttribute("likeCancle",likeCancle);
      
      // 상세보기
      ReviewVO vo = reviewService.selectReviewDetail(reviewunq);
      
      // 내용 개행
      String content = vo.getReviewcontent();
        content = content.replace("\n", "<br>");
        content = content.replace(" ", "&nbsp");
        vo.setReviewcontent(content);
      
      model.addAttribute("vo", vo);
      
      // 댓글 리스트
      List<?> reviewCmList = reviewService.selectReviewCm(vo1);
      model.addAttribute("cmlist",reviewCmList);

      return "review/reviewDetail";

   }
   
   // 좋아요 클릭
   @RequestMapping("/reviewLikeSave.do")
   @ResponseBody
   public String insertReviewLike(String reviewunq, ReviewVO vo) throws Exception {
         
      
      String str = "";
      
      int result = reviewService.selectReviewLike(vo);
      if( result == 0 ) {
         reviewService.insertReviewLike(vo);
         reviewService.updateReviewStar(reviewunq);
         str="ok";
      } else {
         str = "ok1";   
      }
      return str;
   }
   
   // 좋아요 취소
   @RequestMapping("/reviewLikeDelete.do")
   @ResponseBody
   public String deleteReviewLike(String reviewunq,ReviewVO vo) throws Exception {
      
      String str = "";
      
      // 데이터 삭제
      int cnt  = reviewService.deleteReviewLike(vo);
      if( cnt == 1 ) {
         reviewService.deleteReviewLike(vo);
         reviewService.updateReviewStarMinus(reviewunq);
         str = "ok";
      }
      return str;
   }
   
   // 여행 리뷰 수정 처리
   @RequestMapping("/reviewModifySave.do")
   @ResponseBody
   public String updateReviewSave(@RequestParam Map<String, Object> map1, MultipartHttpServletRequest multiRequest) throws Exception{
      
      // map --> {"title":"12121121212","content":"aaaaaa"}

      String path = propertiesService.getString("Globals.fileStorePath2");

      // 파일업로드는 아래 메소드에서 진행
      Map<String, String> map2 = uploadProcess(multiRequest, path);
      if (map2.get("file1") != null && !map2.get("file1").equals("")) {
         map1.put("reviewsrc", map2.get("file1"));
      }
      
      String str = "";
      int result = reviewService.updateReviewSave(map1);
      if(result == 1 ) str = "ok";
      return str;
   }

   
   // 여행 리뷰 댓글 저장 및 수정
   @RequestMapping("/reviewCmWriteSave.do")
   @ResponseBody
   public String insertReviewCm(ReviewVO vo) throws Exception {
         
      String str = "";
      // insert -> 성공:null, 실패:x
      
      if(vo.getCmunq() == null || vo.getCmunq().equals("") ) {
      String result = reviewService.insertReviewCm(vo);
      if( result == null ) str = "ok";
      } else {
         int cnt = reviewService.updateReviewCm(vo);
         if(cnt ==1 ) str = "ok1";
      }
      return str;
   }
   
   // 여행 리뷰 댓글 삭제
   @RequestMapping("/reviewCmDelete.do")
   @ResponseBody
   public String deleteReviewCm(String cmunq) throws Exception {
      
      String str = "";
      // 데이터 삭제
      int cnt  = reviewService.deleteReviewCm(cmunq);

      if( cnt == 1 ) str = "ok";
      return str;
   }

   // 여행 리뷰 수정 화면
   @RequestMapping("/reviewModify.do")
   public String SelectReviewModify(String reviewunq, ModelMap model) throws Exception {

      String url = "review/reviewModify";

      ReviewVO vo = reviewService.selectReviewDetail(reviewunq);
      model.addAttribute("vo", vo);

      return url;
   }
   
   
}