package com.ict.seoulfloor.dao;

import java.util.List;
import java.util.Map;
import com.ict.seoulfloor.vo.DataVO;

public interface RecommendDAO {
	public List<DataVO> listshow(Map<String, String> params);
}
