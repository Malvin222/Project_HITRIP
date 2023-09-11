package egov.hitrip.serviceimpl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.BsnmService;
import egov.hitrip.service.BsnmVO;

@Service("bsnmService")
public class BsnmServiceImpl implements BsnmService {
	
	@Resource(name = "bsnmDAO")
	BsnmDAO bsnmDAO;
	
	@Override
	public String insertBsnm(BsnmVO vo) throws Exception {
		
		return bsnmDAO.insertBsnm(vo);
	}

	@Override
	public int selectBsnmid(String bsnmid) throws Exception {
		
		return bsnmDAO.selectBsnmid(bsnmid);
	}

	/*
	 * @Override public int selectMemberNickname(String usernickname) throws
	 * Exception {
	 * 
	 * return memberDAO.selectMemberNickname(usernickname); }
	 */

	@Override
	public String selectPreventName(int no) throws Exception {
		
		return bsnmDAO.selectPreventName(no);
	}

	@Override
	public String selectBsnmLogin(BsnmVO vo) throws Exception {
		
		return bsnmDAO.selectBsnmLogin(vo);
	}

	@Override
	public String selectBsnmState(String bsnmid) throws Exception {
		
		return bsnmDAO.selectBsnmState(bsnmid);
	}

	@Override
	public BsnmVO selectBsnmDetail(String bsnmid) throws Exception {
		
		return bsnmDAO.selectBsnmDetail(bsnmid);
	}

	@Override
	public int updateBsnm(BsnmVO vo) throws Exception {
		
		return bsnmDAO.updateBsnm(vo);
	}

	@Override
	public int updateBsnmPassChange(Map<String, String> map) {
		
		return bsnmDAO.updateBsnmPassChange(map);
	}

	@Override
	public String selectBsnmidReturn(BsnmVO vo) throws Exception {
		
		return bsnmDAO.selectBsnmidReturn(vo);
	}

	@Override
	public int selectBsnmExistCount(BsnmVO vo) throws Exception {
		
		return bsnmDAO.selectBsnmExistCount(vo);
	}

	@Override
	public void updateBsnmPass(BsnmVO vo) throws Exception {
		
		bsnmDAO.updateBsnmPass(vo);
	}

	@Override
	public int selectBsnmCheck(BsnmVO bsnmno) throws Exception {
		return bsnmDAO.selectBsnmCheck(bsnmno);
	}
}
