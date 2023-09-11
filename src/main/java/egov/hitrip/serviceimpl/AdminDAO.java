package egov.hitrip.serviceimpl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.AdminVO;
import egov.hitrip.service.BsnmVO;
import egov.hitrip.service.MemberVO;
import egov.hitrip.service.NoticeVO;
import egov.hitrip.service.PageVO;

@Repository("adminDAO")
public class AdminDAO extends EgovAbstractDAO {

	public String insertAdmin(AdminVO vo) {
		
		return (String) insert("adminDAO.insertAdmin",vo);
	}
	
	public int selectAdminid(String adminid) {
		
		return (int) select("adminDAO.selectAdminid",adminid);
	}
	
	public int selectFirstId(String adminid) {
		
		return (int) select("adminDAO.selectFirstId",adminid);
	}

	public String selectAdminSuper(String adminid) {
		
		return (String) select("adminDAO.selectAdminSuper",adminid);
	}
	
	public String selectAdminAuth(String adminid) {
		
		return (String) select("adminDAO.selectAdminAuth",adminid);
	}
	
	public String selectAdminLogin(AdminVO vo) {
		
		return (String) select("adminDAO.selectAdminLogin",vo);
	}
	
	public int selectNoticeTotal(PageVO vo) {
		
		return (int) select("adminDAO.selectNoticeTotal",vo);
	}

	public List<?> selectNoticeList(PageVO vo) {
		
		return list("adminDAO.selectNoticeList",vo);
	}

	public String insertNotice(NoticeVO vo) {
		
		return (String) insert("adminDAO.insertNotice",vo);
	}

	public int updateNoticeHits(String noticeunq) {
		
		return update("adminDAO.updateNoticeHits",noticeunq);
	}

	public NoticeVO selectNoticeDetail(String noticeunq) {
		
		return (NoticeVO) select("adminDAO.selectNoticeDetail",noticeunq);
	}

	public int adminNoticeUpdate(NoticeVO vo) {
		
		return update("adminDAO.adminNoticeUpdate",vo);
	}
	
	public int adminNoticeDelete(NoticeVO vo) {
		
		return delete("adminDAO.adminNoticeDelete",vo);
	}

	public List<?> selectMemberList(PageVO vo) {
		
		return list("adminDAO.selectMemberList",vo);
	}

	public int selectMemberTotal(PageVO vo) {
		
		return (int) select("adminDAO.selectMemberTotal",vo);
	}

	public MemberVO selectMemberDetail(String userid) {
		
		return (MemberVO) select("adminDAO.selectMemberDetail",userid);
	}

	public int updateMemberSave(MemberVO vo) {
		
		return update("adminDAO.updateMemberSave",vo);
	}

	public int deleteMemberUser(String userid) {
		
		return delete("adminDAO.deleteMemberUser",userid);
	}

	public int updateAllState(String userstate) {
		
		return update("adminDAO.updateAllState",userstate);
	}

	public int deleteAllDelete(String userstate) {
		
		return delete("adminDAO.deleteAllDelete",userstate);
	}
	
	public List<?> selectBsnmList(PageVO vo) {
		
		return list("adminDAO.selectBsnmList",vo);
	}

	public int selectBsnmTotal(PageVO vo) {
		
		return (int) select("adminDAO.selectBsnmTotal",vo);
	}

	public BsnmVO selectBsnmDetail(String bsnmid) {
		
		return (BsnmVO) select("adminDAO.selectBsnmDetail",bsnmid);
	}

	public int updateBsnmSave(BsnmVO vo) {
		
		return update("adminDAO.updateBsnmSave",vo);
	}

	public int deleteBsnmUser(String bsnmid) {
		
		return delete("adminDAO.deleteBsnmUser",bsnmid);
	}

	public int updateBsnmAllState(String bsnmstate) {
		
		return update("adminDAO.updateBsnmAllState",bsnmstate);
	}

	public int deleteBsnmAllDelete(String bsnmstate) {
		
		return delete("adminDAO.deleteBsnmAllDelete",bsnmstate);
	}

}
