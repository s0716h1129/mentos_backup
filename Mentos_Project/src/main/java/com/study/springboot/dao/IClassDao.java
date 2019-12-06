package com.study.springboot.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.ClassDto;

@Mapper
public interface IClassDao {
	public ArrayList<ClassDto> classListDao(int nStart, int nEnd);
	public ClassDto classContentViewDao(String class_number);
	public int classWriteDao(String class_mento, String class_name, String class_content, String class_place, String class_image, String class_mento_information);
	public int classModifyDao(String class_number, String class_mento, String class_name, String class_content);
	public int classUpHitDao(String class_number);
	public int classDeleteDao(String class_number);
	public String getMentee(String id);
	public ClassDto callClass(String id);
	public int joinClass(String id, String mentee);
	public int totalCount();
	public int reviewClass(String writer, String class_number, int score, String review_content);
	public int getRanking(String type);
}
