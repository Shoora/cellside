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
        $this->load->model('catalog/product');

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
        $this->template = $this->config->get('config_template') . '/template/repair/repair-1.tpl';
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
        $this->template = $this->config->get('config_template') . '/template/repair/repair-1-2.tpl';
        $this->document->setTitle('Choose color');

        /*
         * Assigning template vars
         */
        $this->data['colors'] = $this->_getColors( $this->_getInfo('device') );


        /*
         * Render
         */
        $this->response->setOutput($this->render());
    }

    /**
     *
     *      Step 3
     *
     * @return void
     */
    public function step_three()
    {
        /*
         * Template
         */
        $this->template = $this->config->get('config_template') . '/template/repair/repair-1-3.tpl';
        $this->document->setTitle('Choose issue');

        /*
         * Assigning template vars
         */
        $this->data['issues'] = $this->_getIssues( $this->_getInfo('color') );

        /*
         * Render
         */
        $this->response->setOutput($this->render());
    }

    /**
     *
     *      Step 4
     *
     * @return void
     */
    public function step_four()
    {
        /*
         * Template
         */
        $this->template = $this->config->get('config_template') . '/template/repair/repair-1-4.tpl';
        $this->document->setTitle('Choose service');

        /*
         * Render
         */
        $this->response->setOutput($this->render());
    }

    /**
     *
     *      Step 5
     *
     * @return void
     */
    public function step_five()
    {
        switch ( $this->_getInfo('service') ? $this->_getInfo('service') : 'mail' ) {
            // DIY Repair
            case 'diy':
                $this->document->setTitle('DIY Repair');
                $this->template = $this->config->get('config_template') . '/template/repair/repair-1-5-diy.tpl';

                // Template vars
                $this->data['issue_id'] = $this->_getInfo('issue');
                $this->data['color_id'] = $this->_getInfo('color');
                $this->data['device_id']= $this->_getInfo('device');

                $this->data['issue'] = $this->model_catalog_category->getCategory( $this->data['issue_id'] );
                $this->data['color'] = $this->model_catalog_category->getCategory( $this->data['color_id'] );
                $this->data['device'] = $this->model_catalog_category->getCategory( $this->data['device_id'] );
                $this->data['manufacturer'] = $this->model_catalog_category->getCategory( $this->data['device']['parent_id'] );
                $this->data['product'] = reset($this->model_catalog_product->getProducts( array( 'filter_category_id' => $this->data['issue_id'] ) ));
                $this->data['product']['price'] = $this->currency->format($this->data['product']['price']);

                break;

            // Walk-in Repair
            case 'walk':
                $this->document->setTitle('Walk-in repair');
                $this->template = $this->config->get('config_template') . '/template/repair/repair-1-5-walk.tpl';

                break;

            // Mail-in Repair
            default:
                $this->document->setTitle('Mail-in repair');
                $this->template = $this->config->get('config_template') . '/template/repair/repair-1-5-mail.tpl';
                $this->data['mail'] = 'cods.max@gmail.com';

                // Template vars
                $this->data['issue_id'] = $this->_getInfo('issue');
                $this->data['color_id'] = $this->_getInfo('color');
                $this->data['device_id']= $this->_getInfo('device');

                $this->data['issue'] = $this->model_catalog_category->getCategory( $this->data['issue_id'] );
                $this->data['color'] = $this->model_catalog_category->getCategory( $this->data['color_id'] );
                $this->data['device'] = $this->model_catalog_category->getCategory( $this->data['device_id'] );
                $this->data['manufacturer'] = $this->model_catalog_category->getCategory( $this->data['device']['parent_id'] );
                $this->data['product'] = reset($this->model_catalog_product->getProducts( array( 'filter_category_id' => $this->data['issue_id'] ) ));
                $this->data['product']['price'] = $this->currency->format($this->data['product']['price']);

                break;
        }

        /*
         * Render
         */
        $this->response->setOutput($this->render());
    }

    /**
     * Getting formatted data for convert to pdf
     */
    public function info()
    {
        $id = isset($_GET['ssid']) ? $_GET['ssid'] : null;
        if ( is_null($id) ) {
            die('No data here');
        }

        $file = dirname(__FILE__) . DIRECTORY_SEPARATOR . '_cache' . DIRECTORY_SEPARATOR . $id . '.php';

        // Display data
        if ( file_exists($file) ) {
            /*
             * Load & display
             */
            $this->document->setTitle('Mail-in repair');
            $this->template = $this->config->get('config_template') . '/template/repair/mail-report.tpl';

            $data = array();
            include $file;

            $this->data['report'] = $data;

            /*
             * Render
             */
            $this->response->setOutput($this->render());
        } else {
            die('No data here');
        }
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
                    $this->_setInfo('device', abs(intval($_POST['device'])));
                    die( json_encode(array( 'error' => 0 )) );
                } else {
                    die( json_encode(array( 'error' => 'Please, select your device' )) );
                }
                break;
            case 'color':
                if (isset($_POST['color']) && is_numeric($_POST['color'])) {
                    $this->_setInfo('color', abs(intval($_POST['color'])));
                    die( json_encode(array( 'error' => 0 )) );
                } else {
                    die( json_encode(array( 'error' => 'Please, select color of your device' )) );
                }
                break;
            case 'issue':
                if (isset($_POST['issue']) && is_numeric($_POST['issue'])) {
                    $this->_setInfo('issue', abs(intval($_POST['issue'])));
                    die( json_encode(array( 'error' => 0 )) );
                } else {
                    die( json_encode(array( 'error' => 'Please, select issue of your device' )) );
                }
                break;
            case 'service':
                $services = array( 'mail', 'walk', 'diy' );

                if (isset($_POST['service']) && in_array($_POST['service'], $services)) {
                    $this->_setInfo('service', trim($_POST['service']));
                    die( json_encode(array( 'error' => 0 )) );
                } else {
                    die( json_encode(array( 'error' => 'Please, select service for your device' )) );
                }
                break;
            case 'mail-in':
                $this->data['mail'] = 'cods.max@gmail.com';

                // Template vars
                $this->data['issue_id'] = $this->_getInfo('issue');
                $this->data['color_id'] = $this->_getInfo('color');
                $this->data['device_id']= $this->_getInfo('device');

                $this->data['issue'] = $this->model_catalog_category->getCategory( $this->data['issue_id'] );
                $this->data['color'] = $this->model_catalog_category->getCategory( $this->data['color_id'] );
                $this->data['device'] = $this->model_catalog_category->getCategory( $this->data['device_id'] );
                $this->data['manufacturer'] = $this->model_catalog_category->getCategory( $this->data['device']['parent_id'] );
                $this->data['product'] = reset($this->model_catalog_product->getProducts( array( 'filter_category_id' => $this->data['issue_id'] ) ));
                $this->data['product']['price'] = $this->currency->format($this->data['product']['price']);

                // Data for pdf

                $data = array(
                    array(
                        'var'   => 'First Name',
                        'val'   => $_POST['first_name']
                    ),
                    array(
                        'var'   => 'Last Name',
                        'val'   => $_POST['last_name']
                    ),
                    array(
                        'var'   => 'Phone',
                        'val'   => $_POST['phone']
                    ),
                    array(
                        'var'   => 'E-Mail',
                        'val'   => $_POST['email']
                    ),
                    array(
                        'var'   => 'Fax',
                        'val'   => $_POST['fax']
                    ),
                    array(
                        'var'   => 'Address',
                        'val'   => $_POST['address']
                    ),
                    array(
                        'var'   => 'Address 2',
                        'val'   => $_POST['address2']
                    ),
                    array(
                        'var'   => 'City',
                        'val'   => $_POST['city']
                    ),
                    array(
                        'var'   => 'Province',
                        'val'   => $_POST['province']
                    ),
                    array(
                        'var'   => 'Postal Code',
                        'val'   => $_POST['zip']
                    ),
                    array(
                        'var'   => 'Description',
                        'val'   => $_POST['description']
                    )
                );

                $this->_putInfo( $data );
                $pdf_link = $this->_getPdfLink('/index.php?ssid=' . session_id() . '&route=repair/repair/info');

                die( json_encode(array( 'error' => 0, 'result' => $pdf_link )) );
                break;
            default:
                die( json_encode(array( 'error' => 'Some error happens' )) );
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
     * Returns array of available device colors
     *
     * @param $parent
     *
     * @return array
     */
    private function _getColors($parent)
    {
        $colors = $this->model_catalog_category->getCategories($parent);
        $final_colors = array();
        foreach ( $colors as $color ) {
            $color['color'] = strtolower( trim($color['name']) );
            $final_colors[] = $color;
        }

        return $final_colors;
    }

    /**
     * Returns all available issues for selected device
     *
     * @param $parent
     *
     * @return array
     */
    private function _getIssues($parent)
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

    /**
     * Writing repair information
     *
     * @param $var
     * @param $val
     */
    private function _setInfo($var, $val)
    {
        $_SESSION['repair']['phone'][ $var ] = $val;
    }

    /**
     * Returns array services available for selected device
     *
     * @param $issues
     *
     * @return array
     */
    private function _getService($issues)
    {
        $issues = explode(',', $issues);

    }

    /**
     * Getting repair information
     *
     * @param $var
     *
     * @return mixed
     */
    private function _getInfo($var)
    {
        return $_SESSION['repair']['phone'][ $var ];
    }


    private function _sendMailRepair()
    {

    }

    /**
     * Cached info about user
     * @param $data
     * @return bool
     */
    private function _putInfo($data)
    {
        $file = dirname(__FILE__) . DIRECTORY_SEPARATOR . '_cache' . DIRECTORY_SEPARATOR . session_id() . '.php';
        return file_put_contents( $file, '<?php' . PHP_EOL . '$data = ' . var_export($data, true) . ';' );
    }

    /**
     * @param $link
     *
     * @return string
     */
    private function _getPdfLink($link)
    {
        $url = 'http://www.web2pdfconvert.com/engine.aspx';
        $data = '?cURL=http://' . $_SERVER['HTTP_HOST'] . '/' . urlencode($link) . '&lowquality=false&porient=portrait&infostamp=false&logostamp=true&allowplugins=false&allowscript=true&showpagenr=false&margintop=10&marginleft=5&marginbottom=10&marginright=5&psize=a4&userpass=&ownerpass=&allowcopy=true&allowedit=true&allowprint=true&title=&author=&subject=&keywords=&conversiondelay=1&printtype=false&nobackground=false&outline=false&ref=form';
        $response = file_get_contents($url . $data);

        preg_match('/href="(.+?\.pdf)"/i', $response, $matches);
        return $matches[1];
    }
}