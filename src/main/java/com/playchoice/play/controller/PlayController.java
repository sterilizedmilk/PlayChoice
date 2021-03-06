package com.playchoice.play.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playchoice.admin.dto.AreaDTO;
import com.playchoice.admin.dto.GenreDTO;
import com.playchoice.common.PageDTO;
import com.playchoice.common.Pagination;
import com.playchoice.play.dto.PlayDTO;
import com.playchoice.play.dto.PlayMenuDTO;
import com.playchoice.play.service.PlayServiceImpl;
import com.playchoice.schedule.dto.ScheduleDTO;
import com.playchoice.schedule.dto.ScheduleJsonDTO;
import com.playchoice.schedule.service.ScheduleService;

/**
 * 연극 목록, 검색, 정보 열람, 예매
 */
@Controller
@RequestMapping("/play")
public class PlayController {
	
	private PlayDTO playDto;
	private List<ScheduleDTO> scheduleDto;

	@Autowired
	private PlayServiceImpl service;
	
	@Autowired
	private ScheduleService scheduleService;

	private static final Logger logger = LoggerFactory.getLogger(PlayController.class);

	// 전체 일정
	// 메뉴에서 장르나 지역의 경우, 0이면 전체 보기
	@ModelAttribute("area")
	public List<AreaDTO> getAreaList() {
		// 메뉴 상단에 있는 지역 관련
		return service.getAreaList();
	}

	@ModelAttribute("genre")
	public List<GenreDTO> getGenreList() {
		// 메뉴 상단에 있는 장르 관련
		return service.getGenreList();
	}

	// 전체 일정
	@SuppressWarnings("null")
	@RequestMapping("mainlist")
	public String playListController(HttpServletRequest request, Model model, PlayMenuDTO menudto) throws Exception {

		List<PlayDTO> dto = null;
		HttpSession session;
		SimpleDateFormat sdf;

		switch (menudto.getS_tab()) {
		case "mainlist":
			menudto.setS_tab("mainlist");
			dto = service.playList(menudto);
			// model.addAttribute("list", dto);
			model.addAttribute("title", "전체리스트");

			System.out.println("전체리스트 " + dto);
			break;
		case "todaylist":
			menudto.setS_tab("todaylist");
			session = request.getSession();
			sdf = new SimpleDateFormat("yyyy-MM-dd");

			if (session.getAttribute("date") instanceof Date) {
				Date date = (Date) session.getAttribute("date");

				menudto.setS_time(sdf.format(date));
				dto = service.playTodayList(menudto);
				System.out.println("todaylist--------" + dto);
				// model.addAttribute("list", dto);
				model.addAttribute("title", "오늘 리스트(" + sdf.format(date) + ")");
			}
			break;
		case "tomorrowlist":
			menudto.setS_tab("tomorrowlist");
			session = request.getSession();
			sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();

			if (session.getAttribute("date") instanceof Date) {

				Date date = (Date) session.getAttribute("date");

				cal.setTime(date);
				cal.add(Calendar.DATE, 1);

				menudto.setS_time(sdf.format(cal.getTime()));
				dto = service.playTodayList(menudto);
				System.out.println("todaylist--------" + dto);
				// model.addAttribute("list", dto);
				model.addAttribute("title", "내일 리스트(" + sdf.format(cal.getTime()) + ")");
			}
			break;
		}
		model.addAttribute("menudto", menudto);
		model.addAttribute("list", dto);
		return "play/playlist";
	}

	// 오늘일정
	@RequestMapping("todaylist")
	public String playTodaylist(HttpServletRequest request, Model model,
			@RequestParam(value = "a_id", required = false, defaultValue = "0") int a_id,
			@RequestParam(value = "g_id", required = false, defaultValue = "0") int g_id) throws Exception {
		PlayMenuDTO menudto = new PlayMenuDTO();
		menudto.setS_tab("todaylist");

		model.addAttribute("playMenu", menudto);

		HttpSession session = request.getSession();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (session.getAttribute("date") instanceof Date) {
			Date date = (Date) session.getAttribute("date");

			String res = sdf.format(date);

			List<PlayDTO> dto = service.playTodayList(res);
			model.addAttribute("list", dto);

		}
		model.addAttribute("title", "오늘 리스트");
		return "play/playlist";
	}

