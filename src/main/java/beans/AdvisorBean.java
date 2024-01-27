package beans;

import java.io.Serializable;

import org.apache.tomcat.util.descriptor.web.LoginConfig;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import dao.AdvisorDAO;
import dto.AdvisorDTO;
import mysql.AdvisorDAOImpl;

public class AdvisorBean implements Serializable{

	private static final long serialVersionUID = 4255983544686393059L;
	private AdvisorDTO advisor = new AdvisorDTO();
	private boolean isLoggedIn = false;
	private AdvisorDAO advisorDAO = new AdvisorDAOImpl();
	
	public boolean login(String username, String password) {
		advisor =  advisorDAO.login(username);
		if (advisor == null) {
			isLoggedIn = false;
			return false;
	    }
	    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(10);
	    if (encoder.matches(password, advisor.getPassword())) {
	    	isLoggedIn = true;
	    	return true;
	    }
	    else {
	    	isLoggedIn = false;
	    	return false;
	    }
	}
	
	public AdvisorDTO getAdvisor() {
		return advisor;
	}
	public void setAdvisor(AdvisorDTO advisor) {
		this.advisor = advisor;
	}
	public boolean isLoggedIn() {
		return isLoggedIn;
	}
	public void setLoggedIn(boolean isLoggedIn) {
		this.isLoggedIn = isLoggedIn;
	}
	
	

}
