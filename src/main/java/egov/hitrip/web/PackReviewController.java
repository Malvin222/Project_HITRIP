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
import egov.hitrip.service.PackReviewService;
import egov.hitrip.service.PackReviewVO;

@Controller
public class PackReviewController {

	@Resource(name = "packReviewService")
	PackReviewService packReviewService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	// 패키지여행 작성화면 및 예약목록 출력
	@RequestMapping("/packReviewWrite.do")
	public String packReviewWrite(String userid,PackReviewVO vo,ModelMap model) throws Exception {
		
		List<?> packReserve = packReviewService.selectPackReserve(userid);
		model.addAttribute("packReserve", packReserve);
		  //현재 날짜 출력
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		Calendar cal = Calendar.getInstance(); 
		String nowday = format.format(cal.getTime());
		model.addAttribute("nowday",nowday);
		
		return "packreview/packReviewWrite";
	}
	//패키지 여행 조회
	@RequestMapping("/packReviewCount.do")
	@ResponseBody
	public String packReviewCount(PackReviewVO vo,ModelMap model) throws Exception{
		String str = ""; 
		int packReviewCount = packReviewService.selectPackReviewCount(vo);
		model.addAttribute("packReviewCount",packReviewCount);
		//중복된 패키지 여행후기
		if (packReviewCount !=0) 
			str = "aa";
		
		return str;
	}
	//패키지여행 후기 목록
	@RequestMapping("/packReviewList.do")
	public String packReviewList(DefaultVO defaultVO, ModelMap model) throws Exception{
		
		 // 총데이터 개수, 하단에서 각종 계산에 쓰이고 화면으로 올린다.
	      int total = packReviewService.selectPackReviewTotal(defaultVO);

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

	      List<?> packReviewList = packReviewService.selectPackReview(defaultVO);
	      model.addAttribute("packReviewList", packReviewList);
	      model.addAttribute("vo", defaultVO);

		
		return "packreview/packReviewList";
	}
	
	  // 여행 후기 작성 처리
	  @RequestMapping("/packReviewWriteSave.do")
	  @ResponseBody 
	  public String insertReviewSave(@RequestParam Map<String,Object> map1, MultipartHttpServletRequest multiRequest) throws Exception {
	  
	  // map --> {"title":"12121121212","content":"aaaaaa"}
	  
	  String str = "ok"; 
	  String path = propertiesService.getString("Globals.fileStorePath3");
	  
	  // 파일업로드는 아래 메소드에서 진행 
	  Map<String, String> map2 = uploadProcess(multiRequest,path); 
	  
	  if (map2.get("file1") != null && !map2.get("file1").equals("")) {
	  map1.put("packreviewsrc1", map2.get("file1") ); 
	  }
	  if (map2.get("file2") != null && !map2.get("file2").equals("")) {
		  map1.put("packreviewsrc2", map2.get("file2") ); 
	  }
	
	  String result = packReviewService.insertPakcReviewSave(map1); 
	  
	  if (result != null) str = "error";
	
	  return str; 
	  }
	  
	  public static Map<String, String> uploadProcess(MultipartHttpServletRequest multiRequest, String path) throws Exception { 
		  
		  String filePath = "";
	  
	  //multiRequest 변수를 통해 파일 정보들을 가져와 Map에 넣음
	  
		  Map<String, MultipartFile> files = multiRequest.getFileMap(); Map<String,String> map1 = new HashMap<String, String>();
		  
		  Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator(); 
		  int number = 1; 
			  while (itr.hasNext()) { 
				  Entry<String, MultipartFile> entry = itr.next(); 
				  MultipartFile file = entry.getValue(); 
				  String orgname = file.getOriginalFilename();
					
				  //UUID는 범용 고유 식별자
				  //UUID가 중복이 전혀 없는 것은 아니지만, 중복될 확률은 희박하다고 한다
				  UUID uuid = UUID.randomUUID();
				  String fileName = uuid + "_" + orgname;
				  if (orgname.length() > 10) {
					    orgname = orgname.substring(orgname.length() - 10);
				  }
				  if (orgname != null && !orgname.equals("")) {
			            filePath = path + "/" + fileName;
			            file.transferTo(new File(filePath));
			            map1.put("file" + number, fileName);
			            number++;
			         }
			  }

		  return map1; 
		  }
  	
	  // 여행 리뷰 디테일 화면
	  @RequestMapping("/packReviewDetail.do") 
	  public String selectPackReviewDetail(String packreviewunq, PackReviewVO vo1, ModelMap model) throws Exception {
	  
	  PackReviewVO vo = packReviewService.selectPackReviewDetail(packreviewunq);
	  model.addAttribute("vo", vo);
		  
	  //조회수 증가 
	  packReviewService.updatePackReviewHits(packreviewunq);
	  
	  // 댓글 리스트 
	  List<?> packReviewCmList = packReviewService.selectPackReviewCm(vo1);
	  model.addAttribute("cmlist",packReviewCmList);
	  
	  //좋아요 참여 취소
	  int likeCancle = packReviewService.selectPackReviewLike(vo1);
	  model.addAttribute("likeCancle",likeCancle);
		
	  
	  return "packreview/packReviewDetail";
	  
	  }
		 
