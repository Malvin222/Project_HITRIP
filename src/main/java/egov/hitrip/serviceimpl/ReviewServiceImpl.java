package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.DefaultVO;
import egov.hitrip.service.PackVO;
import egov.hitrip.service.ReviewService;
import egov.hitrip.service.ReviewVO;


@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {

	@Resource(name="reviewDAO")
	ReviewDAO reviewDAO;
	

	@Override
	public String insertReviewSave(Map<String, Object> map1) throws Exception {
		return reviewDAO.insertReviewSave(map1);
	}

	@Override
	public List<?> selectReviewList(DefaultVO vo) throws Exception {
		return reviewDAO.selectReviewList(vo);
	}

	@Override
	public int selectReviewTotal(DefaultVO vo) throws Exception {
		return reviewDAO.selectReviewTotal(vo);
	}

	@Override
	public int updateReviewHits(String reviewunq) throws Exception {
		return reviewDAO.updateReviewHits(reviewunq);
	}

	@Override
	public int deleteReview(ReviewVO vo) throws Exception {
		return reviewDAO.deleteReview(vo);
	}

	@Override
	public ReviewVO selectReviewDetail(String reviewunq) throws Exception {
		return reviewDAO.selectReviewDetail(reviewunq);
	}
	
	@Override 
	public int updateReviewSave(Map<String, Object> map1) throws Exception { 
		return reviewDAO.updateReviewSave(map1); 
	}
	 
	@Override
	public List<?> selectReviewCm(ReviewVO vo) throws Exception {
		return reviewDAO.selectReviewCm(vo);
	}

	@Override
	public String insertReviewCm(ReviewVO vo) throws Exception {
		return reviewDAO.insertReviewCm(vo);
	}

	@Override
	public int deleteReviewCm(String cmunq) throws Exception {
		return reviewDAO.deleteReviewCm(cmunq);
	}

	@Override
	public int updateReviewCm(ReviewVO vo) throws Exception {
		return reviewDAO.updateReviewCm(vo);
	}

	@Override
	public int selectReviewLike(ReviewVO vo) throws Exception {
		return reviewDAO.selectReviewLike(vo);
	}

	@Override
	public String insertReviewLike(ReviewVO vo) throws Exception {
		return reviewDAO.insertReviewLike(vo);
	}

	@Override
	public int deleteReviewLike(ReviewVO vo) throws Exception {
		return reviewDAO.deleteReviewLike(vo);
	}

	@Override
	public int updateReviewStar(String reviewunq) throws Exception {
		return reviewDAO.updateReviewStar(reviewunq);
	}

	@Override
	public int updateReviewStarMinus(String reviewunq) throws Exception {
		return reviewDAO.updateReviewStarMinus(reviewunq);
	}
	


}



