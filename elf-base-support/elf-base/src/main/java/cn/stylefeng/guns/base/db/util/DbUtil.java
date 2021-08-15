package cn.stylefeng.guns.base.db.util;

import cn.stylefeng.guns.base.db.entity.DatabaseInfo;
import cn.stylefeng.roses.core.config.properties.DruidProperties;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 数据库操作工具类
 *
 * @author fengshuonan
 * @Date 2019/1/13 18:34
 */
@Slf4j
public class DbUtil {

    /**
     * 查询某个数据库连接的所有表
     *
     * @author fengshuonan
     * @Date 2019-05-04 20:30
     */
    public static List<Map<String, Object>> selectTables(DatabaseInfo dbInfo) {
        ArrayList<Map<String, Object>> list = new ArrayList<>();
        try {
            Class.forName(dbInfo.getJdbcDriver());
            Connection conn = DriverManager.getConnection(dbInfo.getJdbcUrl(), dbInfo.getUserName(), dbInfo.getPassword());

            //获取数据库名称
            String dbName = getDbName(dbInfo);

            PreparedStatement preparedStatement = conn.prepareStatement(
                    "select TABLE_NAME as tableName,TABLE_COMMENT as tableComment from information_schema.`TABLES` where TABLE_SCHEMA = '" + dbName + "'");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                HashMap<String, Object> map = new HashMap<>();
                String tableName = resultSet.getString("tableName");
                String tableComment = resultSet.getString("tableComment");
                map.put("tableName", tableName);
                map.put("tableComment", tableComment);
                list.add(map);
            }
            return list;
        } catch (Exception ex) {
            log.error("执行sql出现问题！", ex);
            return null;
        }
    }

    /**
     * 查询某个表的所有字段
     *
     * @author fengshuonan
     * @Date 2019-05-04 20:31
     */
    public static List<Map<String, Object>> getTableFields(DatabaseInfo dbInfo, String tableName) {
        ArrayList<Map<String, Object>> list = new ArrayList<>();
        try {
            Class.forName(dbInfo.getJdbcDriver());
            Connection conn = DriverManager.getConnection(dbInfo.getJdbcUrl(), dbInfo.getUserName(), dbInfo.getPassword());

            //获取数据库名称
            String dbName = getDbName(dbInfo);

            PreparedStatement preparedStatement = conn.prepareStatement(
                    "select COLUMN_NAME as columnName,COLUMN_COMMENT as columnComment from information_schema.COLUMNS where table_name = '" + tableName + "' and table_schema = '" + dbName + "'");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                HashMap<String, Object> map = new HashMap<>();
                String columnName = resultSet.getString("columnName");
                String columnComment = resultSet.getString("columnComment");
                map.put("columnName", columnName);
                map.put("columnComment", columnComment);
                list.add(map);
            }
            return list;
        } catch (Exception ex) {
            log.error("执行sql出现问题！", ex);
            return null;
        }
    }

    /**
     * 创建数据库
     *
     * @author fengshuonan
     * @Date 2019-06-18 15:29
     */
    public static void createDatabase(DruidProperties druidProperties, String databaseName) {
        try {
            Class.forName(druidProperties.getDriverClassName());
            Connection conn = DriverManager.getConnection(druidProperties.getUrl(), druidProperties.getUsername(), druidProperties.getPassword());

            //创建sql
            String sql = "CREATE DATABASE IF NOT EXISTS " + databaseName + " DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
            PreparedStatement preparedStatement = conn.prepareStatement(sql);

            int i = preparedStatement.executeUpdate();
            log.info("创建数据库！数量：" + i);

        } catch (Exception ex) {
            log.error("执行sql出现问题！", ex);
        }
    }

    /**
     * 获取数据库名称
     *
     * @author fengshuonan
     * @Date 2019-06-18 15:25
     */
    private static String getDbName(DatabaseInfo dbInfo) {
        String jdbcUrl = dbInfo.getJdbcUrl();
        int first = jdbcUrl.lastIndexOf("/") + 1;
        int last = jdbcUrl.indexOf("?");
        return jdbcUrl.substring(first, last);
    }
}
