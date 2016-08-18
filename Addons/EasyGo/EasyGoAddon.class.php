<?php

namespace Addons\EasyGo;
use Common\Controller\Addon;

/**
 * EasyGo输入框增强插件插件
 * @author che1988  zhuxiulai@qq.com
 */

    class EasyGoAddon extends Addon{

        public $info = array(
            'name'=>'EasyGo',
            'title'=>'EasyGo输入框增强插件',
            'description'=>'EasyGo是一个让输入框增强的一个插件，现在有取色器，时间选择器，地图选择器等等',
            'status'=>1,
            'author'=>'che1988',
            'version'=>'0.1'
        );

        public function install(){
            /* 先判断插件需要的钩子是否存在 */
            $hook_mod = M('Hooks');
            $where['name'] = 'EasyGo';
            $gethook = $hook_mod->where($where)->find();
            if(!$gethook || empty($gethook) || !is_array($gethook)){
                $data['name'] = 'EasyGo';
                $data['description'] = 'EasyGo输入框增强';
                $data['type'] = 1;
                $data['update_time'] = NOW_TIME;
                $data['addons'] = "EasyGo";
                if( false !== $hook_mod->create($data) ){
                    $hook_mod->add();
                }
            }
			return true;
        }

        public function uninstall(){
            return true;
        }
		
		/* 显示文档模型编辑页插件扩展信息表单 */
		public function EasyGo($param = array()){

			$this->assign('param',$param);
			$this->assign('config', $this->getConfig());
			/* $param[0] 选择器类型
			** 1：颜色  2：时间  3:map
			*/
         //   \Think\Log::record ( '插件easygo' . $param['0'] . '的param0 ' . $param );
			switch($param['0']){
				case 1://颜色选择器
					if(!isset($param['2']) || $param['2']==1){
						$this->display('Color/content1');
					}elseif($param['2']==2){
						$this->display('Color/content2');
					}	
					break;
				case 2://时间选择器
					if(!isset($param['2']) || $param['2']==1){
						$this->display('Date/content1');
					}elseif($param['2']==2){
						
					}
					break;
                default ://地图坐标选择器

                   //     $key = $param ['name'] . '_' . get_token ();
                   // \Think\Log::record ( '插件easygo' . $key . '的key '.$param ['extra']. '的extra '.$param ['value']. '的value ' );
                    //S($key,null);
                    //    $json = S ( $key );
                   // \Think\Log::record ( '插件easygo' . $json . '的json1 ' );
                       // if ($json === false) {
                         //   $arr =  $param ['value'];
                           // \Think\Log::record ( '插件easygo' . $arr . '的arr '.$arr ['data'] );
                         //   $tree = $this->str2json ( $arr  );
                       //     \Think\Log::record ( '插件easygo' . $tree . '的tree ' );
                     //       $json = json_encode ( $tree );

                   //         S ( $key, $json, 86400 );

                 //       }
               //  \Think\Log::record ( '插件easygo' . $json . '的json ' );
                     //   $this->assign ( 'json', $json );

                   //     $param ['default_value'] = $param ['value'];
                 //       empty ( $param ['default_value'] ) || $param ['default_value'] = '"' . str_replace ( ',', '","', $param ['default_value'] ) . '"';
                  //      $this->assign ( $param );
                  //      \Think\Log::record ( '插件easygo' . $param . '的param '.$param ['default_value'] );
						$this->display('Map/content1');

			}
			
		}


        function str2json($str) {
            $str = str_replace ( '，', ',', $str );
            $str = str_replace ( '【', '[', $str );
            $str = str_replace ( '】', ']', $str );
            $str = str_replace ( '：', ':', $str );

            $arr = StringToArray ( $str );
            $str = '';
            foreach ( $arr as $v ) {
                if ($v == '[' || $v == ']' || $v == ',') {
                    if ($str) {
                        $block = explode ( ':', trim ( $str ) );
                        $blockArr ['a'] = $block [0];
                        $blockArr ['t'] = isset ( $block [1] ) ? $block [1] : $block [0];

                        $arr2 [] = $blockArr;
                    }
                    $v == ',' || $arr2 [] = $v;
                    $str = '';
                } else {
                    $str .= $v;
                }
            }
            if ($arr2 [0] == '[') {
                unset ( $arr2 [0] );
                array_pop ( $arr2 );
            }
            // dump ( $arr2 );
            // 通过栈的原理把一维数组转成多维数据
            $wareroom = array ();
            foreach ( $arr2 as $k => $vo ) {
                if ($vo == ']') {
                    // 逆向出栈
                    $count = count ( $wareroom ) - 1;
                    for($i = $count; $i >= 0; $i --) {
                        if ($wareroom [$i] == '[') {
                            $parent = $i - 1;
                            array_pop ( $wareroom );
                            break;
                        } else {
                            $d [] = array_pop ( $wareroom );
                        }
                    }

                    krsort ( $d );
                    $wareroom [$parent] ['d'] = $d;
                    unset ( $d );
                } else {
                    // 入栈
                    array_push ( $wareroom, $vo );
                }
            }
            // dump ( $wareroom );
            return $wareroom;
        }

    }