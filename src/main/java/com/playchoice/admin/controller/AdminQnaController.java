package com.playchoice.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.playchoice.admin.service.AdminPlayService;
import com.playchoice.member.dto.MemberDTO;
import com.playchoice.play.dto.PlayDTO;
import com.playchoice.qna.dto.QnaDTO;

@Controller
@RequestMapping("admin/qna")
public class AdminQnaController {

	@Autowired
	private AdminPlayService service;
	
	//Q & A 리스트
	@RequestMapping("qnalist")
	public String qnaList(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		
//		model.addAttribute("qnaList",service.getQna(1));
//		model.addAttribute("myPlayList", service.myPlay(1));
		
		MemberDTO res = (MemberDTO)session.getAttribute("login");
			if(res != null) { //세션 체크
		
				model.addAttribute("qnaList",service.getQna(res.getM_code()));
				model.addAttribute("myPlayList", service.myPlay(res.getM_code()));
			
			}else {
				
				model.addAttribute("msg","로그인해야합니다.");
				model.addAttribute("url", "../../");
			}
	
		return "admin/qna/qnalist";
	}
	//연극 별 Q & A 리스트
	@RequestMapping("qnalist_asplay")
	public String qnaListAsPlay(HttpServletRequest request,PlayDTO dto, Model model) {
		
		HttpSession session = request.getSession();
		
		MemberDTO res = (MemberDTO)session.getAttribute("login");
		if(res != null) { //세션 체크
			model.addAttribute("myPlayList", service.myPlay(res.getM_code()));
			if(dto.getP_id() == 0) {
				model.addAttribute("qnaList",service.getQna(res.getM_code()));
			}else {
				model.addAttribute("qnaList",service.getQnaAsPlay(dto.getP_id()));
			}
		}else {
			
			model.addAttribute("msg","로그인해야합니다.");
			model.addAttribute("url", "../../");
		}
		
		
		
//		if(dto.getP_id() == 0) {
//			model.addAttribute("qnaList",service.getQna(1));
//		}else {
//			model.addAttribute("qnaList",service.getQnaAsPlay(dto.getP_id()));
//		}
//		
//		model.addAttribute("myPlayList", service.myPlay(1));
		
		return "admin/qna/qnalist";
	}
	
	
	@RequestMapping("qnadetail")
	public String qnaDetail(HttpServletRequest request, QnaDTO dto, Model model) {
		
		model.addAttribute("list", service.getDetail(dto));
		
		
		return "admin/qna/qnadetail";
	}
	
	@RequestMapping("write")
	public String replyWri(QnaDTO dto, Model model) {
		//내용 빈칸 체크 , 디자인 , 뉴/답변완료 체크 , 연극별로 보여주기, detail페이지에 m_code 고정되어있음
		service.replyWri(dto);
		
		return "redirect:/admin/qna/qnalist";
	}
	
	@RequestMapping("modify")
	public String replyModi(QnaDTO dto, Model model) {
		
		service.replyModi(dto);
		
		return "redirect:/admin/qna/qnalist";
	}
	
}
