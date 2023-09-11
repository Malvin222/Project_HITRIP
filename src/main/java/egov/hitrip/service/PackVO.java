package egov.hitrip.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class PackVO  implements Serializable{
	private String packunq;			//패키지여행 고유번호
	private String bsnmid;			//사업자아이디
	private String packpass;		//패키지여행 암호
	private String packloc;			//패키지여행 지역
	private String packrdate;		//패키지여행 등록일
	private String packsdate;		//패키지여행 시작일
	private String packedate;		//패키지여행 종료일
	private String packcharge;		//패키지여행 요금
	private int packstar;			//패키지여행 추천수
	private String packopen;		//패키지여행 오픈
	private int packhits;			//패키지여행 조회수
	private String packsrc1;		//패키지여행 사진1
	private String packtitle;		//패키지여행 제목

	

	public String getPackunq() {
		return packunq;
	}
	public void setPackunq(String packunq) {
		this.packunq = packunq;
	}
	public String getBsnmid() {
		return bsnmid;
	}
	public void setBsnmid(String bsnmid) {
		this.bsnmid = bsnmid;
	}
	public String getPackpass() {
		return packpass;
	}
	public void setPackpass(String packpass) {
		this.packpass = packpass;
	}
	public String getPackloc() {
		return packloc;
	}
	public void setPackloc(String packloc) {
		this.packloc = packloc;
	}
	public String getPackrdate() {
		return packrdate;
	}
	public void setPackrdate(String packrdate) {
		this.packrdate = packrdate;
	}
	public String getPacksdate() {
		return packsdate;
	}
	public void setPacksdate(String packsdate) {
		this.packsdate = packsdate;
	}
	public String getPackedate() {
		return packedate;
	}
	public void setPackedate(String packedate) {
		this.packedate = packedate;
	}
	public String getPackcharge() {
		return packcharge;
	}
	public void setPackcharge(String packcharge) {
		this.packcharge = packcharge;
	}
	public int getPackstar() {
		return packstar;
	}
	public void setPackstar(int packstar) {
		this.packstar = packstar;
	}
	public String getPackopen() {
		return packopen;
	}
	public void setPackopen(String packopen) {
		this.packopen = packopen;
	}
	public int getPackhits() {
		return packhits;
	}
	public void setPackhits(int packhits) {
		this.packhits = packhits;
	}
	public String getPacksrc1() {
		return packsrc1;
	}
	public void setPacksrc1(String packsrc1) {
		this.packsrc1 = packsrc1;
	}
	public String getPacktitle() {
		return packtitle;
	}
	public void setPacktitle(String packtitle) {
		this.packtitle = packtitle;
	}
	
	/**
	 *  serialVersion UID
	 */
	private static final long serialVersionUID = -858838578081269359L;

	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";

	/** 검색사용여부 */
	private String searchUseYn = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** 페이지갯수(화면출력) */
	private int pageUnit = 10;

	/** 페이지사이즈(페이징) */
	private int pageSize = 10;

	/** 화면출력, SELECT SQL에서의 시작행 번호 */
	private int firstIndex = 1;

	/** 화면출력, SELECT SQL에서의 종료행 번호 */
	private int lastIndex = 10;

	/** 화면출력에서 행번호 매김 시 초기세팅 번호 */
	private int recordCountPerPage = 10;

	/** 마지막페이지 번호*/
	private int lastPage = 1;
	
	/** 페이징의 시작페이지 번호*/
	private int startPage = 1;
	
	/** 페이징의 끝페이지 번호*/
	private int endPage = 10;
	
	/** 전체데이터 개수 */
	private int total = 0;
	
	/** 검색 후 데이터 개수 */
	private int totalSearch = 0;
	
	private int beforePage = 1;
	
	private int nextPage = 1;

	public int getBeforePage() {
		return beforePage;
	}

	public void setBeforePage(int beforePage) {
		this.beforePage = beforePage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getTotalSearch() {
		return totalSearch;
	}

	public void setTotalSearch(int totalSearch) {
		this.totalSearch = totalSearch;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	//댓글
	private String userid;			//유저아이디
	private String packcmpass;		//댓글암호
	private String packcmcontent;	//댓글 콘텐츠
	private String packcmrdate;		//댓글 등록일
	private String cmunq;			//댓글 고유번호
	


	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPackcmpass() {
		return packcmpass;
	}
	public void setPackcmpass(String packcmpass) {
		this.packcmpass = packcmpass;
	}
	public String getPackcmcontent() {
		return packcmcontent;
	}
	public void setPackcmcontent(String packcmcontent) {
		this.packcmcontent = packcmcontent;
	}
	public String getPackcmrdate() {
		return packcmrdate;
	}
	public void setPackcmrdate(String packcmrdate) {
		this.packcmrdate = packcmrdate;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCmunq() {
		return cmunq;
	}
	public void setCmunq(String cmunq) {
		this.cmunq = cmunq;
	}
	
	private String cancle;
	private String packlike;

	public String getCancle() {
		return cancle;
	}
	public void setCancle(String cancle) {
		this.cancle = cancle;
	}
	public String getPacklike() {
		return packlike;
	}
	public void setPacklike(String packlike) {
		this.packlike = packlike;
	}
	
	
}
