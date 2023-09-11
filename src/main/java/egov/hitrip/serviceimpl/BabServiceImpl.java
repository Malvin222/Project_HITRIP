package egov.hitrip.serviceimpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.BabService;
import egov.hitrip.service.BabVO;

@Service("babService")
public class BabServiceImpl implements BabService {
	
	@Resource(name="babDAO")
	BabDAO babDAO;
	
	@Override
	public List<?> selectBabList(BabVO vo) {
		return babDAO.selectBabList(vo);
	}

	@Override
	public int selectBabTotal(BabVO vo) throws Exception {
		return babDAO.selectBabTotal(vo);
	}

	@Override
	public BabVO selectBabDetail(String contentid) throws Exception {
		return babDAO.selectBabDetail(contentid);
	}

	@Override
	public List<?> selectBabHomeList(BabVO bvo) throws Exception {
		
		return babDAO.selectBabHomeList(bvo);
	}



}
