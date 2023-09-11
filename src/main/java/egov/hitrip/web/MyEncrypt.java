package egov.hitrip.web;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class MyEncrypt {

	public static String testMD5(String pwd) {
	    String MD5 = "";
	    try {
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        md.update(pwd.getBytes());
	        byte byteData[] = md.digest();
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++) {
	            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	        }
	        MD5 = sb.toString();
	 
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	        MD5 = null;
	    }
	    return MD5;
	}
	
	public static String randomPass() {	//	랜덤패스워드
	    List<String> lName = Arrays.asList(
	    		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
	    		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
	    List<String> fName = Arrays.asList("1","2","3","4","5","6","7","8","9","0");
	    Collections.shuffle(lName);
	    Collections.shuffle(fName);
	    String pass = lName.get(0) + fName.get(0) + lName.get(1) + fName.get(1) +
	    				 lName.get(2) + fName.get(2) + lName.get(3) + fName.get(3) +
	    				 lName.get(4) + fName.get(4) + lName.get(5) + fName.get(5) +
	    				 lName.get(6) + fName.get(6) + lName.get(7) + fName.get(7);
	    return pass;
	 }
}
