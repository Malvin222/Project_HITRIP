package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.PlanService;
import egov.hitrip.service.PlanVO;

@Service("planService")
public class PlanServiceImpl implements PlanService {

	@Resource(name = "planDAO")
    PlanDAO planDAO;
	
	@Override
	public List<?> selectPlanList(PlanVO vo) throws Exception {
		
		return planDAO.selectPlanList(vo);
	}

	@Override
	public PlanVO selectPlanDetail(PlanVO vo) throws Exception {
		
		return planDAO.selectPlanDetail(vo);
	}

	@Override
	public String insertPlan(PlanVO vo) throws Exception {
		
		return planDAO.insertPlan(vo);
	}

	@Override
	public int updatePlan(PlanVO vo) throws Exception {
		
		return planDAO.updatePlan(vo);
	}

	@Override
	public int deletePlan(PlanVO vo) throws Exception {
		
		return planDAO.deletePlan(vo);
	}

	@Override
	public int updatePlanOpen(Map<String, Object> map1) throws Exception {
		
		return planDAO.updatePlanOpen(map1);
	}

	@Override
	public String selectPrtunq(int planunq) throws Exception {
		
		return planDAO.selectPrtunq(planunq);
	}

	@Override
	public int updatePlanClose(String planunq) throws Exception {
		
		return planDAO.updatePlanClose(planunq);
	}

}
