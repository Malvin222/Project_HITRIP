package egov.hitrip.service;

public class AdminVO {

	private String adminid;		//관리자아이디
	private String adminpass;	//관리자비밀번호
	private String adminname;	//관리자이름
	private String adminphone;	//관리자핸드폰번호
	private String adminsuper;	//슈퍼관리자( Y or N )
	private String adminauth;	//관리자상태( Y or N )
	
	public String getAdminid() {
		return adminid;
	}
	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}
	public String getAdminpass() {
		return adminpass;
	}
	public void setAdminpass(String adminpass) {
		this.adminpass = adminpass;
	}
	public String getAdminname() {
		return adminname;
	}
	public void setAdminname(String adminname) {
		this.adminname = adminname;
	}
	public String getAdminphone() {
		return adminphone;
	}
	public void setAdminphone(String adminphone) {
		this.adminphone = adminphone;
	}
	public String getAdminauth() {
		return adminauth;
	}
	public void setAdminauth(String adminauth) {
		this.adminauth = adminauth;
	}
	public String getAdminsuper() {
		return adminsuper;
	}
	public void setAdminsuper(String adminsuper) {
		this.adminsuper = adminsuper;
	}
	
	
}
