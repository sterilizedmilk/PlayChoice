package com.playchoice.play.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.playchoice.admin.dto.AreaDTO;
import com.playchoice.admin.dto.GenreDTO;
import com.playchoice.common.PageDTO;
import com.playchoice.play.dto.PlayDTO;
import com.playchoice.play.dto.PlayMenuDTO;
import com.playchoice.qna.dto.QnaDTO;
import com.playchoice.schedule.dto.ScheduleDTO;

public interface PlayService {
	// 연극 목록
	public List<PlayDTO> playList() throws Exception;

	// 연극 목록 (장르와 지역 구분)
	public List<PlayDTO> playList(PlayMenuDTO menudto);

	// 연극 상세
	public PlayDTO playDetail(int p_id) throws Exception;

	public List<ScheduleDTO> viewCal(HashMap<String, Object> param);

	public List<ScheduleDTO> getSchedule(int p_id);

	public Object getReviewSmall(int p_id);

	public Object getReviewScore(int p_id);

	public Map<String, List<QnaDTO>> getQnAList(int p_id, PageDTO pdto);
	
	public int QnaCnt(int p_id);

	// 오늘연극
	public List<PlayDTO> playTodayList(String date);

	// 연극 주간 랭킹
	public Object RankList();

	// 지역 관련 리스트
	public List<AreaDTO> getAreaList();

	// 장르 관련 리스트
	public List<GenreDTO> getGenreList();

	Object SearchList(String search);

	List<PlayDTO> playTodayList(PlayMenuDTO dto);

	Object getReviewList(int p_id,PageDTO pdto);
}
