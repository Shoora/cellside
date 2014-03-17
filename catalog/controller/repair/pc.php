<?php
class ControllerRepairPc extends Controller
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
        $this->template = $this->config->get('config_template') . '/template/repair/repair-2.tpl';
        $this->document->setTitle('Choose device');

        /*
         * Assigning template vars
         */
        // ...

        /*
         * Render
         */
        $this->response->setOutput($this->render());
    }


    public function step_four()
    {
        /*
         * Template
         */
        $this->template = $this->config->get('config_template') . '/template/repair/repair-2-4.tpl';
        $this->document->setTitle('Enquire');

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
                    $this->_setInfo('device', abs(intval($_POST['device'])));
                    die( json_encode(array( 'error' => 0 )) );
                } else {
                    die( json_encode(array( 'error' => 'Please, select your device' )) );
                }
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
     * Writing repair information
     *
     * @param $var
     * @param $val
     *
     * @return void
     */
    private function _setInfo($var, $val)
    {
        $_SESSION['repair']['pc'][ $var ] = $val;
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
        return $_SESSION['repair']['pc'][ $var ];
    }
}