package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.PageVO;
import egov.hitrip.service.PrtVO;

@Repository("prtDAO")
public class PrtDAO extends EgovAbstractDAO {

	public String insertPrtBoard(Map<String, Object> map1) {
		
		return (String) insert("prtDAO.insertPrtBoard",map1);
	}

	public int selectPrtTotal(PageVO vo) {
		
		return (int) select("prtDAO.selectPrtTotal",vo);
	}

	public List<?> selectPrtList(PageVO vo) {
		
		return list("prtDAO.selectPrtList",vo);
	}

	public int updatePrtBoardHits(String prtunq) {
		
		return update("prtDAO.updatePrtBoardHits",prtunq);
	}

	public PrtVO selectPrtBoardDetail(PrtVO vo) {
		
		return (PrtVO) select("prtDAO.selectPrtBoardDetail",vo);
	}

	public int updatePrtBoard(PrtVO vo) {
		
		return update("prtDAO.updatePrtBoard",vo);
	}
	
	public int deletePrtBoard(String prtunq) {
		
		return delete("prtDAO.deletePrtBoard",prtunq);
	}

	public String insertPrtBoardCm(PrtVO vo) {
		
		return (String) insert("prtDAO.insertPrtBoardCm",vo);
	}

	public List<?> selectPrtBoardCm(PrtVO vo) {
		
		return list("prtDAO.selectPrtBoardCm",vo);
	}

	public int deletePrtBoardCm(PrtVO vo) {
		
		return delete("prtDAO.deletePrtBoardCm",vo);
	}

	public String selectPlanunq(String prtunq) {
		
		return (String) select("prtDAO.selectPlanunq",prtunq);
	}

	public int updatePrtBoardCm(PrtVO vo) {
		
		return update("prtDAO.updatePrtBoardCm",vo);
	}

}
