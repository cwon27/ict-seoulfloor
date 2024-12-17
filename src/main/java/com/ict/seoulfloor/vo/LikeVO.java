package com.ict.seoulfloor.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor	
public class LikeVO {
	private int no;
	private int Data_no;
	private String userid;
	private String writedate;
}
