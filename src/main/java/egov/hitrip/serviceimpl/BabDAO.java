package egov.hitrip.serviceimpl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.BabVO;

@Repository("babDAO")
public class BabDAO extends EgovAbstractDAO {

	public List<?> selectBabList(BabVO vo) {
		return list("babDAO.selectBabList",vo);
	}

	public int selectBabTotal(BabVO vo) {
		return (int) select ("babDAO.selectBabTotal",vo);
	}

	public BabVO selectBabDetail(String contentid) {
		return (BabVO) select("babDAO.selectBabDetail",contentid);
	}

	public List<?> selectBabHomeList(BabVO bvo) {
		
		return list("babDAO.selectBabHomeList",bvo);
	}
	
	

}
