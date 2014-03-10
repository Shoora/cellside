<?php

class ControllerProductArtist extends Controller {

    public function index() {

        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('localisation/country');

        $category_info = $this->model_catalog_category->getCategory(25);
        $this->document->setTitle($category_info['name']);
        $this->document->setDescription($category_info['meta_description']);
        $this->document->setKeywords($category_info['meta_keyword']);
        $this->data['heading_title'] = $category_info['name'];
        $this->data['categoryID'] = $category_id;
        $this->data['pathID'] = 25;
        $this->language->load('product/category');
        $this->data['text_refine'] = $this->language->get('text_refine');
        $this->data['text_empty'] = $this->language->get('text_empty');
        $this->data['text_quantity'] = $this->language->get('text_quantity');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $this->data['text_model'] = $this->language->get('text_model');
        $this->data['text_price'] = $this->language->get('text_price');
        $this->data['text_tax'] = $this->language->get('text_tax');
        $this->data['text_points'] = $this->language->get('text_points');
        $this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        $this->data['text_display'] = $this->language->get('text_display');
        $this->data['text_list'] = $this->language->get('text_list');
        $this->data['text_grid'] = $this->language->get('text_grid');
        $this->data['text_sort'] = $this->language->get('text_sort');
        $this->data['text_limit'] = $this->language->get('text_limit');

        $this->data['button_cart'] = $this->language->get('button_cart');
        $this->data['button_wishlist'] = $this->language->get('button_wishlist');
        $this->data['button_compare'] = $this->language->get('button_compare');
        $this->data['button_continue'] = $this->language->get('button_continue');

        $results = $this->MsLoader->MsSeller->getSellers(false, array(
            'order_by' => 'total_sales',
            'order_way' => 'DESC',
            'limit' => 1
                )
        );

        foreach ($results as $result) {
            if ($result['ms.avatar'] && file_exists(DIR_IMAGE . $result['ms.avatar'])) {
                $image = $this->MsLoader->MsFile->resizeImage($result['ms.avatar'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
            } else {
                $image = $this->MsLoader->MsFile->resizeImage('ms_no_image.jpg', $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
            }

            $country = $this->model_localisation_country->getCountry($result['ms.country_id']);
            $this->data['sellers'][] = array(
                'seller_id' => $result['seller_id'],
                'thumb' => $image,
                'nickname' => $result['ms.nickname'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['ms.description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
                //'rating'      => $result['rating'],
                'country' => ($country ? $country['name'] : NULL),
                'company' => ($result['ms.company'] ? $result['ms.company'] : NULL),
                'website' => ($result['ms.website'] ? $result['ms.website'] : NULL),
                'country_flag' => ($country ? 'image/flags/' . strtolower($country['iso_code_2']) . '.png' : NULL),
                'total_sales' => $this->MsLoader->MsSeller->getSalesForSeller($result['seller_id']),
                'total_products' => $this->MsLoader->MsProduct->getTotalProducts(array(
                    'seller_id' => $result['seller_id'],
                    'product_status' => array(MsProduct::STATUS_ACTIVE)
                )),
                'href' => $this->url->link('seller/catalog-seller/profile', '&seller_id=' . $result['seller_id'])
            );
        }

        $seller = $this->data['sellers'][0];

        $products = $this->MsLoader->MsProduct->getProducts(
                array(
            'seller_id' => $seller['seller_id'],
            'language_id' => $this->config->get('config_language_id'),
            'product_status' => array(MsProduct::STATUS_ACTIVE)
                ), array(
            'order_by' => 'pd.name',
            'order_way' => 'ASC',
            'offset' => 0,
            'limit' => 3
                )
        );
        if (!empty($products)) {
            foreach ($products as $product) {
                $product_data = $this->model_catalog_product->getProduct($product['product_id']);
                if ($product_data['image'] && file_exists(DIR_IMAGE . $product_data['image'])) {
                    $image = $this->MsLoader->MsFile->resizeImage($product_data['image'], 262, 457);
                    $image2 = $this->MsLoader->MsFile->resizeImage($product_data['image'], 180, 160);
                } else {
                    $image = $this->MsLoader->MsFile->resizeImage('no_image.jpg', 262, 457);
                    $image2 = $this->MsLoader->MsFile->resizeImage('no_image.jpg', 180, 160);
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($product_data['price'], $product_data['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                if ((float) $product_data['special']) {
                    $special = $this->currency->format($this->tax->calculate($product_data['special'], $product_data['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = $product_data['rating'];
                } else {
                    $rating = false;
                }

                $this->data['products'][] = array(
                    'product_id' => $product['product_id'],
                    'thumb' => $image2,
                    'big_thumb' => $image,
                    'device_case' => $product_data['device_case'],
                    'name' => $product_data['name'],
                    'price' => $price,
                    'special' => $special,
                    'rating' => $rating,
                    'reviews' => sprintf($this->language->get('text_reviews'), (int) $product_data['reviews']),
                    'href' => $this->url->link('product/product', 'product_id=' . $product_data['product_id']),
                    'device_case' => $product_data['device_case']
                );
            }
        } else {
            $this->data['products'] = NULL;
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/artists.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/product/artists.tpl';
        } else {
            $this->template = 'default/template/error/not_found.tpl';
        }

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
    }

}
