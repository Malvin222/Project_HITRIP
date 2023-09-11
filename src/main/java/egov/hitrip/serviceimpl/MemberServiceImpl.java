package egov.hitrip.serviceimpl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.AdminVO;
import egov.hitrip.service.MemberService;
import egov.hitrip.service.MemberVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Resource(name = "memberDAO")
	MemberDAO memberDAO;
	
	@Override
	public String insertMember(MemberVO vo) throws Exception {
		
		return memberDAO.insertMember(vo);
	}

	@Override
	public int selectMemberUserid(String userid) throws Exception {
		
		return memberDAO.selectMemberUserid(userid);
	}

	@Override
	public int selectMemberNickname(String usernickname) throws Exception {
		
		return memberDAO.selectMemberNickname(usernickname);
	}

	@Override
	public String selectPreventName(int no) throws Exception {
		
		return memberDAO.selectPreventName(no);
	}

	@Override
	public String selectMemberLogin(MemberVO vo) throws Exception {
		
		return memberDAO.selectMemberLogin(vo);
	}

	@Override
	public String selectMemberState(String userid) throws Exception {
		
		return memberDAO.selectMemberState(userid);
	}

	@Override
	public MemberVO selectMemberDetail(String userid) throws Exception {
		
		return memberDAO.selectMemberDetail(userid);
	}

	@Override
	public int updateMember(MemberVO vo) throws Exception {
		
		return memberDAO.updateMember(vo);
	}

	@Override
	public int updateMemberPassChange(Map<String, String> map) {
		
		return memberDAO.updateMemberPassChange(map);
	}

	@Override
	public String selectMemberUseridReturn(MemberVO vo) throws Exception {
		
		return memberDAO.selectMemberUseridReturn(vo);
	}

	@Override
	public int selectMemberExistCount(MemberVO vo) throws Exception {
		
		return memberDAO.selectMemberExistCount(vo);
	}

	@Override
	public void updateMemberPass(MemberVO vo) throws Exception {
		
		memberDAO.updateMemberPass(vo);
	}

	@Override
	public int selectMemberCancelChk(Map<String, String> map1) throws Exception {
		
		return memberDAO.selectMemberCancelChk(map1);
	}

	@Override
	public int updateMemberStateUpdate(Map<String, String> map2) throws Exception {
		
		return memberDAO.updateMemberStateUpdate(map2);
	}


}
