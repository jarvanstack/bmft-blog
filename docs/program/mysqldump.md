## mysqldump

golang 中实现的零依赖、高性能、并发 mysqldump 工具。

项目地址: https://github.com/dengjiawen8955/mysqldump

文章地址: https://bmft.tech/#/2-program/0325-mysqldump


## Features

* 自定义 Writer: 如本地文件、多文件储存、远程服务器、云存储等。（默认控制台输出）。
* 支持所有 MYSQL 数据类型.
* 支持 INSERT Merge, 大幅提升数据恢复性能

## QuickStart

### Create Table and Insert Test Data

```sql
DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `char_col` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `varchar_col` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `binary_col` binary(10) DEFAULT NULL,
  `varbinary_col` varbinary(255) DEFAULT NULL,
  `tinyblob_col` tinyblob,
  `tinytext_col` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `text_col` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `blob_col` blob,
  `mediumtext_col` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `mediumblob_col` mediumblob,
  `longtext_col` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `longblob_col` longblob,
  `enum_col` enum('value1','value2','value3') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `set_col` set('value1','value2','value3') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bit_col` bit(8) DEFAULT NULL,
  `tinyint_col` tinyint NOT NULL DEFAULT '0',
  `bool_col` tinyint(1) NOT NULL DEFAULT '0',
  `boolean_col` tinyint(1) NOT NULL DEFAULT '0',
  `smallint_col` smallint NOT NULL DEFAULT '0',
  `mediumint_col` mediumint NOT NULL DEFAULT '0',
  `int_col` int NOT NULL DEFAULT '0',
  `integer_col` int NOT NULL DEFAULT '0',
  `bigint_col` bigint NOT NULL DEFAULT '0',
  `float_col` float(8,2) NOT NULL DEFAULT '0.00',
  `double_col` double(8,2) NOT NULL DEFAULT '0.00',
  `decimal_col` decimal(10,2) NOT NULL DEFAULT '0.00',
  `dec_col` decimal(10,2) NOT NULL DEFAULT '0.00',
  `date_col` date DEFAULT NULL,
  `datetime_col` datetime DEFAULT NULL,
  `timestamp_col` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time_col` time DEFAULT NULL,
  `year_col` year DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `test` VALUES (1,'abc','def',0x61626300000000000000,0x646566,0x74696E79626C6F62,'Hello','World',0x776F726C64,'Medium Text',0x4D656469756D426C6F62,'Long Text',0x4C6F6E67426C6F62,'value2','value1,value3',0x66,-128,1,0,-32768,-8388608,-2147483648,-2147483648,-9223372036854775808,1234.56,1234.56,1234.56,1234.56,'2023-03-17','2023-03-17 10:00:00','2023-03-17 14:04:46','10:00:00',2023);

```

### Dump SQL

```go
import (
	"os"

	"github.com/dengjiawen8955/mysqldump"
)

func main() {

	dns := "root:rootpasswd@tcp(localhost:3306)/dbname?charset=utf8mb4&parseTime=true&loc=Asia%2FShanghai"

	f, _ := os.Create("dump.sql")

	_ = mysqldump.Dump(
		dns,                          // DNS
		mysqldump.WithDropTable(),    // Option: Delete table before create (Default: Not delete table)
		mysqldump.WithData(),         // Option: Dump Data (Default: Only dump table schema)
		mysqldump.WithTables("test"), // Option: Dump Tables (Default: All tables)
		mysqldump.WithWriter(f),      // Option: Writer (Default: os.Stdout)
		mysqldump.WithDBs("dc3"),     // Option: Dump Dbs (Default: db in dns)
	)
}
```

### Output File dump.sql

```sql
-- ----------------------------
-- MySQL Database Dump
-- Start Time: 2023-03-17 16:07:47
-- ----------------------------


DROP TABLE IF EXISTS `test`;
-- ----------------------------
-- Table structure for test
-- ----------------------------
CREATE TABLE `test` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `char_col` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `varchar_col` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `binary_col` binary(10) DEFAULT NULL,
  `varbinary_col` varbinary(255) DEFAULT NULL,
  `tinyblob_col` tinyblob,
  `tinytext_col` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `text_col` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `blob_col` blob,
  `mediumtext_col` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `mediumblob_col` mediumblob,
  `longtext_col` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `longblob_col` longblob,
  `enum_col` enum('value1','value2','value3') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `set_col` set('value1','value2','value3') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bit_col` bit(8) DEFAULT NULL,
  `tinyint_col` tinyint NOT NULL DEFAULT '0',
  `bool_col` tinyint(1) NOT NULL DEFAULT '0',
  `boolean_col` tinyint(1) NOT NULL DEFAULT '0',
  `smallint_col` smallint NOT NULL DEFAULT '0',
  `mediumint_col` mediumint NOT NULL DEFAULT '0',
  `int_col` int NOT NULL DEFAULT '0',
  `integer_col` int NOT NULL DEFAULT '0',
  `bigint_col` bigint NOT NULL DEFAULT '0',
  `float_col` float(8,2) NOT NULL DEFAULT '0.00',
  `double_col` double(8,2) NOT NULL DEFAULT '0.00',
  `decimal_col` decimal(10,2) NOT NULL DEFAULT '0.00',
  `dec_col` decimal(10,2) NOT NULL DEFAULT '0.00',
  `date_col` date DEFAULT NULL,
  `datetime_col` datetime DEFAULT NULL,
  `timestamp_col` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time_col` time DEFAULT NULL,
  `year_col` year DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (1,'abc','def',0x61626300000000000000,0x646566,0x74696E79626C6F62,'Hello','World',0x776F726C64,'Medium Text',0x4D656469756D426C6F62,'Long Text',0x4C6F6E67426C6F62,'value2','value1,value3',0x66,-128,1,0,-32768,-8388608,-2147483648,-2147483648,-9223372036854775808,1234.56,1234.56,1234.56,1234.56,'2023-03-17','2023-03-17 10:00:00','2023-03-17 14:04:46','10:00:00',2023);


-- ----------------------------
-- Dumped by mysqldump2
-- Cost Time: 7.364804ms
-- ----------------------------
```

### Source SQL

```go
import (
	"os"

	"github.com/dengjiawen8955/mysqldump"
)

func main() {

	dns := "root:rootpasswd@tcp(localhost:3306)/dbname?charset=utf8mb4&parseTime=true&loc=Asia%2FShanghai"
	f, _ := os.Open("dump.sql")

	_ = mysqldump.Source(
		dns,
		f,
        mysqldump.WithMergeInsert(1000),// Option: Merge insert 1000 (Default: Not merge insert)
	)
}
```

