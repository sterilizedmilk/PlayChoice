package com.playchoice.review.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ReviewDTO {
	
	int m_code,s_id,r_play_score,r_actor1_score,r_actor2_score,r_deleted, p_id;
	Date r_register_time;
	String r_content, m_id;
	
	
	public String getSdfTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(this.r_register_time);
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getM_code() {
		return m_code;
	}
	public void setM_code(int m_code) {
		this.m_code = m_code;
	}
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
	public int getR_play_score() {
		return r_play_score;
	}
	public void setR_play_score(int r_play_score) {
		this.r_play_score = r_play_score;
	}
	public int getR_actor1_score() {
		return r_actor1_score;
	}
	public void setR_actor1_score(int r_actor1_score) {
		this.r_actor1_score = r_actor1_score;
	}
	public int getR_actor2_score() {
		return r_actor2_score;
	}
	public void setR_actor2_score(int r_actor2_score) {
		this.r_actor2_score = r_actor2_score;
	}
	public int getR_deleted() {
		return r_deleted;
	}
	public void setR_deleted(int r_deleted) {
		this.r_deleted = r_deleted;
	}
	public Date getR_register_time() {
		return r_register_time;
	}
	public void setR_register_time(Date r_register_time) {
		this.r_register_time = r_register_time;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	
	@Override
	public String toString() {
		return "ReviewDTO [m_code=" + m_code + ", s_id=" + s_id + ", r_play_score=" + r_play_score + ", r_actor1_score="
				+ r_actor1_score + ", r_actor2_score=" + r_actor2_score + ", r_deleted=" + r_deleted + ", p_id=" + p_id
				+ ", r_register_time=" + r_register_time + ", r_content=" + r_content + ", m_id=" + m_id + "]";
	}
	
}
