package com.ict.seoulfloor.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.seoulfloor.dao.RecommendDAO;
import com.ict.seoulfloor.vo.DataVO;

@Service
public class RecommendServiceImpl implements RecommendService {
	@Autowired
	RecommendDAO dao;

	@Override
	public List<DataVO> listshow(Map<String, String> params) {
		return dao.listshow(params);
	}
}
