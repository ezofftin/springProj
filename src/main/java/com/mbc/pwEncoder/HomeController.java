package com.mbc.pwEncoder;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@RequestMapping("chiperTest")
	public void chiperTest() {
		String plainPw = "test1234";
		
		// 평문비번은 같아도 암호화된 값은 서로 다르다.
		String encPw1 = pwEncoder.encode(plainPw);
		String encPw2 = pwEncoder.encode(plainPw);
		System.out.println("-----------------");
		System.out.println("encPw1 : " + encPw1);
		System.out.println("encPw2 : " + encPw2);
		
		String pw1 = "test1234";
		String pw2 = "test";
		// matches는 리턴값이 boolean
		System.out.println(pwEncoder.matches(pw1, encPw1));
		System.out.println(pwEncoder.matches(pw1, encPw2));
		System.out.println("---------------------");
		System.out.println(pwEncoder.matches(pw2, encPw1));
				
		
	}
	
	
}





