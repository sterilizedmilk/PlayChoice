package com.playchoice.member.dao;

import com.playchoice.member.dto.LoginDTO;
import com.playchoice.member.dto.MemberDTO;

public interface MemberDAO {
	
	// 회원 가입
	public void insertMember(MemberDTO dto) throws Exception;
	
	// 회원 정보 조회
	public MemberDTO viewMember(String m_id) throws Exception;
	public MemberDTO viewMemberByEmail(String m_mail) throws Exception;
	
	// 회원 정보 수정
	public void updateMember(MemberDTO dto) throws Exception;
	
	// 회원 탈퇴(m_status=2)
	public void deleteMember(String m_id) throws Exception;
		
	// 로그인
	public MemberDTO loginMember(LoginDTO dto) throws Exception;
	
	// 아이디 찾기
	public Object findId(MemberDTO dto);
	
	// 비밀번호 찾기
	public int findPw(MemberDTO dto);
	
	// 회원 정보 수정 및 삭제를 위한 비밀번호 체크
	public boolean checkPw(String m_id, String m_pw) throws Exception;
	
	// 비밀번호 변경
	public int updatePw(String m_id, String new_pw) throws Exception;
	
}
