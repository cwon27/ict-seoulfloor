orpackage com.ict.seoulfloor.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.seoulfloor.dao.ListDAO;
import com.ict.seoulfloor.vo.CommentVO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.LikeVO;

@Service
public class ListServiceImpl implements ListService {
	@Autowired
	ListDAO dao;
	
	@Override
	public List<DataVO> getAllLists() {
		return dao.getAllLists();
	}
	
	// 1. tradition
	
	@Override
	public List<DataVO> getTradList() {
		return dao.getTradList();
	}
	
	@Override
	   public List<DataVO> searchLists(String keyword, int page, int pageSize, String sort) {
	       int offset = (page - 1) * pageSize; 

	           if (keyword == null || keyword.trim().isEmpty()) {
	               
	               return dao.searchLists(null, offset, pageSize, sort); 
	           } else {
	               
	               return dao.searchLists(keyword, offset, pageSize, sort);
	       
	           }
	   }
	
   @Override
   public int getTotalCount(String keyword) {
       if (keyword == null || keyword.trim().isEmpty()) {
               
               return dao.getTotalCount(null); 
           } else {
               
               return dao.getTotalCount(keyword);
           }
   }
	
	
	// 2. hip
	
	@Override
	public List<DataVO> getHipList() {
		return dao.getHipList();
	}
	

	@Override
	public List<DataVO> searchHipLists(String keyword, int page, int pageSize, String sort) {
		int offset = (page - 1) * pageSize;  

        if (keyword == null || keyword.trim().isEmpty()) {
            
            return dao.searchHipLists(null, offset, pageSize, sort);
        } else {
            
            return dao.searchHipLists(keyword, offset, pageSize, sort);
    
        }
	}


	@Override
	public int getTotalHipCount(String keyword) {
		 if (keyword == null || keyword.trim().isEmpty()) {
	            
	            return dao.getTotalHipCount(null);
	        } else {
	            
	            return dao.getTotalHipCount(keyword);
	        }
	}
	
	//--------------------------------------------
	

	@Override
	public DataVO listSelectOne(int no) {
		return dao.listSelectOne(no);
	}

	@Override
	public void hitCount(int no, String logId) {
		dao.hitCount(no, logId);
	}

	@Override
	public int reviewInsert(CommentVO vo) {
		return dao.reviewInsert(vo);
	}

	@Override
	public List<CommentVO> reviewSelectList(int Data_no) {
		return dao.reviewSelectList(Data_no);
	}
	
	@Override
	public CommentVO reviewGradeAvg(int Data_no) {
		return dao.reviewGradeAvg(Data_no);
	}
	
	@Override
	public CommentVO reviewDbOne(int comment_no) {
		return dao.reviewDbOne(comment_no);
	}
	
	@Override
	public int reviewUpdate(CommentVO vo) {
		return dao.reviewUpdate(vo);
	}
	
	@Override
	public int reviewDelete(int review_no, String logId, int Data_no) {
		return dao.reviewDelete(review_no, logId, Data_no);
	}
	
	@Override
	public List<CommentVO> reviewSortList(@Param("Data_no") int Data_no, @Param("sort_opt") String sort_opt) {
		return dao.reviewSortList(Data_no, sort_opt);
	}
	
	@Override
	public void reviewHitCount(int comment_no, int Data_no) {
		dao.reviewHitCount(comment_no, Data_no);
		
	}
	
	
   @Override
   public List<String> filter(int num) {
      return dao.filter(num);
   }

   @Override
   public List<DataVO> filterList(Map<String, String> params) {
      return dao.filterList(params);
   }
   
   @Override
   public LikeVO getlikeState(int no, String userid) {
	   return dao.getlikeState(no, userid);
   }
   @Override
   public int updatelikeState(int no, String userid) {
	   return dao.updatelikeState(no, userid);
   }
   @Override
   public int deletelikeState(int no, String userid) {
	   return dao.deletelikeState(no, userid);
   }
   @Override
   public int getLikeCount(int no) {
	   return dao.getLikeCount(no);
   }




}
