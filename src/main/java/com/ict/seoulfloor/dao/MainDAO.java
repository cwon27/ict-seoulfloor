package com.ict.seoulfloor.dao;

import java.util.List;
import java.util.Map;

import com.ict.seoulfloor.vo.CommentVO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.EventVO;

public interface MainDAO {
	public List<Map<String, Object>> calSelect(String startDate, String endDate);
	public List<DataVO> getDateList(String dataStr);
	
	public List<DataVO> mainSelectRecord();
	public List<CommentVO> mainReviewSelect();
	
	public List<EventVO> eventList();
	public EventVO eventView(int no);
	public void eventhi(int no);
	public List<EventVO> getEventsSortedBy(String sortType);
}
