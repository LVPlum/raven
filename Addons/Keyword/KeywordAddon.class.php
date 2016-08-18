<?php

namespace Addons\Keyword;
use Common\Controller\Addon;

/**
 * 关键词插件
 * @author UCToo
 */

    class KeywordAddon extends Addon{

        public $info = array(
            'name'=>'Keyword',
            'title'=>'关键词',
            'description'=>'关键词数据管理和微信关键词消息处理行为插件',
            'status'=>1,
            'author'=>'UCToo',
            'version'=>'0.1'
        );


        public $admin_list = array(
            'model'=>'Keyword',		//要查的表
                            'fields'=>'*',			//要查的字段
                            'map'=>'',				//查询条件, 如果需要可以再插件类的构造方法里动态重置这个属性
                            'order'=>'id desc',		//排序,
                            'listKey'=>array( 		//这里定义的是除了id序号外的表格里字段显示的表头名
                            '字段名'=>'表头显示名'
                            ),
        );

        public $custom_adminlist = 'model=Keyword';

        public function install(){

            return true;
        }

        public function uninstall(){

            return true;
        }

        //实现的keyword钩子方法，对关键词进行匹配，根据具体处理业务的addon数据或配置，组装回复给用户的内容
        public function keyword($params){

            if($params['mp_id']){
                $kmap['mp_id'] = $params['mp_id'];
                $kmap['keyword'] = $params['weObj']->getRevContent();       //TODO:先只支持精确匹配，后续根据keyword_type字段增加模糊匹配
                $Keyword = M('Keyword')->where($kmap)->find();

                if($Keyword['model'] && $Keyword['aim_id']){              //如果有指定模型，就用模型中的aim_id数据组装回复的内容

                    $amap['id'] =  $Keyword['aim_id'];
                    $aimData = M($Keyword['model'])->where($amap)->find();

                    $reData[0]['Title'] = $aimData['title'];
                    $reData[0]['Description'] = $aimData['intro'];
                    $reData[0]['PicUrl'] = get_cover_url($aimData['cover']) ; //'http://images.domain.com/templates/domaincom/logo.png';
                    $reData[0]['Url'] = $aimData['url'];

                    $params['weObj']->news($reData);
                }elseif ($Keyword['addon']){                                 //TODO:没有指定模型，就用addon的配置信息组装回复的内容
                    $amap['name'] =  $Keyword['addon'];
                    $aimData = M('Addons')->where($amap)->find();             //插件信息组装回复，当然插件需要先安装了
       
                    $reData[0]['Title'] = $aimData['title'];
                    $reData[0]['Description'] = $aimData['description'];

                    $reData[0]['PicUrl'] = get_cover_url( $Keyword['cover'] ); //在后台关键词管理功能上传回复封面图片
                    $param['mp_id'] = $params['mp_id'];
                    $reData[0]['Url'] = $Keyword['url'];
                    $params['weObj']->news($reData);
                }

            }else{

            }
           // $params['weObj']->text("hello ");
        }

    }