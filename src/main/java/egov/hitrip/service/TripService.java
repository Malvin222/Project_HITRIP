package egov.hitrip.service;

import java.util.List;


public interface TripService {
	
	// 국내여행지 리스트 select
	List<?> selectTripList(TripVO vo) 		  throws Exception;
	
	// 국내여행지 총 개수(total) select
	int 	selectTripTotal(TripVO vo) 		  throws Exception;
	
	// 국내여행지 디테일 select
	TripVO selectTripDetail(String contentid) throws Exception;
	
	//	홈화면 랜덤용
	List<?> selectTripHomeList(TripVO tvo) throws Exception;
}
