<?php
class ControllerRepairRepair extends Controller
{
    /**
     * Array of errors
     *
     * @var array
     */
    private $error = array();

    /**
     * Setting up the current controller
     *
     * @param $registry
     */
    function __construct($registry)
    {
        parent::__construct($registry);

        // System
        $this->load->model('repair/repair');
        $this->load->model('catalog/category');

        // View
        $this->data['themeName'] = $this->config->get('config_template');
        $this->children = array(
            'common/footer',
            'common/header'
        );
    }

    /**
     * Starting repair page [Phone & Tablets]
     *
     *      Step 1
     *
     * @return void
     */
    public function index()
    {
        /*
         * Template
         */
        $this->template = $this->config->get('config_template') . '/template/repair/repair.tpl';
        $this->document->setTitle('Choose device');

        /*
         * Assigning template vars
         */
        $this->data['manufacturers'] = $this->_getManufacturers();
        $this->data['selected'] = intval(abs($_GET['manufacturer']));
        $this->data['categories'] = $this->_getCategories(871, $this->data['selected']);

        /*
         * Render
         */
        $this->response->setOutput($this->render());
    }

    /**
     *
     *      Step 2
     *
     * @return void
     */
    public function step_two()
    {
        /*
         * Template
         */
        $this->template = $this->config->get('config_template') . '/template/repair/repair.tpl';

        /*
         * Assigning template vars
         */
        // ...

        /*
         * Render
         */
        $this->response->setOutput($this->render());
    }

    /**
     * Setting data about repair
     *
     * @return void
     */
    public function ajax()
    {
        switch ($_POST['act']) {
            case 'device':
                if (isset($_POST['device']) && is_numeric($_POST['device'])) {
                    $_SESSION['repair']['phone']['device'] = abs(intval($_POST['device']));
                    die( json_encode(array( 'error' => 0 )) );
                } else {
                    die( json_encode(array( 'error' => 'Please, select your device' )) );
                }
                break;
            default:
                die( json_encode(array( 'error' => 'Please, select your device' )) );
                break;
        }
    }


    /*
     * --------------------------------
     *      PRIVATE SECTION
     * --------------------------------
     */

    /**
     * Returns array of manufacturers
     *
     * @param   int $parent
     *
     * @return  array
     */
    private function _getManufacturers($parent = 871)
    {
        return $this->model_catalog_category->getCategories($parent);
    }

    /**
     * Returns all categories and subcategories
     *
     * @param   $parent 871
     * @param   $filter id of parent category
     *
     * @return  array
     */
    private function _getCategories($parent = 871, $filter = null)
    {
        $parents = $this->model_catalog_category->getCategories($parent);
        $childs = $parent_list = array();
        foreach ($parents as $category) {
            // Skipping filtered categories
            if (!is_null($filter) && $filter && $filter != $category['category_id']) {
                continue;
            }

            $childs[] = $this->model_catalog_category->getCategories($category['category_id']);
            $parent_list[$category['category_id']] = $category;
        }

        $final_list = array();
        for ($i = 0; $i < count($childs); $i++) {
            $item = $childs[$i][0];
            $item['name'] = $parent_list[$item['parent_id']]['name'] . ' ' . $item['name'];
            $final_list[] = $item;
        }

        return $final_list;
    }
}