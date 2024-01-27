package dto;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

public class AdvisorQuestionDTO implements Serializable{

	private static final long serialVersionUID = -1313040941800095861L;
	
	private Long id;
	private String question;
	private Long clientSenderId;
	private String clientSenderUsername;
	private Long clientSenderProfileId;
	private Long fitnessProgramId;
	private String fitnessProgramName;
	private Date creationDate;
	private Boolean isRead;
	private String mail;
	public AdvisorQuestionDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AdvisorQuestionDTO(Long id, String question, Long clientSenderId, String clientSenderUsername,
			Long clientSenderProfileId, Long fitnessProgramId, String fitnessProgramName, Date creationDate, Boolean isRead,String mail) {
		super();
		this.id = id;
		this.question = question;
		this.clientSenderId = clientSenderId;
		this.clientSenderUsername = clientSenderUsername;
		this.clientSenderProfileId = clientSenderProfileId;
		this.fitnessProgramId = fitnessProgramId;
		this.fitnessProgramName = fitnessProgramName;
		this.creationDate = creationDate;
		this.isRead = isRead;
		this.mail = mail;
	}
	
	public AdvisorQuestionDTO(Long id) {
		super();
		this.id = id;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public Long getClientSenderId() {
		return clientSenderId;
	}
	public void setClientSenderId(Long clientSenderId) {
		this.clientSenderId = clientSenderId;
	}
	public String getClientSenderUsername() {
		return clientSenderUsername;
	}
	public void setClientSenderUsername(String clientSenderUsername) {
		this.clientSenderUsername = clientSenderUsername;
	}
	public Long getClientSenderProfileId() {
		return clientSenderProfileId;
	}
	public void setClientSenderProfileId(Long clientSenderProfileId) {
		this.clientSenderProfileId = clientSenderProfileId;
	}
	public Long getFitnessProgramId() {
		return fitnessProgramId;
	}
	public void setFitnessProgramId(Long fitnessProgramId) {
		this.fitnessProgramId = fitnessProgramId;
	}
	public String getFitnessProgramName() {
		return fitnessProgramName;
	}
	public void setFitnessProgramName(String fitnessProgramName) {
		this.fitnessProgramName = fitnessProgramName;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public Boolean getIsRead() {
		return isRead;
	}
	public void setIsRead(Boolean isRead) {
		this.isRead = isRead;
	}
	
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AdvisorQuestionDTO other = (AdvisorQuestionDTO) obj;
		return Objects.equals(id, other.id);
	}
	
	

}
