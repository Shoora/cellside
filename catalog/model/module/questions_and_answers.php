<?php
class ModelModuleQuestionsAndAnswers extends Model {
    protected $question_count = 0;
    protected $answer_count = 0;

    public function addQuestion($data) {
        $customer_language_id = $this->getLanguageIdByCode($this->session->data['language']);
        $customer_id = ($this->customer->isLogged()) ? $this->customer->getId() : null;
        $product_id = (isset($data['product_id']) && (int)$data['product_id']) ? $data['product_id'] : null;

        $this->db->query("INSERT INTO " . DB_PREFIX . "question SET product_id = " . ($product_id ? "'" . (int)$product_id . "'" : "NULL" ) . ", store_id = '" . (int)$this->config->get('config_store_id') . "',  customer_id = " . ($customer_id ? "'" . (int)$customer_id . "'" : "NULL" ) . ", customer_language_id = '" . (int)$customer_language_id . "', notify_author = '" . (int)$data['notify'] . "', author = '" . $this->db->escape($data['name']) . "', email = '" . $this->db->escape($data['email']) . "', allow_answers = '" . (int)$this->config->get('qap_allow_customer_answers') . "', status = '" . (!(int)$this->config->get('qap_moderate_new_questions')) . "', date_added = NOW(), date_modified = NOW()");

        $question_id = $this->db->getLastId();

        $this->db->query("INSERT INTO " . DB_PREFIX . "question_text SET question_id = '" . (int)$question_id . "', language_id = '" . (int)$customer_language_id . "', question = '" . $this->db->escape($data['question']) . "', details = '" . $this->db->escape($data['details']) . "'");

        if ($product_id) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "question_to_product SET question_id = '" . (int)$question_id . "', product_id = '" . (int)$product_id . "'");
        }

        $this->db->query("INSERT INTO " . DB_PREFIX . "question_to_store SET question_id = '" . (int)$question_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "'");

        $this->sendNewQuestionNotificationEmail($question_id, $data);

        return $question_id;
    }

    public function addAnswer($data) {
        $customer_language_id = $this->getLanguageIdByCode($this->session->data['language']);
        $customer_id = ($this->customer->isLogged()) ? $this->customer->getId() : null;

        $this->db->query("INSERT INTO " . DB_PREFIX . "question_answer SET question_id = '" . (int)$data['question_id'] . "', customer_id = " . ($customer_id ? "'" . (int)$customer_id . "'" : "NULL" ) . ", notify = '1', author = '" . $this->db->escape($data['name']) . "', email = '" . $this->db->escape($data['email']) . "', status = '" . (!(int)$this->config->get('qap_moderate_customer_answers')) . "', date_added = NOW(), date_modified = NOW()");

        $answer_id = $this->db->getLastId();

        $this->db->query("INSERT INTO " . DB_PREFIX . "question_answer_text SET answer_id = '" . (int)$answer_id . "', language_id = '" . (int)$customer_language_id . "', answer = '" . $this->db->escape($data['answer']) . "'");

        $this->sendNewQuestionAnswerNotificationEmail((int)$data['question_id'], $answer_id, $data);

        return $answer_id;
    }

    public function updateVote($answer_id, $vote, $customer_id, $remove=false) {
        if ($remove) {
            $this->db->query("DELETE FROM " . DB_PREFIX . "question_answer_vote WHERE answer_id = '" . (int)$answer_id . "' AND customer_id = '" . (int)$customer_id . "'");
        } else {
            $this->db->query("INSERT INTO " . DB_PREFIX . "question_answer_vote SET answer_id = '" . (int)$answer_id . "', customer_id = '" . (int)$customer_id . "', vote = '" . (int)$vote . "' ON DUPLICATE KEY UPDATE vote = '" . (int)$vote . "'");
        }
    }

    public function getLanguageIdByCode($code) {
        $query = $this->db->query("SELECT language_id FROM `" . DB_PREFIX . "language` WHERE code = '" . $this->db->escape($code) . "'");

        if ($query->num_rows)
            return $query->row['language_id'];
        else
            return null;
    }

    public function getQuestion($question_id) {
        $sql = "SELECT q.*";

        if ((int)$this->config->get('qap_display_all_languages')) {
            $sql .= " FROM (SELECT q.* FROM (SELECT q.*, qt.question, qt.details, qt.language_id, IF( qt.language_id = '" . (int)$this->config->get('config_language_id') . "', 2, IF( qt.language_id = q.customer_language_id, 1, 0 ) ) AS priority FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q LEFT JOIN (SELECT q.question_id, IF( qt.language_id = '" . (int)$this->config->get('config_language_id') . "', 2, IF( qt.language_id = q.customer_language_id, 1, 0 ) ) AS priority FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q2 ON (q.question_id = q2.question_id AND q.priority < q2.priority) WHERE q2.question_id IS NULL) q";
        } else {
            $sql .= " FROM (SELECT q.*, qt.question, qt.details, qt.language_id FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q";
        }

        $sql .= " LEFT JOIN " . DB_PREFIX . "question_to_store q2s ON (q.question_id = q2s.question_id)";

        $where = array();

        $where[] = "q2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        $where[] = "q.status = '1'";
        $where[] = "q.question_id = '" . (int)$question_id . "'";

        if (!(int)$this->config->get('qap_display_all_languages')) {
            $where[] = "q.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if ($where) {
            $sql .= " WHERE " . implode(' AND ', $where);
        }

        if ((int)$this->config->get('qap_display_all_languages')) {
            $sql .= " ORDER BY priority DESC";
        }

        $query = $this->db->query($sql);

        if ($query->num_rows)
            return $query->row;
        else
            return null;
    }

    public function getQuestionsAndAnswers($data = array()) {
        $sql = "SELECT SQL_CALC_FOUND_ROWS q.*, COUNT(DISTINCT a.answer_id) AS answers";

        if (isset($data['sort']) && $data['sort'] == "helpful") {
            $sql .= ", IFNULL(SUM(av.vote), 0) AS helpful";
        }

        if ((int)$this->config->get('qap_display_all_languages')) {
            $sql .= " FROM (SELECT q.* FROM (SELECT q.*, qt.question, qt.details, qt.language_id, IF( qt.language_id = '" . (int)$this->config->get('config_language_id') . "', 2, IF( qt.language_id = q.customer_language_id, 1, 0 ) ) AS priority FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q LEFT JOIN (SELECT q.question_id, IF( qt.language_id = '" . (int)$this->config->get('config_language_id') . "', 2, IF( qt.language_id = q.customer_language_id, 1, 0 ) ) AS priority FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q2 ON (q.question_id = q2.question_id AND q.priority < q2.priority) WHERE q2.question_id IS NULL) q";
        } else {
            $sql .= " FROM (SELECT q.*, qt.question, qt.details, qt.language_id FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q";
        }

        $sql .= " LEFT JOIN " . DB_PREFIX . "question_answer a ON (q.question_id = a.question_id AND a.status = '1') LEFT JOIN " . DB_PREFIX . "question_to_product q2p ON (q.question_id = q2p.question_id) LEFT JOIN " . DB_PREFIX . "question_to_store q2s ON (q.question_id = q2s.question_id)";

        if (isset($data['search']) && count((array)$data['search'])) {
            if ((int)$this->config->get('qap_display_all_languages')) {
                $sql .= " LEFT JOIN (SELECT at.* FROM (SELECT qat.answer_id, qat.answer, qat.language_id, IF( qat.language_id = '" . (int)$this->config->get('config_language_id') . "', 1, 0 ) AS priority FROM " . DB_PREFIX . "question_answer_text qat) at LEFT JOIN (SELECT qat.answer_id, IF( qat.language_id = '" . (int)$this->config->get('config_language_id') . "', 1, 0 ) AS priority FROM " . DB_PREFIX . "question_answer_text qat) at2 ON (at.answer_id = at2.answer_id AND at.priority < at2.priority) WHERE at2.answer_id IS NULL) at ON (a.answer_id = at.answer_id)";
            } else {
                $sql .= " LEFT JOIN " . DB_PREFIX . "question_answer_text at ON (a.answer_id = at.answer_id AND at.language_id = '" . (int)$this->config->get('config_language_id') . "')";
            }
        }

        if (isset($data['sort']) && $data['sort'] == "helpful") {
            $sql .= " LEFT JOIN " . DB_PREFIX . "question_answer_vote av ON (a.answer_id = av.answer_id)";
        }

        $where = array();

        $where[] = "q2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        $where[] = "q.status = '1'";

        if (!(int)$this->config->get('qap_display_all_languages')) {
            $where[] = "q.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if (isset($data['type']) && $data['type'] == "general") {
            $where[] = "q2p.product_id IS NULL";
        } else {
            if (isset($data['product_id'])) {
                $where[] = "q2p.product_id = '" . (int)$data['product_id'] . "'";
            } else {
                return array();
            }
        }

        if (isset($data['search']) && count((array)$data['search'])) {
            foreach ((array)$data['search'] as $keyword) {
                if ($keyword) {
                    $matches = array();
                    if (preg_match("/^id:(\d+)$/", $keyword, $matches)) {
                        $where[] = "q.question_id = '" . (int)($matches[1]) . "'";
                    } else {
                        $where[] = "(q.question LIKE '%" . $this->db->escape($keyword) . "%' OR q.details LIKE '%" . $this->db->escape($keyword) . "%' OR at.answer LIKE '%" . $this->db->escape($keyword) . "%')";
                    }
                }
            }
        }

        if ($where) {
            $sql .= " WHERE " . implode(' AND ', $where);
        }

        $sql .= " GROUP BY q.question_id";

        if (isset($data['sort']) && $data['sort'] == "recent") {
            $sql .= " ORDER BY q.date_added DESC";
        } else if (isset($data['sort']) && $data['sort'] == "oldest") {
            $sql .= " ORDER BY q.date_added ASC";
        } else if (isset($data['sort']) && $data['sort'] == "most_answers") {
            $sql .= " ORDER BY answers DESC";
        } else if (isset($data['sort']) && $data['sort'] == "least_answers") {
            $sql .= " ORDER BY answers ASC";
        } else if (isset($data['sort']) && $data['sort'] == "recent_answers") {
            $sql .= " ORDER BY a.date_added DESC";
        } else if (isset($data['sort']) && $data['sort'] == "oldest_answers") {
            $sql .= " ORDER BY a.date_added ASC";
        } else if (isset($data['sort']) && $data['sort'] == "helpful") {
            $sql .= " ORDER BY helpful DESC, answers DESC, a.date_added DESC";
        } else {
            $sql .= " ORDER BY q.date_added DESC";
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
        $this->question_count = ($count->num_rows) ? (int)$count->row['count'] : 0;
        $this->answer_count = 0;

        foreach ($query->rows as &$question)  {
            $answers = $this->getQuestionAnswers($question['question_id'], $data);

            $this->answer_count += count($answers);

            $question['answers'] = $answers;
        }

        return $query->rows;
    }

    public function getQuestionAnswers($question_id, $data = array()) {
        $sql = "SELECT a.*, at.*, a.answer_id, (SELECT COUNT(*) FROM " . DB_PREFIX . "question_answer_vote av1 WHERE av1.answer_id = a.answer_id AND av1.vote > '0') AS likes, (SELECT COUNT(*) FROM " . DB_PREFIX . "question_answer_vote av2 WHERE av2.answer_id = a.answer_id AND av2.vote < '0') AS dislikes";

        if ((int)$this->config->get('qap_allow_answer_voting') && $this->customer->isLogged()) {
            $sql .= ", av.vote as my_vote";
        } else {
            $sql .= ", '0' AS my_vote";
        }

        $sql .= " FROM " . DB_PREFIX . "question_answer a INNER JOIN " . DB_PREFIX . "question q ON (a.question_id = q.question_id)";

        if ((int)$this->config->get('qap_display_all_languages')) {
            $sql .= " INNER JOIN (SELECT at.* FROM (SELECT qat.answer_id, qat.answer, qat.language_id, IF( qat.language_id = '" . (int)$this->config->get('config_language_id') . "', 1, 0 ) AS priority FROM " . DB_PREFIX . "question_answer_text qat) at LEFT JOIN (SELECT qat.answer_id, IF( qat.language_id = '" . (int)$this->config->get('config_language_id') . "', 1, 0 ) AS priority FROM " . DB_PREFIX . "question_answer_text qat) at2 ON (at.answer_id = at2.answer_id AND at.priority < at2.priority) WHERE at2.answer_id IS NULL) at ON (a.answer_id = at.answer_id)";
        } else {
            $sql .= " INNER JOIN " . DB_PREFIX . "question_answer_text at ON (a.answer_id = at.answer_id)";
        }

        if ((int)$this->config->get('qap_allow_answer_voting') && $this->customer->isLogged()) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "question_answer_vote av ON (a.answer_id = av.answer_id AND av.customer_id = '" . (int)$this->customer->getId() . "')";
        }

        $where = array();

        $where[] = "a.question_id = '" . (int)$question_id . "'";
        $where[] = "a.status = '1'";

        if (!(int)$this->config->get('qap_display_all_languages')) {
            $where[] = "at.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if ($where) {
            $sql .= " WHERE " . implode(' AND ', $where);
        }

        $sql .= " GROUP BY a.answer_id";

        if (isset($data['sort']) && $data['sort'] == "recent_answers") {
            $sql .= " ORDER BY a.date_added DESC";
        } else if (isset($data['sort']) && $data['sort'] == "oldest_answers") {
            $sql .= " ORDER BY a.date_added ASC";
        } else {
            $sql .= " ORDER BY (likes * 1 + dislikes * -1) DESC, (likes + dislikes) DESC, a.date_added DESC";
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getTotalAnswers($data = array()) {
        $sql = "SELECT COUNT(DISTINCT answer_id) AS total FROM (SELECT q.question_id, a.answer_id";

        if ((int)$this->config->get('qap_display_all_languages')) {
            $sql .= " FROM (SELECT q.* FROM (SELECT q.*, qt.question, qt.details, qt.language_id, IF( qt.language_id = '" . (int)$this->config->get('config_language_id') . "', 2, IF( qt.language_id = q.customer_language_id, 1, 0 ) ) AS priority FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q LEFT JOIN (SELECT q.question_id, IF( qt.language_id = '" . (int)$this->config->get('config_language_id') . "', 2, IF( qt.language_id = q.customer_language_id, 1, 0 ) ) AS priority FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q2 ON (q.question_id = q2.question_id AND q.priority < q2.priority) WHERE q2.question_id IS NULL) q";
        } else {
            $sql .= " FROM (SELECT q.*, qt.question, qt.details, qt.language_id FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id)) q";
        }

        $sql .= " LEFT JOIN " . DB_PREFIX . "question_answer a ON (q.question_id = a.question_id AND a.status = '1') LEFT JOIN " . DB_PREFIX . "question_to_product q2p ON (q.question_id = q2p.question_id) LEFT JOIN " . DB_PREFIX . "question_to_store q2s ON (q.question_id = q2s.question_id)";

        if (isset($data['search']) && count((array)$data['search'])) {
            if ((int)$this->config->get('qap_display_all_languages')) {
                $sql .= " LEFT JOIN (SELECT at.* FROM (SELECT qat.answer_id, qat.answer, qat.language_id, IF( qat.language_id = '" . (int)$this->config->get('config_language_id') . "', 1, 0 ) AS priority FROM " . DB_PREFIX . "question_answer_text qat) at LEFT JOIN (SELECT qat.answer_id, IF( qat.language_id = '" . (int)$this->config->get('config_language_id') . "', 1, 0 ) AS priority FROM " . DB_PREFIX . "question_answer_text qat) at2 ON (at.answer_id = at2.answer_id AND at.priority < at2.priority) WHERE at2.answer_id IS NULL) at ON (a.answer_id = at.answer_id)";
            } else {
                $sql .= " LEFT JOIN " . DB_PREFIX . "question_answer_text at ON (a.answer_id = at.answer_id AND at.language_id = '" . (int)$this->config->get('config_language_id') . "')";
            }
        }

        $where = array();

        $where[] = "q2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        $where[] = "q.status = '1'";
        $where[] = "a.status = '1'";

        if (!(int)$this->config->get('qap_display_all_languages')) {
            $where[] = "q.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if (isset($data['type']) && $data['type'] == "general") {
            $where[] = "q2p.product_id IS NULL";
        } else {
            if (isset($data['product_id'])) {
                $where[] = "q2p.product_id = '" . (int)$data['product_id'] . "'";
            } else {
                return 0;
            }
        }

        if (!(int)$this->config->get('qap_display_all_languages')) {
            $where[] = "at.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if (isset($data['search']) && count((array)$data['search'])) {
            foreach ((array)$data['search'] as $keyword) {
                if ($keyword) {
                    $matches = array();
                    if (preg_match("/^id:(\d+)$/", $keyword, $matches)) {
                        $where[] = "q.question_id = '" . (int)($matches[1]) . "'";
                    } else {
                        $where[] = "(q.question LIKE '%" . $this->db->escape($keyword) . "%' OR q.details LIKE '%" . $this->db->escape($keyword) . "%' OR at.answer LIKE '%" . $this->db->escape($keyword) . "%')";
                    }
                }
            }
        }

        if ($where) {
            $sql .= " WHERE " . implode(' AND ', $where);
        }

        $sql .= " GROUP BY a.answer_id, q.question_id) AS tmp";

        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getAnswerVotes($answer_id) {
        $sql = "SELECT SUM(av.vote) AS votes FROM " . DB_PREFIX . "question_answer_vote av WHERE av.answer_id = '" . (int)$answer_id . "'";

        $query = $this->db->query($sql);

        return (int)$query->row['votes'];
    }

    public function getTotalQuestions() {
        return $this->question_count;
    }

    /*public function getTotalAnswers() {
        return $this->answer_count;
    }*/

    public function activateNextNotification($question_id, $nnak) {
        $this->db->query("UPDATE " . DB_PREFIX . "question_answer a INNER JOIN " . DB_PREFIX . "question q ON (a.question_id = q.question_id) SET a.notify = '0' WHERE q.question_id = '" . (int)$question_id . "' AND q.activate_next_notification = '" . $this->db->escape($nnak) . "' AND a.status = '1'");
        $this->db->query("UPDATE " . DB_PREFIX . "question SET activate_next_notification = '' WHERE question_id = '" . (int)$question_id . "' AND activate_next_notification = '" . $this->db->escape($nnak) . "'");
    }

    public function setAnswerNotification($answer_id, $notify) {
        $this->db->query("UPDATE " . DB_PREFIX . "question_answer SET notify = '" . (int)$notify . "' WHERE answer_id = '" . (int)$answer_id . "'");
    }

    public function setQuestionNotificationActivation($question_id, $activation_key) {
        $this->db->query("UPDATE " . DB_PREFIX . "question SET activate_next_notification = '" . $this->db->escape($activation_key) . "' WHERE question_id = '" . (int)$question_id . "'");
    }

    protected function sendNewQuestionNotificationEmail($question_id, $data) {
        if ((int)$this->config->get('qap_new_question_notification')) {
            $product_id = (isset($data['product_id']) && (int)$data['product_id']) ? $data['product_id'] : null;
            $product_name = '';
            $product_link = '';
            $question = html_entity_decode($data['question'], ENT_QUOTES, 'UTF-8');
            $question_details = html_entity_decode($data['details'], ENT_QUOTES, 'UTF-8');

            $l_query = $this->db->query("SELECT language_id, filename, directory FROM " . DB_PREFIX . "language WHERE code = '" . $this->db->escape($this->config->get('config_admin_language')) . "'");
            $language = new Language($l_query->row['directory']);
            $language->load($l_query->row['filename']);
            $language->load('mail/qap_new_question');

            // Get customer info
            if ($this->customer->isLogged()) {
                $author = $this->customer->getFirstName() . " " . $this->customer->getLastName();
            } else {
                $author = $data['name'] ? strip_tags($data['name']) : $language->get('text_anonymous');
            }
            $question_author = $data['name'] ? strip_tags($data['name']) : $language->get('text_anonymous');

            if ($product_id) {
                // Get product info
                $p_query = $this->db->query("SELECT pd.name AS name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$l_query->row['language_id'] . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

                if (!$p_query->num_rows) {
                    $product_name = $language->get('text_unknown_product');
                } else {
                    $product_name = $p_query->row['name'];
                }
                $product_link = $this->url->link('product/product', 'product_id=' . $product_id);
            }

            $admin_url = new Url($this->config->get('qap_admin_url'), $this->config->get('qap_admin_url'));
            $admin_link = $admin_url->link('catalog/questions_and_answers/update', 'question_id=' . $question_id, 'SSL');

            $subject = sprintf($language->get('text_subject'), $this->config->get('config_name'));

            // HTML Mail
            $template = new Template();

            $template->data['title'] = sprintf($language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

            $template->data['text_product_question'] = $language->get('text_product_question');
            $template->data['text_general_question'] = $language->get('text_general_question');
            $template->data['text_answer_question'] = $language->get('text_answer_question');
            $template->data['text_question_details'] = $language->get('text_question_details');
            $template->data['text_question_short'] = $language->get('text_question_short');
            $template->data['text_ip'] = $language->get('text_ip');
            $template->data['text_powered_by'] = $language->get('text_powered_by');

            $template->data['store_name'] = $this->config->get('config_name');
            $template->data['store_url'] = $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url');
            $template->data['logo'] = $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
            $template->data['question'] = $question;
            $template->data['question_details'] = $question_details;
            $template->data['question_date'] = date($language->get('date_format_short'));
            $template->data['author'] = $author;
            $template->data['question_author'] = $question_author;
            $template->data['question_author_email'] = $data['email'];
            $template->data['product'] = $product_id;
            $template->data['product_name'] = $product_name;
            $template->data['product_url'] = $product_link;
            $template->data['admin_link'] = $admin_link;
            $template->data['ip_address'] = $this->request->server['REMOTE_ADDR'];

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/qap_new_question.tpl')) {
                $html = $template->fetch($this->config->get('config_template') . '/template/mail/qap_new_question.tpl');
            } else {
                $html = $template->fetch('default/template/mail/qap_new_question.tpl');
            }

            // Text Mail
            $text = (($product_id) ? sprintf($language->get('text_product_question'), $author, $product_name) : sprintf($language->get('text_general_question'), $author)) . "\n\n";
            $text .= $language->get('text_answer_question') . "\n" . $admin_link . "\n\n";

            $text .= "-----------------------------------------\n";
            $text .= $language->get('text_question_details') . "\n";
            $text .= $question . "\n" . $question_details . "\n\n";
            $text .= $question_author . ", " . $data['email'] . "\n" . date($language->get('date_format_short')) . "\n";
            $text .= $language->get('text_ip') . " " . $this->request->server['REMOTE_ADDR'] . "\n";
            $text .= "-----------------------------------------\n\n";

            $text = strip_tags($this->br2nl($text));

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->hostname = $this->config->get('config_smtp_host');
            $mail->username = $this->config->get('config_smtp_username');
            $mail->password = $this->config->get('config_smtp_password');
            $mail->port = $this->config->get('config_smtp_port');
            $mail->timeout = $this->config->get('config_smtp_timeout');
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject($subject);
            $mail->setHtml($html);
            $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));

            $emails = explode(',', $this->config->get('qap_notification_emails'));

            foreach ($emails as $email) {
                $mail->setTo($email);
                $mail->send();
            }
        }

        return true;
    }

    protected function sendNewQuestionAnswerNotificationEmail($question_id, $answer_id, $data) {
        $notify_author = null;
        $author_language = null;

        if ((int)$this->config->get('qap_new_answer_notification')) {
            // Get admin interface language
            $l_query = $this->db->query("SELECT language_id, filename, directory FROM " . DB_PREFIX . "language WHERE code = '" . $this->db->escape($this->config->get('config_admin_language')) . "'");
            $language = new Language($l_query->row['directory']);
            $language->load($l_query->row['filename']);
            $language->load('mail/qap_new_answer');

            // Get question info
            $q_query = $this->db->query("SELECT q.*, qt.*, q.question_id, MAX( IF( qt.language_id = '" . (int)$l_query->row['language_id'] . "', 2, IF( qt.language_id = q.customer_language_id, 1, 0 ) ) ) AS priority FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id) WHERE q.question_id = '" . (int)$question_id . "' ORDER BY priority DESC LIMIT 1");

            if (!$q_query->num_rows) {
                return false;
            }

            $notify_author = (int)$q_query->row['notify_author'] && $q_query->row['activate_next_notification'] == '' && $q_query->row['email'] != '';
            $author_language = $q_query->row['customer_language_id'];

            $product_id = (isset($data['product_id']) && (int)$data['product_id']) ? $data['product_id'] : null;
            $product_name = '';
            $product_link = '';
            $answer = html_entity_decode($data['answer'], ENT_QUOTES, 'UTF-8');
            $question = html_entity_decode($q_query->row['question'], ENT_QUOTES, 'UTF-8');
            $question_details = html_entity_decode($q_query->row['details'], ENT_QUOTES, 'UTF-8');
            $question_author = $q_query->row['author'] ? strip_tags($q_query->row['author']) : $language->get('text_anonymous');
            $question_author_email = $q_query->row['email'];
            $question_date = date($language->get('date_format_short'), strtotime($q_query->row['date_added']));

            // Get customer info
            if ($this->customer->isLogged()) {
                $author = $this->customer->getFirstName() . " " . $this->customer->getLastName();
            } else {
                $author = $data['name'] ? strip_tags($data['name']) : $language->get('text_anonymous');
            }
            $answer_author = $data['name'] ? strip_tags($data['name']) : $language->get('text_anonymous');

            if ($product_id) {
                // Get product info
                $p_query = $this->db->query("SELECT pd.name AS name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$l_query->row['language_id'] . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

                if (!$p_query->num_rows) {
                    $product_name = $language->get('text_unknown_product');
                } else {
                    $product_name = $p_query->row['name'];
                }
                $product_link = $this->url->link('product/product', 'product_id=' . $product_id);
            }

            $admin_url = new Url($this->config->get('qap_admin_url'), $this->config->get('qap_admin_url'));
            $admin_link = $admin_url->link('catalog/questions_and_answers/update', 'question_id=' . $question_id, 'SSL');

            $subject = sprintf($language->get('text_subject'), $this->config->get('config_name'));

            // HTML Mail
            $template = new Template();

            $template->data['title'] = sprintf($language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

            $template->data['text_product_question_answer'] = $language->get('text_product_question_answer');
            $template->data['text_general_question_answer'] = $language->get('text_general_question_answer');
            $template->data['text_admin_question'] = $language->get('text_admin_question');
            $template->data['text_question_details'] = $language->get('text_question_details');
            $template->data['text_question_short'] = $language->get('text_question_short');
            $template->data['text_answer_short'] = $language->get('text_answer_short');
            $template->data['text_ip'] = $language->get('text_ip');
            $template->data['text_powered_by'] = $language->get('text_powered_by');

            $template->data['store_name'] = $this->config->get('config_name');
            $template->data['store_url'] = $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url');
            $template->data['logo'] = $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
            $template->data['question'] = $question;
            $template->data['question_details'] = $question_details;
            $template->data['question_date'] = $question_date;
            $template->data['question_author'] = $question_author;
            $template->data['question_author_email'] = $question_author_email;
            $template->data['answer'] = $answer;
            $template->data['answer_date'] = date($language->get('date_format_short'));
            $template->data['answer_author_email'] = $data['email'];
            $template->data['answer_author'] = $answer_author;
            $template->data['author'] = $author;
            $template->data['product'] = $product_id;
            $template->data['product_name'] = $product_name;
            $template->data['product_url'] = $product_link;
            $template->data['admin_link'] = $admin_link;
            $template->data['ip_address'] = $this->request->server['REMOTE_ADDR'];

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/qap_new_answer.tpl')) {
                $html = $template->fetch($this->config->get('config_template') . '/template/mail/qap_new_answer.tpl');
            } else {
                $html = $template->fetch('default/template/mail/qap_new_answer.tpl');
            }

            // Text Mail
            $text = (($product_id) ? sprintf($language->get('text_product_question_answer'), $author, $product_name) : sprintf($language->get('text_general_question_answer'), $author)) . "\n\n";
            $text .= $language->get('text_admin_question') . "\n" . $admin_link . "\n\n";

            $text .= "-----------------------------------------\n";
            $text .= $language->get('text_question_details') . "\n";
            $text .= $language->get('text_question_short') . ":\n";
            $text .= $question . "\n" . $question_details . "\n\n";
            $text .= $question_author . ", " . $question_author_email . "\n" . $question_date . "\n\n\n";
            $text .= $language->get('text_answer_short') . ":\n";
            $text .= $answer . "\n\n";
            $text .= $answer_author . ", " . $data['email'] . "\n" . date($language->get('date_format_short')) . "\n";
            $text .= $language->get('text_ip') . " " . $this->request->server['REMOTE_ADDR'] . "\n";
            $text .= "-----------------------------------------\n\n";

            $text = strip_tags($this->br2nl($text));

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->hostname = $this->config->get('config_smtp_host');
            $mail->username = $this->config->get('config_smtp_username');
            $mail->password = $this->config->get('config_smtp_password');
            $mail->port = $this->config->get('config_smtp_port');
            $mail->timeout = $this->config->get('config_smtp_timeout');
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject($subject);
            $mail->setHtml($html);
            $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));

            $emails = explode(',', $this->config->get('qap_notification_emails'));

            foreach ($emails as $email) {
                $mail->setTo($email);
                $mail->send();
            }
        }

        if (!(int)$this->config->get('qap_moderate_customer_answers')) {
            if (is_null($notify_author)) {
                $q_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "question WHERE question_id = '" . (int)$question_id . "'");
                if (!$q_query->num_rows) {
                    return false;
                }

                $notify_author = (int)$q_query->row['notify_author'] && $q_query->row['activate_next_notification'] == '' && $q_query->row['email'] != '';
                $author_language = $q_query->row['customer_language_id'];
            }

            if ($notify_author && ((int)$author_language == (int)$this->config->get('config_language_id') || (int)$this->config->get('qap_display_all_languages'))) {
                // Get question author language
                $l_query = $this->db->query("SELECT language_id, filename, directory FROM " . DB_PREFIX . "language WHERE language_id = '" . (int)$author_language . "'");
                $language = new Language($l_query->row['directory']);
                $language->load($l_query->row['filename']);
                $language->load('mail/qap_question_answered');

                // Get question info
                $q_query = $this->db->query("SELECT q.*, qt.*, q.question_id FROM " . DB_PREFIX . "question q INNER JOIN " . DB_PREFIX . "question_text qt ON (q.question_id = qt.question_id AND qt.language_id = q.customer_language_id) WHERE q.question_id = '" . (int)$question_id . "'");

                if (!$q_query->num_rows) {
                    return false;
                }

                $product_id = (isset($data['product_id']) && (int)$data['product_id']) ? $data['product_id'] : null;
                $product_name = '';
                $product_link = '';
                $answer = html_entity_decode($data['answer'], ENT_QUOTES, 'UTF-8');
                $question = html_entity_decode($q_query->row['question'], ENT_QUOTES, 'UTF-8');
                $question_details = html_entity_decode($q_query->row['details'], ENT_QUOTES, 'UTF-8');
                $question_author = $q_query->row['author'] ? strip_tags($q_query->row['author']) : $language->get('text_anonymous');
                $question_author_email = $q_query->row['email'];
                $question_date = date($language->get('date_format_short'), strtotime($q_query->row['date_added']));

                $next_notification_activation_key = $this->unique_key();

                $answer_author = $data['name'] ? strip_tags($data['name']) : $language->get('text_anonymous');

                if ($product_id) {
                    // Get product info
                    $p_query = $this->db->query("SELECT pd.name AS name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$l_query->row['language_id'] . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

                    if (!$p_query->num_rows) {
                        $product_name = $language->get('text_unknown_product');
                    } else {
                        $product_name = $p_query->row['name'];
                    }

                    $view_link = $this->url->link('product/product', 'product_id=' . $product_id . '&nnak=' . $next_notification_activation_key);
                    $view_opt_out_link = $this->url->link('product/product', 'product_id=' . $product_id);
                } else {
                    $view_link = $this->url->link('module/questions_and_answers/faq', 'question_id=' . $question_id . '&nnak=' . $next_notification_activation_key);
                    $view_opt_out_link = $this->url->link('module/questions_and_answers/faq', 'question_id=' . $question_id);
                }

                $subject = sprintf($language->get('text_subject'), $this->config->get('config_name'));

                // HTML Mail
                $template = new Template();

                $template->data['title'] = sprintf($language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

                $template->data['text_greeting'] = $language->get('text_greeting');
                $template->data['text_answered_product'] = $language->get('text_answered_product');
                $template->data['text_answered_general'] = $language->get('text_answered_general');
                $template->data['text_answered'] = $language->get('text_answered');
                $template->data['text_view'] = $language->get('text_view');
                $template->data['text_view_opt_out'] = $language->get('text_view_opt_out');
                $template->data['text_question_detail'] = $language->get('text_question_detail');
                $template->data['text_asked'] = sprintf($language->get('text_asked'), date($language->get('date_format_short'), strtotime($q_query->row['date_added'])));
                $template->data['text_question_short'] = $language->get('text_question_short');
                $template->data['text_answer_short'] = $language->get('text_answer_short');
                $template->data['text_powered_by'] = $language->get('text_powered_by');
                $template->data['text_closing'] = $language->get('text_closing');

                $template->data['store_name'] = $this->config->get('config_name');
                $template->data['store_url'] = $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url');
                $template->data['logo'] = $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
                $template->data['question'] = $question;
                $template->data['question_details'] = $question_details;
                $template->data['answer'] = $answer;
                $template->data['author'] = $question_author;
                $template->data['answer_author'] = $answer_author;
                $template->data['product'] = $product_id;
                $template->data['product_name'] = $product_name;
                $template->data['product_url'] = $view_opt_out_link;
                $template->data['view_link'] = $view_link;
                $template->data['view_opt_out_link'] = $view_opt_out_link;
                $template->data['show_answer'] = (int)$this->config->get('qap_show_answer_in_customer_notification');
                $template->data['sender'] = $this->config->get('config_name');

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/qap_question_answered.tpl')) {
                    $html = $template->fetch($this->config->get('config_template') . '/template/mail/qap_question_answered.tpl');
                } else {
                    $html = $template->fetch('default/template/mail/qap_question_answered.tpl');
                }

                // Text Mail
                $text  = $language->get('text_greeting') . (strip_tags($question_author) ? ' ' . $question_author : '') . ",\n\n";
                $text .= (($product_id) ? sprintf($language->get('text_answered_product'), $product_name) : $language->get('text_answered_general')) . "\n\n";
                $text .= $language->get('text_view') . "\n" . $view_link . "\n\n";
                $text .= $language->get('text_view_opt_out') . "\n" . $view_opt_out_link . "\n\n";
                $text .= $language->get('text_closing') . "\n";
                $text .= $this->config->get('config_name') . "\n\n";

                if ((int)$this->config->get('qap_show_answer_in_customer_notification')) {
                    $text .= "-----------------------------------------\n";
                    $text .= $language->get('text_question_detail') . "\n";
                    $text .= sprintf($language->get('text_asked'), date($language->get('date_format_short'), strtotime($q_query->row['date_added']))) . "\n";
                    $text .= $question . "\n" . $question_details . "\n\n";
                    $text .= $language->get('text_answered') . "\n" . $answer . "\n" . $answer_author . "\n";
                    $text .= "-----------------------------------------\n\n";
                }

                $text = strip_tags($this->br2nl($text));

                $mail = new Mail();
                $mail->protocol = $this->config->get('config_mail_protocol');
                $mail->parameter = $this->config->get('config_mail_parameter');
                $mail->hostname = $this->config->get('config_smtp_host');
                $mail->username = $this->config->get('config_smtp_username');
                $mail->password = $this->config->get('config_smtp_password');
                $mail->port = $this->config->get('config_smtp_port');
                $mail->timeout = $this->config->get('config_smtp_timeout');
                $mail->setFrom($this->config->get('config_email'));
                $mail->setSender($this->config->get('config_name'));
                $mail->setSubject($subject);
                $mail->setHtml($html);
                $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));

                $mail->setTo($question_author_email);
                $mail->send();

                $this->setQuestionNotificationActivation($question_id, $next_notification_activation_key);
                $this->setAnswerNotification($answer_id, 0);
            }
        }

        return true;
    }

    private function br2nl($text) {
        return preg_replace('/<br\\s*?\/??>/i', '\n', $text);
    }

    private function unique_key() {
        return base_convert(base_convert(rand(0,15), 10, 16) . substr(uniqid(), 1), 16, 36);
    }

}
