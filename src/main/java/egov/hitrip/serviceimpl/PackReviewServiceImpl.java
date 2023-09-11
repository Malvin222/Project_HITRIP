package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.DefaultVO;
import egov.hitrip.service.PackReviewService;
import egov.hitrip.service.PackReviewVO;

@Service("packReviewService")
public class PackReviewServiceImpl implements PackReviewService {
	
	@Resource(name="packReviewDAO")
	PackReviewDAO packReviewDAO;
	
	@Override
	public List<?> selectPackReserve(String userid) throws Exception {
		return packReviewDAO.selectPackReserve(userid);
	}

	@Override
	public String insertPakcReviewSave(Map<String, Object> map1) throws Exception {
		return packReviewDAO.insertPakcReviewSave(map1);
	}

	@Override
	public List<?> selectPackReview(DefaultVO defaultVO) throws Exception {
		return packReviewDAO.selectPackReview(defaultVO);
	}

	@Override
	public int selectPackReviewTotal(DefaultVO defaultVO) {
		return packReviewDAO.selectPackReviewTotal(defaultVO);
	}

	@Override
	public PackReviewVO selectPackReviewDetail(String packreviewunq) throws Exception {
		return packReviewDAO.selectPackReviewDetail(packreviewunq);
	}

	@Override
	public int updatePackReviewHits(String packreviewunq) throws Exception {
		return packReviewDAO.updatePackReviewHits(packreviewunq);
	}

	@Override
	public int updatePackReviewSave(Map<String, Object> map1) throws Exception {
		return packReviewDAO.updatePackReviewSave(map1);
	}

	@Override
	public int deletePackReview(PackReviewVO vo) throws Exception {
		return packReviewDAO.deletePackReview(vo);
	}

	@Override
	public List<?> selectPackReviewCm(PackReviewVO vo1) throws Exception {
		return packReviewDAO.selectPackReviewCm(vo1);
	}

	@Override
	public String insertPackReviewCm(PackReviewVO vo) throws Exception {
		return packReviewDAO.insertPackReviewCm(vo);
	}

	@Override
	public int updatePackReviewCm(PackReviewVO vo) throws Exception {
		return packReviewDAO.updatePackReviewCm(vo);
	}

	@Override
	public int deletePackReviewCm(String cmunq) throws Exception {
		return packReviewDAO.deletePackReviewCm(cmunq);
	}

	@Override
	public int selectPackReviewLike(PackReviewVO vo1) throws Exception {
		return packReviewDAO.selectPackReviewLike(vo1);
	}

	@Override
	public String insertPackReviewLike(PackReviewVO vo) throws Exception {
		return packReviewDAO.insertPackReviewLike(vo);
	}

	@Override
	public int updatePackReviewStar(String packreviewunq) throws Exception {
		return packReviewDAO.updatePackReviewStar(packreviewunq);
	}

	@Override
	public int deletePackReviewLike(PackReviewVO vo) throws Exception {
		return packReviewDAO.deletePackReviewLike(vo);
	}

	@Override
	public int updatePackReviewStarMinus(String packreviewunq) throws Exception {
		return packReviewDAO.updatePackReviewStartMinus(packreviewunq);
	}

	@Override
	public int selectPackReviewCount(PackReviewVO vo) throws Exception {
		return packReviewDAO.selectPackReviewCount(vo);
	}
}
