package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PayDto {
	private String pay_member;
	private String pay_price;
	private String pay_kind;
	private int pay_num;
	private String pay_type;
	private Date pay_date;
	private String refund;
	
	private String class_name;
	private String place_name;
}
