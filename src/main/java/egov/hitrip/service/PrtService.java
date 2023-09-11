package egov.hitrip.service;

import java.util.List;
import java.util.Map;

public interface PrtService {
	//	동행게시판 저장
	String insertPrtBoard(Map<String, Object> map1) throws Exception;
	//	동행게시판 총 게시물 수
	int selectPrtTotal(PageVO vo) throws Exception;
	//	동행게시판 리스트 출력
	List<?> selectPrtList(PageVO vo) throws Exception;
	//	조회수 증가
	int updatePrtBoardHits(String prtunq) throws Exception;
	//	동행게시판 상세보기
	PrtVO selectPrtBoardDetail(PrtVO vo) throws Exception;
	//	동행게시판 수정
	int updatePrtBoard(PrtVO vo) throws Exception;
	//	동행게시판 삭제
	int deletePrtBoard(String prtunq) throws Exception;
	//	동행게시판 댓글 저장
	String insertPrtBoardCm(PrtVO vo) throws Exception;
	//	동행게시판 상세보기 댓글 리스트
	List<?> selectPrtBoardCm(PrtVO vo) throws Exception;
	//	동행게시판 댓글 수정
	int updatePrtBoardCm(PrtVO vo) throws Exception;
	//	동행게시판 댓글 삭제
	int deletePrtBoardCm(PrtVO vo) throws Exception;
	//	동행게시판에서 글 삭제시 일정에서 동행 미등록을 위한 planunq
	String selectPlanunq(String prtunq) throws Exception;
	

}
