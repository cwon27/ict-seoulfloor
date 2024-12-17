package com.ict.seoulfloor.vo;

import java.sql.Blob;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentVO {
	private int comment_no;
	private int Data_no;
	private String userid;
	private String content;
	private String writedate;
	private int hit;
	private int grade;
	private String title;
	private String thumb;
	private String content_txt;
	private int grade_avg;
}
