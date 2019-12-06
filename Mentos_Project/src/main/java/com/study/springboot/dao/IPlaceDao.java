package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.PlaceDto;

@Mapper
public interface IPlaceDao {
	public List<PlaceDto> listDao(int nStart, int nEnd);
	public void rentDao(String place_name, String place_address, String place_people, 
			String place_money, String place_phone, String place_email, String place_content,
			String place_image);
	public  PlaceDto viewDao(String id);
	public int totalCount();
}
