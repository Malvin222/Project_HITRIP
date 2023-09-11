package egov.hitrip.serviceimpl;

import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.AdminVO;
import egov.hitrip.service.MemberVO;

@Repository("memberDAO")
public class MemberDAO extends EgovAbstractDAO {
	
	public String insertMember(MemberVO vo) {
		
		return (String) insert("memberDAO.insertMember",vo);
	}

	public int selectMemberUserid(String userid) {
		
		return (int) select("memberDAO.selectMemberUserid",userid);
	}

	public int selectMemberNickname(String usernickname) {
		
		return (int) select("memberDAO.selectMemberNickname",usernickname);
	}

	public String selectPreventName(int no) {
		
		return (String) select("memberDAO.selectPreventName",no);
	}

	public String selectMemberLogin(MemberVO vo) {
		
		return (String) select("memberDAO.selectMemberLogin",vo);
	}
	
	public String selectMemberState(String userid) {
		
		return (String) select("memberDAO.selectMemberState",userid);
	}

	public MemberVO selectMemberDetail(String userid) {
		
		return (MemberVO) select("memberDAO.selectMemberDetail",userid);
	}

	public int updateMember(MemberVO vo) {
		
		return update("memberDAO.updateMember",vo);
	}

	public int updateMemberPassChange(Map<String, String> map) {
		
		return update("memberDAO.updateMemberPassChange",map);
	}

	public String selectMemberUseridReturn(MemberVO vo) {
		
		return (String) select("memberDAO.selectMemberUseridReturn",vo);
	}

	public int selectMemberExistCount(MemberVO vo) {
		
		return (int) select("memberDAO.selectMemberExistCount",vo);
	}

	public void updateMemberPass(MemberVO vo) {
		
		update("memberDAO.updateMemberPass",vo);
	}

	public int selectMemberCancelChk(Map<String, String> map1) {
		
		return (int) select("memberDAO.selectMemberCancelChk",map1);
	}

	public int updateMemberStateUpdate(Map<String, String> map2) {
		
		return update("memberDAO.updateMemberStateUpdate",map2);
	}

}
