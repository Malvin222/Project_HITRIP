package egov.hitrip.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egov.hitrip.service.AdminService;
import egov.hitrip.service.BsnmService;
import egov.hitrip.service.MemberService;
import egov.hitrip.service.MemberVO;

@Controller
public class MemberController {

	@Resource(name = "memberService")
	MemberService memberService;
	
	@Resource(name = "adminService")
	AdminService adminService;
	
	@Resource(name = "bsnmService")
	BsnmService bsnmService;
	
	@RequestMapping("/loginWrite.do")
	public String loginWrite() {
		
		return "member/loginWrite";
	}
	
	@RequestMapping("/joinWrite.do")
	public String joinWrite() {
		
		return "member/joinWrite";
	}
	
	@RequestMapping("/mbrConditions.do")
	public String mbrConditions() {
		
		return "member/mbrConditions";
	}
	
	@RequestMapping("/mbrJoinWrite.do")
	public String mbrJoinWrite(ModelMap model) throws Exception {
		
		
		  int no = (int) Math.ceil(Math.random() * 10); String filename =
		  memberService.selectPreventName(no); filename = filename.replace(".jpg", "");
		  
		  model.addAttribute("no",no); model.addAttribute("filename",filename);
		 
		
		return "member/mbrJoinWrite";
	}
	
	@RequestMapping("/preventImg.do")
	@ResponseBody
	public String selectPreventImg(String no) throws Exception {
		
		int no1 = Integer.parseInt(no)+1;
		if( no1 > 10 ) no1 = 1;
		
		String filename = memberService.selectPreventName(no1);
		filename = filename.replace(".jpg", "");
		
		return filename+","+no1;
	}
	
	@RequestMapping("/mbrJoinSave.do")
	@ResponseBody
	public String insertMember(MemberVO vo) throws Exception {
		
		String[] birth = vo.getUserbirth().split("-");
		
		Calendar current = Calendar.getInstance();
        
        int currentYear  = current.get(Calendar.YEAR);			//	현재 년
        int currentMonth = current.get(Calendar.MONTH) + 1;		//	현재 월
        int currentDay   = current.get(Calendar.DAY_OF_MONTH);	//	현재 일
        
        // 만 나이 구하기 2022-1995=27 (현재년-태어난년)
        int age = currentYear - Integer.parseInt(birth[0]);
        // 만약 생일이 지나지 않았으면 -1
        if ( Integer.parseInt(birth[1]) * 100 + Integer.parseInt(birth[2]) > currentMonth * 100 + currentDay) 
            age--;
        if( age < 0 ) age = 0;
        // 5월 26일 생은 526
        // 현재날짜 5월 25일은 525
        // 두 수를 비교 했을 때 생일이 더 클 경우 생일이 지나지 않은 것이다.
		
        vo.setUserage(age+"");
        
        
		String str = "3";
		
		String useropen = vo.getUseropeninfo();
		if( useropen == null || useropen.equals("") ) {
			vo.setUseropeninfo("N");
		}
		
		int result1 = memberService.selectMemberUserid(vo.getUserid());
		
		
		if( result1 == 1 ) {
			str = "2";	//	이미사용중인아이디
		} else {
			result1 = memberService.selectMemberNickname(vo.getUsernickname());
			if( result1 == 1 ) {
				str = "4";	//	닉네임 중복
			} else {
				
				String pass1 = vo.getUserpass();
				String pass2 = MyEncrypt.testMD5(pass1);
				vo.setUserpass(pass2);				
				
				memberService.insertMember(vo);
				str = "1";	//	저장성공
			}			
		}		
		return str;
	}
	
	@RequestMapping("/mbrUserIdCheck.do")
	@ResponseBody
	public String selectMemberUserid(String userid) throws Exception {
				
		String msg = "3";		
		int result = 0;
		int result2 = 0;
		int result3 = 0;
		String pattern = "[a-zA-Z]{1}[0-9a-zA-Z_]{5,19}";
		boolean pattern_chk = userid.matches(pattern);
		
		if( pattern_chk == true ) {
			result = memberService.selectMemberUserid(userid);
			result2 = adminService.selectAdminid(userid);
			result3 = bsnmService.selectBsnmid(userid);
			if( result == 0 && result2 == 0 && result3 == 0 ) {
				msg = "1";
			} else {
				msg = "2";
			}
		}		
		return msg;
	}
	
	@RequestMapping("/logout.do")
	@ResponseBody
	public String logout(HttpSession session) {
		
		session.removeAttribute("SessionUserID");
		
		return "1";
	}
	
	@RequestMapping(value = "/loginSession.do",
					produces = "application/text;charset=utf-8")
	@ResponseBody
	public String loginSession(MemberVO vo,HttpSession session) throws Exception {
		String str = "";
		
		String state = memberService.selectMemberState(vo.getUserid());
		if( !state.equals("1") ) str = "4";
		
		//	패스워드의 암호화 처리
		String pass1 = vo.getUserpass();
		String pass2 = MyEncrypt.testMD5(pass1);
		vo.setUserpass(pass2);		
		
		String name = memberService.selectMemberLogin(vo);
		
		if( name == null ) {
			str = null;
		} else {
			if( !str.equals("4") ) {
				session.setAttribute("SessionUserID", vo.getUserid());
				str = name+"유저";
			}
		}
		
		return str;
	}
	
