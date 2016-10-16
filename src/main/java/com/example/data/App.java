package com.example.data;

/**
 * The goal here is to extract data from MySQL and insert it into elastic search index
 */
public class App {
    public static void main(String[] args) {
        System.out.println("Hello World!");
        JDBCHelper jdbcHelper = new JDBCHelper();
        jdbcHelper.selectAll();
    }
}

