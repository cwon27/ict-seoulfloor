package com.ict.seoulfloor.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import com.ict.seoulfloor.vo.CommentVO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.LikeVO;

public interface ListDAO {
	public List<DataVO> getAllLists();
	
	// 1. tradition
	public List<DataVO> getTradList();
	public List<DataVO> searchLists(@Param("keyword") String keyword,
									 @Param("offset") int offset,
									 @Param("pageSize")int pageSize,
									 @Param("sort") String sort);
	public int getTotalCount(@Param("keyword") String keyword);
	
	// 2. hip
	public List<DataVO> getHipList();
	public List<DataVO> searchHipLists(@Param("keyword") String keyword,
									    @Param("offset") int offset,
									    @Param("pageSize")int pageSize,
									    @Param("sort") String sort);
	public int getTotalHipCount(@Param("keyword") String keyword);
	//------------------------------------------------------------
	
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
	
	//------------------------------------------------------------
	
	
	 public List<String> filter(int num);
	 public List<DataVO> filterList(Map<String, String> params);
	 
	 
	 public LikeVO getlikeState(int no, String userid);
	 public int updatelikeState(int no, String userid);
	 public int deletelikeState(int no, String userid);
	 public int getLikeCount(int no);
	
}
