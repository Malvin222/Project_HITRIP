package egov.hitrip.serviceimpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.AdminService;
import egov.hitrip.service.AdminVO;
import egov.hitrip.service.BsnmVO;
import egov.hitrip.service.MemberVO;
import egov.hitrip.service.NoticeVO;
import egov.hitrip.service.PageVO;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	
	@Resource(name = "adminDAO")
	AdminDAO adminDAO;

	@Override
	public String insertAdmin(AdminVO vo) throws Exception {
		
		return adminDAO.insertAdmin(vo);
	}
	
	@Override
	public int selectAdminid(String adminid) throws Exception {
		
		return adminDAO.selectAdminid(adminid);
	}
	
	@Override
	public int selectFirstId(String adminid) throws Exception {
		
		return adminDAO.selectFirstId(adminid);
	}

	@Override
	public String selectAdminSuper(String adminid) throws Exception {
		
		return adminDAO.selectAdminSuper(adminid);
	}
	
	@Override
	public String selectAdminAuth(String adminid) throws Exception {
		
		return adminDAO.selectAdminAuth(adminid);
	}

	@Override
	public String selectAdminLogin(AdminVO vo) throws Exception {
		
		return adminDAO.selectAdminLogin(vo);
	}
	
	@Override
	public List<?> selectNoticeList(PageVO vo) throws Exception {
		
		return adminDAO.selectNoticeList(vo);
	}

	@Override
	public int selectNoticeTotal(PageVO vo) throws Exception {
		
		return adminDAO.selectNoticeTotal(vo);
	}

	@Override
	public String insertNotice(NoticeVO vo) throws Exception {
		
		return adminDAO.insertNotice(vo);
	}

	@Override
	public int updateNoticeHits(String noticeunq) throws Exception {
		
		return adminDAO.updateNoticeHits(noticeunq);
	}

	@Override
	public NoticeVO selectNoticeDetail(String noticeunq) throws Exception {
		
		return adminDAO.selectNoticeDetail(noticeunq);
	}

	@Override
	public int adminNoticeUpdate(NoticeVO vo) throws Exception {
		
		return adminDAO.adminNoticeUpdate(vo);
	}
	
	@Override
	public int adminNoticeDelete(NoticeVO vo) throws Exception {
		
		return adminDAO.adminNoticeDelete(vo);
	}

	@Override
	public List<?> selectMemberList(PageVO vo) throws Exception {
		
		return adminDAO.selectMemberList(vo);
	}

	@Override
	public int selectMemberTotal(PageVO vo) throws Exception {
		
		return adminDAO.selectMemberTotal(vo);
	}

	@Override
	public MemberVO selectMemberDetail(String userid) throws Exception {
		
		return adminDAO.selectMemberDetail(userid);
	}

	@Override
	public int updateMemberSave(MemberVO vo) throws Exception {
		
		return adminDAO.updateMemberSave(vo);
	}

	@Override
	public int deleteMemberUser(String userid) throws Exception {
		
		return adminDAO.deleteMemberUser(userid);
	}

	@Override
	public int updateAllState(String userstate) throws Exception {
		
		return adminDAO.updateAllState(userstate);
	}

	@Override
	public int deleteAllDelete(String userstate) throws Exception {
		
		return adminDAO.deleteAllDelete(userstate);
	}

	@Override
	public List<?> selectBsnmList(PageVO vo) throws Exception {
		
		return adminDAO.selectBsnmList(vo);
	}

	@Override
	public int selectBsnmTotal(PageVO vo) throws Exception {
		
		return adminDAO.selectBsnmTotal(vo);
	}

	@Override
	public BsnmVO selectBsnmDetail(String bsnmid) throws Exception {
		
		return adminDAO.selectBsnmDetail(bsnmid);
	}

	@Override
	public int updateBsnmSave(BsnmVO vo) throws Exception {
		
		return adminDAO.updateBsnmSave(vo);
	}

	@Override
	public int deleteBsnmUser(String bsnmid) throws Exception {
		
		return adminDAO.deleteBsnmUser(bsnmid);
	}

	@Override
	public int updateBsnmAllState(String bsnmstate) throws Exception {
		
		return adminDAO.updateBsnmAllState(bsnmstate);
	}

	@Override
	public int deleteBsnmAllDelete(String bsnmstate) throws Exception {
		
		return adminDAO.deleteBsnmAllDelete(bsnmstate);
	}
}
