package egov.hitrip.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egov.hitrip.service.PlanService;
import egov.hitrip.service.PlanVO;
import egov.hitrip.service.PrtService;

@Controller
public class PlanController {

	@Resource(name="planService")
	PlanService planService;
	
	@Resource(name = "prtService")
	PrtService prtService;
	
	@RequestMapping("planMain.do")
	public String planMain(PlanVO vo, ModelMap model, HttpSession session) throws Exception {
		
		String url = "planboard/planMain";
		String userid = (String) session.getAttribute("SessionUserID");
		String superid = (String) session.getAttribute("SessionAdminSuperID");

		// 주소를 써서 다이렉트로 들어온 경우 세션이 없으므로 주소를 바꿈
		if (userid == null && superid == null) {
		    url = "redirect:/loginWrite.do"; // 아예 로그인 화면으로 보내버림
		} 

		vo.setUserid(userid);

		List<String> modifiedList = new ArrayList<>();
		List<?> list = planService.selectPlanList(vo);

		for (Object item : list) {
		    // 개행 문자를 \n으로 변환하여 리스트에 추가
		    String modifiedItem = item.toString().replaceAll("(\r\n|\r|\n|\n\r)", "\\\\n");
		    modifiedList.add(modifiedItem);
		}
		System.out.println(modifiedList);
		// 변환된 데이터를 담을 리스트
		List<Map<String, Object>> convertedList = new ArrayList<>();

		for (String item : modifiedList) {
		    // JSON 형태의 문자열을 Map으로 변환
		    Map<String, Object> map = new HashMap<>();
		    item = item.replace("{", "").replace("}", ""); 	// 중괄호 제거
		    String[] keyValuePairs = item.split(", ");		//	배열안에 ,로 데이터 구분되어있음
		    for (String pair : keyValuePairs) {				//	위에서 split로 나눈 값을 pair에 담음(planunq=102)
		        String[] keyValue = pair.split("=");		//	= 로 다시 한번 나눠서 keyValue에 담음 planunq,102
		        map.put(keyValue[0], keyValue[1]);			//	맵에 넣음 아이디 : "planunq", 값 : 102
		    }
		    
		    //제목이 11글자를 넘어가면 9글자까지만 잘라내고 ... 붙여서 출력
		    String plantitleValue = (String) map.get("plantitle");
		    if( plantitleValue.length() > 11 ) {
		    	map.put("plantitle", plantitleValue.substring(0, 9)+"...");
		    }

		    // 필요한 필드를 정수로 변환하여 다시 맵에 넣음
		    map.put("planunq", Integer.parseInt((String) map.get("planunq")));
		    map.put("planyear", Integer.parseInt((String) map.get("planyear")));
		    map.put("planmonth", Integer.parseInt((String) map.get("planmonth")));
		    map.put("planday", Integer.parseInt((String) map.get("planday")));
		    map.put("planeyear", Integer.parseInt((String) map.get("planeyear")));
		    map.put("planemonth", Integer.parseInt((String) map.get("planemonth")));
		    map.put("planeday", Integer.parseInt((String) map.get("planeday")));

		    convertedList.add(map);
		}

		list = convertedList;	//	정리되어 넣어진 convertedList를 리스트에 넣어줌

		model.addAttribute("PlanVO", vo);
		model.addAttribute("planList", list);

		return url;
	}
	
	@RequestMapping("planDayList.do")
	public String planDayList() {
		
		return "planboard/planDayList";
	}
	
	@RequestMapping("planWrite.do")
	public String planWrite() {
		
		return "planboard/planWrite";
	}
	
	@RequestMapping("/planWriteSave.do")
	@ResponseBody
	public String insertPlanWrite(PlanVO vo, HttpSession session) throws Exception {
		
		String userid = (String) session.getAttribute("SessionUserID");
		
		String str = "2";
		
		String openplan = vo.getPlanopen();
		if( openplan == null || openplan.equals("") ) {
			vo.setPlanopen("N");
		}
		
		vo.setUserid(userid);
		
		String result = planService.insertPlan(vo);		
		
		if( result == null ) {
			str = "1";	//	이미사용중인아이디
		} 		
		return str;
	}
	
