package egov.hitrip.service;

public class NoticeVO {

	private int noticeunq;			//	공지글unq
	private String noticetitle;		//	공지글 제목
	private String noticepass;		//	공지글 암호
	private String noticename;		//	작성자
	private String noticecontent;	//	공지글 내용
	private int noticehits;			//	공지글 조회수
	private String noticerdate;		//	공지글 등록일
	private String noticeemps;		//	중요공지 ( Y or N )
	
	public int getNoticeunq() {
		return noticeunq;
	}
	public void setNoticeunq(int noticeunq) {
		this.noticeunq = noticeunq;
	}
	public String getNoticetitle() {
		return noticetitle;
	}
	public void setNoticetitle(String noticetitle) {
		this.noticetitle = noticetitle;
	}
	public String getNoticepass() {
		return noticepass;
	}
	public void setNoticepass(String noticepass) {
		this.noticepass = noticepass;
	}
	public String getNoticename() {
		return noticename;
	}
	public void setNoticename(String noticename) {
		this.noticename = noticename;
	}
	public String getNoticecontent() {
		return noticecontent;
	}
	public void setNoticecontent(String noticecontent) {
		this.noticecontent = noticecontent;
	}
	public int getNoticehits() {
		return noticehits;
	}
	public void setNoticehits(int noticehits) {
		this.noticehits = noticehits;
	}
	public String getNoticerdate() {
		return noticerdate;
	}
	public void setNoticerdate(String noticerdate) {
		this.noticerdate = noticerdate;
	}
	public String getNoticeemps() {
		return noticeemps;
	}
	public void setNoticeemps(String noticeemps) {
		this.noticeemps = noticeemps;
	}
}
