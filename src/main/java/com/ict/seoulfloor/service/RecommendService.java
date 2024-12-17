package com.ict.seoulfloor.service;

import java.util.List;
import java.util.Map;

import com.ict.seoulfloor.vo.DataVO;

public interface RecommendService {
	public List<DataVO> listshow(Map<String, String> params);
}
