package egov.hitrip.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egov.hitrip.service.BsnmService;
import egov.hitrip.service.BsnmVO;

@Controller
public class BsnmController {

	@Resource(name = "bsnmService")
	BsnmService bsnmService;
	
	//사업자회원 로그인 페이지
	@RequestMapping("/bsnmLoginWrite.do")
	public String loginWrite() {
		
		return "bsnm/bsnmLoginWrite";
	}
	
	//사업자 회원가입 약관 페이지
	@RequestMapping("/bsnmConditions.do")
	public String bsnmConditions() {
		
		return "bsnm/bsnmConditions";
	}
	
	//사업자 회원 가입 페이지
	@RequestMapping("/bsnmJoinWrite.do")
	public String bsnmJoinWrite(ModelMap model) throws Exception {
		
		
		  int no = (int) Math.ceil(Math.random() * 10); String filename =
		  bsnmService.selectPreventName(no); filename = filename.replace(".jpg", "");
		  
		  model.addAttribute("no",no); 
		  model.addAttribute("filename",filename);
		 
		
		return "bsnm/bsnmJoinWrite";
	}
	//사업자 회원가입 자동가입 방지 이미지
	@RequestMapping("/bsnmpreventImg.do")
	@ResponseBody
	public String selectPreventImg(String no) throws Exception {
		
		int no1 = Integer.parseInt(no)+1;
		if( no1 > 10 ) no1 = 1;
		
		String filename = bsnmService.selectPreventName(no1);
		filename = filename.replace(".jpg", "");
		
		return filename+","+no1;
	}
	
	//사업자 회원가입 저장처리
	@RequestMapping("/bsnmJoinSave.do")
	@ResponseBody
	public String insertBsnm(BsnmVO vo) throws Exception {
		
		String str = "";
		
		String bsnmopen = vo.getBsnmopeninfo();
		
		if( bsnmopen == null || bsnmopen.equals("") ) {
			vo.setBsnmopeninfo("N");
		}
		
		int result1 = bsnmService.selectBsnmid(vo.getBsnmid());
		
		
		if( result1 == 1 ) {
			str = "2";	//	이미사용중인아이디
		} else {
			
				String pass1 = vo.getBsnmpass();
				String pass2 = MyEncrypt.testMD5(pass1);
				vo.setBsnmpass(pass2);				
				
				bsnmService.insertBsnm(vo);
				str = "1";	//	저장성공
				
		}		
		return str;
	}
	
	//사업자 중복 아이디 체크
	@RequestMapping("/bsnmIdCheck.do")
	@ResponseBody
	public String selectBsnmid(String bsnmid) throws Exception {
				
		String msg = "3";		
		int result = 0;
		String pattern = "[a-zA-Z]{1}[0-9a-zA-Z_]{5,19}";
		boolean pattern_chk = bsnmid.matches(pattern);
		
		if( pattern_chk == true ) {
			result = bsnmService.selectBsnmid(bsnmid);
			if( result == 0 ) {
				msg = "1";
			} else {
				msg = "2";
			}
		}		
		return msg;
	}
	
	//사업자회원 로그아웃
	@RequestMapping("/bsnmLogout.do")
	@ResponseBody
	public String logout(HttpSession session) {
		
		session.removeAttribute("SessionBsnmID");
		
		return "1";
	}
	
	//사업자 회원 로그인 세션
	@RequestMapping(value = "/bsnmloginSession.do",
					produces = "application/text;charset=utf-8")
	@ResponseBody
	public String bsnmloginSession(BsnmVO vo,HttpSession session) throws Exception {
		String str = "";
		
		String state = bsnmService.selectBsnmState(vo.getBsnmid());
		if( !state.equals("1") ) str = "4";
		
		//	패스워드의 암호화 처리
		String pass1 = vo.getBsnmpass();
		String pass2 = MyEncrypt.testMD5(pass1);
		vo.setBsnmpass(pass2);
		System.out.println(pass2);
		
		String name = bsnmService.selectBsnmLogin(vo);
		
		if( name == null ) {
			str = null;
		} else {
			if( !str.equals("4") ) {
				session.setAttribute("SessionBsnmID", vo.getBsnmid());
				str = name+"사업자";
			}
		}
		
		return str;
	}
	
	//사업자 회원정보 변경 페이지
	@RequestMapping("/bsnmModify.do")	
	public String selectBsnmDetail(HttpSession session,ModelMap model) throws Exception {
		
		String url = "bsnm/bsnmModify";
		String bsnmid = (String) session.getAttribute("SessionBsnmID");
		//	주소를 써서 다이렉트로 들어온경우 세션이 없으므로 주소를 바꿈
		if( bsnmid == null ) {
			url = "redirect:/bsnmLoginWrite.do";//	아예 로그인화면으로 보내버림
		} 
		
		BsnmVO vo = bsnmService.selectBsnmDetail(bsnmid);
		model.addAttribute("vo",vo);
		
		return url;
	}
	
