package egov.hitrip.service;

import java.util.List;
import java.util.Map;

public interface PackReviewService {
	
	//패키지 예약 목록
	List<?> selectPackReserve(String userid) throws Exception;
	
	//패키지 후기 저장
	String insertPakcReviewSave(Map<String, Object> map1) throws Exception;
	//패키지 후기 목록
	List<?> selectPackReview(DefaultVO defaultVO) throws Exception;
	//패키지 후기 목록 토탈
	int selectPackReviewTotal(DefaultVO defaultVO) throws Exception;
	
	//패키지 후기 디테일
	PackReviewVO selectPackReviewDetail(String packreviewunq) throws Exception;
	//패키지 후기 조회수
	int updatePackReviewHits(String packreviewunq) throws Exception;
	
	//패키지 후기 수정 저장
	int updatePackReviewSave(Map<String, Object> map1) throws Exception;
	//패키지 후기 삭제
	int deletePackReview(PackReviewVO vo) throws Exception;
	
	//패키지 후기 댓글 리스트
	List<?> selectPackReviewCm(PackReviewVO vo1) throws Exception;
	//패키지 후기 댓글 저장
	String insertPackReviewCm(PackReviewVO vo) throws Exception;
	//패키지 후기 댓글 수정
	int updatePackReviewCm(PackReviewVO vo) throws Exception;
	//패키지 후기 댓글 삭제
	int deletePackReviewCm(String cmunq) throws Exception;
	//패키지 후기 좋아요 조회
	int selectPackReviewLike(PackReviewVO vo1) throws Exception;
	//패키지 후기 좋아요 등록
	String insertPackReviewLike(PackReviewVO vo) throws Exception;
	//패키지 후기 좋아요 수정
	int updatePackReviewStar(String packreviewunq) throws Exception;
	//패키지 후기 좋아요 삭제
	int deletePackReviewLike(PackReviewVO vo) throws Exception;
	//패키지 후기 좋아요 감소
	int updatePackReviewStarMinus(String packreviewunq) throws Exception;
	//패키지 후기 작성 중복
	int selectPackReviewCount(PackReviewVO vo) throws Exception;

}
