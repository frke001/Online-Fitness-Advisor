package dao;

import java.util.List;

import dto.AdvisorQuestionDTO;

public interface AdvisorQuestionDAO {
	
	List<AdvisorQuestionDTO> getAll();
	List<AdvisorQuestionDTO> getAllByContent(String content);
	boolean readMessage(Long id);
}
