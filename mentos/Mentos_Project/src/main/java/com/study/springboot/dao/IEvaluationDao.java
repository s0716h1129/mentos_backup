package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.EvaluationDto;
import com.study.springboot.dto.PlaceDto;

@Mapper
public interface IEvaluationDao {
	public List<EvaluationDto> listDao(int nStart, int nEnd);
	public int totalCount();
	public void write(String title, String name, String content);
	public  EvaluationDto viewDao(String id);
	public int Modify(String evaluation_number);
	public int modifyOk(String evaluation_title,String evaluation_content, String evaluation_number);
	public int Delete(String evaluation_number);
	public void upHit(String bId);
	public void replyDao( String title, String name, String content, 
					  int Group, int Step, int Indent);
	public void replyShape(int group, int step);
}
