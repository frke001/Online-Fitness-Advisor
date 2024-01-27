package beans;

import java.io.Serializable;
import java.util.List;

import dao.AdvisorQuestionDAO;
import dto.AdvisorQuestionDTO;
import mysql.AdvisorQuestionDAOImpl;

public class AdvisorQuestionBean implements Serializable{

	private static final long serialVersionUID = 5147198017146850328L;
	private AdvisorQuestionDAO advisorQuestionDAO = new AdvisorQuestionDAOImpl();
	
	public List<AdvisorQuestionDTO> getAll(){
		return advisorQuestionDAO.getAll();
	}
	public List<AdvisorQuestionDTO> getAllByContent(String content){
		return advisorQuestionDAO.getAllByContent(content);
	}
	
	public boolean readMessage(Long id) {
		return advisorQuestionDAO.readMessage(id);
	}
	
	public AdvisorQuestionDTO findById(Long id) {
		List<AdvisorQuestionDTO> all = getAll();
		int index = all.indexOf(new AdvisorQuestionDTO(id));
		if(index != -1)
			return all.get(index);
		else {
			return null;
		}
	}
}
