package egov.hitrip.service;

import java.util.List;
import java.util.Map;

public interface PlanService {
	//	일정출력
	List<?> selectPlanList(PlanVO vo) throws Exception;
	//	상세일정
	PlanVO selectPlanDetail(PlanVO vo) throws Exception;
	//	일정추가
	String insertPlan(PlanVO vo) throws Exception;
	//	일정 업데이트
	int updatePlan(PlanVO vo) throws Exception;
	//	일정 삭제
	int deletePlan(PlanVO vo) throws Exception;
	//	동행게시판 등록시 미등록에서 등록으로 변경
	int updatePlanOpen(Map<String, Object> map1) throws Exception;
	//	동행게시판 등록에서 미등록으로 변경시 등록된 동행글 삭제
	String selectPrtunq(int planunq) throws Exception;
	//	동행게시판 글 삭제시 동행찾기 N으로 업데이트
	int updatePlanClose(String planunq) throws Exception;
}
