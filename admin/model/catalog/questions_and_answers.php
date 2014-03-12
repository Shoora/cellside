<?php
class ModelCatalogQuestionsAndAnswers extends Model {
    protected $count = 0;

    public function addQuestion($data) {
        if (isset($data['related_products'])) {
            $product_id = $data['related_products'][0];
        } else {
            $product_id = null;
        }

        if (isset($data['stores'])) {
            $store_id = $data['stores'][0];
        } else {
            $store_id = '0';
        }

        $this->db->query("INSERT INTO " . DB_PREFIX . "question SET product_id = " . ($product_id ? "'" . (int)$product_id . "'" : "NULL" ) . ", store_id = '" . (int)$store_id . "', customer_id = " . ((isset($data['customer_id']) && !is_null($data['customer_id'])) ? "'" . (int)$data['customer_id'] . "'" : "NULL" ) . ", customer_language_id = '" . (int)$data['customer_language_id'] . "', notify_author = '" . (int)$data['notify_author'] . "', activate_next_notification = '" . $this->db->escape($data['activate_next_notification']) . "', author = '" . $this->db->escape($data['author']) . "', email = '" . $this->db->escape($data['email']) . "', allow_answers = '" . (int)$data['allow_answers'] . "', status = '" . (int)$data['status'] . "', date_added = NOW(), date_modified = NOW()");

        $question_id = $this->db->getLastId();

        foreach ($data['question_text'] as $language_id => $q) {
            $question = preg_replace("/\s+/", "", strip_tags($q['question']));
            if ($question) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "question_text SET question_id = '" . (int)$question_id . "', language_id = '" . (int)$language_id . "', question = '" . $this->db->escape($q['question']) . "', details = '" . $this->db->escape($q['details']) . "'");
            }
        }

        if (isset($data['related_products'])) {
            foreach ($data['related_products'] as $product_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "question_to_product SET question_id = '" . (int)$question_id . "', product_id = '" . (int)$product_id . "'");
            }
        }

        if (isset($data['stores'])) {
            foreach ($data['stores'] as $store) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "question_to_store SET question_id = '" . (int)$question_id . "', store_id = '" . (int)$store . "'");
            }
        }

        if (isset($data['answers'])) {
            foreach ($data['answers'] as $answer) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "question_answer SET question_id = '" . (int)$question_id . "', customer_id = " . ((isset($data['customer_id']) && !is_null($data['customer_id']) && $data['customer_id']) ? "'" . (int)$data['customer_id'] . "'" : "NULL" ) . ", author = '" . $this->db->escape($answer['author']) . "', email = '" . $this->db->escape($answer['email']) . "', notify = '" . (int)$answer['notify'] . "', status = '" . (int)$answer['status'] . "', date_added = NOW(), date_modified = NOW()");

                $answer_id = $this->db->getLastId();

                foreach ($answer['answer_text'] as $language_id => $a) {
                    $answer_text = preg_replace("/\s+/", "", strip_tags($a));
                    if ($answer_text) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "question_answer_text SET answer_id = '" . (int)$answer_id . "', language_id = '" . (int)$language_id . "', answer = '" . $this->db->escape($a) . "'");
                    }
                }
            }
        }

        return $question_id;
    }

    public function editQuestion($question_id, $data) {
        if (isset($data['related_products'])) {
            if ($data['product_id'] && !in_array($data['product_id'], $data['related_products']) || !$data['product_id']) {
                $product_id = $data['related_products'][0];
            } else {
                $product_id = $data['product_id'];
            }
        } else {
            $product_id = null;
        }

        if (isset($data['stores'])) {
            if ($data['store_id'] && !in_array($data['store_id'], $data['stores']) || !$data['store_id']) {
                $store_id = $data['stores'][0];
            } else {
                $store_id = $data['store_id'];
            }
        } else {
            $store_id = '0';
        }

        $this->db->query("UPDATE " . DB_PREFIX . "question SET product_id = " . ($product_id ? "'" . (int)$product_id . "'" : "NULL" ) . ", store_id = '" . (int)$store_id . "', customer_id = " . ((isset($data['customer_id']) && !is_null($data['customer_id'])) ? "'" . (int)$data['customer_id'] . "'" : "NULL" ) . ", customer_language_id = '" . (int)$data['customer_language_id'] . "', notify_author = '" . (int)$data['notify_author'] . "', activate_next_notification = '" . $this->db->escape($data['activate_next_notification']) . "', author = '" . $this->db->escape($data['author']) . "', email = '" . $this->db->escape($data['email']) . "', allow_answers = '" . (int)$data['allow_answers'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW() WHERE question_id = '" . (int)$question_id . "'");

        $this->db->query("DELETE FROM " . DB_PREFIX . "question_text WHERE question_id = '" . (int)$question_id . "'");

        foreach ($data['question_text'] as $language_id => $q) {
            $question = preg_replace("/\s+/", "", strip_tags($q['question']));
            if ($question) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "question_text SET question_id = '" . (int)$question_id . "', language_id = '" . (int)$language_id . "', question = '" . $this->db->escape($q['question']) . "', details = '" . $this->db->escape($q['details']) . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "question_to_product WHERE question_id = '" . (int)$question_id . "'");

        if (isset($data['related_products'])) {
            foreach ($data['related_products'] as $product_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "question_to_product SET question_id = '" . (int)$question_id . "', product_id = '" . (int)$product_id . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "question_to_store WHERE question_id = '" . (int)$question_id . "'");

        if (isset($data['stores'])) {
            foreach ($data['stores'] as $store) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "question_to_store SET question_id = '" . (int)$question_id . "', store_id = '" . (int)$store . "'");
            }
        }

        if (isset($data['answers'])) {
            $query = $this->db->query("SELECT answer_id FROM " . DB_PREFIX . "question_answer WHERE question_id = '" . (int)$question_id . "'");

            $existing_answers = array();

            if ($query->num_rows) {
                foreach ($query->rows as $value) {
                    $existing_answers[] = (int)$value['answer_id'];
                }
            }

            foreach ($data['answers'] as $answer) {
                if (isset($answer['answer_id']) && $answer['answer_id'] && ($key = array_search((int)$answer['answer_id'], $existing_answers)) !== false) {
                    unset($existing_answers[$key]);

                    $this->db->query("UPDATE " . DB_PREFIX . "question_answer SET customer_id = " . ((isset($answer['customer_id']) && !is_null($answer['customer_id']) && $answer['customer_id']) ? "'" . (int)$answer['customer_id'] . "'" : "NULL" ) . ", author = '" . $this->db->escape($answer['author']) . "', email = '" . $this->db->escape($answer['email']) . "', notify = '" . (int)$answer['notify'] . "', status = '" . (int)$answer['status'] . "', date_modified = NOW() WHERE answer_id = '" . (int)$answer['answer_id'] . "'");

                    $answer_id = $answer['answer_id'];
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "question_answer SET question_id = '" . (int)$question_id . "', customer_id = " . ((isset($answer['customer_id']) && !is_null($answer['customer_id']) && $answer['customer_id']) ? "'" . (int)$answer['customer_id'] . "'" : "NULL" ) . ", author = '" . $this->db->escape($answer['author']) . "', email = '" . $this->db->escape($answer['email']) . "', notify = '" . (int)$answer['notify'] . "', status = '" . (int)$answer['status'] . "', date_added = NOW(), date_modified = NOW()");

                    $answer_id = $this->db->getLastId();
                }

                $this->db->query("DELETE FROM " . DB_PREFIX . "question_answer_text WHERE answer_id = '" . (int)$answer_id . "'");

                foreach ($answer['answer_text'] as $language_id => $a) {
                    $answer_text = preg_replace("/\s+/", "", strip_tags($a));
                    if ($answer_text) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "question_answer_text SET answer_id = '" . (int)$answer_id . "', language_id = '" . (int)$language_id . "', answer = '" . $this->db->escape($a) . "'");
                    }
                }
            }

            foreach ($existing_answers as $delete_answer_id) {
                $this->db->query("DELETE a.*, at.*, av.* FROM " . DB_PREFIX . "question_answer a LEFT JOIN " . DB_PREFIX . "question_answer_text at ON (a.answer_id = at.answer_id) LEFT JOIN " . DB_PREFIX . "question_answer_vote av ON (a.answer_id = av.answer_id) WHERE a.answer_id = '" . (int)$delete_answer_id . "'");
            }
        } else {
            $this->db->query("DELETE a.*, at.*, av.* FROM " . DB_PREFIX . "question_answer a LEFT JOIN " . DB_PREFIX . "question_answer_text at ON (a.answer_id = at.answer_id) LEFT JOIN " . DB_PREFIX . "question_answer_vote av ON (a.answer_id = av.answer_id) WHERE a.question_id = '" . (int)$question_id . "'");
        }

        return $question_id;
    }

    public function deleteQuestion($question_id) {
        // Delete answers and answer votes related to the particular question
        $this->db->query("DELETE a.*, at.*, av.* FROM " . DB_PREFIX . "question_answer a LEFT JOIN " . DB_PREFIX . "question_answer_text at ON (a.answer_id = at.answer_id) LEFT JOIN " . DB_PREFIX . "question_answer_vote av ON (a.answer_id = av.answer_id) WHERE a.question_id = '" . (int)$question_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "question_to_store WHERE question_id = '" . (int)$question_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "question_to_product WHERE question_id = '" . (int)$question_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "question_text WHERE question_id = '" . (int)$question_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "question WHERE question_id = '" . (int)$question_id . "'");
    }

    public function setAnswerNotification($answer_id, $notify) {
        $this->db->query("UPDATE " . DB_PREFIX . "question_answer SET notify = '" . (int)$notify . "' WHERE answer_id = '" . (int)$answer_id . "'");
    }

    public function setQuestionNotificationActivation($question_id, $activation_key) {
        $this->db->query("UPDATE " . DB_PREFIX . "question SET activate_next_notification = '" . $this->db->escape($activation_key) . "' WHERE question_id = '" . (int)$question_id . "'");
    }

    public function getQuestion($question_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "question WHERE question_id = '" . (int)$question_id . "'");

        return $query->row;
    }

    public function getQuestions($data = array()) {
        $lang = $this->config->get('qap_list_language');

        $sql = "SELECT SQL_CALC_FOUND_ROWS q.*, qt.*, q.question_id, COUNT(DISTINCT a.answer_id) AS answers";

        if (isset($data["filter_approval"]) && !is_null($data["filter_approval"])) {
            $sql .= ", (SELECT COUNT(*) FROM " . DB_PREFIX . "question_answer qa WHERE qa.status = '0' AND qa.question_id = q.question_id) AS disabled_answers";
        }

        $sql .= " FROM " . DB_PREFIX . "question q LEFT JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id AND " . (($lang == "*") ? "qt.language_id = q.customer_language_id" : "qt.language_id = '" . (int)$lang . "'") . ") LEFT JOIN " . DB_PREFIX . "question_answer a ON (q.question_id = a.question_id)";

        // if (!empty($data['filter_product'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "question_to_product q2p ON (q.question_id = q2p.question_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (q2p.product_id = pd.product_id AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "')";
        // }

        if (isset($data['filter_store'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "question_to_store q2s ON (q.question_id = q2s.question_id)";
        }

        // WHERE where
        $where = array();

        if ($this->config->get('qap_list_questions') == "general") {
            $where[] = "q2p.product_id IS NULL";
        } else if ($this->config->get('qap_list_questions') == "product") {
            $where[] = "q2p.product_id IS NOT NULL";
        }

        /*if ($lang != "*") {
            $where[] = "qt.language_id IS NOT NULL";
        }*/

        $date_filters = array(
            'date_added'        => 'q.date_added',
            'date_modified'     => 'q.date_modified'
        );

        foreach ($date_filters as $key => $value) {
            if (isset($data["filter_$key"]) && !is_null($data["filter_$key"])) {
                $where[] = "DATE($value) = DATE('" . $this->db->escape($data["filter_$key"]) . "')";
            }
        }

        $int_interval_filters = array(
            'id'        => 'q.question_id',
            'status'    => 'q.status'
        );

        foreach ($int_interval_filters as $key => $value) {
            if (isset($data["filter_$key"]) && !is_null($data["filter_$key"])) {
                $where[] = $this->filterInterval($data["filter_$key"], $value);
            }
        }

        $anywhere_filters = array(
            'product'   => 'pd.name',
            'question'  => 'qt.question',
            'author'    => 'q.author',
            'email'     => 'q.email',
        );

        foreach ($anywhere_filters as $key => $value) {
            if (!empty($data["filter_$key"])) {
                $where[] = "LCASE($value) LIKE '%" . $this->db->escape(utf8_strtolower($data["filter_$key"])) . "%'";
            }
        }

        if (isset($data['filter_store'])) {
            if ($data['filter_store'] == '*')
                $where[] = "q2s.store_id IS NULL";
            else
                $where[] = "q2s.store_id = '" . (int)$data['filter_store'] . "'";
        }

        if ($where) {
            $sql .= " WHERE " . implode(' AND ', $where);
        }

        $sql .= " GROUP BY q.question_id";

        // HAVING where
        $having = array();

        if (isset($data["filter_approval"]) && !is_null($data["filter_approval"])) {
            $having[] = "(q.status = '0' OR disabled_answers > '0')";
        }

        $int_interval_filters = array(
            'answers'   => 'answers'
        );

        foreach ($int_interval_filters as $key => $value) {
            if (isset($data["filter_$key"]) && !is_null($data["filter_$key"])) {
                $having[] = $this->filterInterval($data["filter_$key"], $value);
            }
        }

        if ($having) {
            $sql .= " HAVING " . implode(' AND ', $having);
        }

        $sort_data = array(
            'q.question_id',
            'a.date_added',
            'a.date_modified',
            'qt.question',
            'q.author',
            'q.email',
            'answers',
            'q.status'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY q.date_added";
        }

        if (isset($data['order']) && ($data['order'] == 'ASC')) {
            $sql .= " ASC";
        } else {
            $sql .= " DESC";
        }

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);

        $count = $this->db->query("SELECT FOUND_ROWS() AS count");
        $this->count = ($count->num_rows) ? (int)$count->row['count'] : 0;

        return $query->rows;
    }

    public function getQuestionTexts($question_id) {
        $data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "question_text WHERE question_id = '" . (int)$question_id . "'");

        foreach ($query->rows as $result) {
            $data[$result['language_id']] = array(
                'question'  => $result['question'],
                'details'   => $result['details']
            );
        }

        return $data;
    }

    public function getQuestionAnswers($question_id) {
        $data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "question_answer WHERE question_id = '" . (int)$question_id . "'  ORDER BY date_added DESC");

        foreach ($query->rows as $result) {
            $data[] = $result;
        }

        return $data;
    }

    public function getAnswerTexts($answer_id) {
        $data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "question_answer_text WHERE answer_id = '" . (int)$answer_id . "'");

        foreach ($query->rows as $result) {
            $data[$result['language_id']] = $result['answer'];
        }

        return $data;
    }

    public function getAnswerVotes($answer_id) {
        $query = $this->db->query("SELECT (SELECT COUNT(*) FROM " . DB_PREFIX . "question_answer_vote av1 WHERE av1.answer_id = av.answer_id AND av1.vote > '0') AS likes, (SELECT COUNT(*) FROM " . DB_PREFIX . "question_answer_vote av2 WHERE av2.answer_id = av.answer_id AND av2.vote < '0') AS dislikes FROM " . DB_PREFIX . "question_answer_vote av WHERE av.answer_id = '" . (int)$answer_id . "'");

        return $query->row;
    }

    public function getTotal() {
        return $this->count;
    }

    public function getTotalQuestions() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "question`");

        return $query->row['total'];
    }

    public function getTotalUnansweredQuestions() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "question` q LEFT JOIN `" . DB_PREFIX . "question_answer` a ON (q.question_id = a.question_id) WHERE a.answer_id IS NULL");

        return $query->row['total'];
    }

    public function getTotalDisabledQuestionsAndAnswers() {
        $query = $this->db->query("SELECT SUM(t.total) AS total FROM ((SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "question` WHERE status = '0') UNION ALL (SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "question_answer` WHERE status = '0')) t");

        return $query->row['total'];
    }

    public function getAnswers($question_id) {
        $data = array();

        $lang = $this->config->get('qap_list_language');

        $sql = "SELECT a.*, at.*, (SELECT COUNT(*) FROM " . DB_PREFIX . "question_answer_vote av1 WHERE av1.answer_id = a.answer_id AND av1.vote > '0') AS likes, (SELECT COUNT(*) FROM " . DB_PREFIX . "question_answer_vote av2 WHERE av2.answer_id = a.answer_id AND av2.vote < '0') AS dislikes FROM " . DB_PREFIX . "question_answer a INNER JOIN " . DB_PREFIX . "question q ON (q.question_id = a.question_id) LEFT JOIN " . DB_PREFIX . "question_answer_text at ON (a.answer_id = at.answer_id AND " . (($lang == "*") ? "at.language_id = q.customer_language_id" : "at.language_id = '" . (int)$lang . "'") . ") WHERE a.question_id = '" . (int)$question_id . "' ORDER BY (likes + dislikes) DESC, a.date_added ASC";

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getQuestionProducts($question_id) {
        $data = array();

        $query = $this->db->query("SELECT pd.* FROM " . DB_PREFIX . "question_to_product q2p LEFT JOIN " . DB_PREFIX . "product p ON (p.product_id = q2p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (pd.product_id = p.product_id AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "') WHERE q2p.question_id = '" . (int)$question_id . "' ORDER BY p.sort_order ASC");

        foreach ($query->rows as $result) {
            $data[$result['product_id']] = $result;
        }

        return $data;
    }

    public function getQuestionStores($question_id) {
        $data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "question_to_store WHERE question_id = '" . (int)$question_id . "'");

        foreach ($query->rows as $result) {
            $data[] = $result['store_id'];
        }

        return $data;
    }

    public function getTotalQuestionDisabledAnswers($question_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "question_answer WHERE question_id = '" . (int)$question_id . "' AND status = '0'");

        return $query->row['total'];
    }

    public function filterInterval($filter, $field, $date=false) {
        if ($date) {
            if (preg_match('/^(!=|<>)\s*(\d{2,4}-\d{1,2}-\d{1,2})$/', html_entity_decode(trim($filter)), $matches) && count($matches) == 3) {
                return "DATE($field) <> DATE('" . $matches[2] . "')";
            } else if (preg_match('/^(\d{2,4}-\d{1,2}-\d{1,2})\s*(<|<=)\s*(\d{2,4}-\d{1,2}-\d{1,2})$/', html_entity_decode(trim($filter)), $matches) && count($matches) == 4 && strtotime($matches[1]) <= strtotime($matches[3])) {
                return "DATE('" . $matches[1] . "') ${matches[2]} DATE($field) AND DATE($field) ${matches[2]} DATE('" . $matches[3] . "')";
            } else if (preg_match('/^(\d{2,4}-\d{1,2}-\d{1,2})\s*(>|>=)\s*(\d{2,4}-\d{1,2}-\d{1,2})$/', html_entity_decode(trim($filter)), $matches) && count($matches) == 4 && strtotime($matches[1]) >= strtotime($matches[3])) {
                return "DATE('" . $matches[1] . "') ${matches[2]} DATE($field) AND DATE($field) ${matches[2]} DATE('" . $matches[3] . "')";
            } else if (preg_match('/^(<|<=|>|>=)\s*(\d{2,4}-\d{1,2}-\d{1,2})$/', html_entity_decode(trim($filter)), $matches) && count($matches) == 3) {
                return "DATE($field) ${matches[1]} DATE('" . $matches[2] . "')";
            } else if (preg_match('/^(\d{2,4}-\d{1,2}-\d{1,2})\s*(>|>=|<|<=)$/', html_entity_decode(trim($filter)), $matches) && count($matches) == 3) {
                return "DATE('" . $matches[1] . "') ${matches[2]} DATE($field)";
            } else {
                return "DATE(${field}) = DATE('${filter}')";
            }
        } else {
            if (preg_match('/^(!=|<>)\s*(-?\d+\.?\d*)$/', html_entity_decode(trim(str_replace(",", ".", $filter))), $matches) && count($matches) == 3) {
                return "$field <> '" . (float)$matches[2] . "'";
            } else if (preg_match('/^(-?\d+\.?\d*)\s*(<|<=)\s*(-?\d+\.?\d*)$/', html_entity_decode(trim(str_replace(",", ".", $filter))), $matches) && count($matches) == 4 && (float)$matches[1] <= (float)$matches[3]) {
                return "'" . (float)$matches[1] . "' ${matches[2]} $field AND $field ${matches[2]} '" . (float)$matches[3] . "'";
            } else if (preg_match('/^(-?\d+\.?\d*)\s*(>|>=)\s*(-?\d+\.?\d*)$/', html_entity_decode(trim(str_replace(",", ".", $filter))), $matches) && count($matches) == 4 && (float)$matches[1] >= (float)$matches[3]) {
                return "'" . (float)$matches[1] . "' ${matches[2]} $field AND $field ${matches[2]} '" . (float)$matches[3] . "'";
            } else if (preg_match('/^(<|<=|>|>=)\s*(-?\d+\.?\d*)$/', html_entity_decode(trim(str_replace(",", ".", $filter))), $matches) && count($matches) == 3) {
                return "$field ${matches[1]} '" . (float)$matches[2] . "'";
            } else if (preg_match('/^(-?\d+\.?\d*)\s*(>|>=|<|<=)$/', html_entity_decode(trim(str_replace(",", ".", $filter))), $matches) && count($matches) == 3) {
                return "'" . (float)$matches[1] . "' ${matches[2]} $field";
            } else {
                return $field . " = '" . (int)$filter . "'";
            }
        }
    }
}
?>