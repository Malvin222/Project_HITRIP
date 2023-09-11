package egov.hitrip.service;

public class PlanVO {

	int planunq;			//	일정unq
	int planyear;			//	일정시작 년
	int planmonth;			//	일정시작 월
	int planday;			//	일정시작 일
	int planeyear;			//	일정종료 년
	int planemonth;			//	일정종료 월
	int planeday;			//	일정종료 일
	String plantitle;		//	일정제목
	String plancontent;		//	일정내용
	String planopen;		//	동행등록 ( Y or N )
	String userid;			//	유저아이디
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPlanopen() {
		return planopen;
	}
	public void setPlanopen(String planopen) {
		this.planopen = planopen;
	}
	public int getPlanunq() {
		return planunq;
	}
	public void setPlanunq(int planunq) {
		this.planunq = planunq;
	}
	public int getPlanyear() {
		return planyear;
	}
	public void setPlanyear(int planyear) {
		this.planyear = planyear;
	}
	public int getPlanmonth() {
		return planmonth;
	}
	public void setPlanmonth(int planmonth) {
		this.planmonth = planmonth;
	}
	public int getPlanday() {
		return planday;
	}
	public void setPlanday(int planday) {
		this.planday = planday;
	}	
	public int getPlaneyear() {
		return planeyear;
	}
	public void setPlaneyear(int planeyear) {
		this.planeyear = planeyear;
	}
	public int getPlanemonth() {
		return planemonth;
	}
	public void setPlanemonth(int planemonth) {
		this.planemonth = planemonth;
	}
	public int getPlaneday() {
		return planeday;
	}
	public void setPlaneday(int planeday) {
		this.planeday = planeday;
	}
	public String getPlantitle() {
		return plantitle;
	}
	public void setPlantitle(String plantitle) {
		this.plantitle = plantitle;
	}
	public String getPlancontent() {
		return plancontent;
	}
	public void setPlancontent(String plancontent) {
		this.plancontent = plancontent;
	}
	
}
