package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.PlanVO;

@Repository("planDAO")
public class PlanDAO  extends EgovAbstractDAO {

	public List<?> selectPlanList(PlanVO vo) {
		
		return list ("planDAO.selectPlanList",vo);
	}

	public PlanVO selectPlanDetail(PlanVO vo) {
		
		return (PlanVO) select("planDAO.selectPlanDetail", vo);
	}

	public String insertPlan(PlanVO vo) {
		
		return (String) insert("planDAO.insertPlan",vo);
	}

	public int updatePlan(PlanVO vo) {
		
		return update("planDAO.updatePlan",vo);
	}

	public int deletePlan(PlanVO vo) {
		
		return delete("planDAO.deletePlan",vo);
	}

	public int updatePlanOpen(Map<String, Object> map1) {
		
		return update("planDAO.updatePlanOpen",map1);
	}

	public String selectPrtunq(int planunq) {
		
		return (String) select("planDAO.selectPrtunq",planunq);
	}

	public int updatePlanClose(String planunq) {
		
		return update("planDAO.updatePlanClose",planunq);
	}

}
