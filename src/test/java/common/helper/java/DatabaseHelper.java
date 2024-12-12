package common.helper.java;

import java.sql.*;
import java.util.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class DatabaseHelper {

    private static final Logger logger = LogManager.getLogger(DatabaseHelper.class);
    private final String dbType;
    private final String dbUser;
    private final String dbPassword;
    private final String dbUrl;
    private final String databaseName;
    private final String postGreSQLUrl;
    private final String postGreSQLUser;
    private final String postGreSQLPassword;
    private final String postGreSQLDatabaseName;

    public enum DatabaseType {
        MYSQL, SQLSERVER, POSTGRESQL
    }

    public DatabaseHelper() {
        PropertiesHelper.loadDataProperties("db_connection");
        this.dbUrl = PropertiesHelper.getPropValue("dbUrl");
        this.dbUser = PropertiesHelper.getPropValue("dbUser");
        this.dbPassword = PropertiesHelper.getPropValue("dbPassword");
        this.dbType = PropertiesHelper.getPropValue("dbType");
        this.databaseName = PropertiesHelper.getPropValue("databaseName");
        this.postGreSQLUrl = PropertiesHelper.getPropValue("postGreSQLUrl");
        this.postGreSQLUser = PropertiesHelper.getPropValue("postGreSQLUser");
        this.postGreSQLPassword = PropertiesHelper.getPropValue("postGreSQLPassword");
        this.postGreSQLDatabaseName = PropertiesHelper.getPropValue("postGreSQLDatabaseName");
    }

    public DatabaseHelper(String filename) {
        PropertiesHelper.loadDataProperties(filename);
        this.dbUrl = PropertiesHelper.getPropValue("dbUrl");
        this.dbUser = PropertiesHelper.getPropValue("dbUser");
        this.dbPassword = PropertiesHelper.getPropValue("dbPassword");
        this.dbType = PropertiesHelper.getPropValue("dbType");
        this.databaseName = PropertiesHelper.getPropValue("databaseName");
        this.postGreSQLUrl = PropertiesHelper.getPropValue("postGreSQLUrl");
        this.postGreSQLUser = PropertiesHelper.getPropValue("postGreSQLUser");
        this.postGreSQLPassword = PropertiesHelper.getPropValue("postGreSQLPassword");
        this.postGreSQLDatabaseName = PropertiesHelper.getPropValue("postGreSQLDatabaseName");
    }

    private Connection getConnection(DatabaseType type) throws SQLException {
        String connectionUrl = switch (type) {
            case POSTGRESQL -> String.format("jdbc:postgresql://%s/%s", postGreSQLUrl, postGreSQLDatabaseName);
            case MYSQL -> String.format("jdbc:mysql://%s/%s?user=%s&password=%s", dbUrl, databaseName, dbUser, dbPassword);
            default -> String.format("jdbc:%s://%s;databaseName=%s;user=%s;password=%s;",
                    dbType.toLowerCase(), dbUrl, databaseName, dbUser, dbPassword);
        };
        return DriverManager.getConnection(connectionUrl, dbUser, dbPassword);
    }

    public List<Map<String, String>> executeQuery(String query) {
        return executeQuery(query, DatabaseType.POSTGRESQL);
    }

    public List<Map<String, String>> executeQuery(String query, DatabaseType type) {
        List<Map<String, String>> results = new ArrayList<>();
        try (Connection conn = getConnection(type);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            logger.info("Executing query: {}", query);
            ResultSetMetaData rsmd = rs.getMetaData();
            int colCount = rsmd.getColumnCount();
            List<String> columns = new ArrayList<>();

            for (int i = 1; i <= colCount; i++) {
                columns.add(rsmd.getColumnName(i));
            }

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                for (String colName : columns) {
                    row.put(colName, rs.getString(colName));
                }
                results.add(row);
            }
        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage(), e);
        }
        return results;
    }

    public boolean executeUpdate(String query) {
        return executeUpdate(query, DatabaseType.SQLSERVER);
    }

    public boolean executeUpdate(String query, DatabaseType type) {
        boolean result = false;
        try (Connection conn = getConnection(type);
             Statement stmt = conn.createStatement()) {

            logger.info("Executing update: {}", query);
            result = stmt.executeUpdate(query) >= 1;

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage(), e);
        }
        return result;
    }

    public List<String> getColumnNames(String query) {
        List<String> columns = new ArrayList<>();
        try (Connection conn = getConnection(DatabaseType.MYSQL);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            ResultSetMetaData rsmd = rs.getMetaData();
            int colCount = rsmd.getColumnCount();
            for (int i = 1; i <= colCount; i++) {
                columns.add(rsmd.getColumnName(i));
            }
        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage(), e);
        }
        return columns;
    }

    public List<Map<String, String>> executeQueryAndGetData(String query) {
        return executeQueryAndGetData(query, 10, 30);
    }

    public List<Map<String, String>> executeQueryAndGetData(String query, int attempts, int delay) {
        for (int i = 0; i < attempts; i++) {
            List<Map<String, String>> result = executeQuery(query);
            if (!result.isEmpty()) {
                return result;
            }
            try {
                Thread.sleep(delay);
            } catch (InterruptedException e) {
                logger.warn("Interrupted while waiting: {}", e.getMessage());
                Thread.currentThread().interrupt();
            }
        }
        return Collections.emptyList();
    }

    public List<Map<String, String>> executeQueryAndGetDataWithoutLooping(String query) {
        try {
            Thread.sleep(30);
        } catch (InterruptedException e) {
            logger.warn("Interrupted while sleeping: {}", e.getMessage());
            Thread.currentThread().interrupt();
        }
        return executeQuery(query);
    }
}