	//사업자 회원정보 변경 저장처리
	@RequestMapping("/bsnmModifySave.do")
	@ResponseBody
	public String updateBsnm(BsnmVO vo,HttpSession session) throws Exception {
		
		String str = "";
		String bsnmid = (String) session.getAttribute("SessionBsnmID");
		String bsnmopen = vo.getBsnmopeninfo();
		if( bsnmopen == null || bsnmopen.equals("") ) {
			vo.setBsnmopeninfo("N");
		}
		if( bsnmid == null ) {	//	없는 데이터
			str = "4";
		} else {
			// (1) DB의 별칭과 VO별칭의 일치여부
			// (2) 내용 불일치라면 타 사용자와의 중복여부 체크
			// (3) 중복인경우(화면으로 return) / 중복이 아닌경우(저장서비스 실행)
			
			if( !str.equals("3") ) {
				// result = 1 (OK)
				/*
				 * String pass1 = vo.getBsnmpass(); String pass2 = MyEncrypt.testMD5(pass1);
				 * vo.setBsnmpass(pass2);
				 */
				int result = bsnmService.updateBsnm(vo);
				if( result == 1 ) str = "1";
				else if( result == 0 ) str = "2";
			}
		}
		return str;
	}
	
	//사업자 회원 아이디 찾기페이지
	@RequestMapping("/bsnmIdpwSearch.do")
	public String bsnmIdpwSearch() {
		
		return "bsnm/bsnmIdpwSearch";
	}
	
	//사업자 회원 아이디 패스워드 찾기 
	@RequestMapping("/bsnmIdpwSearchSub.do")
	@ResponseBody
	public String selectBsnmIdpwSearch(BsnmVO vo) throws Exception {
		
		String str = "";
		
		/*   아이디를 찾는 경우 
		 * 1. 닉네임,이메일을 조건으로 아이디 검색
		 * 2. 검색에 성공하면 아이디값을 실패하면 "4"를 리턴한다.
		 * */
		
		if( vo.getBsnmid() == null || vo.getBsnmid().equals("") ) {
			//	닉네임, 이메일을 통한 아이디 검색 후 아이디 전송			
			String bsnmid = bsnmService.selectBsnmidReturn(vo);
			if( bsnmid != null && !bsnmid.equals("") ) {
				str = bsnmid;
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
			int cnt = bsnmService.selectBsnmExistCount(vo);
			if( cnt == 0 ) {	//	없는 데이터
				str = "4";
			} else {
				// String pass = "1234";
				String pass1 = MyEncrypt.randomPass();	//	비밀번호 랜덤생성
				System.out.println(pass1);
				String pass2 = MyEncrypt.testMD5(pass1);
				vo.setBsnmpass(pass2);
				bsnmService.updateBsnmPass(vo);
				
				str = pass1;
			}
		}		
		return str;
	}
	
	//사업자 비밀번호 변경 팝업창
	@RequestMapping("/bsnmPassChange.do")
	public String bsnmPassChangeWrite() {
		
		return "bsnm/bsnmPassChange";
	}
	
	//사업자 비밀번호 변경 저장
	@RequestMapping("/bsnmPassChangeSub.do")
	@ResponseBody
	public String updateBsnmPassChange(HttpSession session,
										String pass1,
										String pass2) throws Exception {
		/*
		 *  로그인여부확인
		 */
		String bsnmid = (String) session.getAttribute("SessionBsnmID");
		pass1 = MyEncrypt.testMD5(pass1);	//	현재암호 암호화
		pass2 = MyEncrypt.testMD5(pass2);	//	변경암호 암호화
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("bsnmid", bsnmid);		
		map.put("pass1", pass1);	//	현재암호
		map.put("pass2", pass2);	//	변경암호
		
		int result = bsnmService.updateBsnmPassChange(map);

		String str = "";
		
		if(result == 1) {
			str = "1";	//	성공
		} else {
			str = "4";	//	현재암호불일치
		}
		
		return str;
	}
	
	//사업자 조회
	   @RequestMapping("/bsnmnoCheck.do")
	   @ResponseBody
	   public String bsnmnoCheck(BsnmVO bsnmno) throws Exception{
	      String str = ""; 
	      int result = bsnmService.selectBsnmCheck(bsnmno);

	      if(result == 0) {
	         str = "0";
	       } else {
	          str ="1";
	       }
	      
	      return str;
	   }
}