	@RequestMapping("/planDetail.do")
	public String selectPlanDetail(PlanVO vo, ModelMap model, HttpSession session) throws Exception {
		String url = "member/mbrModify";
		String userid = (String) session.getAttribute("SessionUserID");
		//	주소를 써서 다이렉트로 들어온경우 세션이 없으므로 주소를 바꿈
		if( userid == null ) {
			url = "redirect:/loginWrite.do";//	아예 로그인화면으로 보내버림
		} 
		
		PlanVO plan = planService.selectPlanDetail(vo);
		
		String month = plan.getPlanmonth()+"";	//	시작일
		String emonth = plan.getPlanemonth()+"";	//	종료일
		String day = plan.getPlanday()+"";	//	종료일
		String eday = plan.getPlaneday()+"";	//	종료일
		
		if( plan.getPlanmonth() < 10 ) {	//	9월까지는 앞에 0을 붙여줘야 mm형식에 맞음
			month = "0"+month;
		}
		if( plan.getPlanemonth() < 10 ) {	//	9월까지는 앞에 0을 붙여줘야 mm형식에 맞음
			emonth = "0"+emonth;
		}
		if( plan.getPlanday() < 10 ) {	//	9일까지는 앞에 0을 붙여줘야 dd형식에 맞음
			day = "0"+day;
		}
		if( plan.getPlaneday() < 10 ) {	//	9일까지는 앞에 0을 붙여줘야 dd형식에 맞음
			eday = "0"+eday;
		}
		
		//	시작일(yyyy-mm-dd)형식
		String plansdate = plan.getPlanyear() + "-" + month + "-" + day;
		//	종료일(yyyy-mm-dd)형식
		String planedate = plan.getPlaneyear() + "-" + emonth + "-" + eday;
		
		String content = plan.getPlancontent(); content =
		content.replace("\\n","<br>"); 
		content = content.replace(" ","&nbsp;");
		  
		plan.setPlancontent(content);

		plan.setUserid(userid);
		model.addAttribute("PlanVO", plan);
		//	시작일, 종료일 model에 주입해서 보냄
		model.addAttribute("plansdate",plansdate);
		model.addAttribute("planedate",planedate);
		
		return "planboard/planDetail";
	}
	
	@RequestMapping("/planModify.do")
	public String selectPlanModify(PlanVO vo, ModelMap model, HttpSession session) throws Exception {
		
		String url = "planboard/planModify";
		String userid = (String) session.getAttribute("SessionUserID");
		//	주소를 써서 다이렉트로 들어온경우 세션이 없으므로 주소를 바꿈
		if( userid == null ) {
			url = "redirect:/loginWrite.do";//	아예 로그인화면으로 보내버림
		}	
		
		PlanVO plan = planService.selectPlanDetail(vo);
		
		String month = plan.getPlanmonth()+"";
		String emonth = plan.getPlanemonth()+"";
		String day = plan.getPlanday()+"";
		String eday = plan.getPlaneday()+"";
		
		if( plan.getPlanmonth() < 10 ) {	//	9월까지는 앞에 0을 붙여줘야 mm형식에 맞음
			month = "0"+month;
		}
		if( plan.getPlanemonth() < 10 ) {	//	9월까지는 앞에 0을 붙여줘야 mm형식에 맞음
			emonth = "0"+emonth;
		}
		if( plan.getPlanday() < 10 ) {	//	9일까지는 앞에 0을 붙여줘야 dd형식에 맞음
			day = "0"+day;
		}
		if( plan.getPlaneday() < 10 ) {	//	9일까지는 앞에 0을 붙여줘야 dd형식에 맞음
			eday = "0"+eday;
		}
		
		String plansdate = plan.getPlanyear()+"-"+month+"-"+day;
		String planedate = plan.getPlaneyear()+"-"+emonth+"-"+eday;
		
		plan.setUserid(userid);		
		
	    String content = plan.getPlancontent(); content =
	    content.replace("\\n","<br>"); 
	    content = content.replace(" ","&nbsp;");
	  
	    plan.setPlancontent(content);		 
		
		model.addAttribute("PlanVO",plan);
		model.addAttribute("plansdate",plansdate);
		model.addAttribute("planedate",planedate);
		
		return url;
	}
	
	@RequestMapping("/planModifySave.do")
	@ResponseBody
	public String updatePlan(PlanVO vo) throws Exception {
		
		String planopen = vo.getPlanopen();
		if( planopen == null ) { planopen = "N"; }		
		if( planopen.equals("N") ) {			
			String prtunq = planService.selectPrtunq(vo.getPlanunq());			
			prtService.deletePrtBoard(prtunq);
		}
		
		vo.setPlanopen(planopen);
		
		int result = planService.updatePlan(vo);
		
		String str = "";
		if(result == 1) str = "ok";
		else str = "fail";
		
		return str;
	}
	
	@RequestMapping("/planDelete.do")
	@ResponseBody
	public String adminNoticeDelete(PlanVO vo) throws Exception {

		int result = planService.deletePlan(vo);
		String str = "";
		if (result == 1)
			str = "ok";
		else
			str = "fail";

		return str;
	}
}
