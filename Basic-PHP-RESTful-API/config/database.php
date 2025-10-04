<?php

require __DIR__ .  '/../vendor/autoload.php';


class Database {
    public $conn;

    public function __construct() {
    }

    public function connect(): ?PDO {
        $this->conn = null;

        try {
            // $dsn = "mysql:host={$this->DB_HOST};dbname={$this->DB_NAME};charset=utf8";
            $this->conn = new PDO('sqlite:' . '../db/contato.sqlite3');
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            error_log("[" . date("Y-m-d H:i:s") . "] Connection failed: " . $e->getMessage() . "\r\n", 3, '../logs/error.log');
        }

        $query = "CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, age TEXT NOT NULL, job TEXT NOT NULL)";
        $this->conn->exec($query);

        return $this->conn;
    }
}