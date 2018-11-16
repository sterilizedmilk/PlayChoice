package com.playchoice.play.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.playchoice.play.dao.PlayDAO;
import com.playchoice.play.dto.PlayDTO;

@Service
public class PlayServiceImpl implements PlayService{

	@Autowired
	private PlayDAO playDao;
	
	@Override
	public List<PlayDTO> playList() throws Exception {
		System.out.println("servicelist start");
		return playDao.playList();
	}

	@Override
	public PlayDTO playDetail(int p_id) throws Exception {
		System.out.println("servicedetail start");
		return playDao.playDetail(p_id);
	}

}