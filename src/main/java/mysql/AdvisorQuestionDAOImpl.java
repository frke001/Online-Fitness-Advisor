package mysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dao.AdvisorQuestionDAO;
import dto.AdvisorQuestionDTO;
import util.DBUtil;

public class AdvisorQuestionDAOImpl implements AdvisorQuestionDAO{

	private static final String SQL_SELECT_ALL = "SELECT\r\n"
			+ "    a.id AS advisor_question_id,\r\n"
			+ "    a.question,\r\n"
			+ "    a.is_read,\r\n"
			+ "    a.creation_date,\r\n"
			+ "    c.id AS client_id,\r\n"
			+ "    c.username AS client_username,\r\n"
			+ "    c.mail AS client_mail,\r\n"
			+ "    c.phofile_image_id AS client_image_id,\r\n"
			+ "    f.id AS fitness_program_id,\r\n"
			+ "    f.name AS fitness_program_name\r\n"
			+ "FROM\r\n"
			+ "    advisor_question a\r\n"
			+ "    INNER JOIN client c ON a.client_sender_id = c.id\r\n"
			+ "    INNER JOIN fintess_program f ON a.fitness_program_id = f.id"
			+ " ORDER BY\r\n"
	        + " a.creation_date DESC";
	private static final String SQL_SELECT_BY_CONTENT = "SELECT\r\n"
			+ "    a.id AS advisor_question_id,\r\n"
			+ "    a.question,\r\n"
			+ "    a.is_read,\r\n"
			+ "    a.creation_date,\r\n"
			+ "    c.id AS client_id,\r\n"
			+ "    c.username AS client_username,\r\n"
			+ "    c.mail AS client_mail,\r\n"
			+ "    c.phofile_image_id AS client_image_id,\r\n"
			+ "    f.id AS fitness_program_id,\r\n"
			+ "    f.name AS fitness_program_name\r\n"
			+ "FROM\r\n"
			+ "    advisor_question a\r\n"
			+ "    INNER JOIN client c ON a.client_sender_id = c.id\r\n"
			+ "    INNER JOIN fintess_program f ON a.fitness_program_id = f.id\r\n"
			+ "WHERE\r\n"
			+ "   a.question like ?"
			+ " ORDER BY\r\n"
	        + " a.creation_date DESC";
	private static final String SQL_UPDATE_QUESTION = "UPDATE advisor_question SET is_read=true WHERE id=?";
	@Override
	public List<AdvisorQuestionDTO> getAll() {
		List<AdvisorQuestionDTO> question = new ArrayList<AdvisorQuestionDTO>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Object values[] = {};
		try {
			connection = DBUtil.getConnection();
			preparedStatement = DBUtil.prepareStatement(connection, SQL_SELECT_ALL, false, values);
			resultSet = preparedStatement.executeQuery();
			while(resultSet.next()) {
				question.add(new AdvisorQuestionDTO(resultSet.getLong("advisor_question_id"), resultSet.getString("question"),
						resultSet.getLong("client_id"), resultSet.getString("client_username"), resultSet.getLong("client_image_id"),
						resultSet.getLong("fitness_program_id"), resultSet.getString("fitness_program_name"),
						resultSet.getDate("creation_date"), resultSet.getBoolean("is_read"),resultSet.getString("client_mail")));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet,preparedStatement,connection);
		}
		return question;
	}
	@Override
	public List<AdvisorQuestionDTO> getAllByContent(String content) {
		List<AdvisorQuestionDTO> question = new ArrayList<AdvisorQuestionDTO>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Object values[] = {"%" + content + "%"};
		try {
			connection = DBUtil.getConnection();
			preparedStatement = DBUtil.prepareStatement(connection, SQL_SELECT_BY_CONTENT, false, values);
			resultSet = preparedStatement.executeQuery();
			while(resultSet.next()) {
				question.add(new AdvisorQuestionDTO(resultSet.getLong("advisor_question_id"), resultSet.getString("question"),
						resultSet.getLong("client_id"), resultSet.getString("client_username"), resultSet.getLong("client_image_id"),
						resultSet.getLong("fitness_program_id"), resultSet.getString("fitness_program_name"),
						resultSet.getDate("creation_date"), resultSet.getBoolean("is_read"),resultSet.getString("client_mail")));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet,preparedStatement,connection);
		}
		return question;
	}
	@Override
	public boolean readMessage(Long id) {
		boolean result = false;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Object[] values = {id};
		try {
			connection = DBUtil.getConnection();
			preparedStatement = DBUtil.prepareStatement(connection, SQL_UPDATE_QUESTION, true, values);
			int count = preparedStatement.executeUpdate();
			if(count > 0) {
				result = true;
			}
		}catch (Exception e) {
			//e.printStackTrace();
			return result;
		}finally {
			DBUtil.close(resultSet,preparedStatement,connection);
		}
		return result;
	}
	
	

}
