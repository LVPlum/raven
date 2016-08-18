<?php
// +----------------------------------------------------------------------
// | UCToo [ Universal Convergence Technology ]
// +----------------------------------------------------------------------
// | Copyright (c) 2014-2015 http://uctoo.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: Patrick <contact@uctoo.com>
// +----------------------------------------------------------------------

namespace Home\Controller;

use Think\Controller;
use Com\TPWechat;
/**
 * 微信交互控制器，中控服务器
 * 主要获取和反馈微信平台的数据，分析用户交互和系统消息分发。
 */
class WeixinController extends Controller {

    private $options = array(
          'token'=>APP_TOKEN, //填写你设定的key
          'encodingaeskey'=>'', //填写加密用的EncodingAESKey
          'appid'=>'', //填写高级调用功能的app id
          'appsecret'=>'' //填写高级调用功能的密钥
      );

    private $member_public;   //公众号

    public function _initialize(){
        /* 读取数据库中的公众号信息初始化微信类 */



    }

     /**
     * 微信消息接口入口
     * 所有发送到微信的消息都会推送到该操作
     * 所以，微信公众平台后台填写的api地址则为该操作的访问地址
     * 在mp.weixin.qq.com 开发者中心配置的 URL(服务器地址)  http://域名/index.php/home/weixin/index/id/member_public表的id.html
     */
	public function index($id = '') {
        //
        $this->member_public = M('MemberPublic')->find($id);
        $this->options['appid'] = $this->member_public['appid'];    //初始化options信息
        $this->options['appsecret'] = $this->member_public['secret'];
        $this->options['encodingaeskey'] = $this->member_public['encodingaeskey'];
        $weObj = new TPWechat($this->options);
        $weObj->valid();
        $weObj->getRev();
        $data = $weObj->getRevData();
        $type = $weObj->getRevType();
        $ToUserName = $weObj->getRevTo();
        $FromUserName = $weObj->getRevFrom();
        $params['weObj'] = &$weObj;
        $params['mp_id'] = $id;
        $params['weOptions'] = $this->options;
        
        //如果被动响应可获得用户信息就记录下
	if (! empty ( $id )) {                    //设置当前上下文的公众号id
            $mp_id =  get_mpid($id);
        }
        if (! empty ( $ToUserName )) {
            get_token ( $ToUserName );
        }
        if (! empty ( $FromUserName )) {
          $oid =  get_openid($FromUserName);
        }
        
        hook('init_ucuser',$params);   //把消息分发到addons/ucuser/init_ucuser的方法中,初始化公众号粉丝信息

        //与微信交互的中控服务器逻辑可以自己定义，这里实现一个通用的
        switch ($type) {
            //事件
            case TPWechat::MSGTYPE_EVENT:         //先处理事件型消息
                $event = $weObj->getRevEvent();
                switch ($event) {
                    //关注
                    case TPWechat::EVENT_SUBSCRIBE:
                        //二维码关注
                        if(isset($event['eventkey']) && isset($event['ticket'])){

                            //普通关注
                        }else{

                        }
                        break;
                    //扫描二维码
                    case TPWechat::EVENT_SCAN:

                        break;
                    //地理位置
                    case TPWechat::EVENT_LOCATION:

                        break;
                    //自定义菜单 - 点击菜单拉取消息时的事件推送
                    case TPWechat::EVENT_MENU_CLICK:

                        break;
                    //自定义菜单 - 点击菜单跳转链接时的事件推送
                    case TPWechat::EVENT_MENU_VIEW:

                        break;
                    //自定义菜单 - 扫码推事件的事件推送
                    case TPWechat::EVENT_MENU_SCAN_PUSH:

                        break;
                    //自定义菜单 - 扫码推事件且弹出“消息接收中”提示框的事件推送
                    case TPWechat::EVENT_MENU_SCAN_WAITMSG:

                        break;
                    //自定义菜单 - 弹出系统拍照发图的事件推送
                    case TPWechat::EVENT_MENU_PIC_SYS:

                        break;
                    //自定义菜单 - 弹出拍照或者相册发图的事件推送
                    case TPWechat::EVENT_MENU_PIC_PHOTO:

                        break;
                    //自定义菜单 - 弹出微信相册发图器的事件推送
                    case TPWechat::EVENT_MENU_PIC_WEIXIN:

                        break;
                    //自定义菜单 - 弹出地理位置选择器的事件推送
                    case TPWechat::EVENT_MENU_LOCATION:

                        break;
                    //取消关注
                    case TPWechat::EVENT_UNSUBSCRIBE:

                        break;
                    //群发接口完成后推送的结果
                    case TPWechat::EVENT_SEND_MASS:

                        break;
                    //模板消息完成后推送的结果
                    case TPWechat::EVENT_SEND_TEMPLATE:

                        break;
                    default:

                        break;
                }
                break;
            //文本
            case TPWechat::MSGTYPE_TEXT :

                hook('keyword',$params);   //把消息分发到实现了keyword方法的addons中,参数中包含本次用户交互的微信类实例和公众号在系统中id
		        $weObj->reply();           //在addons中处理完业务逻辑，回复消息给用户
                break;
            //图像
            case TPWechat::MSGTYPE_IMAGE :

                break;
            //语音
            case TPWechat::MSGTYPE_VOICE :

                break;
            //视频
            case TPWechat::MSGTYPE_VIDEO :

                break;
            //位置
            case TPWechat::MSGTYPE_LOCATION :

                break;
            //链接
            case TPWechat::MSGTYPE_LINK :

                break;
            default:

                break;
        }

        // 记录日志
        addWeixinLog ( $data, $GLOBALS ['HTTP_RAW_POST_DATA'] );
	}

}