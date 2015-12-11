package sarin.app.controller;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;



@RestController
public class MainController {

	private final String URL ="http://localhost:8080/Home_Work_Rest_Webservice/api/";
	
	@RequestMapping(value={"/list"},method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getUser(){
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders header = new HttpHeaders();		
		HttpEntity<String> request =new HttpEntity<String>(header);		
		ResponseEntity<Map> response = restTemplate.exchange(
										URL+"list.act",
										HttpMethod.GET,
										request,
										Map.class
										);
		System.out.println(response);
		return new ResponseEntity<Map<String,Object>>(
						response.getBody(),
						response.getStatusCode()
						
					);
	}
	
	@RequestMapping(value={"/add"},method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addUser(){
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders header = new HttpHeaders();
		
		HttpEntity<String> request =new HttpEntity<String>(header);		
		ResponseEntity<Map> response = restTemplate.exchange(
										URL+"add",
										HttpMethod.POST,
										request,
										Map.class
										);
		System.out.println(response);
		return new ResponseEntity<Map<String,Object>>(
						response.getBody(),
						response.getStatusCode()
						
					);
	}
	
	@RequestMapping(value={"/","/index"}, method = RequestMethod.GET)
	public ModelAndView list() throws SQLException{			
		ModelAndView model=new ModelAndView("index");
		System.out.println(123);
		return model;
	}
	
	
}
