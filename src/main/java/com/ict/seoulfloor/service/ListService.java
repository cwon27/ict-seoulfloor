package com.ict.seoulfloor.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ict.seoulfloor.vo.CommentVO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.LikeVO;

public interface ListService {
	public List<DataVO> getAllLists();
	
	// 1. tradition
	public List<DataVO> getTradList();
	public List<DataVO> searchLists(String keyword, int page, int pageSize, String sort);
	public int getTotalCount(String keyword);
	
		
	
	// 2. hip
	public List<DataVO> getHipList();
	public List<DataVO> searchHipLists(String keyword, int page, int pageSize, String sort);
	public int getTotalHipCount(String keyword);
	
	//----------------------------------------
	
	public DataVO listSelectOne(int no);
	public void hitCount(int no, String logId);
	public int reviewInsert(CommentVO vo);
	public List<CommentVO> reviewSelectList(int Data_no);
	public CommentVO reviewGradeAvg(int Data_no);
	public CommentVO reviewDbOne(int comment_no);
	public int reviewUpdate(CommentVO vo);
	public int reviewDelete(int review_no, String logId, int Data_no);
	public List<CommentVO> reviewSortList(@Param("Data_no") int Data_no, @Param("sort_opt") String sort_opt);
	public void reviewHitCount(int comment_no, int Data_no);

	//----------------------------------------
	
	 public List<String> filter(int num);
	 public List<DataVO> filterList(Map<String, String> params);
	 
	 public LikeVO getlikeState(int no, String userid);
	 public int updatelikeState(int no, String userid);
	 public int deletelikeState(int no, String userid);
	 public int getLikeCount(int no);
}
