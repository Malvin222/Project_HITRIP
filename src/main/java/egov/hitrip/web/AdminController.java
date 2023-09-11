package egov.hitrip.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egov.hitrip.service.AdminService;
import egov.hitrip.service.AdminVO;
import egov.hitrip.service.BsnmService;
import egov.hitrip.service.BsnmVO;
import egov.hitrip.service.MemberService;
import egov.hitrip.service.MemberVO;
import egov.hitrip.service.NoticeVO;
import egov.hitrip.service.PackService;
import egov.hitrip.service.PackVO;
import egov.hitrip.service.PageVO;

@Controller
public class AdminController {

   @Resource( name = "adminService" )
   AdminService adminService;
   
   @Resource(name = "memberService")
   MemberService memberService;
   
   @Resource(name = "bsnmService")
   BsnmService bsnmService;
   
   @Resource(name = "packService")
   PackService packService;
   
   /** EgovPropertyService */
   @Resource(name = "propertiesService")
   protected EgovPropertyService propertiesService;
   
   @RequestMapping("adminMain.do")
   public String adminMain() {
      
      return "admin/adminMain";
   }
   
   @RequestMapping("adminJoinWrite.do")
   public String adminjoinWrite() {
      
      return "admin/adminJoinWrite";
   }
   
   @RequestMapping("adminLoginWrite.do")
   public String adminLoginWrite(HttpSession session) {
      
      String url = "admin/adminLoginWrite";
      
      String userid = (String) session.getAttribute("SessionUserID");
      String bsnmid = (String) session.getAttribute("SessionBsnmID");
      String adminid = (String) session.getAttribute("SessionAdminID");
      String adminSuperId = (String) session.getAttribute("SessionAdminSuperID");
      if( userid != null || bsnmid != null ||
         adminid != null || adminSuperId != null   ) {
         if( userid != null || bsnmid != null) {
            url = "redirect:/";
         } else {
            url = "redirect:adminNoticeList.do";
         }
      }
      
      return url;
   }
   
   @RequestMapping("/adminJoinSave.do")
   @ResponseBody
   public String insertAdmin(AdminVO vo, String adminId, HttpSession session) throws Exception {
      String str = "3";
      String state = "";   //   adminsuper 값을 담을 변수
      
      //   세션에서 sql에 날릴 아이디 값을 받아옴
      adminId = (String) session.getAttribute("SessionAdminSuperID");
      String admin = (String) session.getAttribute("SessionAdminID");
      vo.setAdminsuper("N");   //   최고관리자는 한명(기본 N)
      
      //   아이디 중복검사
      int result2 = adminService.selectAdminid(vo.getAdminid());
      //   첫 가입 아이디 검사
      int result3 = adminService.selectFirstId(vo.getAdminid());
      //   세션에 담긴 id값이 null이면 sql처리에서 오류발생
      if( adminId != null ) {
         state = adminService.selectAdminSuper(adminId);
      } else if( result3 == 0 ) {
         vo.setAdminsuper("Y");
      }
      
      String chk = vo.getAdminsuper();   //   vo에 담긴 adminsuper 값 확
      if( result2 == 1 ) {
         str = "2";   //   이미사용중인아이디
      } else if( state.equals("N") ) {
         str = "3";   //   최고관리자가 아님
      } else {
         if( chk.equals("Y") == true ||   //   초기상태(관리자 아무도 없음)
            state.equals("Y") == true ) {   //   최고관리자 로그인상태(세션값)
            String pass1 = vo.getAdminpass();
            String pass2 = MyEncrypt.testMD5(pass1);
            vo.setAdminpass(pass2);            
            
            adminService.insertAdmin(vo);
            str = "1";   //   저장성공      
         }         
      }         
      return str;
   }
   
   @RequestMapping("/adminLogout.do")
   @ResponseBody
   public String logout(HttpSession session) {
      
      session.removeAttribute("SessionAdminID");
      session.removeAttribute("SessionAdminSuperID");
      
      return "1";
   }
   
   @RequestMapping("/adminIdCheck.do")
   @ResponseBody
   public String selectAdminid(String adminid) throws Exception {
            
      String msg = "3";      
      int result = 0;
      int result2 = 0;
      String pattern = "[a-zA-Z]{1}[0-9a-zA-Z_]{5,19}";
      boolean pattern_chk = adminid.matches(pattern);
      
      if( pattern_chk == true ) {
         result = adminService.selectAdminid(adminid);
         result2 = memberService.selectMemberUserid(adminid);
         if( result == 0 && result2 == 0 ) {
            msg = "1";
         } else {
            msg = "2";
         }
      }      
      return msg;
   }
   
