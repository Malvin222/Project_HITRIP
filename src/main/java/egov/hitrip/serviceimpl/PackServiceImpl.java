package egov.hitrip.serviceimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egov.hitrip.service.PackService;
import egov.hitrip.service.PackVO;

@Service("packService")
public class PackServiceImpl implements PackService {

	@Resource(name="packDAO")
	PackDAO packDAO;
	
	@Override
	public String insertPackBoardWriteSave(Map<String, Object> map1) throws Exception {
		
		return packDAO.insertPackBoardWriteSave(map1);
	}

	@Override
	public List<?> selectPackBoardList(PackVO vo) throws Exception {
		return packDAO.selectPackBoardList(vo);
	}

	@Override
	public int selectPackBoardTotal(PackVO vo) throws Exception {
		return packDAO.selectPackBoardTotal(vo);
	}

	@Override
	public PackVO selectPackBoardDetail(String packunq) throws Exception {
		return packDAO.selectPackBoardDetail(packunq);
	}

	@Override
	public int updatePackBoardHits(String packunq) throws Exception {
		return packDAO.updatePackBoardHits(packunq);
	}

	@Override
	public int deletePackBoard(String packunq) throws Exception {
		return packDAO.deletePackBoard(packunq);
	}

	@Override
	public int updatePackBoard(Map<String, Object> map1) throws Exception {
		return packDAO.updatePackBoard(map1);
	}

	@Override
	public List<?> selectPackBoardCm(PackVO vo) throws Exception {
		return packDAO.selectPackBoardCm(vo);
	}

	@Override
	public String insertPackBoardCm(PackVO vo) throws Exception {
		return packDAO.insertPackBoardCm(vo);
	}

	@Override
	public int deletePackBoardCm(String cmunq) throws Exception {
		return packDAO.deleteBoardCm(cmunq);
	}

	@Override
	public int updatePackBoardCm(PackVO vo) throws Exception {
		return packDAO.updatePackBoardCm(vo);
	}

	@Override
	public String insertPackReserve(PackVO vo) throws Exception {
		return packDAO.insertPackReserve(vo);
	}

	@Override
	public int selectReserveUserid(PackVO vo) throws Exception {
		return packDAO.selectReserveUserid(vo);
	}

	@Override
	public int deleteReserve(PackVO vo) throws Exception {
		return packDAO.deleteReserve(vo);
	}
	@Override
	public int selectPackLike(PackVO vo) throws Exception {
		return packDAO.selectPackLike(vo);
	}

	@Override
	public String insertPackLike(PackVO vo) throws Exception {
		return packDAO.insertPackLike(vo);
	}

	@Override
	public int updatePackStar(String packunq) throws Exception {
		return packDAO.updatePackStar(packunq);
	}

	@Override
	public int deletePackLike(PackVO vo) throws Exception {
		return packDAO.deletePackLike(vo);
	}

	@Override
	public int updatePackStarMinus(String packunq) throws Exception {
		return packDAO.updatePackStarMinus(packunq);
	}

}
