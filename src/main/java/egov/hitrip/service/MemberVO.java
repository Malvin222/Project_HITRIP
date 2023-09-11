package egov.hitrip.service;

public class MemberVO {

	private String userid;			//유저아이디
	private String userpass;		//유저암호
	private String username;		//유저이름
	private String usernickname;	//유저닉네임
	private String userbirth;		//유저생일
	private String userage;			//유저나이
	private String userphone;		//유저핸드폰번호
	private String useremail;		//유저메일
	private String userrdate;		//유저가입일
	private String useropeninfo;	//유저정보공개
	private String usergender;		//유저성별
	private String userstate;		//회원상태(관리자만보임)
	private String usermemo;		//회원메모(관리자만보임)
	private String nickname_change;	//닉네임 변경 확인용
	
	public String getNickname_change() {
		return nickname_change;
	}
	public void setNickname_change(String nickname_change) {
		this.nickname_change = nickname_change;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpass() {
		return userpass;
	}
	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsernickname() {
		return usernickname;
	}
	public void setUsernickname(String usernickname) {
		this.usernickname = usernickname;
	}
	public String getUserbirth() {
		return userbirth;
	}
	public void setUserbirth(String userbirth) {
		this.userbirth = userbirth;
	}
	public String getUserage() {
		return userage;
	}
	public void setUserage(String userage) {
		this.userage = userage;
	}
	public String getUserphone() {
		return userphone;
	}
	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getUserrdate() {
		return userrdate;
	}
	public void setUserrdate(String userrdate) {
		this.userrdate = userrdate;
	}
	public String getUseropeninfo() {
		return useropeninfo;
	}
	public void setUseropeninfo(String useropeninfo) {
		this.useropeninfo = useropeninfo;
	}
	public String getUsergender() {
		return usergender;
	}
	public void setUsergender(String usergender) {
		this.usergender = usergender;
	}
	public String getUserstate() {
		return userstate;
	}
	public void setUserstate(String userstate) {
		this.userstate = userstate;
	}
	public String getUsermemo() {
		return usermemo;
	}
	public void setUsermemo(String usermemo) {
		this.usermemo = usermemo;
	}
	
}
