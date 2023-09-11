package egov.hitrip.service;

import java.util.Map;

public interface BsnmService {

	//	회원가입
	String insertBsnm(BsnmVO vo) throws Exception;
	//	아이디 중복체크
	int selectBsnmid(String bsnmid) throws Exception;
	//	자동등록방지
	String selectPreventName(int no) throws Exception;
	//	로그인 처리
	String selectBsnmLogin(BsnmVO vo) throws Exception;
	//	회원 상태 체크(userstate가 1이어야함)
	String selectBsnmState(String bsnm) throws Exception;
	//	회원정보 수정에 필요한 데이터
	BsnmVO selectBsnmDetail(String userid) throws Exception;
	//	회원정보 수정
	int updateBsnm(BsnmVO vo) throws Exception;
	//	비밀번호 변경
	int updateBsnmPassChange(Map<String, String> map);
	//	아이디 찾기
	String selectBsnmidReturn(BsnmVO vo) throws Exception;
	//	비밀번호 찾기
	int selectBsnmExistCount(BsnmVO vo) throws Exception;
	//	임시비밀번호 생성 및 저장
	void updateBsnmPass(BsnmVO vo) throws Exception;
	//가입한 사업자번호 체크
	int selectBsnmCheck(BsnmVO bsnmno) throws Exception;
	
	
	
}
