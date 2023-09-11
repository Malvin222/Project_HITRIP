package egov.hitrip.service;

import java.util.List;
import java.util.Map;

public interface ReviewService {

	
	// 여행후기 등록
	String insertReviewSave(Map<String, Object> map1) throws Exception;
	
	// 여행후기 목록
	List<?> selectReviewList(DefaultVO vo) throws Exception;
	
	// 여행후기 총 등록개수/검색개수
	int selectReviewTotal(DefaultVO vo) throws Exception;

	// 여행후기 삭제
	int deleteReview(ReviewVO vo) throws Exception;

	// 조회수 증가
	int updateReviewHits(String reviewunq) throws Exception;

	// 여행 리뷰 디테일 
	ReviewVO selectReviewDetail(String reviewunq) throws Exception;

	// 여행 리뷰 수정 처리
	int updateReviewSave(Map<String, Object> map1) throws Exception;

	// 여행 리뷰 댓글 리스트
	List<?> selectReviewCm(ReviewVO vo) throws Exception;
	
	// 여행 리뷰 댓글 등록
	String insertReviewCm(ReviewVO vo) throws Exception;

	// 여행 리뷰 댓글 삭제
	int deleteReviewCm(String cmunq) throws Exception;
	
	// 여행 리뷰 댓글 수정
	int updateReviewCm(ReviewVO vo) throws Exception;

	// 여행 리뷰 좋아요 중복 체크
	int selectReviewLike(ReviewVO vo) throws Exception;

	// 여행 리뷰 좋아요 클릭
	String insertReviewLike(ReviewVO vo) throws Exception;

	// 여행 리뷰 좋아요 취소
	int deleteReviewLike(ReviewVO vo) throws Exception;
	
	// 여행 리뷰 좋아요 증가(추천수)
	int updateReviewStar(String reviewunq) throws Exception;

	// 여행 리뷰 좋아요 감소(추천수) // 좋아요 취소시 추천수 감소
	int updateReviewStarMinus(String reviewunq) throws Exception;
	

	

	
	

	
	
}






