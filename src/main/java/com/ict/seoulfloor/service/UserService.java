package com.ict.seoulfloor.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.MemberVO;
import com.ict.seoulfloor.vo.StampVO;

public interface UserService {
	public MemberVO loginOk(MemberVO vo);
	
	public int idDoubleCheck(String userid);
	
	public int memberInsert(MemberVO vo);
	
	public MemberVO memberSelect(String userid);
	
	public int memberEdit(MemberVO vo);
	
	public int updateUserProfile(MemberVO vo);
	
	public MemberVO saveProfileImage(MultipartFile file, String userid);

	public List<DataVO> likeList(String userid);
	
	public int saveStamp(StampVO stampVO);
	
	public int updateStamp(StampVO stampVO);
	
	public String getStampByUser(String userid);
	
	public String findpassword(String userid, String email, String tel);
	
	

}