   @RequestMapping(value = "/adminLoginSession.do",
               produces = "application/text;charset=utf-8")
   @ResponseBody
   public String loginSession(AdminVO vo,HttpSession session) throws Exception {
      String str = "";
      
      String state = adminService.selectAdminSuper(vo.getAdminid());

      if( !state.equals("Y") ) {
         str = "N";
         if( str.equals("N") ) {
            String auth = adminService.selectAdminAuth(vo.getAdminid());
            if( auth.equals("N") ) {
               str = "4";
            }
         }
      }         
      
      //   패스워드의 암호화 처리
      String pass1 = vo.getAdminpass();
      String pass2 = MyEncrypt.testMD5(pass1);
      vo.setAdminpass(pass2);      
      
      String name = adminService.selectAdminLogin(vo);

      if( name == null ) {
         str = null;
      } else {
         if( !str.equals("4") && state.equals("Y") ) {
            session.setAttribute("SessionAdminSuperID", vo.getAdminid());
            str = name+"최고관리자";
         } else if( !str.equals("4") ) {
            session.setAttribute("SessionAdminID", vo.getAdminid());
            str = name+"관리자";
         }
      }
      
      return str;
   }
   
   @RequestMapping("/adminNoticeList.do")
   public String selectNoticeList(PageVO vo, ModelMap model, HttpSession session) throws Exception {
      
      String url = "admin/board/adminNoticeList";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }      
      
      int pageUnit = vo.getPageUnit();
      
      //   현재 페이지 번호
      int pageIndex = vo.getPageIndex();
      //   firstIndex 값 계산
      int firstIndex = (pageIndex-1)*pageUnit + 1;
      //   lastIndex 값 계산
      int lastIndex = pageIndex*pageUnit;
      
      vo.setFirstIndex(firstIndex);
      vo.setLastIndex(lastIndex);
      
      int total = adminService.selectNoticeTotal(vo);
      
      //   화면출력 시작번호
      int recordCountPerPage = total - ((pageIndex-1)*pageUnit);
      vo.setRecordCountPerPage(recordCountPerPage);
      
      int lastPage = (int) Math.ceil((double)total/pageUnit);
      vo.setLastPage(lastPage);
      
      List<?> list = adminService.selectNoticeList(vo);
      
      model.addAttribute("PageVO",vo);
      model.addAttribute("NoticeList",list);
      model.addAttribute("total",total);
      
