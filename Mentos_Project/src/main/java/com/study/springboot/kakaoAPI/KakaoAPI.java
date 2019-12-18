package com.study.springboot.kakaoAPI;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

@Service
public class KakaoAPI {
   public String getAccessToken (String authorize_code) throws ParseException {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=a68c8c847423a2284c6e8b645f7060cd");
            sb.append("&redirect_uri=http://localhost:8081/main/login");
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            
            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
               
            JSONParser jsonParser = new JSONParser();

            //JSON데이터를 넣어 JSON Object 로 만들어 준다.
            JSONObject jsonObj = (JSONObject) jsonParser.parse(result);
            
            access_Token = (String) jsonObj.get("access_token");
            refresh_Token = (String) jsonObj.get("refresh_token");
            
         System.out.println("access_token : " + access_Token);
         System.out.println("refresh_token : " + refresh_Token);
         
            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        
        return access_Token;
    }
   
   public HashMap<String, Object> getUserInfo (String access_Token) throws ParseException {
       
       //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
       HashMap<String, Object> userInfo = new HashMap<>();
       String reqURL = "https://kapi.kakao.com/v2/user/me";
       try {
           URL url = new URL(reqURL);
           HttpURLConnection conn = (HttpURLConnection) url.openConnection();
           conn.setRequestMethod("POST");
           
           //    요청에 필요한 Header에 포함될 내용
           conn.setRequestProperty("Authorization", "Bearer " + access_Token);
           
           int responseCode = conn.getResponseCode();
           System.out.println("responseCode : " + responseCode);
           
           BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
           
           String line = "";
           String result = "";
           
           while ((line = br.readLine()) != null) {
               result += line;
           }
           System.out.println("response body : " + result);
          
           JSONParser parser = new JSONParser();
           JSONObject jsonObj = (JSONObject) parser.parse(result);
           JSONObject properties = (JSONObject) jsonObj.get("properties");
           JSONObject kakao_account = (JSONObject) jsonObj.get("kakao_account");
           
           String nickname = (String) properties.get("nickname");
           String profile_image = (String) properties.get("profile_image");
           String kakaoid = Long.toString((long) jsonObj.get("id"));
           
           userInfo.put("nickname", nickname);
           userInfo.put("profile_image", profile_image);
           userInfo.put("snscheck", kakaoid);
       } catch (IOException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }
       
       return userInfo;
   }

}