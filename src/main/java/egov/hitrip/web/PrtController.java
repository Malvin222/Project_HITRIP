package egov.hitrip.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egov.hitrip.service.MemberService;
import egov.hitrip.service.MemberVO;
import egov.hitrip.service.PackVO;
import egov.hitrip.service.PageVO;
import egov.hitrip.service.PlanService;
import egov.hitrip.service.PlanVO;
import egov.hitrip.service.PrtService;
import egov.hitrip.service.PrtVO;

@Controller
public class PrtController {

	@Resource(name = "planService")
	PlanService planService;

	@Resource(name = "prtService")
	PrtService prtService;

	@Resource(name = "memberService")
	MemberService memberService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@RequestMapping("/prtBoardWrite.do")
	public String prtBoardWrite(PlanVO vo, ModelMap model, HttpSession session) throws Exception {

		String url = "prtboard/prtBoardWrite";
		
		String userid = (String) session.getAttribute("SessionUserID");
		String adminid = (String) session.getAttribute("SessionAdminID");
		String superid = (String) session.getAttribute("SessionAdminSuperID");
		
		// 주소를 써서 다이렉트로 들어온 경우 세션이 없으므로 주소를 바꿈
		if (userid == null && adminid == null && superid == null) {
		    url = "redirect:/loginWrite.do"; // 아예 로그인 화면으로 보내버림
		}

		PlanVO plan = planService.selectPlanDetail(vo);

		String month = plan.getPlanmonth() + "";
		String emonth = plan.getPlanemonth() + "";
		String day = plan.getPlanday()+"";	//	종료일
		String eday = plan.getPlaneday()+"";	//	종료일
		
		if (plan.getPlanmonth() < 10) { // 9월까지는 앞에 0을 붙여줘야 mm형식에 맞음
			month = "0" + month;
		}
		if (plan.getPlanemonth() < 10) { // 9월까지는 앞에 0을 붙여줘야 mm형식에 맞음
			emonth = "0" + emonth;
		}
		if( plan.getPlanday() < 10 ) {	//	9일까지는 앞에 0을 붙여줘야 dd형식에 맞음
			day = "0"+day;
		}
		if( plan.getPlaneday() < 10 ) {	//	9일까지는 앞에 0을 붙여줘야 dd형식에 맞음
			eday = "0"+eday;
		}
		
		String plansdate = plan.getPlanyear() + "-" + month + "-" + day;
		String planedate = plan.getPlaneyear() + "-" + emonth + "-" + eday;

		plan.setUserid(userid);

		String content = plan.getPlancontent();
		content = content.replace("\\n", "<br>");
		content = content.replace(" ", "&nbsp;");

		plan.setPlancontent(content);

		model.addAttribute("PlanVO", plan);
		model.addAttribute("plansdate", plansdate);
		model.addAttribute("planedate", planedate);

		return url;
	}

