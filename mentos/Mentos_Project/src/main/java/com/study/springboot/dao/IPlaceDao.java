package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.PlaceDto;

@Mapper
public interface IPlaceDao {
	public List<PlaceDto> listDao(int nStart, int nEnd);
	public int rentDao(Map<String, String> rentMap);
	public  PlaceDto viewDao(String id);
	public int totalCount();
	public int placeModify(String place_number);
	public int modifyOk(Map<String, String> modifyMap);
	public int placeDelete(String place_number);	
}
