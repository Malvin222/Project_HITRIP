package egov.hitrip.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.hitrip.service.AdminService;
import egov.hitrip.service.BabService;
import egov.hitrip.service.BabVO;
import egov.hitrip.service.DefaultVO;
import egov.hitrip.service.NoticeVO;
import egov.hitrip.service.PackReviewService;
import egov.hitrip.service.PackService;
import egov.hitrip.service.PackVO;
import egov.hitrip.service.PageVO;
import egov.hitrip.service.PrtService;
import egov.hitrip.service.ReviewService;
import egov.hitrip.service.TripService;
import egov.hitrip.service.TripVO;

@Controller
public class MainController {

	@Resource( name = "adminService" )
	AdminService adminService;
	
	@Resource( name = "prtService" )
	PrtService prtService;
	
	@Resource( name = "reviewService" )
	ReviewService reviewService;
	
	@Resource(name = "tripService")
	TripService tripService;
	
	@Resource(name = "babService")
	BabService babService;
	
	@Resource(name="packService")
	PackService packService;
	
	@Resource(name = "packReviewService")
	PackReviewService packReviewService;
	
	@RequestMapping("/index.do")
	public String index() {
		
		return "index";
	}
	
	@RequestMapping("/main.do")
	public String main(PageVO pvo, DefaultVO dvo, TripVO tvo, BabVO bvo, PackVO pavo, ModelMap model) throws Exception {
		
		List<?> prtlist = prtService.selectPrtList(pvo);
		model.addAttribute("PrtList",prtlist);
		
		List<?> reviewList = reviewService.selectReviewList(dvo);
		model.addAttribute("ReviewList", reviewList);
		
		List<?> triplist = tripService.selectTripHomeList(tvo);		
		model.addAttribute("TripList", triplist);
		
		List<?> bablist = babService.selectBabHomeList(bvo);		
		model.addAttribute("BabList", bablist);
		
		List<?> packlist = packService.selectPackBoardList(pavo);
		model.addAttribute("PackList", packlist);
		
		List<?> packrelist = packReviewService.selectPackReview(dvo);
	    model.addAttribute("PackReList", packrelist);
		
		return "main/main";
	}
	
	@RequestMapping("/noticeList.do")
	public String selectMemberNoticeList(PageVO vo, ModelMap model) throws Exception {
		
		int pageUnit = vo.getPageUnit();
		
		//	현재 페이지 번호
		int pageIndex = vo.getPageIndex();
		//	firstIndex 값 계산
		int firstIndex = (pageIndex-1)*pageUnit + 1;
		//	lastIndex 값 계산
		int lastIndex = pageIndex*pageUnit;
		
		vo.setFirstIndex(firstIndex);
		vo.setLastIndex(lastIndex);
		
		int total = adminService.selectNoticeTotal(vo);
		
		//	화면출력 시작번호
		int recordCountPerPage = total - ((pageIndex-1)*pageUnit);
		vo.setRecordCountPerPage(recordCountPerPage);
		
		int lastPage = (int) Math.ceil((double)total/pageUnit);
		vo.setLastPage(lastPage);
		
		List<?> list = adminService.selectNoticeList(vo);
		
		model.addAttribute("PageVO",vo);
		model.addAttribute("NoticeList",list);
		model.addAttribute("total",total);
		
		return "main/noticeList";
	}
	//	공지사항 상세보기
	@RequestMapping("/noticeDetail.do")
	public String selectMemberNoticeDetail(String noticeunq, ModelMap model, HttpSession session) throws Exception {
		
		//		조회수 증가
		adminService.updateNoticeHits(noticeunq);
		
		//	상세보기
		NoticeVO vo = adminService.selectNoticeDetail(noticeunq);
		
		String content = vo.getNoticecontent();
		content = content.replace("\n", "<br>");
		content = content.replace(" ", "&nbsp");
		vo.setNoticecontent(content);
		
		model.addAttribute("Noticevo",vo);
		
		return "main/noticeDetail";			
	}
   // 이용약관
   @RequestMapping("/service.do")
   public String service() {
      
      return "main/service";
   }
   
   // 개인정보 처리방침
   @RequestMapping("/policy.do")
   public String policy() {
      
      return "main/policy";
   }

}
