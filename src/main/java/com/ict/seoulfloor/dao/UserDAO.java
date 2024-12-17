package com.ict.seoulfloor.dao;

import java.util.List;

import com.ict.seoulfloor.vo.DataVO;
import com.ict.seoulfloor.vo.MemberVO;
import com.ict.seoulfloor.vo.StampVO;

public interface UserDAO {
	//�α���
	public MemberVO loginOk(MemberVO vo);
				
	//���̵� �ߺ��˻�
	public int idDoubleCheck(String userid);
	
	//ȸ�����
	public int memberInsert(MemberVO vo);
	
	//ȸ������
	public MemberVO memberSelect(String userid);
	
	//ȸ������
	public int memberEdit(MemberVO vo);
	
	public int updateUserProfile(MemberVO vo);
	//�����ʻ�������
	// public void updateUserProfile(String userid, String filePath);
	
	//�����ʻ������
	public MemberVO saveProfileImage(String userid); 
	
	// ���ƿ��� ����Ʈ ���
	public List<DataVO> likeList(String userid);
	
	//������� 
	public int saveStamp(StampVO stampVO);
	
	public int updateStamp(StampVO stampVO);
	
	//����������� ��������
	public String getStampByUser(String userid);	
	
	//�н�����ޱ�
	public String findpassword(String userid, String email, String tel);
}
