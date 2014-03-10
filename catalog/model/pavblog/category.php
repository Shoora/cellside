<?php 
/******************************************************
 * @package Pav blog module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

/**
 * class ModelPavblogcategory 
 */
class ModelPavblogcategory extends Model {		
	
	private $children;
	
	/**
	 * Get List Admin Users
	 */
	public function getUsers(){
		$sql = "SELECT * FROM `" . DB_PREFIX . "user`";
		$query = $this->db->query( $sql );
		$users = $query->rows;
		$output = array();
		foreach( $users as $user ){
			$output[$user['user_id']] = $user['username'];
		}
		return $output;
	}
	
	/**
	 * Get Category Information by Id
	 */
	public function getInfo( $id ){
		$sql = ' SELECT m.*, md.title,md.description FROM ' . DB_PREFIX . 'pavblog_category m LEFT JOIN '
							.DB_PREFIX.'pavblog_category_description md ON m.category_id=md.category_id AND language_id='.(int)$this->config->get('config_language_id') ;
	
		$sql .= ' WHERE m.category_id='.(int)$id;						
	
		$query = $this->db->query( $sql );
		return $query->row;
	}
	
	/**
	 * Get  Sub Categories by Parent ID
	 */
	public function getChildren( $category_id ){
	
		$sql = ' SELECT m.*, md.title,md.description FROM ' . DB_PREFIX . 'pavblog_category m LEFT JOIN '
							.DB_PREFIX.'pavblog_category_description md ON m.category_id=md.category_id AND language_id='.(int)$this->config->get('config_language_id') ;
	
		$sql .= ' WHERE m.parent_id='.(int)$category_id . ' ORDER BY position ' ;						
	
		$query = $this->db->query( $sql );
		return $query->rows;
	}
	
	/**
	 * Get  Sub Categories by Parent ID
	 */
	public function getChild( $id=null ){
		$sql = ' SELECT m.*, md.title,md.description FROM ' . DB_PREFIX . 'pavblog_category m LEFT JOIN '
								.DB_PREFIX.'pavblog_category_description md ON m.category_id=md.category_id AND language_id='.(int)$this->config->get('config_language_id') ;
		if( $id != null ) {						
			$sql .= ' WHERE parent_id='.(int)$id;						
		}
		$sql .= ' ORDER BY `position`  ';
		$query = $this->db->query( $sql );						
		return $query->rows;
	}
	
	/**
	 * get full tree menu built in with HTML 
	 */
	public function getTree( $id=null ){
		 
		$childs = $this->getChild( $id );
		
		foreach($childs as $child ){
			$this->children[$child['parent_id']][] = $child;	
		}
		$parent = 1 ;
		$output = $this->genTree( $parent, 1, 'pav-category' );
		return $output;
	}
	
	public function genTree( $parent, $level , $class="" ){
		if( $this->hasChild($parent) ){
			$data = $this->getNodes( $parent );
			$t = $class;
			$output = '<ul class="level'.$level. " ".$t.' ">';
			
			foreach( $data as $menu ){
				$output .='<li >';
					$output .= '<a href="'.$this->url->link('pavblog/category',"id=".$menu['category_id']).'" title="'.$menu['title'].'">'.$menu['title']."</a>";
					if( $this->hasChild($menu['category_id']) ){
						$output .= '<span class="head"><a style="float:right;" href="#">+</a></span>';
					}
				if($menu['category_id'] > 1)
					$output .= $this->genTree( $menu['category_id'], $level+1 );
				
				$output .= '</li>';
			}	
			$output .= '</ul>';
			return $output;
		}
		return ;
	}
	
	public function hasChild( $id ){
		return isset($this->children[$id]);
	}	
	
	public function getNodes( $id ){
		return $this->children[$id];
	} 
}
?>
