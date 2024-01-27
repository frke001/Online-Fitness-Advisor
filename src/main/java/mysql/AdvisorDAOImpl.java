package mysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.AdvisorDAO;
import dto.AdvisorDTO;
import util.DBUtil;

public class AdvisorDAOImpl implements AdvisorDAO {

	private static final String SQL_SELECT_FOR_LOGIN = "SELECT * FROM advisor WHERE username=? AND deleted=?";
	@Override
	public AdvisorDTO login(String username) {
		AdvisorDTO adminDTO = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Object values[] = {username, false};
		try {
			connection = DBUtil.getConnection();
			preparedStatement = DBUtil.prepareStatement(connection, SQL_SELECT_FOR_LOGIN, false, values);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				adminDTO = new AdvisorDTO(resultSet.getLong("id"),
						resultSet.getString("name"),
						resultSet.getString("surname")
						, resultSet.getString("username"),
						resultSet.getString("password"),
						resultSet.getString("mail"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			DBUtil.close(resultSet,preparedStatement,connection);
		}
		return adminDTO;
	}
	
}
