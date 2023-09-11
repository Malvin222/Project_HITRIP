package egov.hitrip.service;

public class PackReviewVO {
	String userid;				//유저아이디
	String packreviewtitle;		//패키지여행 리뷰 제목
	String packreviewpass;		//패키지여행 리뷰 암호
	String packreviewrdate;		//패키지여행 리뷰 등록일
	String packreviewcontent;	//패키지여행 리뷰 내용
	String packreviewsrc1;		//패키지여행 리뷰 사진1
	String packreviewsrc2;		//패키지여행 리뷰 사진2
	int packreviewhits;			//패키지여행 리뷰 조회수
	int packreviewstar;			//패키지여행 리뷰 추천수
	String packtitle;			//패키지여행 제목
	int packunq;				//패키지여행 고유번호
	int packreviewunq;			//패키지여행 리뷰 고유번호
	String packsdate;			//패키지여행 시작일
	String packedate;			//패키지여행 종료일
	String packloc;				//패키지여행 지역
	
	// 댓글 관련
	String cmunq;				//댓글 고유번호
	String packreviewcmpass;	//댓글 암호
	String packreviewcmcontent;	//댓글 내용
	String packreviewcmrdate;	//댓글 등록일
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPackreviewtitle() {
		return packreviewtitle;
	}
	public void setPackreviewtitle(String packreviewtitle) {
		this.packreviewtitle = packreviewtitle;
	}
	public String getPackreviewpass() {
		return packreviewpass;
	}
	public void setPackreviewpass(String packreviewpass) {
		this.packreviewpass = packreviewpass;
	}
	public String getPackreviewrdate() {
		return packreviewrdate;
	}
	public void setPackreviewrdate(String packreviewrdate) {
		this.packreviewrdate = packreviewrdate;
	}
	public String getPackreviewcontent() {
		return packreviewcontent;
	}
	public void setPackreviewcontent(String packreviewcontent) {
		this.packreviewcontent = packreviewcontent;
	}
	public String getPackreviewsrc1() {
		return packreviewsrc1;
	}
	public void setPackreviewsrc1(String packreviewsrc1) {
		this.packreviewsrc1 = packreviewsrc1;
	}
	public String getPackreviewsrc2() {
		return packreviewsrc2;
	}
	public void setPackreviewsrc2(String packreviewsrc2) {
		this.packreviewsrc2 = packreviewsrc2;
	}
	public int getPackreviewhits() {
		return packreviewhits;
	}
	public void setPackreviewhits(int packreviewhits) {
		this.packreviewhits = packreviewhits;
	}
	public int getPackreviewstar() {
		return packreviewstar;
	}
	public void setPackreviewstar(int packreviewstar) {
		this.packreviewstar = packreviewstar;
	}
	public String getPacktitle() {
		return packtitle;
	}
	public void setPacktitle(String packtitle) {
		this.packtitle = packtitle;
	}
	public int getPackunq() {
		return packunq;
	}
	public void setPackunq(int packunq) {
		this.packunq = packunq;
	}
	public int getPackreviewunq() {
		return packreviewunq;
	}
	public void setPackreviewunq(int packreviewunq) {
		this.packreviewunq = packreviewunq;
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
	public String getPackloc() {
		return packloc;
	}
	public void setPackloc(String packloc) {
		this.packloc = packloc;
	}
	public String getCmunq() {
		return cmunq;
	}
	public void setCmunq(String cmunq) {
		this.cmunq = cmunq;
	}
	public String getPackreviewcmpass() {
		return packreviewcmpass;
	}
	public void setPackreviewcmpass(String packreviewcmpass) {
		this.packreviewcmpass = packreviewcmpass;
	}
	public String getPackreviewcmcontent() {
		return packreviewcmcontent;
	}
	public void setPackreviewcmcontent(String packreviewcmcontent) {
		this.packreviewcmcontent = packreviewcmcontent;
	}
	public String getPackreviewcmrdate() {
		return packreviewcmrdate;
	}
	public void setPackreviewcmrdate(String packreviewcmrdate) {
		this.packreviewcmrdate = packreviewcmrdate;
	}
	
	
	String packreviewlike;

	public String getPackreviewlike() {
		return packreviewlike;
	}
	public void setPackreviewlike(String packreviewlike) {
		this.packreviewlike = packreviewlike;
	}
	
}
