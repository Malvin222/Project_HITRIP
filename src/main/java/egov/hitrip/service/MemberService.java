package egov.hitrip.service;

import java.util.Map;

public interface MemberService {

	//	회원가입
	String insertMember(MemberVO vo) throws Exception;
	//	아이디 중복체크
	int selectMemberUserid(String userid) throws Exception;
	//	닉네임 중복체크
	int selectMemberNickname(String usernickname) throws Exception;
	//	자동등록방지
	String selectPreventName(int no) throws Exception;
	//	로그인 처리
	String selectMemberLogin(MemberVO vo) throws Exception;
	//	회원 상태 체크(userstate가 1이어야함)
	String selectMemberState(String userid) throws Exception;
	//	회원정보 수정에 필요한 데이터
	MemberVO selectMemberDetail(String userid) throws Exception;
	//	회원정보 수정
	int updateMember(MemberVO vo) throws Exception;
	//	비밀번호 변경
	int updateMemberPassChange(Map<String, String> map);
	//	아이디 찾기
	String selectMemberUseridReturn(MemberVO vo) throws Exception;
	//	비밀번호 찾기
	int selectMemberExistCount(MemberVO vo) throws Exception;
	//	임시비밀번호 생성 및 저장
	void updateMemberPass(MemberVO vo) throws Exception;
	//	회원탈퇴
	int selectMemberCancelChk(Map<String, String> map1) throws Exception;
	//	회원상태업데이트
	int updateMemberStateUpdate(Map<String, String> map2) throws Exception;
	
	
	
	
}