	// 내일일정
	@RequestMapping("tomorrowlist")
	public String playTomorrowlist(HttpServletRequest request, Model model,
			@RequestParam(value = "a_id", required = false, defaultValue = "0") int a_id,
			@RequestParam(value = "g_id", required = false, defaultValue = "0") int g_id) throws Exception {

		PlayMenuDTO menudto = new PlayMenuDTO();
		menudto.setS_tab("tomorrowlist");

		model.addAttribute("playMenu", menudto);

		HttpSession session = request.getSession();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();

		if (session.getAttribute("date") instanceof Date) {

			Date date = (Date) session.getAttribute("date");

			cal.setTime(date);
			cal.add(Calendar.DATE, 1);

			String res = sdf.format(cal.getTime());
			List<PlayDTO> dto = service.playTodayList(res);
			model.addAttribute("list", dto);
		}
		model.addAttribute("title", "내일 리스트");
		return "play/playlist";
	}

	// 연극 detail
	@RequestMapping(value = "playdetail", method = RequestMethod.GET)
	public String playDetail(@RequestParam("p_id") int p_id, PageDTO pdto, Model model) throws Exception {
		// play
		model.addAttribute("playDTO", service.playDetail(p_id));

		// schedule
		scheduleDto = service.getSchedule(p_id);
		model.addAttribute("schedule", scheduleDto);

		// review
		model.addAttribute("reviewList", service.getReviewList(p_id, pdto));
		
		Pagination pagination = new Pagination(pdto);

		Object reviewScore = service.getReviewScore(p_id);
		if(reviewScore instanceof HashMap) {
			if(((HashMap) reviewScore).get("cnt") instanceof Long) {
				long tmp =  (long)((HashMap) reviewScore).get("cnt");
				int cnt = (int) tmp;
				pagination.setTotalCnt(cnt);
				model.addAttribute("paging", pagination);
			}			
		}
		
		model.addAttribute("reviewScore", reviewScore);
		
		// Q & A
		
		model.addAttribute("qnalist", service.getQnAList(p_id, pdto));
		int qnacnt = service.QnaCnt(p_id);
		Pagination pagination2 = new Pagination(pdto);
		pagination2.setTotalCnt(qnacnt);
		
		System.out.println(service.getQnAList(p_id, pdto).get("alist"));
		model.addAttribute("qnacnt", qnacnt);
		model.addAttribute("paging2", pagination2);
		return "play/playdetail";

	}
	
	//리뷰 아작스
	@RequestMapping("reviewPage")
	@ResponseBody
	public List reviewPage(int p_id, PageDTO pdto) {

		List reviewList = service.getReviewList(p_id, pdto);
		
		return reviewList;
		
	}
	
	//QnA 아작스
	@RequestMapping("qnaPage")
	@ResponseBody
	public Map qnaPage(int p_id, PageDTO pdto) {

		Map qnaMap = service.getQnAList(p_id, pdto);
		
		return qnaMap;
		
	}

	// 장바구니
	@RequestMapping("bastket")
	public void addBastket(@RequestParam HashMap<String, Object> param) {
		// TODO 쿠키적용
		System.out.println(param);
	}

	// 결제
	@RequestMapping("payment")
	public void directPay(@RequestParam HashMap<String, Object> param) {
		// TODO 로그인여부 확인(인터셉터)
		System.out.println(param);
	}
	
	// 달력 일정 리턴
	@RequestMapping(value = "playcal", method = RequestMethod.POST)
	@ResponseBody
	public Object getBookInfo(int p_id, int year, int month) {
		List<ScheduleDTO> scheduleList = scheduleService.getScheduleListByMonth(p_id, year, month);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.sssZ");

		List<ScheduleJsonDTO> result = new ArrayList<>();
		for (ScheduleDTO sch : scheduleList) {
			ScheduleJsonDTO a = new ScheduleJsonDTO();
			a.setStart(sdf.format(sch.getS_time()));
			a.setTitle(sch.getS_price() + "원");
			result.add(a);
		}

		return result;
	}
}