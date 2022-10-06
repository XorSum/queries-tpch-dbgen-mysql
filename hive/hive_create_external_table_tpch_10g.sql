CREATE EXTERNAL TABLE region (
    r_regionkey bigint,
    r_name string,
    r_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "region",
    "hive.sql.dbcp.maxActive" = "1"
);

CREATE EXTERNAL TABLE nation (
    n_nationkey bigint,
    n_name string,
    n_regionkey bigint,
    n_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "nation",
    "hive.sql.dbcp.maxActive" = "1"
);

CREATE EXTERNAL TABLE part (
    p_partkey bigint,
    p_name string,
    p_mfgr string,
    p_brand string,
    p_type string,
    p_size bigint,
    p_container string,
    p_retailprice bigint,
    p_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "part",
    "hive.sql.dbcp.maxActive" = "1"
);

CREATE EXTERNAL TABLE supplier (
    s_suppkey bigint,
    s_name string,
    s_address string,
    s_nationkey bigint,
    s_phone string,
    s_acctbal bigint,
    s_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "supplier",
    "hive.sql.dbcp.maxActive" = "1"
);

CREATE EXTERNAL TABLE partsupp (
    ps_partkey bigint,
    ps_suppkey bigint,
    ps_availqty bigint,
    ps_supplycost bigint,
    ps_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "partsupp",
    "hive.sql.dbcp.maxActive" = "1"
);

CREATE EXTERNAL TABLE customer (
    c_custkey bigint,
    c_name string,
    c_address string,
    c_nationkey bigint,
    c_phone string,
    c_acctbal bigint,
    c_mktsegment string,
    c_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "customer",
    "hive.sql.dbcp.maxActive" = "1"
);

CREATE EXTERNAL TABLE orders (
    o_orderkey bigint,
    o_custkey bigint,
    o_orderstatus string,
    o_totalprice bigint,
    o_orderdate string,
    o_orderpriority string,
    o_clerk string,
    o_shippriority bigint,
    o_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "orders",
    "hive.sql.dbcp.maxActive" = "1"
);

CREATE EXTERNAL TABLE lineitem (
    l_orderkey bigint,
    l_partkey bigint,
    l_suppkey bigint,
    l_linenumber bigint,
    l_quantity bigint,
    l_extendedprice bigint,
    l_discount bigint,
    l_tax bigint,
    l_returnflag string,
    l_linestatus string,
    l_shipdate string,
    l_commitdate string,
    l_receiptdate string,
    l_shipinstruct string,
    l_shipmode string,
    l_comment string
) STORED BY 'org.apache.hive.storage.jdbc.JdbcStorageHandler' TBLPROPERTIES (
    "hive.sql.database.type" = "MYSQL",
    "hive.sql.jdbc.url" = "jdbc:mysql://10.11.6.23:2883/tpch_10g_part?serverTimezone=UTC&useSSL=false",
    "hive.sql.jdbc.driver" = "com.mysql.jdbc.Driver",
    "hive.sql.dbcp.username" = "root@eva",
    "hive.sql.dbcp.password" = "123456",
    "hive.sql.table" = "lineitem",
    "hive.sql.dbcp.maxActive" = "1"
);