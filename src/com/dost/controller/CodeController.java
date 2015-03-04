package com.dost.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dost.hibernate.DbCode;
import com.dost.service.CodeService;

@Controller
@RequestMapping("api")
public class CodeController {

	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value="/codes/all", method=RequestMethod.GET)  
	@ResponseBody
	public Map<String, List<DbCode>> getAllCodes() {
		List<DbCode> allCodes = codeService.getAllCodes();
		Map<String, List<DbCode>> responseMap = new HashMap<String, List<DbCode>>();
		for(DbCode code : allCodes) {
			List<DbCode> codes = responseMap.get(code.getType());
			if(codes == null) {
				codes = new ArrayList<DbCode>();
				codes.add(code);
				responseMap.put(code.getType(), codes);
			}
			else {
				codes.add(code);
			}
		}
		return responseMap;
	}
	
	@RequestMapping(value="/code/{id}", method=RequestMethod.GET)  
	@ResponseBody
	public DbCode getCodeById(@PathVariable Long id, HttpServletRequest request) {
		DbCode code = codeService.getCodeById(id);
		return code;
	}
	
	@RequestMapping(value="/codes/{type}", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbCode> getCodeByTagName(@PathVariable String type) {
		List<DbCode> codesByTag = codeService.getCodesByTag(type);
		return codesByTag;
	}
}
