package egov.hitrip.serviceimpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.TripService;
import egov.hitrip.service.TripVO;

@Service("tripService")
public class TripServiceImpl implements TripService {
	
	@Resource(name="tripDAO")
	TripDAO tripDAO;
	
	@Override
	public List<?> selectTripList(TripVO vo) {
		return tripDAO.selectTripList(vo);
	}

	@Override
	public int selectTripTotal(TripVO vo) throws Exception {
		return tripDAO.selectTripTotal(vo);
	}

	@Override
	public TripVO selectTripDetail(String contentid) throws Exception {
		return tripDAO.selectTripDetail(contentid);
	}

	@Override
	public List<?> selectTripHomeList(TripVO tvo) throws Exception {
		
		return tripDAO.selectTripHomeList(tvo);
	}



}
