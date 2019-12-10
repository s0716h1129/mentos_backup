package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.PlaceDto;

@Mapper
public interface IPlaceDao {
	public List<PlaceDto> listDao(int nStart, int nEnd);
	public void rentDao(String place_name, String place, String place_people, 
			String place_price, String place_phone, String place_email, String place_content,
			String place_image);
	public  PlaceDto viewDao(String id);
	public int totalCount();
	public int placeModify(String place_number);
	public int modifyOk(String place_name, String place, String place_people, 
			String place_price, String place_phone, String place_email, String place_content,
			String place_image, String place_number);
	public int placeDelete(String place_number);
	
}
