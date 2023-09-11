package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.PageVO;
import egov.hitrip.service.PrtService;
import egov.hitrip.service.PrtVO;

@Service("prtService")
public class PrtServiceImpl implements PrtService {

	@Resource(name = "prtDAO")
	PrtDAO prtDAO;

	@Override
	public String insertPrtBoard(Map<String, Object> map1) throws Exception {
		
		return prtDAO.insertPrtBoard(map1);
	}

	@Override
	public int selectPrtTotal(PageVO vo) throws Exception {
		
		return prtDAO.selectPrtTotal(vo);
	}

	@Override
	public List<?> selectPrtList(PageVO vo) throws Exception {
		
		return prtDAO.selectPrtList(vo);
	}

	@Override
	public int updatePrtBoardHits(String prtunq) throws Exception {

		return prtDAO.updatePrtBoardHits(prtunq);
		
	}

	@Override
	public PrtVO selectPrtBoardDetail(PrtVO vo) throws Exception {
		
		return prtDAO.selectPrtBoardDetail(vo);
	}

	@Override
	public int updatePrtBoard(PrtVO vo) throws Exception {
		
		return prtDAO.updatePrtBoard(vo);
	}
	@Override
	public int deletePrtBoard(String prtunq) throws Exception {
		
		return prtDAO.deletePrtBoard(prtunq);
	}

	@Override
	public String insertPrtBoardCm(PrtVO vo) throws Exception {
		
		return prtDAO.insertPrtBoardCm(vo);
	}

	@Override
	public List<?> selectPrtBoardCm(PrtVO vo) throws Exception {
		
		return prtDAO.selectPrtBoardCm(vo);
	}

	@Override
	public int deletePrtBoardCm(PrtVO vo) throws Exception {
		
		return prtDAO.deletePrtBoardCm(vo);
	}

	@Override
	public String selectPlanunq(String prtunq) throws Exception {
		
		return prtDAO.selectPlanunq(prtunq);
	}

	@Override
	public int updatePrtBoardCm(PrtVO vo) throws Exception {
		
		return prtDAO.updatePrtBoardCm(vo);
	}

}
