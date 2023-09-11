package egov.hitrip.service;

import java.util.List;

public interface AdminService {

	//	관리자 생성
	String insertAdmin(AdminVO vo) throws Exception;
	//	관리자 아이디 중복체크
	int selectAdminid(String adminid) throws Exception;
	//	관리자 아이디 첫 생성유무확인 (슈퍼관리자)
	int selectFirstId(String adminid) throws Exception;
	//	최고관리자 권한확인
	String selectAdminSuper(String adminid) throws Exception;
	//	관리자 권한확인
	String selectAdminAuth(String adminid) throws Exception;
	//	관리자 로그인
	String selectAdminLogin(AdminVO vo) throws Exception;
	//	공지사항 리스트
	List<?> selectNoticeList(PageVO vo) throws Exception;
	//	페이징을 위한 게시물개수 확인
	int selectNoticeTotal(PageVO vo) throws Exception;
	//	공지사항 등록
	String insertNotice(NoticeVO vo) throws Exception;
	//	조회수 증가
	int updateNoticeHits(String noticeunq) throws Exception;
	//	공지글 상세보기
	NoticeVO selectNoticeDetail(String noticeunq) throws Exception;
	//	공지글 수정하기
	int adminNoticeUpdate(NoticeVO vo) throws Exception;
	//	공지글 삭제하기
	int adminNoticeDelete(NoticeVO vo) throws Exception;
	//	일반회원목록
	List<?> selectMemberList(PageVO vo) throws Exception;
	//	회원총인원수
	int selectMemberTotal(PageVO vo) throws Exception;
	//	회원 상세보기
	MemberVO selectMemberDetail(String userid) throws Exception;
	//	회원 업데이트
	int updateMemberSave(MemberVO vo) throws Exception;
	//	회원 삭제
	int deleteMemberUser(String userid) throws Exception;
	//	탈퇴회원 삭제예정으로 변경
	int updateAllState(String userstate) throws Exception;
	//	삭제예정 회원 일괄 삭제
	int deleteAllDelete(String userstate) throws Exception;
	//	사업자회원목록
	List<?> selectBsnmList(PageVO vo) throws Exception;
	//	사업자회원총인원수
	int selectBsnmTotal(PageVO vo) throws Exception;
	//	사업자회원 상세보기
	BsnmVO selectBsnmDetail(String bsnmid) throws Exception;
	//	사업자회원 업데이트
	int updateBsnmSave(BsnmVO vo) throws Exception;
	//	사업자회원 삭제
	int deleteBsnmUser(String bsnmid) throws Exception;
	//	사업자탈퇴회원 삭제예정으로 변경
	int updateBsnmAllState(String bsnmstate) throws Exception;
	//	삭제예정 사업자회원 일괄 삭제
	int deleteBsnmAllDelete(String bsnmstate) throws Exception;
}
