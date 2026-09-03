-- SESSION A: PREPARE ISOLATION LEVEL & START TRANSACTION
mysql> USE college_demo;
Database changed

mysql> SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
Query OK, 0 rows affected (0.00 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE student SET cgpa = 9.90 WHERE roll_no = 101;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0


-- SESSION B: READ UNCOMMITTED DATA (DIRTY READ OCCURS)
mysql> USE college_demo;
Database changed

mysql> SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
Query OK, 0 rows affected (0.00 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT roll_no, name, cgpa FROM student WHERE roll_no = 101;
+---------+-----------+------+
| roll_no | name      | cgpa |
+---------+-----------+------+
|     101 | Chaitanya | 9.90 |
+---------+-----------+------+
1 row in set (0.00 sec)


-- SESSION A: REVERT CHANGES VIA ROLLBACK
mysql> ROLLBACK;
Query OK, 0 rows affected (0.01 sec)


-- SESSION B: RE-READ DATA (DATA HAS DISAPPEARED / REVERTED)
mysql> SELECT roll_no, name, cgpa FROM student WHERE roll_no = 101;
+---------+-----------+------+
| roll_no | name      | cgpa |
+---------+-----------+------+
|     101 | Chaitanya | 9.50 |
+---------+-----------+------+
1 row in set (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)
