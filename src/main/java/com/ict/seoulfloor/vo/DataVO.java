package com.ict.seoulfloor.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DataVO {
	private int no;
	private String type;
	private int type_no;
	private String title;
	private String start_date;
	private String end_date;
	private String all_date;
	private String loc;
	private String loc_detail;
	private String lat;
	private String lng;
	private String admission;
	private String page_url;
	private String img_url;
	private String host;
	private int hit;
}
