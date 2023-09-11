package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import egov.hitrip.service.PackVO;

@Repository("packDAO")
public class PackDAO  extends EgovAbstractDAO {

	public String insertPackBoardWriteSave(Map<String, Object> map1) {
		
		return (String) insert("packDAO.insertPackBoardWriteSave",map1);
	}

	public List<?> selectPackBoardList(PackVO vo) {
		return list("packDAO.selectPackBoardList",vo);
	}

	public int selectPackBoardTotal(PackVO vo) {
		return (int) select("packDAO.selectPackBoardTotal",vo);
	}

	public PackVO selectPackBoardDetail(String packunq) {
		return (PackVO) select("packDAO.selectPackBoardDetail",packunq);
	}

	public int updatePackBoardHits(String packunq) {
		return update("packDAO.updatePackBoardHits",packunq);
	}

	public int deletePackBoard(String packunq) {
		return (int) delete("packDAO.deletePackBoard",packunq);
	}

	public int updatePackBoard(Map<String, Object> map1) {
		return (int) update("packDAO.updatePackBoard",map1);
	}

	public List<?> selectPackBoardCm(PackVO vo) {
		return list("packDAO.selectPackBoardCm",vo);
	}

	public String insertPackBoardCm(PackVO vo) {
		return (String) insert("packDAO.insertPackBoardCm",vo);
	}

	public int deleteBoardCm(String cmunq) {
		return delete("packDAO.deletePackBaordCm",cmunq);
	}

	public int updatePackBoardCm(PackVO vo) {
		return update("packDAO.updatePackBoardCm",vo);
	}

	public String insertPackReserve(PackVO vo) {
		return (String) insert("packDAO.insertPackReserve",vo);
	}

	public int selectReserveUserid(PackVO vo) {
		return (int)select("packDAO.selectReserveUserid",vo);
	}

	public int deleteReserve(PackVO vo) {
		return delete("packDAO.deleteReserve",vo);
	}

	public int selectPackLike(PackVO vo) {
		return (int) select("packDAO.selectPackLike",vo);
		
	}

	public String insertPackLike(PackVO vo) {
		return (String) insert("packDAO.insertPackLike",vo);
	}

	public int updatePackStar(String packunq) {
		return (int) update("packDAO.updatePackStar",packunq);
	}

	public int deletePackLike(PackVO vo) {
		return (int) delete("packDAO.deletePackLike",vo);
	}

	public int updatePackStarMinus(String packunq) {
		return (int) update("packDAO.updatePackStarMinus",packunq);
	}


}