      return url;
   }
   
   @RequestMapping("/adminNoticeWrite.do")
   public String adminNoticeWrite(HttpSession session) {
      
      String url = "admin/board/adminNoticeWrite";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
      return url;
   }
   
   @RequestMapping("/adminNoticeSave.do")
   @ResponseBody
   public String insertNotice(NoticeVO vo) throws Exception {
      
      String emps = vo.getNoticeemps();
      if(emps == null || emps.equals("") ) emps = "N";
      vo.setNoticeemps(emps);
      
      String str = "";
      String result = adminService.insertNotice(vo);
      if(result == null) str = "ok";
      else str = "fail";
      
      return str;
   }
   
   @RequestMapping("/adminNoticeDetail.do")
   public String selectNoticeDetail(String noticeunq, ModelMap model, HttpSession session) throws Exception {
      
      String url = "admin/board/adminNoticeDetail";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
      //   조회수 증가
      adminService.updateNoticeHits(noticeunq);
      
      //   상세보기
      NoticeVO vo = adminService.selectNoticeDetail(noticeunq);
      
      String content = vo.getNoticecontent();
      content = content.replace("\n", "<br>");
      content = content.replace(" ", "&nbsp");
      vo.setNoticecontent(content);
      
      model.addAttribute("Noticevo",vo);
      
      return url;
   }
   
   @RequestMapping("/adminNoticeModify.do")
   public String selectNoticeModify(String noticeunq, ModelMap model, HttpSession session) throws Exception {
      
      String url = "admin/board/adminNoticeModify";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
      NoticeVO vo = adminService.selectNoticeDetail(noticeunq);
      model.addAttribute("Noticevo",vo);
      
      return url;
   }
   
   @RequestMapping("/adminNoticeModifySave.do")
   @ResponseBody
   public String updateNotice(NoticeVO vo) throws Exception {
      
      String emps = vo.getNoticeemps();
      if(emps==null) {emps = "N";}
      
      vo.setNoticeemps(emps);
      
      int result = adminService.adminNoticeUpdate(vo);
      
      String str = "";
      if(result == 1) str = "ok";
      else str = "fail";
      
      return str;
   }
   
   @RequestMapping("/adminNoticeDelete.do")
   @ResponseBody
   public String adminNoticeDelete(NoticeVO vo) throws Exception {

      int result = adminService.adminNoticeDelete(vo);
      String str = "";
      if (result == 1)
         str = "ok";
      else
         str = "fail";

      return str;
   }
   //   관리자 회원 관리 시작
   @RequestMapping("/adminMemberList.do")
   public String selectMemberList(PageVO vo, ModelMap model, HttpSession session) throws Exception {
      
      String url = "admin/member/adminMemberList";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
      int pageUnit = vo.getPageUnit();

      // 현재 페이지 번호
      int pageIndex = vo.getPageIndex();
      // firstIndex 값 계산
      int firstIndex = (pageIndex - 1) * pageUnit + 1;
      // lastIndex 값 계산
      int lastIndex = pageIndex * pageUnit;

      vo.setFirstIndex(firstIndex);
      vo.setLastIndex(lastIndex);

      int total = adminService.selectMemberTotal(vo);

      // 화면출력 시작번호
      int recordCountPerPage = total - ((pageIndex - 1) * pageUnit);
      vo.setRecordCountPerPage(recordCountPerPage);

      int lastPage = (int) Math.ceil((double) total / pageUnit);
      vo.setLastPage(lastPage);
      
      String searchKeyword = "";
      String searchKeyword1 = "";
      if(vo.getSearchCondition().equals("userstate")) {
         searchKeyword1 = vo.getSearchKeyword();
         switch(vo.getSearchKeyword()){
            case "정상"  :  searchKeyword = "1";
               break;
            case "중지"  :  searchKeyword = "2";
               break;
            case "탈퇴"  :  searchKeyword = "3";
               break;
            case "삭제"  :  searchKeyword = "4";
               break;
         }
         vo.setSearchKeyword(searchKeyword);
      }
      
      List<?> list = adminService.selectMemberList(vo);
      vo.setSearchKeyword(searchKeyword1);
      
      model.addAttribute("PageVO", vo);
      model.addAttribute("Memberlist", list);
      model.addAttribute("total", total);

      return url;
   }
   
   @RequestMapping("adminMemberModify.do")
   public String selectMemberModify(String userid, ModelMap model, HttpSession session) throws Exception {

      String url = "admin/member/adminMemberModify";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
      MemberVO vo = adminService.selectMemberDetail(userid);

      model.addAttribute("MemberVO", vo);

      return url;
   }

   @RequestMapping("/adminMemberModifySave.do")
   @ResponseBody
   public String updateMemberSave(MemberVO vo) throws Exception {

      String str = "";

      
        String memo = vo.getUsermemo(); 
        if(memo != null) { 
           memo = memo.replace("\n","<br>"); 
           memo = memo.replace(" ", "&nbsp"); 
           vo.setUsermemo(memo); 
        }
       

      String openchk = vo.getUseropeninfo();
      if (openchk == null || openchk.equals(""))
         openchk = "N";
      vo.setUseropeninfo(openchk);

      int cnt = adminService.updateMemberSave(vo);

      if (cnt == 1) {
         str = "ok";
      }

      return str;
   }
   
   @RequestMapping("/adminMemberDelete.do")
   @ResponseBody
   public String deleteMemberUser(String userid) throws Exception {

      int cnt = adminService.deleteMemberUser(userid);
      String str = "";
      if (cnt == 1) {
         str = "ok";
      }         

      return str;
   }
   
   @RequestMapping("/adminMemberAllStateSub.do")
   @ResponseBody
   public String updateAllStateSub(String userstate) throws Exception {
      
      int cnt = adminService.updateAllState(userstate);
      
      String str = "";
      System.out.println(cnt);
      if (cnt != 0) {
         str = "ok";
      }
      
      System.out.println(str);
      
      return str;
   }
   
   @RequestMapping("/adminMemberAllDeleteSub.do")
   @ResponseBody
   public String updateAllDeleteSub(String userstate) throws Exception {
      
      int cnt = adminService.deleteAllDelete(userstate);
      
      String str = "";
      System.out.println(cnt);
      if (cnt != 0) {
         str = "ok";
      }
      
      System.out.println(str);
      
      return str;
   }
   //   관리자 회원 관리 끝
   
   //   관리자 사업자회원관리 시작
   @RequestMapping("/adminBsnmList.do")
   public String selectBsnmList(PageVO vo, ModelMap model, HttpSession session) throws Exception {
      
      String url = "admin/bsnm/adminBsnmList";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
      int pageUnit = vo.getPageUnit();

      // 현재 페이지 번호
      int pageIndex = vo.getPageIndex();
      // firstIndex 값 계산
      int firstIndex = (pageIndex - 1) * pageUnit + 1;
      // lastIndex 값 계산
      int lastIndex = pageIndex * pageUnit;

      vo.setFirstIndex(firstIndex);
      vo.setLastIndex(lastIndex);

      int total = adminService.selectBsnmTotal(vo);

      // 화면출력 시작번호
      int recordCountPerPage = total - ((pageIndex - 1) * pageUnit);
      vo.setRecordCountPerPage(recordCountPerPage);

      int lastPage = (int) Math.ceil((double) total / pageUnit);
      vo.setLastPage(lastPage);
      
      String searchKeyword = "";
      String searchKeyword1 = "";
      if(vo.getSearchCondition().equals("bsnmstate")) {
         searchKeyword1 = vo.getSearchKeyword();
         switch(vo.getSearchKeyword()){
            case "정상"  :  searchKeyword = "1";
               break;
            case "중지"  :  searchKeyword = "2";
               break;
            case "탈퇴"  :  searchKeyword = "3";
               break;
            case "삭제"  :  searchKeyword = "4";
               break;
         }
         vo.setSearchKeyword(searchKeyword);
      }
      
      
      List<?> list = adminService.selectBsnmList(vo);
      vo.setSearchKeyword(searchKeyword1);
      
      model.addAttribute("PageVO", vo);
      model.addAttribute("Bsnmlist", list);
      model.addAttribute("total", total);

      return url;
   }
   
   @RequestMapping("adminBsnmModify.do")
   public String selectBsnmModify(String bsnmid, ModelMap model, HttpSession session) throws Exception {

      String url = "admin/bsnm/adminBsnmModify";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
      BsnmVO vo = adminService.selectBsnmDetail(bsnmid);

      model.addAttribute("BsnmVO", vo);

      return url;
   }

   @RequestMapping("/adminBsnmModifySave.do")
   @ResponseBody
   public String updateBsnmSave(BsnmVO vo) throws Exception {

      String str = "";

      
      /*
       * String memo = vo.getUsermemo(); if(memo != null) { memo =
       * memo.replace("\n","<br>"); memo = memo.replace(" ", "&nbsp");
       * vo.setUsermemo(memo); }
       */
       

      String openchk = vo.getBsnmopeninfo();
      if (openchk == null || openchk.equals(""))
         openchk = "N";
      vo.setBsnmopeninfo(openchk);

      int cnt = adminService.updateBsnmSave(vo);

      if (cnt == 1) {
         str = "ok";
      }

      return str;
   }
   
   @RequestMapping("/adminBsnmDelete.do")
   @ResponseBody
   public String deleteBsnmUser(String bsnmid) throws Exception {

      int cnt = adminService.deleteBsnmUser(bsnmid);
      String str = "";
      if (cnt == 1) {
         str = "ok";
      }         

      return str;
   }
   
   @RequestMapping("/adminBsnmAllStateSub.do")
   @ResponseBody
   public String updateBsmAllStateSub(String bsnmstate) throws Exception {
      
      int cnt = adminService.updateBsnmAllState(bsnmstate);
      
      String str = "";
      System.out.println(cnt);
      if (cnt != 0) {
         str = "ok";
      }
      
      System.out.println(str);
      
      return str;
   }
   
   @RequestMapping("/adminBsnmAllDeleteSub.do")
   @ResponseBody
   public String updateBsnmAllDeleteSub(String bsnmstate) throws Exception {
      
      int cnt = adminService.deleteBsnmAllDelete(bsnmstate);
      
      String str = "";
      System.out.println(cnt);
      if (cnt != 0) {
         str = "ok";
      }
      
      System.out.println(str);
      
      return str;
   }
   //   관리자 사업자회원 관리 끝
   
   @RequestMapping("/adminPackList.do")
   public String selectPackBoardList(PackVO vo,ModelMap model, HttpSession session) throws Exception{
      
      String url = "admin/board/adminPackList";
      
      String adminsuperid = (String) session.getAttribute("SessionAdminSuperID");
      if( adminsuperid == null ) {
         String adminid = (String) session.getAttribute("SessionAdminID");
         if( adminid == null ) {
            url = "redirect:/adminLoginWrite.do";//   아예 로그인화면으로 보내버림
         }         
      }
      
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
      
      model.addAttribute("PackList",packBoardList);
      model.addAttribute("PackVO",vo);
      
      return url;
   }
}