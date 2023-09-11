package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.DefaultVO;
import egov.hitrip.service.PackVO;
import egov.hitrip.service.ReviewVO;

@Repository("reviewDAO")
public class ReviewDAO  extends EgovAbstractDAO {

	

	public String insertReviewSave(Map<String, Object> map1) {
		return (String) insert("reviewDAO.insertReviewSave",map1);
	}

	public List<?> selectReviewList(DefaultVO vo) {
		return list("reviewDAO.selectReviewList",vo);
	}

	public int selectReviewTotal(DefaultVO vo) {
		return (int)select("reviewDAO.selectReviewTotal",vo);
	}

	public int deleteReview(ReviewVO vo) {
		return delete("reviewDAO.deleteReview",vo);
	}

	public int updateReviewHits(String reviewunq) {
		return update("reviewDAO.updateReviewHits",reviewunq);
	}

	public ReviewVO selectReviewDetail(String reviewunq) {
		return (ReviewVO) select("reviewDAO.selectReviewDetail",reviewunq);
	}

    public int updateReviewSave(Map<String, Object> map1) { 
	   return update("reviewDAO.updateReviewSave",map1); 
    }
    
    public List<?> selectReviewCm(ReviewVO vo) {
		return list("reviewDAO.selectReviewCm",vo);
	}

	public String insertReviewCm(ReviewVO vo) {
		return (String) insert("reviewDAO.insertReviewCm",vo);
	}
	
	public int deleteReviewCm(String cmunq) {
		return delete("reviewDAO.deleteReviewCm",cmunq);
	}

	public int updateReviewCm(ReviewVO vo) {
		return update("reviewDAO.updateReviewCm",vo);
	}

	public int selectReviewLike(ReviewVO vo) {
		return (int) select("reviewDAO.selectReviewLike",vo);
	}

	public String insertReviewLike(ReviewVO vo) {
		return (String) insert("reviewDAO.insertReviewLike",vo);
	}

	public int deleteReviewLike(ReviewVO vo) {
		return delete("reviewDAO.deleteReviewLike",vo);
	}
	public int updateReviewStar(String reviewunq) {
		return update("reviewDAO.updateReviewStar",reviewunq);
	}

	public int updateReviewStarMinus(String reviewunq) {
		return update("reviewDAO.updateReviewStarMinus",reviewunq);
	}


}




