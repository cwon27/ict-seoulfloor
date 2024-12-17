package com.ict.seoulfloor.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ict.seoulfloor.dao.UserDAO;
import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.MemberVO;
import com.ict.seoulfloor.vo.StampVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO dao;

	@Override
	public MemberVO loginOk(MemberVO vo) {

		return dao.loginOk(vo);
	}

	@Override
	public int idDoubleCheck(String userid) {
	
		return dao.idDoubleCheck(userid);
	}

	@Override
	public int memberInsert(MemberVO vo) {
	
		return dao.memberInsert(vo);
	}

	@Override
	public MemberVO memberSelect(String userid) {

		return dao.memberSelect(userid);
	}

	@Override
	public int memberEdit(MemberVO vo) {
		
		return dao.memberEdit(vo);
	}


	@Override
	public MemberVO saveProfileImage(MultipartFile file, String userid) {
		String fileName = file.getOriginalFilename();
		String filePath = "/upload/"+fileName;
		try {
			file.transferTo(new File(filePath));
			
			// return dao.updateUserProfile(userid, filePath);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;

	}

	@Override
	public int updateUserProfile(MemberVO vo) {
		return dao.updateUserProfile(vo);
	}

	@Override
	public List<DataVO> likeList(String userid) {
		return dao.likeList(userid);
	}

	@Override
	public int saveStamp(StampVO stampVO) {

		return dao.saveStamp(stampVO); 
	}

	@Override
	public String getStampByUser(String userid) {
		
		return dao.getStampByUser(userid);
	}
	
	@Override
	public int updateStamp(StampVO stampVO) {

		return dao.updateStamp(stampVO); 
	}

	@Override
	public String findpassword(String userid, String email, String tel) {
	
		return dao.findpassword(userid, email, tel);
	}
	
	




	

	


}