	@RequestMapping("/mbrModify.do")	
	public String selectMemberDetail(HttpSession session,ModelMap model) throws Exception {
		
		String url = "member/mbrModify";
		String userid = (String) session.getAttribute("SessionUserID");
		//	주소를 써서 다이렉트로 들어온경우 세션이 없으므로 주소를 바꿈
		if( userid == null ) {
			url = "redirect:/loginWrite.do";//	아예 로그인화면으로 보내버림
		} 
		
		MemberVO vo = memberService.selectMemberDetail(userid);
		model.addAttribute("vo",vo);
		
		return url;
	}
	
	@RequestMapping("/mbrModifySave.do")
	@ResponseBody
	public String updateMember(MemberVO vo,HttpSession session) throws Exception {
		
		String str = "";
		String userid = (String) session.getAttribute("SessionUserID");
		if( userid == null ) {	//	없는 데이터
			str = "4";
		} else {
			// (1) DB의 별칭과 VO별칭의 일치여부
			// (2) 내용 불일치라면 타 사용자와의 중복여부 체크
			// (3) 중복인경우(화면으로 return) / 중복이 아닌경우(저장서비스 실행)
			
			if(vo.getNickname_change().equals("Y")) {
				int cnt = memberService.selectMemberNickname(vo.getUsernickname());
				if( cnt == 1 ) {
					str = "3";
				}
			}
			if( !str.equals("3") ) {
				// result = 1 (OK)
				int result = memberService.updateMember(vo);
				if( result == 1 ) str = "1";
				else if( result == 0 ) str = "2";
			}
		}
		return str;
	}
	
	@RequestMapping("/idpwSearch.do")
	public String idpwSearch() {
		
		return "member/idpwSearch";
	}
	
	@RequestMapping("/idpwSearchSub.do")
	@ResponseBody
	public String selectIdpwSearch(MemberVO vo) throws Exception {
		
		String str = "";
		
		/*   아이디를 찾는 경우 
		 * 1. 닉네임,이메일을 조건으로 아이디 검색
		 * 2. 검색에 성공하면 아이디값을 실패하면 "4"를 리턴한다.
		 * */
		
		if( vo.getUserid() == null || vo.getUserid().equals("") ) {
			//	닉네임, 이메일을 통한 아이디 검색 후 아이디 전송			
			String userid = memberService.selectMemberUseridReturn(vo);
			if( userid != null && !userid.equals("") ) {
				str = userid;
			} else {
				str = "4";
			}
			
		} else {
			/*	암호 재설정인경우
			 * 	1. 아이디,닉네임,이메일을 조건으로 존재여부 설정
			 * 	2. 존재의 경우
			 * 		(1)	임의의 암호생성
			 * 		(2) 생성된 암호를 이용하여 기존 암호를 새로운 암호로 변경
			 * 		(3) 새로운 암호를 화면에 전달한다.
			 */	
			 
			//	아이디, 닉네임, 이메일을 통한 존재 여부 확인 후 패스워드(재설정) 전송
			int cnt = memberService.selectMemberExistCount(vo);
			if( cnt == 0 ) {	//	없는 데이터
				str = "4";
			} else {
				// String pass = "1234";
				String pass1 = MyEncrypt.randomPass();	//	비밀번호 랜덤생성
				System.out.println(pass1);
				String pass2 = MyEncrypt.testMD5(pass1);
				vo.setUserpass(pass2);
				memberService.updateMemberPass(vo);
				
				str = pass1;
			}
		}		
		return str;
	}
	
	@RequestMapping("/passChange.do")
	public String passChangeWrite() {
		
		return "member/passChange";
	}
	
	@RequestMapping("/passChangeSub.do")
	@ResponseBody
	public String updateMemberPassChange(HttpSession session,
										String pass1,
										String pass2) throws Exception {
		/*
		 *  로그인여부확인
		 */
		String userid = (String) session.getAttribute("SessionUserID");
		pass1 = MyEncrypt.testMD5(pass1);	//	현재암호 암호화
		pass2 = MyEncrypt.testMD5(pass2);	//	변경암호 암호화
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid", userid);		
		map.put("pass1", pass1);	//	현재암호
		map.put("pass2", pass2);	//	변경암호
		
		int result = memberService.updateMemberPassChange(map);

		String str = "";
		
		if(result == 1) {
			str = "1";	//	성공
		} else {
			str = "4";	//	현재암호불일치
		}
		
		return str;
	}
	
	@RequestMapping("/mbrCancel.do")
	public String memberCancelWrite() {
		
		return "member/mbrCancel";
	}
	
	@RequestMapping("/mbrCancelSub.do")
	@ResponseBody
	public String selectMemberCancel(String pass, HttpSession session) throws Exception {
		
		String str = "";
		
		String userid = (String) session.getAttribute("SessionUserID");
		
		pass = MyEncrypt.testMD5(pass);	//	입력받은 암호 DB비교를 위해 암호와
		
		String state = memberService.selectMemberState(userid);	//	만약을 위한 유저상태값. 1이여야함.
		if( !state.equals("1") ) {
			str = "2";
		}		
		
		Map<String,String> map1 = new HashMap<String,String>();
		map1.put("userid", userid);		
		map1.put("pass", pass);
		map1.put("state", state);
		
		int result1 = memberService.selectMemberCancelChk(map1);
		
		if( result1 == 1) {
			Map<String,String> map2 = new HashMap<String,String>();
			map2.put("userid", userid);
			map2.put("state", "3");
			int result2 = memberService.updateMemberStateUpdate(map2);
			if(result2 == 1) {
				str = "1";
				session.removeAttribute("SessionUserID");
			} else {
				str = "4";
			}
			
		} else {
			str = "4";
		}		
		return str;
	}
}
