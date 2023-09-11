package egov.hitrip.serviceimpl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.TripVO;

@Repository("tripDAO")
public class TripDAO extends EgovAbstractDAO {

	public List<?> selectTripList(TripVO vo) {
		return list("tripDAO.selectTripList",vo);
	}

	public int selectTripTotal(TripVO vo) {
		return (int) select ("tripDAO.selectTripTotal",vo);
	}

	public TripVO selectTripDetail(String contentid) {
		return (TripVO) select("tripDAO.selectTripDetail",contentid);
	}

	public List<?> selectTripHomeList(TripVO tvo) {
		
		return list("tripDAO.selectTripHomeList",tvo);
	}

	
	
	

}
