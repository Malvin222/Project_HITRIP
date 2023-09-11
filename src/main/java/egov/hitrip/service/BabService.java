package egov.hitrip.service;

import java.util.List;


public interface BabService {
	
	//식당소개 셀렉
	List<?> selectBabList(BabVO vo) throws Exception;
	//식당소개 토탈
	int selectBabTotal(BabVO vo) throws Exception;
	//식당 디테일
	BabVO selectBabDetail(String contentid) throws Exception;
	//식당 홈 랜덤 리스트
	List<?> selectBabHomeList(BabVO bvo) throws Exception;
}
