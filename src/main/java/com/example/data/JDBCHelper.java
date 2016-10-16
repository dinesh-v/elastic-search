package com.example.data;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.*;
import java.util.logging.Logger;

/**
 * MySQL Data extractor
 */
class JDBCHelper {
    static final Logger LOGGER = Logger.getLogger(JDBCHelper.class.getSimpleName());
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/medical_insurance";

    //  Database credentials
    static final String USER = "twitter";
    static final String PASS = "strong_passw0rd";

    Connection conn = null;
    Statement stmt = null;

    void selectAll() {
        try {
            System.setProperty("java.util.logging.SimpleFormatter.format",
                    "%1$tF %1$tT %4$s %2$s %5$s%6$s%n");
            Class.forName(JDBC_DRIVER);

            LOGGER.info("Connecting to a selected database...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            LOGGER.info("Connected database successfully...");

            LOGGER.info("Creating statement...");
            stmt = conn.createStatement();

            String sql = "SELECT * FROM ipps_summary";
            ResultSet rs = stmt.executeQuery(sql);
            JSONObject jsonObject = new JSONObject();
            int count = 0;
            while (rs.next()) {
                for (int i = 1; i < rs.getMetaData().getColumnCount() + 1; i++) {
                    jsonObject.put(rs.getMetaData().getColumnName(i), rs.getObject(i));
                }

                RESTHelper restHelper = new RESTHelper();
                restHelper.doPost(jsonObject);
                LOGGER.info("Count is " + ++count);
            }
            LOGGER.info("Completed : " + count);
            rs.close();
        } catch (Exception e) {
            LOGGER.severe(e.getMessage());
        }
        LOGGER.info("Goodbye!");
    }
}

class RESTHelper {
    String doPost(JSONObject jsonObject) {
        String response = null;
        try {

            String BASE_URL = "http://127.0.0.1:9200";
            String INDEX = "medical_insurance";
            String TYPE = "ipps_summary";
            String URL = BASE_URL + "/" + INDEX + "/" + TYPE + "/" + jsonObject.getInt("id") + "?pretty";

            URL url = new URL(URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");

            String input = jsonObject.toString();

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes());
            os.flush();

            /*if (conn.getResponseCode() != HttpURLConnection.HTTP_CREATED) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }*/
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream())));

            String output;
            while ((output = br.readLine()) != null) {
                response += output;
            }
            conn.disconnect();

        } catch (MalformedURLException e) {
            JDBCHelper.LOGGER.severe(e.getMessage());
        } catch (IOException e) {
            JDBCHelper.LOGGER.severe(e.getMessage());
        }
        return response;
    }
}