package com.playchoice.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.playchoice.member.dto.MemberDTO;
import com.playchoice.member.dto.ShoppingBasketDTO;
import com.playchoice.member.service.ShoppingBasketService;
import com.playchoice.play.dto.PlayDTO;

@Controller
@RequestMapping(value = "/basket")
public class ShoppingBasketController {

	@Autowired
	ShoppingBasketService basketService;
	
	// 장바구니 추가
	@RequestMapping(value = "/insert")
	public String insert(@ModelAttribute ShoppingBasketDTO dto, HttpSession session) throws Exception {
		int m_code = ((MemberDTO) session.getAttribute("login")).getM_code();
		dto.setM_code(m_code);
		// 장바구니에 기존 상품이 있는지 체크
		int cnt = basketService.countBasket(dto.getP_id(), m_code);
		if(cnt == 0) { // 없으면 장바구니에 추가
			basketService.insertBasket(dto);
		}
		return "redirect:/basket/list";
	}
	
	// 장바구니 목록
	@RequestMapping(value = "/list")
	public String list(HttpSession session, Model model) throws Exception {
		int m_code = ((MemberDTO) session.getAttribute("login")).getM_code(); // session에 저장된 m_code
		
		/*int p_id = */
		//Map<String, Object> map = new HashMap<String, Object>();
		List<PlayDTO> list = basketService.ShoppingBasketList(m_code); // 장바구니 정보
		
		model.addAttribute("list", list);
		return "basket/basketList";
	}
	
	// 장바구니 삭제
	@RequestMapping(value = "/delete")
	public String delete(@RequestParam("p_id") int p_id) throws Exception {
		basketService.deleteBasket(p_id);
		return "redirect:/basket/list"; // 장바구니 목록으로 리다이렉트
	}
	
}
