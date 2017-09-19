package com.iot1.sql.db.dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.iot1.sql.common.DataSourceFactory;
import com.iot1.sql.db.dto.Column;
import com.iot1.sql.db.dto.DataBase;
import com.iot1.sql.db.dto.DbInfo;
import com.iot1.sql.db.dto.Table;

@Repository
public class DbDAOImpl extends SqlSessionDaoSupport implements DbDAO{

	@Autowired
	DataSourceFactory dsf;
	
	@Override
	public List<DbInfo> selectDbInfoList(DbInfo di) {
		
		return this.getSqlSession().selectList("db.SELECT_DB", di);
	}

	@Override
	public DbInfo selectDbInfo(DbInfo di) {
		
		return this.getSqlSession().selectOne("db.SELECT_DB", di);
	}

	@Override
	public boolean isConnecteDB(DbInfo di) throws Exception {
		
		return dsf.isConnecteDB(di);
	}

	@Override
	public List<DataBase> selectDataBaseList() throws Exception {
		DatabaseMetaData meta = dsf.getSqlSession().getConnection().getMetaData();
		ResultSet ctlgs = meta.getCatalogs();
		List<DataBase> databaseList = new ArrayList<DataBase>();
		while(ctlgs.next()){
			DataBase db = new DataBase();
			db.setDatabase(ctlgs.getString(1));
			databaseList.add(db);
		}
		return databaseList;
	}

	//TABLE_SELECT
	@Override
	public List<Table> selectTableList(DataBase di) throws Exception {
		dsf.getSqlSession().selectList("db.USE_DATABASE", di);
		return dsf.getSqlSession().selectList("db.TABLE_SELECT", di);
	}

	@Override
	public List<Column> selectTableInfo(Table table) throws Exception {
		
		return dsf.getSqlSession().selectList("db.TABLE_INFO_SELECT", table);
	}

	@Override
	public Map<String, Object> runSql(Map<String, String> pm) throws Exception {
		String sql = pm.get("sql");
 		sql = sql.trim();
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> type = new ArrayList<String>();
		Statement statement = dsf.getSqlSession().getConnection().createStatement();
		if(sql.indexOf("select")==0){
			type.add("select");
			ResultSet resultSet = statement.executeQuery(sql);
			ResultSetMetaData metadata = resultSet.getMetaData();
			int columnCount = metadata.getColumnCount();
			List<String> columns = new ArrayList<String>();
			for(int i = 1; i <= columnCount; i++){
				String columnName = metadata.getColumnName(i);
				columns.add(columnName);
			}
			List<Map<String, String>> list = new ArrayList<Map<String, String>>();
			while(resultSet.next()){
				Map<String, String> hm = new HashMap<String, String>();
				for(String column : columns){
					hm.put(column, resultSet.getString(column));
				}
				list.add(hm);
			}
			map.put("type", type);
			map.put("list", list);
			map.put("columns", columns);
		}else if(sql.indexOf("insert")==0){
			int result = statement.executeUpdate(sql);
			type.add("insert");
			map.put("type", type);
			map.put("row", result);
		}else if(sql.indexOf("update")==0){
			int result = statement.executeUpdate(sql);
			type.add("update");
			map.put("type", type);
			map.put("row", result);
		}else if(sql.indexOf("delete")==0){
			int result = statement.executeUpdate(sql);
			type.add("delete");
			map.put("type", type);
			map.put("row", result);
		}
		return map;
	}

	@Override
	public Map<String, Object> runSqlList(Map<String, List> pm) throws Exception {
		List sqls = pm.get("sqls");
		String sql = "", sqlObj = "";
		Map<String, Object> map = new HashMap<String, Object>();
		Connection con = null;
		if(con==null){
			con = dsf.getSqlSession().getConnection();
		}
		Statement statement = con.createStatement();
		List<String> type = new ArrayList<String>();
		for(int i=0,max=sqls.size(); i<max; i++){
			sqlObj = (String) sqls.get(i);
			sql = sqlObj.trim();
			try{
				if(sql.indexOf("select")==0){
					type.add("select");
					try{
						ResultSet resultSet = statement.executeQuery(sql);
						ResultSetMetaData metadata = resultSet.getMetaData();
						int columnCount = metadata.getColumnCount();
						List<String> columns = new ArrayList<String>();
						for(int j = 1; j <= columnCount; j++){
							String columnName = metadata.getColumnName(j);
							columns.add(columnName);
						}
						List<Map<String, String>> list = new ArrayList<Map<String, String>>();
						while(resultSet.next()){
							Map<String, String> hm = new HashMap<String, String>();
							for(String column : columns){
								hm.put(column, resultSet.getString(column));
							}
							list.add(hm);
						}
						map.put("type", type);
						map.put("list", list);
						map.put("columns", columns);
						con.commit();
						System.out.println(map);
					}catch(Exception e){
						e.getMessage();
						con.rollback();
					}
				}else if(sql.indexOf("insert")==0){
					type.add("insert");
					try{
						int result = statement.executeUpdate(sql);
						map.put("type", type);
						map.put("row", result);
						con.commit();
						System.out.println(map);
					}catch(Exception e){
						e.getMessage();
						con.rollback();
					}
				}else if(sql.indexOf("delete")==0){
					type.add("delete");
					try{
						int result = statement.executeUpdate(sql);
						map.put("type", type);
						map.put("row", result);
						con.commit();
						System.out.println(map);
					}catch(Exception e){
						e.getMessage();
						con.rollback();
					}
				}else if(sql.indexOf("update")==0){
					type.add("update");
					try{
						int result = statement.executeUpdate(sql);
						map.put("type", type);
						map.put("row", result);
						con.commit();
						System.out.println(map);
					}catch(Exception e){
						e.getMessage();
						con.rollback();
					}
				}
			}catch(Exception e){
				e.printStackTrace();
				con.rollback();
			}
		}
		System.out.println(map);
		return map;
	}

}
