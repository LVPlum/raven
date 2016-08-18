<?php

namespace Addons\Ucuser;
use Common\Controller\Addon;
use Com\TPWechat;
use Com\Wxauth;
use Common\Model\UcuserModel;

/**
 * 微会员插件
 * @author UCToo
 */

    class UcuserAddon extends Addon{

        public $info = array(
            'name'=>'Ucuser',
            'title'=>'微会员',
            'description'=>'微会员用户中心',
            'status'=>1,
            'author'=>'UCToo',
            'version'=>'0.1'
        );

        public $admin_list = array(
            'model'=>'Ucuser',		//要查的表
            'fields'=>'*',			//要查的字段
            'map'=>'',				//查询条件, 如果需要可以再插件类的构造方法里动态重置这个属性
            'order'=>'id desc',		//排序,
            'listKey'=>array( 		//这里定义的是除了id序号外的表格里字段显示的表头名
            '字段名'=>'表头显示名'
            ),
        );

        public $custom_adminlist = 'model=Ucuser';

        public function install(){

            return true;
        }

        public function uninstall(){

            return true;
        }


        /**
         * 实现的init_ucuser钩子方法，对公众号粉丝进行初始化，在需要初始化粉丝信息的地方通过 hook('init_ucuser',$params); 调用
         * @params string $mp_id   公众号在系统中的唯一标识，member_public表的id，必填
         * @params string $weObj   公众号实例
         * @return void      hook函数木有返回值
         * 注意：
         */
        public function init_ucuser($params){

            if($params['mp_id'] && $params['weObj'] instanceof TPWechat){   //带有公众号在系统中唯一ID，存在公众号实例，例如weixincontroller中的被动响应
                   $map['openid'] = get_openid();
                   $map['mp_id'] = $params['mp_id'];
                   $ucuser = D('Ucuser');
                   $data = $ucuser->where($map)->find();
                    if(!$data){                                             //公众号没有这个粉丝信息，就注册一个
                        
                        //先在Member表注册会员，使系统中uid统一，公众号粉丝在绑定手机后可登录网站
                        $aUsername = $aNickname = $map['openid']; //substr(,20);          //以openid作为默认UcenterMember用户名和Member昵称
                        $aPassword = UCenterMember()->create_rand();        //随机密码，用户未通过公众号注册，就不可登录网站
                        $email = $aUsername.'@mp_id'.$map['mp_id'].'.com';   //以openid@mpid123.com作为默认邮箱
                        $mobile = arr2str(UCenterMember()->rand_mobile());                    //生成随机手机号已通过model校验，不实际使用，准确手机以微信绑定的为准
                        $aUnType = 5;                                               //微信公众号粉丝注册
                        $aRole = 3;                                                 //默认公众号粉丝用户角色
                        /* 注册用户 */
                       
                        $uid = UCenterMember()->register($aUsername, $aNickname, $aPassword, $email, $mobile, $aUnType);
                        if (0 < $uid) { //注册成功
                            initRoleUser($aRole,$uid); //初始化角色用户
                            set_user_status($uid, 1);                           //微信注册的用户状态直接设置为1
                        } else { //注册失败，显示错误信息

                        }

                        $uid = $ucuser->registerUser($uid , $map['mp_id'] ,$map['openid']);    //用注册member获取的统一uid注册微信粉丝
                        get_ucuser_uid($uid);                               //设置session中uid
                    }else{
                        get_ucuser_uid( $data['uid']);                               //设置session中uid
                    }
            }else{                                                          //不存在公众号实例或没显式传mp_id参数，例如分享到朋友圈的内容,访问参数中必须带有公众号在系统中唯一标识mp_id
                $umap['openid'] = get_openid();                           //只存在公众号信息的，在get_openid中通过oauth获取用户openid
                $umap['mp_id'] = I ( 'mp_id' );                          //从controller的访问请求中获取mp_id
                if(!empty($umap['mp_id'])){
                    $ucuser = D('Ucuser');
                    $data = $ucuser->where($umap)->find();
                    if(!$data){                                             //公众号没有这个粉丝信息，就注册一个
                        //先在Member表注册会员，使系统中uid统一，公众号粉丝在绑定手机后可登录网站
                        $aUsername = $aNickname = $umap['openid'];          //以openid作为默认UcenterMember用户名和Member昵称
                        $aPassword = UCenterMember()->create_rand();        //随机密码，用户未通过公众号注册，就不可登录网站
                        $email = $aUsername.'@mp_id'.$umap['mp_id'].'com';   //以openid@mpid123.com作为默认邮箱
                        $mobile = arr2str(UCenterMember()->rand_mobile());      //生成随机手机号已通过model校验，不实际使用，准确手机以微信绑定的为准
                        $aUnType = 5;                                           //微信公众号粉丝注册
                        $aRole = 3;                                             //默认公众号粉丝用户角色
                        /* 注册用户 */
                        $uid = UCenterMember()->register($aUsername, $aNickname, $aPassword, $email, $mobile, $aUnType);
                        if (0 < $uid) { //注册成功
                            initRoleUser($aRole,$uid); //初始化角色用户
                            set_user_status($uid, 1);                           //微信注册的用户状态直接设置为1
                        } else { //注册失败，显示错误信息

                        }

                        $uid = $ucuser->registerUser($uid , $umap['mp_id'] ,$umap['openid']);    //用注册member获取的统一uid注册微信粉丝
                        get_ucuser_uid($uid);                               //设置session中uid
                    }else{
                        get_ucuser_uid( $data['uid']);                               //设置session中uid
                    }
                }else{                                                      //没有公众号信息，未能初始化粉丝

                }
            }
        }

    }