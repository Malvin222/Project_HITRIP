package egov.hitrip.serviceimpl;

import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.BsnmVO;
import egov.hitrip.service.MemberVO;

@Repository("bsnmDAO")
public class BsnmDAO extends EgovAbstractDAO {
	
	public String insertBsnm(BsnmVO vo) {
		
		return (String) insert("bsnmDAO.insertBsnm",vo);
	}

	public int selectBsnmid(String bsnmid) {
		
		return (int) select("bsnmDAO.selectBsnmid",bsnmid);
	}

	/*
	 * public int selectMemberNickname(String usernickname) {
	 * 
	 * return (int) select("memberDAO.selectMemberNickname",usernickname); }
	 */

	public String selectPreventName(int no) {
		
		return (String) select("memberDAO.selectPreventName",no);
	}

	public String selectBsnmLogin(BsnmVO vo) {
		
		return (String) select("bsnmDAO.selectBsnmLogin",vo);
	}

	public String selectBsnmState(String bsnmid) {
		
		return (String) select("bsnmDAO.selectBsnmState",bsnmid);
	}

	public BsnmVO selectBsnmDetail(String bsnmid) {
		
		return (BsnmVO) select("bsnmDAO.selectBsnmDetail",bsnmid);
	}

	public int updateBsnm(BsnmVO vo) {
		
		return update("bsnmDAO.updateBsnm",vo);
	}

	public int updateBsnmPassChange(Map<String, String> map) {
		
		return update("bsnmDAO.updateBsnmPassChange",map);
	}

	public String selectBsnmidReturn(BsnmVO vo) {
		
		return (String) select("bsnmDAO.selectBsnmidReturn",vo);
	}

	public int selectBsnmExistCount(BsnmVO vo) {
		
		return (int) select("bsnmDAO.selectBsnmExistCount",vo);
	}

	public void updateBsnmPass(BsnmVO vo) {
		
		update("bsnmDAO.updateBsnmPass",vo);
	}

	public int selectBsnmCheck(BsnmVO bsnmno) {
		return (int) select("bsnmDAO.selectBsnmCheck",bsnmno);
	}
}
