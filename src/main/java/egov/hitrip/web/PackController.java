
package egov.hitrip.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egov.hitrip.service.PackService;
import egov.hitrip.service.PackVO;
import egov.hitrip.service.ReviewVO;

@Controller
public class PackController {
   @Resource(name = "propertiesService")
   protected EgovPropertyService propertiesService;
   
   @Resource(name="packService")
   PackService packService;
   
   //패키지 여행 글등록 페이지
   @RequestMapping("/packBoardWrite.do")
   public String packBoardWrite() throws Exception{
      return "pack/packBoardWrite";
   }
   
   //패키지 여행 글등록 저장처리
   @RequestMapping("/packBoardWriteSave.do")
   @ResponseBody
   public String insertPackBoardWriteSave(   @RequestParam Map<String,Object> map1
                              ,MultipartHttpServletRequest multiRequest
                           ) throws Exception {
      
      //  map --> {"title":"12121121212","content":"aaaaaa"}
      
      String str = "ok";
      String path = propertiesService.getString("Globals.fileStorePath");
   
      
      // 파일업로드는 아래 메소드에서 진행
      Map<String,String> map2 = uploadProcess(multiRequest,path);
      if(map2.get("file1") != null && !map2.get("file1").equals("")) {
         map1.put("packsrc1", map2.get("file1"));
      }
      if(map2.get("file2") != null && !map2.get("file2").equals("")) {
         map1.put("packsrc2", map2.get("file2"));
      }
      
      String result = packService.insertPackBoardWriteSave(map1);
      if( result != null ) str = "error"; 
      
      
      return str;
   }
   
