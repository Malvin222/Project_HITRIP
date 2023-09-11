package egov.hitrip.service;

public class PrtVO {

	private int prtunq;				//	동행게시판unq
	private int planunq;			//	일정게시판unq
	private String userid;			//	유저아이디
	private String usernickname;	//	유저닉네임
	private String usergender;		//	유저성별
	private int userage;			//	유저나이
	private String prttrvarea;		//	여행지역
	private String prttitle;		//	제목
	private String prtpass;			//	암호
	private String prtcontent;		//	내용
	private String prtrdate;		//	등록일
	private String prtudate;		//	수정일
	private String plansdate;		//	여행시작일
	private String planedate;		//	여행종료일
	private int prthits;			//	조회수
	private String prtsrc;			//	파일(사진) 저장경로
	private int prtcmunq;			//	동행게시판댓글unq
	private String prtcmpass;		//	동행게시판 댓글암호
	private String prtcmcontent;	//	동행게시판 댓글내용
	private String prtcmrdate;		//	동행게시판 댓글등록일
	
	public String getPrtcmpass() {
		return prtcmpass;
	}
	public void setPrtcmpass(String prtcmpass) {
		this.prtcmpass = prtcmpass;
	}
	public String getPrtcmcontent() {
		return prtcmcontent;
	}
	public void setPrtcmcontent(String prtcmcontent) {
		this.prtcmcontent = prtcmcontent;
	}
	public String getPrtcmrdate() {
		return prtcmrdate;
	}
	public void setPrtcmrdate(String prtcmrdate) {
		this.prtcmrdate = prtcmrdate;
	}
	public int getPrtunq() {
		return prtunq;
	}
	public void setPrtunq(int prtunq) {
		this.prtunq = prtunq;
	}
	public int getPlanunq() {
		return planunq;
	}
	public void setPlanunq(int planunq) {
		this.planunq = planunq;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsergender() {
		return usergender;
	}
	public void setUsergender(String usergender) {
		this.usergender = usergender;
	}
	public int getUserage() {
		return userage;
	}
	public void setUserage(int userage) {
		this.userage = userage;
	}
	public String getPrttrvarea() {
		return prttrvarea;
	}
	public void setPrttrvarea(String prttrvarea) {
		this.prttrvarea = prttrvarea;
	}
	public String getPrttitle() {
		return prttitle;
	}
	public void setPrttitle(String prttitle) {
		this.prttitle = prttitle;
	}
	public String getPrtpass() {
		return prtpass;
	}
	public void setPrtpass(String prtpass) {
		this.prtpass = prtpass;
	}
	public String getPrtcontent() {
		return prtcontent;
	}
	public void setPrtcontent(String prtcontent) {
		this.prtcontent = prtcontent;
	}
	public String getPrtrdate() {
		return prtrdate;
	}
	public void setPrtrdate(String prtrdate) {
		this.prtrdate = prtrdate;
	}
	public String getPrtudate() {
		return prtudate;
	}
	public void setPrtudate(String prtudate) {
		this.prtudate = prtudate;
	}
	public String getPlansdate() {
		return plansdate;
	}
	public void setPlansdate(String plansdate) {
		this.plansdate = plansdate;
	}
	public String getPlanedate() {
		return planedate;
	}
	public void setPlanedate(String planedate) {
		this.planedate = planedate;
	}
	public int getPrthits() {
		return prthits;
	}
	public void setPrthits(int prthits) {
		this.prthits = prthits;
	}
	public String getPrtsrc() {
		return prtsrc;
	}
	public void setPrtsrc(String prtsrc) {
		this.prtsrc = prtsrc;
	}
	public int getPrtcmunq() {
		return prtcmunq;
	}
	public void setPrtcmunq(int prtcmunq) {
		this.prtcmunq = prtcmunq;
	}
	public String getUsernickname() {
		return usernickname;
	}
	public void setUsernickname(String usernickname) {
		this.usernickname = usernickname;
	}
	
}
