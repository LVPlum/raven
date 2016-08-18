<?php

namespace Addons\welcome;
use Common\Controller\Addon;

/**
 * 欢迎语插件
 * @author patrick
 */

    class WelcomeAddon extends Addon{
		
		public $custom_config = 'config.html';

        public $info = array(
            'name'=>'Welcome',
            'title'=>'欢迎语',
            'description'=>'用户关注公众号时发送的欢迎信息，支持文本，图片，图文的信息',
            'status'=>1,
            'author'=>'patrick',
            'version'=>'0.1'
        );

        public function install(){
            $install_sql = './Addons/Welcome/install.sql';
            if (file_exists ( $install_sql )) {
                execute_sql_file ( $install_sql );
            }
            return true;
        }

        public function uninstall(){
            $uninstall_sql = './Addons/Welcome/uninstall.sql';
            if (file_exists ( $uninstall_sql )) {
                execute_sql_file ( $uninstall_sql );
            }
            return true;
        }



    }