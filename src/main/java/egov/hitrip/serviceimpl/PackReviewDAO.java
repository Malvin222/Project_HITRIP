package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.DefaultVO;
import egov.hitrip.service.PackReviewVO;

@Repository("packReviewDAO")
public class PackReviewDAO extends EgovAbstractDAO {

	public List<?> selectPackReserve(String userid) {
		return list("packReviewDAO.selectPackReserve",userid);
	}

	public String insertPakcReviewSave(Map<String, Object> map1) {
		return (String) insert("packReviewDAO.insertPakcReviewSave",map1);
	}

	public List<?> selectPackReview(DefaultVO defaultVO) {
		return list("packReviewDAO.selectPackReview",defaultVO);
	}

	public int selectPackReviewTotal(DefaultVO defaultVO) {
		return (int) select("packReviewDAO.selectPackReviewTotal",defaultVO);
	}

	public PackReviewVO selectPackReviewDetail(String packreviewunq) {
		return (PackReviewVO) select("packReviewDAO.selectPackReviewDetail",packreviewunq);
	}
	
	public int updatePackReviewHits(String packreviewunq) {
		return (int) update("packReviewDAO.updatePackReviewHits",packreviewunq);
	}

	public int updatePackReviewSave(Map<String, Object> map1) {
		return (int) update("packReviewDAO.updatePackReviewSave",map1);
	}

	public int deletePackReview(PackReviewVO vo) {
		return (int) delete("packReviewDAO.deletePackReview",vo);
	}

	public List<?> selectPackReviewCm(PackReviewVO vo1) {
		return  list("packReviewDAO.selectPackReviewCm",vo1);
	}

	public String insertPackReviewCm(PackReviewVO vo) {
		return (String) insert("packReviewDAO.insertPackReviewCm",vo);
	}

	public int updatePackReviewCm(PackReviewVO vo) {
		return (int) update("packReviewDAO.updatePackReviewCm",vo);
	}

	public int deletePackReviewCm(String cmunq) {
		return (int) delete("packReviewDAO.deletePackReviewCm",cmunq);
	}

	public int selectPackReviewLike(PackReviewVO vo1) {
		return (int) select("packReviewDAO.selectPackReviewLike",vo1);
	}

	public String insertPackReviewLike(PackReviewVO vo) {
		return (String) insert("packReviewDAO.insertPackReviewLike",vo);
	}

	public int updatePackReviewStar(String packreviewunq) {
		return (int) update("packReviewDAO.updatePackReviewStar",packreviewunq);
	}

	public int deletePackReviewLike(PackReviewVO vo) {
		return (int) delete("packReviewDAO.deletePackReviewLike",vo);
	}

	public int updatePackReviewStartMinus(String packreviewunq) {
		return (int) update("packReviewDAO.updatePackReviewStarMinus",packreviewunq);
	}

	public int selectPackReviewCount(PackReviewVO vo) {
		return (int) select("packReivewDAO.selectPackReviewCount",vo);
	}


}
