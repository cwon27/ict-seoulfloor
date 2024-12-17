package com.ict.seoulfloor.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.seoulfloor.dao.MainDAO;
import com.ict.seoulfloor.vo.CommentVO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.EventVO;

@Service
public class MainServiceImpl implements MainService {
	@Autowired
	MainDAO dao;

	@Override
	public List<Map<String, Object>> calSelect(String startDate, String endDate) {
		// TODO Auto-generated method stub
		return dao.calSelect(startDate, endDate);
	}

	@Override
	public List<DataVO> getDateList(String dataStr) {
		return dao.getDateList(dataStr);
	}

	@Override
	public List<DataVO> mainSelectRecord() {
		return dao.mainSelectRecord();
	}
	
	@Override
	public List<CommentVO> mainReviewSelect() {
		return dao.mainReviewSelect();
	}
	
	@Override
	public List<EventVO> eventList() {
		return dao.eventList();
	}

	@Override
	public EventVO eventView(int no) {
		return dao.eventView(no);
	}
	@Override 
	 public List<EventVO> getEventsSortedBy(String sortType){ 
	       return dao.getEventsSortedBy(sortType);
	 }

	@Override
	public void eventhi(int no) {
		dao.eventhi(no);
		
	}

	
}
