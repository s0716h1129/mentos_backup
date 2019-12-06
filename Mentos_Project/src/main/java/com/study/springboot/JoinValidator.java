package com.study.springboot;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.study.springboot.dto.MemberDto;

public class JoinValidator implements Validator{
	@Override
	public boolean supports(Class<?> arg0) {
		return MemberDto.class.isAssignableFrom(arg0);	// 검증할 객체의 클래스 타입 정보
	}
	@Override
	public void validate(Object obj, Errors errors) {
		
		MemberDto dto = (MemberDto)obj;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "email is null or empry");
		if(dto.getEmail() != null) {
			String mId = dto.getEmail();
			if(mId.length() < 6) {
				errors.rejectValue("email", "email is too short.");
			}
		}
				
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "password is empry");
		if(dto.getPassword() != null) {
			String mPw = dto.getPassword();
			if(mPw.length() < 3) {
				errors.rejectValue("password", "password is too short.");
			}
		}
	}
}
