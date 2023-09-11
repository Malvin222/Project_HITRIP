package egov.hitrip.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TripApiController {

	@RequestMapping("/cityDetail.do")
	public String cityDetail() {
		
		return "trip_api/cityDetail";
	}
	
	@RequestMapping("/NewFile.do")
	public String newFile() {
		
		return "test123/NewFile";
	}
}