	// 패키지 여행 저장
	@RequestMapping("/prtBoardWriteSave.do")
	@ResponseBody
	public String insertPrtBoardWriteSave(@RequestParam Map<String, Object> map1,
			MultipartHttpServletRequest multiRequest, String planunq) throws Exception {

		String str = "";
		int result1 = 0;
		
		// map --> {"title":"12121121212","content":"aaaaaa"}
		System.out.println(map1);
		if (map1.get("planopen").equals("미등록")) {
			
			result1 = planService.updatePlanOpen(map1);
			
		}

		if (result1 == 1 || map1.get("planopen").equals("등록")) {
			str = "ok";
			String path = propertiesService.getString("Globals.fileStorePath4");
			
			String userid = (String) map1.get("userid");
			
			MemberVO mvo = memberService.selectMemberDetail(userid);
			
			map1.put("userage", mvo.getUserage());
			map1.put("usergender", mvo.getUsergender());
			
			// 파일업로드는 아래 메소드에서 진행
			Map<String, String> map2 = uploadProcess(multiRequest, path);
			String prtsrc = "";
			//	최대 10개까지 진행
			//	두번째부터는 앞에,를 넣어서 집어넣음
			for (int i = 1; i <= 10; i++) {
				if (map2.get("file"+i) != null && !map2.get("file"+i).equals("")) {
					if( i == 1) {
						prtsrc += map2.get("file"+i);
					} else if( i != 1 ) {
						prtsrc += ","+map2.get("file"+i);
					}
				}
			}
			
			map1.put("prtsrc", prtsrc);
			
			String result = prtService.insertPrtBoard(map1);
			if (result != null)
				str = "error";
		}
			
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
				//UUID자체가 이미 길기때문에 파일명도 길다면 전체 이름이 너무 길어짐
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

	@RequestMapping("/prtBoardList.do")
	public String selectPrtBoardList(PageVO vo, ModelMap model, HttpSession session) throws Exception {
		String url = "prtboard/prtBoardList";
		
		vo.setPageUnit(20);
		
		int pageUnit = vo.getPageUnit();
		
		//	현재 페이지 번호
		int pageIndex = vo.getPageIndex();
		//	firstIndex 값 계산
		int firstIndex = (pageIndex-1)*pageUnit + 1;
		//	lastIndex 값 계산
		int lastIndex = pageIndex*pageUnit;
		
		vo.setFirstIndex(firstIndex);
		vo.setLastIndex(lastIndex);
		
		int total = prtService.selectPrtTotal(vo);
		
		//	화면출력 시작번호
		int recordCountPerPage = total - ((pageIndex-1)*pageUnit);
		vo.setRecordCountPerPage(recordCountPerPage);
		
		int lastPage = (int) Math.ceil((double)total/pageUnit);
		vo.setLastPage(lastPage);
		
		List<?> list = prtService.selectPrtList(vo);
		
		model.addAttribute("PageVO",vo);
		model.addAttribute("PrtList",list);
		model.addAttribute("total",total);
		
		return url;
	}
	
	@RequestMapping("/prtBoardDetail.do")
	public String selectPrtBoardDetial(String prtunq,PrtVO vo, ModelMap model, HttpSession session) throws Exception{
		String url = "prtboard/prtBoardDetail";
		
		String userid = (String) session.getAttribute("SessionUserID");
		String adminid = (String) session.getAttribute("SessionAdminID");
		String superid = (String) session.getAttribute("SessionAdminSuperID");		
		// 주소를 써서 다이렉트로 들어온 경우 세션이 없으므로 주소를 바꿈
		if( userid == null && adminid == null && superid == null ) {
		    url = "redirect:/loginWrite.do"; // 아예 로그인 화면으로 보내버림
		}
		//조회수 증가
		prtService.updatePrtBoardHits(prtunq);
		
		//상세보기
		PrtVO pvo = prtService.selectPrtBoardDetail(vo);
		
		String content = pvo.getPrtcontent();
		content = content.replace("\n", "<br>");
		content = content.replace(" ", "&nbsp");
		pvo.setPrtcontent(content);
		
		model.addAttribute("PrtVO",pvo);
		//댓글 리스트
		List<?> prtBoardCmList = prtService.selectPrtBoardCm(vo);
		model.addAttribute("PrtCmList",prtBoardCmList);
		
		return url;
	}
	
	@RequestMapping("/prtBoardModify.do")
	public String selectPrtBoardModify(PrtVO vo,ModelMap model) throws Exception{
		
		PrtVO pvo = prtService.selectPrtBoardDetail(vo);
		model.addAttribute("PrtVO",pvo);
		
		return "prtboard/prtBoardModify";
		
	}
	@RequestMapping("/prtBoardModifySave.do")
	@ResponseBody
	public String updatePrtBoard(PrtVO vo, MultipartHttpServletRequest multiRequest) throws Exception{
		String path = propertiesService.getString("Globals.fileStorePath4");
		
		//	DB에 저장되어 있는 prtsrc값을 가져옴
		PrtVO pvo = prtService.selectPrtBoardDetail(vo);
		String orgPrtsrc = pvo.getPrtsrc();
		
		Map<String, String> map2 = uploadProcess(multiRequest, path);
		String prtsrc = "";

		//	최대 10개까지 진행
		//	두번째부터는 앞에,를 넣어서 집어넣음
		for (int i = 1; i <= 10; i++) {
			if (map2.get("file"+i) != null && !map2.get("file"+i).equals("")) {
				if( i == 1) {
					prtsrc += map2.get("file"+i);
				} else if( i != 1 ) {
					prtsrc += ","+map2.get("file"+i);
				}
			}
		}
		//	prtsrc가 비어 있다면 새로운 업로드 파일이 없으므로
		//	기존의 orgPrtsrc를 vo에 셋팅해줌
		if( prtsrc.equals("") || prtsrc == null ) {
			vo.setPrtsrc(orgPrtsrc);
		} else {
			vo.setPrtsrc(prtsrc);
		}		
		
		String str = "";
		int result = prtService.updatePrtBoard(vo);
		if(result == 1 ) str = "ok";
		
		return str;
	}
	
	@RequestMapping("/prtBoardDelete.do")
	@ResponseBody
	public String deletePrtBoard(String prtunq) throws Exception{
		
		String planunq = prtService.selectPlanunq(prtunq);
		
		planService.updatePlanClose(planunq);
				
		String str="";
		int cnt = prtService.deletePrtBoard(prtunq);
		if (cnt == 1) str = "okdelete";
		
		return str;
		
	}
	
	@RequestMapping("/prtBoardCmWriteSave.do")
	@ResponseBody
	public String insertPrtBoardCm(PrtVO vo) throws Exception {

		String str = "";
		// insert -> 성공:null, 실패:x
		String result = prtService.insertPrtBoardCm(vo);
		if( result == null ) str = "ok";
		
		return str;
	}

	@RequestMapping("/prtBoardCmUpdate.do")
	@ResponseBody
	public String updatePrtBoardCm(PrtVO vo) throws Exception {

		String str = "";

		int cnt = prtService.updatePrtBoardCm(vo);
		if(cnt ==1 ) str = "ok";
		
		return str;
	}
	
	@RequestMapping("/prtBoardCmDelete.do")
	@ResponseBody
	public String deletePrtBoardCm(PrtVO vo) throws Exception{
		
		String str="";
		int cnt = prtService.deletePrtBoardCm(vo);
		if (cnt == 1) str = "okcmdelte";
		
		return str;
		
	}
}
