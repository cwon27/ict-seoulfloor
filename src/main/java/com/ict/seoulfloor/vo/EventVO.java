package com.ict.seoulfloor.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EventVO {
	private int no;
	private String subject;
	private String content;
	private String writedate;
	private int hit;
	private String event_date;
}