   public static Map<String,String> uploadProcess( 
                     MultipartHttpServletRequest multiRequest 
                    , String path ) throws Exception {
      String filePath  = "";
      
      /* multiRequest 변수를 통해 파일 정보들을 가져와 Map에 넣음
      * */
      Map<String, MultipartFile> files = multiRequest.getFileMap();            
      Map<String,String> map1 = new HashMap<String,String>();
      
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
   
   //패키지 여행 리스트
   @RequestMapping("/packBoardList.do")
   public String selectPackBoardList(PackVO vo,ModelMap model) throws Exception{
      
      // 총데이터 개수, 하단에서 각종 계산에 쓰이고 화면으로 올린다.
      int total = packService.selectPackBoardTotal(vo);

      // 화면출력 단위, 각종 계산에 쓰임
      int pageUnit = vo.getPageUnit();
      
      // 페이징출력 단위, 계산에 쓰임
      int pageSize = vo.getPageSize();
      
      /* 현재페이지 번호, 각종 계산에 쓰임
       *    기본은 1이고 사용자가 출력번호를 클릭하면 그 값을 받는다. */
      int pageIndex = vo.getPageIndex();
      
      /* 전체데이터에서 출력범위설정의 시작번호, SQL에서 사용
       *    현재페이지번호가 1이면 결과가 1   
       *    현재페이지번호가 2이면 결과가 11  
       *    현재페이지번호가 3이면 결과가 21   (나와야함)
       *    현재페이지번호-1 결과를 출력단위와 곱하고 최종 +1 처리한다.
       **/
      int firstIndex = (pageIndex-1)*pageUnit + 1;
      
      /* 전체데이터에서 출력범위설정의 끝번호, SQL에서 사용
       *    현재페이지번호에서 출력단위를 곱한다. */
      int lastIndex = pageIndex*pageUnit;

      // 화면출력시 각 페이지의 시작번호
      int recordCountPerPage = total - ((pageIndex-1)*pageUnit);

      /* { 페이징 설정 }
       *   시작번호/끝번호/마지막번호 세팅 (현재페이지번호와 페이징나열개수를 이용) */
      int startPage = ((pageIndex-1)/pageSize)*pageSize + 1;
      int endPage   = startPage+(pageSize-1);
      int lastPage = (int) Math.ceil((double)total/pageUnit);
      if( endPage > lastPage ) endPage = lastPage;
      
      int nextPage = endPage + 1;
      int beforePage = startPage - 1;
      
      
      /** 모든 변수는 SQL로 전달 또는 화면으로 전달을 위해 defaultVO에 담는다. */
      vo.setFirstIndex(firstIndex);
      vo.setLastIndex(lastIndex);
      vo.setRecordCountPerPage(recordCountPerPage);
      vo.setLastPage(lastPage);
      vo.setStartPage(startPage);
      vo.setEndPage(endPage);
      vo.setNextPage(nextPage);
      vo.setBeforePage(beforePage);
      vo.setTotal(total);      
      
      List<?> packBoardList = packService.selectPackBoardList(vo);
      
      model.addAttribute("resultList",packBoardList);
      model.addAttribute("vo",vo);
      
      //현재 날짜 출력
      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
      Calendar cal = Calendar.getInstance(); 
      String nowday = format.format(cal.getTime());
      model.addAttribute("nowday",nowday);
            
      
      return "pack/packBoardList";
   }
   
   //패키지 여행 디테일
   @RequestMapping("/packBoardDetail.do")
   public String selectpackBoardDetial(String packunq,PackVO vo1, ModelMap model) throws Exception{
      //조회수 증가
      packService.updatePackBoardHits(packunq);
      
      //상세보기
      PackVO vo = packService.selectPackBoardDetail(packunq);
      model.addAttribute("vo",vo);
      
      //댓글 리스트
      List<?> packBoardCmList = packService.selectPackBoardCm(vo1);
      model.addAttribute("cmlist",packBoardCmList);
      
      //패키지참여취소
      int cancle = packService.selectReserveUserid(vo1);
      model.addAttribute("cancle",cancle);
      
      //좋아요 참여 취소
      int likeCancle = packService.selectPackLike(vo1);
      model.addAttribute("likeCancle",likeCancle);
      
      return "pack/packBoardDetail";
   }
   
   //패키지여행목록삭제
   @RequestMapping("/packBoardDelete.do")
   @ResponseBody
   public String deletePackBoard(String packunq) throws Exception{
      
      String str="";
      int cnt = packService.deletePackBoard(packunq);
      if (cnt == 1) str = "ok";
      
      return str;
      
   }
   //패키지여행게시글수정
   @RequestMapping("/packBoardModify.do")
   public String selectBoardModify(String packunq,ModelMap model) throws Exception{
      
      PackVO vo = packService.selectPackBoardDetail(packunq);
      model.addAttribute("vo",vo);
      
      
      return "pack/packBoardModify";
      
   }
   //패키지여행게시글수정저장처리
   @RequestMapping("/packBoardModifySave.do")
   @ResponseBody
   public String updatePackBoard(@RequestParam Map<String,Object> map1, MultipartHttpServletRequest multiRequest) throws Exception{
      String str = "";

      
      String path = propertiesService.getString("Globals.fileStorePath");
      
      // 파일업로드는 아래 메소드에서 진행
            Map<String,String> map2 = uploadProcess(multiRequest,path);
            if(map2.get("file1") != null && !map2.get("file1").equals("")) {
               map1.put("packsrc1", map2.get("file1"));
            }
            if(map2.get("file2") != null && !map2.get("file2").equals("")) {
               map1.put("packsrc2", map2.get("file2"));
            }
            
            int result = packService.updatePackBoard(map1);
            if(result == 1 ) str = "ok";

      
      return str;
   }
   //패키지여행 댓글 저장 및 수정
   @RequestMapping("/packBoardCmWriteSave.do")
   @ResponseBody
   public String insertPackBoardCm(PackVO vo) throws Exception {
         
         String str = "";
         // insert -> 성공:null, 실패:x
         
         if(vo.getCmunq() == null || vo.getCmunq().equals("") ) {
         String result = packService.insertPackBoardCm(vo);
         if( result == null ) str = "ok";
         } else {
            int cnt = packService.updatePackBoardCm(vo);
            if(cnt ==1 ) str = "ok1";
         }
         System.out.println("|||"+vo.getCmunq());
         return str;
   }
   //댓글삭제
   @RequestMapping("/packBoardCmDelete.do")
   @ResponseBody
   public String deletePackBoardCm(String cmunq) throws Exception {
      
      String str = "";
      // 데이터 삭제
      int cnt  = packService.deletePackBoardCm(cmunq);

      if( cnt == 1 ) str = "ok";
      return str;
   }
   //패키지 참여
   @RequestMapping("/packReserveSave.do")
   @ResponseBody
   public String insertPackReserve(PackVO vo) throws Exception {
         
         String str = "";
         // insert -> 성공:null, 실패:x
         
         
         int result = packService.selectReserveUserid(vo);
         if(result == 1) {
            str = "ok1";   
         }else {
            packService.insertPackReserve(vo);
            str="ok";
         }
         return str;
   }
   //패키지 참여취소
   @RequestMapping("/packReserveDelete.do")
   @ResponseBody
   public String deleteReserve(PackVO vo) throws Exception {
      
      String str = "";
      // 데이터 삭제
      int cnt  = packService.deleteReserve(vo);

      if( cnt == 1 ) str = "ok";
      return str;
   }
   
   // 좋아요 클릭
      @RequestMapping("/packLikeSave.do")
      @ResponseBody
      public String insertPackLike(String packunq, PackVO vo) throws Exception {
            
         
         String str = "";
         
         // insert -> 성공:null, 실패:x
         int result = packService.selectPackLike(vo);
         if( result == 0 ) {
            packService.insertPackLike(vo);
            packService.updatePackStar(packunq);
            str="ok";
         } else {
            str = "ok1";   
         }
         return str;
      }
      
      // 좋아요 취소
      @RequestMapping("/packLikeDelete.do")
      @ResponseBody
      public String deletePackLike(String packunq,PackVO vo) throws Exception {
         
         String str = "";
         
         // 데이터 삭제
         int cnt  = packService.selectPackLike(vo);
         
         if( cnt == 1 ) {
            packService.deletePackLike(vo);
            packService.updatePackStarMinus(packunq);
            str = "ok";
         }
         return str;
      }
   
      
      
}