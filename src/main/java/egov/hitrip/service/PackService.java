package egov.hitrip.service;

import java.util.List;
import java.util.Map;


public interface PackService {
	//패키지여행등록
	String insertPackBoardWriteSave(Map<String, Object> map1) throws Exception;
	//패키지여행목록
	List<?> selectPackBoardList(PackVO vo) throws Exception;
	//패키지여행 총 등록개수 / 검색개수
	int selectPackBoardTotal(PackVO vo) throws Exception;
	//패키지여행 디테일
	PackVO selectPackBoardDetail(String packunq) throws Exception;
	//패키지여행 조회수증가
	int updatePackBoardHits(String packunq) throws Exception;
	//패키지여행 삭제
	int deletePackBoard(String packunq) throws Exception;
	//패키지여행 업데이트
	int updatePackBoard(Map<String, Object> map1) throws Exception;
	
	//패키지여행 댓글리스트
	List<?> selectPackBoardCm(PackVO vo) throws Exception;
	//패키지여행 댓글 등록
	String insertPackBoardCm(PackVO vo) throws Exception;
	//패키지여행 댓글 삭제
	int deletePackBoardCm(String cmunq) throws Exception;
	//패키지여행 댓글 수정
	int updatePackBoardCm(PackVO vo) throws Exception;
	
	//패키지 참여
	String insertPackReserve(PackVO vo) throws Exception;
	//패키지 참여 중복체크
	int selectReserveUserid(PackVO vo) throws Exception;
	//패키지 참여 취소
	int deleteReserve(PackVO vo) throws Exception;
	//좋아요 확인
	int selectPackLike(PackVO vo) throws Exception;
	//좋아요 저장
	String insertPackLike(PackVO vo) throws Exception;
	//좋아요 증가
	int updatePackStar(String packunq) throws Exception;
	//좋아요 취소
	int deletePackLike(PackVO vo) throws Exception;
	//좋아요 감소
	int updatePackStarMinus(String packunq) throws Exception;
	
}