# queries-tpch-dbgen-mysql
TPC-H Benchmark, specific for MYSQL  

Implementation TPC-H schema into MySQL DBMS: TUTORIAL

[Download the DBGEN and reference data](http://www.tpc.org/tpch/spec/tpch_2_16_0.zip)  
Unzip the downloaded file
Navigate through the command line to DBGEN folder  
```
$ cd Downloads/TPC-H_Tools_v3.0.0/dbgen/
```  

Make a copy of the dummy makefile  
```
$ cp makefile.suite makefile
```  

In dbgen folder find the created makefile and insert values of `CC`, `DATABASE`, `MACHINE` and `WORKLOAD` to this file.  
```
################
## CHANGE NAME OF ANSI COMPILER HERE
################
CC      = gcc
# Current values for DATABASE are: INFORMIX, DB2, TDAT (Teradata)
#                                  SQLSERVER, SYBASE, ORACLE, VECTORWISE
# Current values for MACHINE are:  ATT, DOS, HP, IBM, ICL, MVS, 
#                                  SGI, SUN, U2200, VMS, LINUX, WIN32 
# Current values for WORKLOAD are:  TPCH
DATABASE= MYSQL
MACHINE = LINUX
WORKLOAD = TPCH
#
...
```  

In dbgen folder find the *tpcd.h* file and add the following code to this file in the appropriate place.  
```
...
#ifdef  MYSQL
#define GEN_QUERY_PLAN  "set showplan on\nset noexec on\ngo\n"
#define START_TRAN      "BEGIN WORK;"
#define END_TRAN        "COMMIT WORK;"
#define SET_OUTPUT      ""
#define SET_ROWCOUNT    "limit %d;\n\n"
#define SET_DBASE       "use %s;\n"
#endif
...
```  

Run make command.  
```
$ make
```  

Generate the files for population. (The last numeric parametr determines the volume of data with which will be your database then populated - I decided that 0.1 (=100MB) is fine for my purposes, since I am not interested in the database benchmark tests.  
```
$ ./dbgen -s 0.1
```  

Connect to SQL server with permission to reach local files, create database and connect to schema.  
```
$ mysql -u root -p --local-infile
$ mysql> CREATE DATABASE tpch;
$ mysql> USE tpch;
```  

Run following queries in SQL console uploaded in this repository.  
```
create table nation  ( n_nationkey  integer not null,
                            n_name       char(25) not null,
                            n_regionkey  integer not null,
                            n_comment    varchar(152));

create table region  ( r_regionkey  integer not null,
                            r_name       char(25) not null,
                            r_comment    varchar(152));

create table part  ( p_partkey     integer not null,
                          p_name        varchar(55) not null,
                          p_mfgr        char(25) not null,
                          p_brand       char(10) not null,
                          p_type        varchar(25) not null,
                          p_size        integer not null,
                          p_container   char(10) not null,
                          p_retailprice decimal(15,2) not null,
                          p_comment     varchar(23) not null );

create table supplier ( s_suppkey     integer not null,
                             s_name        char(25) not null,
                             s_address     varchar(40) not null,
                             s_nationkey   integer not null,
                             s_phone       char(15) not null,
                             s_acctbal     decimal(15,2) not null,
                             s_comment     varchar(101) not null);

create table partsupp ( ps_partkey     integer not null,
                             ps_suppkey     integer not null,
                             ps_availqty    integer not null,
                             ps_supplycost  decimal(15,2)  not null,
                             ps_comment     varchar(199) not null );

create table customer ( c_custkey     integer not null,
                             c_name        varchar(25) not null,
                             c_address     varchar(40) not null,
                             c_nationkey   integer not null,
                             c_phone       char(15) not null,
                             c_acctbal     decimal(15,2)   not null,
                             c_mktsegment  char(10) not null,
                             c_comment     varchar(117) not null);

create table orders  ( o_orderkey       integer not null,
                           o_custkey        integer not null,
                           o_orderstatus    char(1) not null,
                           o_totalprice     decimal(15,2) not null,
                           o_orderdate      date not null,
                           o_orderpriority  char(15) not null,  
                           o_clerk          char(15) not null, 
                           o_shippriority   integer not null,
                           o_comment        varchar(79) not null);

create table lineitem ( l_orderkey    integer not null,
                             l_partkey     integer not null,
                             l_suppkey     integer not null,
                             l_linenumber  integer not null,
                             l_quantity    decimal(15,2) not null,
                             l_extendedprice  decimal(15,2) not null,
                             l_discount    decimal(15,2) not null,
                             l_tax         decimal(15,2) not null,
                             l_returnflag  char(1) not null,
                             l_linestatus  char(1) not null,
                             l_shipdate    date not null,
                             l_commitdate  date not null,
                             l_receiptdate date not null,
                             l_shipinstruct char(25) not null,
                             l_shipmode     char(10) not null,
                             l_comment      varchar(44) not null);
```  

Populate tables with generated dummy data.  
```
load data local infile 'region.tbl' into table region fields terminated by '|';
load data local infile 'nation.tbl' into table nation fields terminated by '|';
load data local infile 'supplier.tbl' into table supplier fields terminated by '|';
load data local infile 'customer.tbl' into table customer fields terminated by '|';
load data local infile 'part.tbl' into table part fields terminated by '|';
load data local infile 'partsupp.tbl' into table partsupp fields terminated by '|';
load data local infile 'orders.tbl' into table orders fields terminated by '|';
load data local infile 'lineitem.tbl' into table lineitem fields terminated by '|';
```  

Alter the schema dependencies (The original statement can be found in dss.ri. This is my modified version in order to work with MySQL.)

```
alter table region   add primary key (r_regionkey);
alter table nation   add primary key (n_nationkey);
alter table supplier add primary key (s_suppkey);
alter table customer add primary key (c_custkey);
alter table part     add primary key (p_partkey);
alter table partsupp add primary key (ps_partkey,ps_suppkey);
alter table orders   add primary key (o_orderkey);
alter table lineitem add primary key (l_orderkey,l_linenumber);
alter table nation   add foreign key nation_fk1   (n_regionkey)         references region   (r_regionkey);
alter table supplier add foreign key supplier_fk1 (s_nationkey)         references nation   (n_nationkey);
alter table customer add foreign key customer_fk1 (c_nationkey)         references nation   (n_nationkey);
alter table partsupp add foreign key partsupp_fk1 (ps_suppkey)          references supplier (s_suppkey);
alter table partsupp add foreign key partsupp_fk2 (ps_partkey)          references part     (p_partkey);
alter table orders   add foreign key orders_fk1   (o_custkey)           references customer (c_custkey);
alter table lineitem add foreign key lineitem_fk1 (l_orderkey)          references orders   (o_orderkey);
alter table lineitem add foreign key lineitem_fk2 (l_partkey,l_suppkey) references partsupp (ps_partkey, ps_suppkey);
``` 

Now you can run your test the queries uploaded in this repository.
Hope that's useful!
