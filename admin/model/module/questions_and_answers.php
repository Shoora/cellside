<?php
class ModelModuleQuestionsAndAnswers extends Model {
    private $tables = array(
        "question_to_store" => array("question_id", "store_id"),
        "question_to_product" => array("question_id", "product_id"),
        "question" => array("question_id", "product_id", "store_id", "customer_id", "customer_language_id", "activate_next_notification", "notify_author", "author", "email", "allow_answers", "status", "date_added", "date_modified"),
        "question_text" => array("question_id", "language_id", "question", "details"),
        "question_answer" => array("answer_id", "question_id", "customer_id", "author", "email", "notify", "status", "date_added", "date_modified"),
        "question_answer_text" => array("answer_id", "language_id", "answer"),
        "question_answer_vote" => array("answer_id", "customer_id", "vote")
    );


    public function upgradeDatabaseStructure($from_version, &$error) {
        $errors = array();

        switch ($from_version) {
            case '1.0.5': // fall-through state
                foreach ($this->tables as $tabel => $columns) {
                    $this->db->query("ALTER TABLE `" . DB_PREFIX . "{$tabel}` CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci");
                }
            case '1.1.0':
                $this->db->query("ALTER TABLE `" . DB_PREFIX . "question_to_product` ADD INDEX fk_q2p_product (product_id)");
                $this->db->query("ALTER TABLE `" . DB_PREFIX . "question_to_store` ADD INDEX fk_q2s_store (store_id)");
                $this->db->query("ALTER TABLE `" . DB_PREFIX . "question` ADD INDEX fk_q_product (product_id), ADD INDEX fk_q_store (store_id), ADD INDEX fk_q_customer (customer_id), ADD INDEX fk_q_customer_language (customer_language_id)");
                $this->db->query("ALTER TABLE `" . DB_PREFIX . "question_text` ADD INDEX fk_qt_language (language_id)");
                $this->db->query("ALTER TABLE `" . DB_PREFIX . "question_answer` ADD INDEX fk_qa_question (question_id), ADD INDEX fk_qa_customer (customer_id)");
                $this->db->query("ALTER TABLE `" . DB_PREFIX . "question_answer_text` ADD INDEX fk_qat_language (language_id)");
                $this->db->query("ALTER TABLE `" . DB_PREFIX . "question_answer_vote` ADD INDEX fk_qav_customer (customer_id)");
                break;
            default:
                break;
        }

        if (!$errors) {
            return true;
        } else {
            $error = array_merge((array)$error, $errors);
            return false;
        }
    }

    public function applyDatabaseChanges() {
        $this->db->query("
            CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "question_to_product (
                question_id INT(11) NOT NULL,
                product_id INT(11) NOT NULL,
                PRIMARY KEY (question_id, product_id),
                INDEX fk_q2p_product (product_id)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
        );

        $this->db->query("
            CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "question_to_store (
                question_id INT(11) NOT NULL,
                store_id INT(11) NOT NULL,
                PRIMARY KEY (question_id, store_id),
                INDEX fk_q2s_store (store_id)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
        );

        $this->db->query("
            CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "question (
                question_id INT(11) NOT NULL AUTO_INCREMENT,
                product_id INT(11),
                store_id INT(11) NOT NULL DEFAULT '0', -- in which store the question was submitted in
                customer_id INT(11),
                customer_language_id INT(11) NOT NULL,
                notify_author TINYINT(1) NOT NULL DEFAULT '1',
                activate_next_notification VARCHAR(64) NOT NULL DEFAULT '',
                author VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
                email VARCHAR(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
                allow_answers TINYINT(1) NOT NULL DEFAULT '1',
                status TINYINT(1) NOT NULL DEFAULT '0',
                date_added DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
                date_modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
                PRIMARY KEY (question_id),
                INDEX fk_q_product (product_id),
                INDEX fk_q_store (store_id),
                INDEX fk_q_customer (customer_id),
                INDEX fk_q_customer_language (customer_language_id)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
        );

        $this->db->query("
            CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "question_text (
                question_id INT(11) NOT NULL,
                language_id INT(11) NOT NULL,
                question VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
                details TEXT COLLATE utf8_unicode_ci NOT NULL,
                PRIMARY KEY (question_id, language_id),
                INDEX fk_qt_language (language_id)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
        );

        $this->db->query("
            CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "question_answer (
                answer_id INT(11) NOT NULL AUTO_INCREMENT,
                question_id INT(11) NOT NULL,
                customer_id INT(11),
                author VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
                email VARCHAR(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
                notify TINYINT(1) NOT NULL DEFAULT '1',
                status TINYINT(1) NOT NULL DEFAULT '0',
                date_added DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
                date_modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
                PRIMARY KEY (answer_id),
                INDEX fk_qa_question (question_id),
                INDEX fk_qa_customer (customer_id)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
        );

        $this->db->query("
            CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "question_answer_text (
                answer_id INT(11) NOT NULL,
                language_id INT(11) NOT NULL,
                answer TEXT COLLATE utf8_unicode_ci NOT NULL,
                PRIMARY KEY (answer_id, language_id),
                INDEX fk_qat_language (language_id)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
        );

        $this->db->query("
            CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "question_answer_vote (
                answer_id INT(11) NOT NULL,
                customer_id INT(11) NOT NULL,
                vote TINYINT(1) NOT NULL DEFAULT '1',
                PRIMARY KEY (answer_id, customer_id),
                INDEX fk_qav_customer (customer_id)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
        );
    }

    public function revertDatabaseChanges() {
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "question");
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "question_text");
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "question_answer");
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "question_answer_text");
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "question_answer_vote");
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "question_to_store");
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "question_to_product");
    }

    public function checkDatabaseStructure(&$error) {
        $errors = array();

        foreach ($this->tables as $tbl => $fields) {
            $table_exists = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "{$tbl}'");
            if (!$table_exists->num_rows) {
                $errors['warning'] = sprintf($this->language->get('error_missing_table'), DB_PREFIX . $tbl);
            } else { // Check for table fields
                foreach($fields as $field) {
                    $column_exists = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "{$tbl} LIKE '{$field}'");
                    if (!$column_exists->num_rows) {
                        $errors['warning'] = sprintf($this->language->get('error_missing_column'), DB_PREFIX . $tbl, $field);
                    }
                }
            }
        }

        if (!$errors) {
            return true;
        } else {
            $error = array_merge((array)$error, $errors);
            return false;
        }
    }
}
?>
