-- SESSION A
mysql> USE college_demo;
Database changed

mysql> SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
Query OK, 0 rows affected (0.00 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM student WHERE dept_id=1;
+---------+-----------+--------------------+--------------+---------+------+----------------+
| roll_no | name      | email              | phone        | dept_id | cgpa | transaction_id |
+---------+-----------+--------------------+--------------+---------+------+----------------+
|     101 | Chaitanya | chaitanya@mail.com | 123456789012 |       1 | 9.50 | TXN1001        |
+---------+-----------+--------------------+--------------+---------+------+----------------+
1 row in set (0.00 sec)


-- SESSION B (Executes while Session A's transaction is active)
mysql> USE college_demo;
Database changed

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO student VALUES (103, 'Ashwin', 'ashwin@gmail.com', '112233445566', 1, 8.90, 'TXN1003');
Query OK, 1 row affected (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.01 sec)


-- SESSION A (Re-executes original query after Session B commits)
mysql> SELECT * FROM student WHERE dept_id=1;
+---------+-----------+--------------------+--------------+---------+------+----------------+
| roll_no | name      | email              | phone        | dept_id | cgpa | transaction_id |
+---------+-----------+--------------------+--------------+---------+------+----------------+
|     101 | Chaitanya | chaitanya@mail.com | 123456789012 |       1 | 9.50 | TXN1001        |
|     103 | Ashwin    | ashwin@gmail.com   | 112233445566 |       1 | 8.90 | TXN1003        |
+---------+-----------+--------------------+--------------+---------+------+----------------+
2 rows in set (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)