	  // 여행 리뷰 수정 화면
	  @RequestMapping("/packReviewModify.do") 
	  public String SelectPackReviewModify(String packreviewunq, ModelMap model) throws Exception {
	  
		  
		  PackReviewVO vo = packReviewService.selectPackReviewDetail(packreviewunq);
		  model.addAttribute("vo", vo);
	 
	  return "packreview/packReviewModify";
	  }
		  
	  // 여행 리뷰 수정 처리
	  
	  @RequestMapping("/packReviewModifySave.do")
	  @ResponseBody 
	  public String updatePackReviewSave(@RequestParam Map<String,Object> map1, MultipartHttpServletRequest multiRequest) throws Exception{
	  
	  // map --> {"title":"12121121212","content":"aaaaaa"}
	  
	  String path = propertiesService.getString("Globals.fileStorePath3");
	  
	  // 파일업로드는 아래 메소드에서 진행 
	  Map<String, String> map2 = uploadProcess(multiRequest,path); 
		  if (map2.get("file1") != null && !map2.get("file1").equals("")) {
		  map1.put("packreviewsrc1", map2.get("file1")); 
		  }
		  if (map2.get("file2") != null && !map2.get("file2").equals("")) {
		 map1.put("packreviewsrc2", map2.get("file2")); 
		  }
		  
	  String str = ""; 
	  int result = packReviewService.updatePackReviewSave(map1); 
	  if(result == 1 ) str = "ok"; 
	  
	  return str; 
	  }
		  
	// 패키지 여행 후기 삭제 처리
		  
	 @RequestMapping("/packReviewDelete.do")
	 @ResponseBody 
	 public String deletePackReview(PackReviewVO vo) throws Exception {
	 
		 String str = ""; 
 		 int result = packReviewService.deletePackReview(vo); 
 		
	 	 if (result == 1) str = "ok";
	 
	   return str; 
	 
	 }
		  
	  // 여행 리뷰 댓글 저장 및 수정
	  @RequestMapping("/packReviewCmWriteSave.do")
	  @ResponseBody 
	  public String insertPackReviewCm(PackReviewVO vo) throws Exception{
	  
	  String str = ""; 
	  // insert -> 성공:null, 실패:x
	  
	  if(vo.getCmunq() == null || vo.getCmunq().equals("") ) { 
	  String result = packReviewService.insertPackReviewCm(vo); 
		  if( result == null ) str = "ok"; 
		  } else { 
			  int cnt = packReviewService.updatePackReviewCm(vo); 
			  if(cnt ==1 ) str = "ok1"; 
		  }
	  return str; 
	  }
	  
	 // 여행 리뷰 댓글 삭제
		  
	  @RequestMapping("/packReviewCmDelete.do")
	  @ResponseBody 
	  public String deletePackReviewCm(String cmunq) throws Exception {
	  String str = ""; 
	  // 데이터 삭제 
	  int cnt = packReviewService.deletePackReviewCm(cmunq);
	  if( cnt == 1 ) str = "ok"; 
	  return str; 
	  }
		  
		// 좋아요 클릭
		@RequestMapping("/packReviewLikeSave.do")
		@ResponseBody
		public String insertPackReviewLike(String packreviewunq, PackReviewVO vo) throws Exception {
				
			
			String str = "";
			
			// insert -> 성공:null, 실패:x
			int result = packReviewService.selectPackReviewLike(vo);
			if( result == 0 ) {
				packReviewService.insertPackReviewLike(vo);
				packReviewService.updatePackReviewStar(packreviewunq);
				str="ok";
			} else {
				str = "ok1";	
			}
			return str;
		}
		
		// 여행 리뷰 좋아요 취소
		@RequestMapping("/packReviewLikeDelete.do")
		@ResponseBody
		public String deletePackReviewLike(String packreviewunq, PackReviewVO vo) throws Exception {
		    String str = ""; // 반환할 결과 문자열 초기화
		    
		    // 데이터베이스에서 해당 리뷰의 좋아요 정보를 조회하여 개수를 가져옴
		    int cnt  = packReviewService.selectPackReviewLike(vo);
		    
		    // 만약 해당 리뷰에 좋아요가 1번 이상 등록되어 있다면
		    if( cnt == 1 ) {
		        // 1. 좋아요 데이터 삭제
		        packReviewService.deletePackReviewLike(vo);
		        
		        // 2. 해당 리뷰의 별점을 1 감소시킴
		        packReviewService.updatePackReviewStarMinus(packreviewunq);
		        
		        // 결과 문자열을 "ok"로 설정하여 좋아요 취소 작업이 성공했음을 나타냄
		        str = "ok";
		    }
		    
		    // 최종 결과 문자열 반환 ("ok" 또는 빈 문자열)
		    return str;
		}
			  


}