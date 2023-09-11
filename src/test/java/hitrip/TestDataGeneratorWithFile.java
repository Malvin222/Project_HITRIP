package hitrip;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class TestDataGeneratorWithFile {
    public static void main(String[] args) {
        Random random = new Random();
        
        //	따로 경로지정안해주면 worksapce에 생성됨
        try (FileWriter writer = new FileWriter("공지글더미데이터1.txt")) {
        	String namesCombined = "";
        	String namesCombined2 = ""; 
        	String pass = "25d55ad283aa400af464c76d713c07ad";	//12345678
        	String randomDateTime = "";
        	
        	for (int i = 1; i <= 1000; i++) {
                String testId = "testid" + i;
                for (int j = 0; j < 3; j++) {
                    String name1 = getRandomName();
                    String name2 = getRandomName();
                    String name3 = getRandomName();

                    namesCombined = name1+name2+name3;
                }
                for (int k = 0; k < 3; k++) {
                    String name1 = getRandomName();
                    String name2 = getRandomName();
                    String name3 = getRandomName();

                    namesCombined2 = name1+name2+name3;
                }
                for (int l = 0; l < 3; l++) {
                    randomDateTime = getRandomDateTime();
                    
                }
                String name1 = namesCombined;	// 이름 or 닉네임용
                String name2 = namesCombined2;	// 이름 or 닉네임용
                String sequenceNumber = String.format("%02d", i);	//	1부터 순차증가
                String birthdate = getRandomBirthdate();	//	랜덤 생일
                String phoneNumber = getRandomPhoneNumber();	//	랜덤 휴대폰 번호
                String email = getRandomEmail();				//	랜덤 이메일 번호
                String date = getRandomDate();					//	랜덤 가입일
                String yValue = random.nextBoolean() ? "Y" : "N";	//	유저정보공개 공개 아니면 비공개
                String mValue = random.nextBoolean() ? "F" : "M";	//	유저성별 여자 아니면 남자
                String state = generateRandomNumber()+"";
                
				//	유저 더미 데이터 생성
				  String generatedData = testId + sequenceNumber + "," + pass + "," + name1 +
				  "," + name2 + "," + birthdate + "," + 30 + "," + phoneNumber + "," + email +
				  "," + date + "," + yValue + "," + mValue + ","+state;
				 
                
                //	공지글 더미 데이터 생성
				/*
				 * String generatedData = sequenceNumber + "," + name1+name2 + "," + pass + ","
				 * + name1 + "," + name2+name1 + "," + 0 + "," + yValue + "," + randomDateTime;
				 */
                
                writer.write(generatedData + "\n");
            }
            System.out.println("Data has been generated and saved to generated_data.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getRandomName() {
        String[] names = {"가", "강", "건", "경", "고", "관", "광", "구", "규", "근", "기", "길", "나", "남", "노", "누", "다",
    	        "단", "달", "담", "대", "덕", "도", "동", "두", "라", "래", "로", "루", "리", "마", "만", "명", "무", "문", "미", "민", "바", "박",
    	        "백", "범", "별", "병", "보", "빛", "사", "산", "상", "새", "서", "석", "선", "설", "섭", "성", "세", "소", "솔", "수", "숙", "순",
    	        "숭", "슬", "승", "시", "신", "아", "안", "애", "엄", "여", "연", "영", "예", "오", "옥", "완", "요", "용", "우", "원", "월", "위",
    	        "유", "윤", "율", "으", "은", "의", "이", "익", "인", "일", "잎", "자", "잔", "장", "재", "전", "정", "제", "조", "종", "주", "준",
    	        "중", "지", "진", "찬", "창", "채", "천", "철", "초", "춘", "충", "치", "탐", "태", "택", "판", "하", "한", "해", "혁", "현", "형",
    	        "혜", "호", "홍", "화", "환", "회", "효", "훈", "휘", "희", "운", "모", "배", "부", "림", "봉", "혼", "황", "량", "린", "을", "비",
    	        "솜", "공", "면", "탁", "온", "디", "항", "후", "려", "균", "묵", "송", "욱", "휴", "언", "령", "섬", "들", "견", "추", "걸", "삼",
    	        "열", "웅", "분", "변", "양", "출", "타", "흥", "겸", "곤", "번", "식", "란", "더", "손", "술", "훔", "반", "빈", "실", "직", "흠",
    	        "흔", "악", "람", "뜸", "권", "복", "심", "헌", "엽", "학", "개", "롱", "평", "늘", "늬", "랑", "얀", "향", "울", "련"};
        
        
        return names[new Random().nextInt(names.length)];
    }

    public static String getRandomBirthdate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        long minDate = Timestamp.valueOf("1970-01-01 00:00:00").getTime();
        long maxDate = System.currentTimeMillis();
        long randomDate = minDate + (long) (Math.random() * (maxDate - minDate));
        return dateFormat.format(new Date(randomDate));
    }

    public static String getRandomPhoneNumber() {
        return "010" + String.format("%07d", new Random().nextInt(10000000));
    }

    public static String getRandomEmail() {
        String[] domains = {"gmail.com", "yahoo.com", "hotmail.com", "example.com"};
        return getRandomString(5) + "@" + domains[new Random().nextInt(domains.length)];
    }

    public static String getRandomDate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yy-MM-dd");
        long currentDate = System.currentTimeMillis();
        long randomDate = currentDate - (long) (Math.random() * 365 * 24 * 60 * 60 * 1000); // within the last year
        return dateFormat.format(new Date(randomDate));
    }

    public static String getRandomString(int length) {
        String characters = "abcdefghijklmnopqrstuvwxyz";
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int randomIndex = new Random().nextInt(characters.length());
            result.append(characters.charAt(randomIndex));
        }
        return result.toString();
    }
    
    public static String getRandomDateTime() {
        Random random = new Random();

        int year = 1970 + random.nextInt(52);  // Generate a year between 1970 and 2021
        int month = 1 + random.nextInt(12);
        int day = 1 + random.nextInt(28); // Assume all months have 28 days for simplicity
        int hour = random.nextInt(24);
        int minute = random.nextInt(60);
        int second = random.nextInt(60);

        String formattedDateTime = String.format("%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second);

        return formattedDateTime;
    }
    
   
    public static int generateRandomNumber() {
        Random random = new Random();
        return random.nextInt(4) + 1;
    }
        
}
