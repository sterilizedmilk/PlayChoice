package com.playchoice.admin.dao;

import java.util.List;

import com.playchoice.admin.dto.AreaDTO;
import com.playchoice.admin.dto.GenreDTO;
import com.playchoice.member.dto.MemberDTO;
import com.playchoice.play.dto.SearchPlayDTO;

public interface SiteAdminDAO {

	public List<MemberDTO> memberList(SearchPlayDTO search);

	public int black(int m_id);

	public int unBlack(int m_id);

	// 연극 관리자 승인
	public int approvePlayAdmin(int m_id);

	// 연극 관리자 해고
	public int dismissPlayAdmin(int m_id);

	// 정산
	public int settleMoney();

	// genre
	public List<GenreDTO> genreList();

	public int genreInsert(String g_name);

	public int genreDelete(int g_id);

	public List<AreaDTO> areaList();

	public int areaInsert(String a_name);

	public int areaDelete(int a_id);

	// 회원 관리
	public Object memberManage();

	public Object memberUpdate(MemberDTO memberDTO);

	public Object memberDelete(MemberDTO memberDTO);

	public Object memberBlack(MemberDTO memberDTO);
}