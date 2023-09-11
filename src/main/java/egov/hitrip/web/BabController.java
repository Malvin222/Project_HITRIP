package egov.hitrip.web;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egov.hitrip.service.BabService;
import egov.hitrip.service.BabVO;

@Controller
public class BabController {
	
	@Resource(name = "babService")
	BabService babService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping("/babList.do")
	public String selectBabList(BabVO vo, ModelMap model) throws Exception {
		// 출력페이지 번호
				int pageIndex = vo.getPageIndex();
				
				// 화면출력 개수 
				int pageUnit = vo.getPageUnit();
				
				// firstIndex 값 계산 ;;  1->1 ; 2->11 ; 3->21
				int firstIndex = (pageIndex-1)*pageUnit + 1;
				
				// lastIndex 값 계산
				int lastIndex = pageIndex*pageUnit; 
				
				//퍼스트 인덱스 세팅
				vo.setFirstIndex(firstIndex);
				//라스트 인데스 세팅
				vo.setLastIndex(lastIndex);
				
				//식당 개수
				int total = babService.selectBabTotal(vo);
				
				// 출력화면 시작번호
				int recordCountPerPage = total - ((pageIndex-1)*pageUnit);
				vo.setRecordCountPerPage(recordCountPerPage);
				
				// 12/10 ->  ceil(1.2) -> 2
				int lastPage = (int) Math.ceil((double)total/pageUnit);
				vo.setLastPage(lastPage);
				
				//식당리스트
				List<?> list = babService.selectBabList(vo);
				
				model.addAttribute("list", list);
				model.addAttribute("vo", vo);
				model.addAttribute("total", total);
				
				return "bab/babList";
	}
	
	@RequestMapping("/babDetail.do")
	//식당소개 디테일
	public String selectBabDetail(String contentid, ModelMap model) throws Exception {
		//식당 contentid를 받아와서 sql로 넘겨준후 결과를 vo로 받아옴
		BabVO vo = babService.selectBabDetail(contentid);
		model.addAttribute("vo",vo);
		
		return "bab/babDetail";
		
	}
	
	
}
