package util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	 private static ConnectionPool connectionPool;
	 static {
		 connectionPool = ConnectionPool.getConnectionPool();
	 }

	    public DBUtil(){
	        super();
	    }

	    public static PreparedStatement prepareStatement(Connection c, String sql,
	                                                     boolean retGenKeys, Object... values) throws SQLException {
	        PreparedStatement ps = c.prepareStatement(sql,
	                retGenKeys ? Statement.RETURN_GENERATED_KEYS
	                        : Statement.NO_GENERATED_KEYS);

	        for (int i = 0; i < values.length; i++)
	            ps.setObject(i + 1, values[i]); // parametri se indeksiraju od 1

	        return ps;
	    }

	    public static Connection getConnection() throws SQLException {
	        Connection connection = connectionPool.checkOut();
	        return connection;
	    }

	    public static void close(Connection connection) {
	        if (connection != null)
	            connectionPool.checkIn(connection);
	    }

	    public static void close(Statement statement) {
	        if (statement != null)
	            try {
	                statement.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	    }

	    public static void close(CallableStatement callableStatement){
	        if (callableStatement != null)
	            try {
	                callableStatement.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	    }

	    public static void close(ResultSet resultSet) {
	        if (resultSet != null)
	            try {
	                resultSet.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	    }

	    public static void close(ResultSet resultSet, Statement statement, Connection connection) {
	        close(resultSet);
	        close(statement);
	        close(connection);
	    }

	    public static void close(ResultSet resultSet, CallableStatement callableStatement, Connection connection){
	        close(resultSet);
	        close(callableStatement);
	        close(connection);
	    }

	    public static void close(Statement statement, Connection connection) {
	        close(statement);
	        close(connection);
	    }
}

