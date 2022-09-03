package com.itkey.sam;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Handles requests for the application home page.
 */
/**
 * @author LKM
 *
 *
 */
@Controller
public class HomeController  {
	final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/*
	@GetMapping("/")
	public String home() {
		return "login";
	}
	*/
	
	@GetMapping("/")
	public String home() {
		return "ajax";
	}
	/*
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@RequestParam Map<String, Object> requestParam) throws Exception {
		int idx = 0;
		// from parameters from request, generate get Param for next request
		String methodGetStr = "";
	
		Map<String, Object> map = new HashMap<String, Object>();
		// CAMEL
		for (Entry<String, Object> elem : requestParam.entrySet()) {
			if (idx == 0) {
				methodGetStr += "?";
			}
			methodGetStr += String.format("%s=%s&", elem.getKey(), elem.getValue());
			idx++;
			if (idx == requestParam.size()) {
				methodGetStr = methodGetStr.substring(0, methodGetStr.length() - 1);
			}
		}
		return "redirect:main.do" + methodGetStr;
	}
	*/
	
}
