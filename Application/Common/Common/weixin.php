<?php
/**
 * Created by PhpStorm.
 * User: uctoo
 * Date: 15-4-7
 * Time: 上午11:26
 * @author:patrick admin@uctoo.com
 */

function addWeixinLog($data, $data_post = '') {
    $log ['cTime'] = time ();
    $log ['cTime_format'] = date ( 'Y-m-d H:i:s', $log ['cTime'] );
    $log ['data'] = is_array ( $data ) ? serialize ( $data ) : $data;
    $log ['data_post'] = is_array ( $data_post ) ? serialize ( $data_post ) : $data_post;
    M ( 'weixin_log' )->add ( $log );
}

// 获取当前用户的Token
function get_token($token = NULL) {
    if ($token !== NULL) {
        session ( 'token', $token );
    } elseif (! empty ( $_REQUEST ['token'] )) {
        session ( 'token', $_REQUEST ['token'] );
    }
    $token = session ( 'token' );
    if (empty ( $token )) {
        $token = session('user_auth.token');
    }
    if (empty ( $token )) {
        return - 1;
    }

    return $token;
}

// 获取公众号的信息   TODO:有bug隐患，存在不同管理员在系统中添加了相同公众号的情况
function get_token_appinfo($token = '') {
    empty ( $token ) && $token = get_token ();
    $map ['public_id'] = $token;
    $info = M ( 'member_public' )->where ( $map )->find ();
    return $info;
}

function get_mpid_appinfo($mp_id = '') {
    empty ( $mp_id ) && $mp_id = get_mpid ();
    $map ['id'] = $mp_id;
    $info = M ( 'member_public' )->where ( $map )->find ();
    return $info;
}
// 获取公众号的信息
function get_token_appname($token = '') {
    empty ( $token ) && $token = get_token ();
    $map ['public_id'] = $token;
    $info = M ( 'member_public' )->where ( $map )->find ();
    return $info['public_name'];
}

// 判断是否是在微信浏览器里
function isWeixinBrowser() {
    $agent = $_SERVER ['HTTP_USER_AGENT'];
    if (! strpos ( $agent, "icroMessenger" )) {
        return false;
    }
    return true;
}

// php获取当前访问的完整url地址
function GetCurUrl() {
    $url = 'http://';
    if (isset ( $_SERVER ['HTTPS'] ) && $_SERVER ['HTTPS'] == 'on') {
        $url = 'https://';
    }
    if ($_SERVER ['SERVER_PORT'] != '80') {
        $url .= $_SERVER ['HTTP_HOST'] . ':' . $_SERVER ['SERVER_PORT'] . $_SERVER ['REQUEST_URI'];
    } else {
        $url .= $_SERVER ['HTTP_HOST'] . $_SERVER ['REQUEST_URI'];
    }
    // 兼容后面的参数组装
    if (stripos ( $url, '?' ) === false) {
        $url .= '?t=' . time ();
    }
    return $url;
}
// 获取当前用户的OpenId
function get_openid($openid = NULL) {
    $mp_id = get_mpid ();
    if ($openid !== NULL) {
        session ( 'openid_' . $mp_id, $openid );
    } elseif (! empty ( $_REQUEST ['openid'] )) {
        session ( 'openid_' . $mp_id, $_REQUEST ['openid'] );
    }
    $openid = session ( 'openid_' . $mp_id );

    $isWeixinBrowser = isWeixinBrowser ();
    //下面这段应该逻辑没问题，如果公众号配置信息错误或者没有snsapi_base作用域的获取信息权限可能会出现死循环，注释掉以下if可治愈
    if ( $openid <= 0 && $isWeixinBrowser) {

        $callback = GetCurUrl ();
       // OAuthWeixin ( $callback );
        $info = get_mpid_appinfo ();

        $options['token'] = APP_TOKEN;
        $options['appid'] = $info['appid'];    //初始化options信息
        $options['appsecret'] = $info['secret'];
        $options['encodingaeskey'] = $info['encodingaeskey'];
        $auth = new Com\Wxauth($options);
        $openid =  $auth->open_id;
        session ( 'wxuser_' . $mp_id.$openid, $auth->wxuser );     //wxauth获得的微信用户信息存到session中

    }

    if (empty ( $openid )) {
        return - 1;
    }

    return $openid;
}

//没有用到这个函数，请使用wxauth类
function OAuthWeixin($callback) {
    $isWeixinBrowser = isWeixinBrowser ();
    $info = get_mpid_appinfo ();

    if (! $isWeixinBrowser || $info ['type'] != 2 || empty ( $info ['appid'] )) {
        redirect ( $callback . '&openid=-1' );
    }
    $param ['appid'] = $info ['appid'];

    if (! isset ( $_GET ['getOpenId'] )) {
        $param ['redirect_uri'] = $callback . '&getOpenId=1';
        $param ['response_type'] = 'code';
        $param ['scope'] = 'snsapi_base';
        $param ['state'] = 123;
        $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?' . http_build_query ( $param ) . '#wechat_redirect';
        redirect ( $url );
    } elseif ($_GET ['state']) {
        $param ['secret'] = $info ['secret'];
        $param ['code'] = I ( 'code' );
        $param ['grant_type'] = 'authorization_code';

        $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?' . http_build_query ( $param );
        $content = file_get_contents ( $url );
        $content = json_decode ( $content, true );

        redirect ( $callback . '&openid=' . $content ['openid'] );
    }
}

// 获取当前上下文的公众号id
function get_mpid($mp_id = NULL) {
    if ($mp_id !== NULL) {
        session ( 'mp_id', $mp_id );
    } elseif (! empty ( $_REQUEST ['mp_id'] )) {
        session ( 'mp_id', $_REQUEST ['mp_id'] );
    }
    $mp_id = session ( 'mp_id' );
    if (empty ( $mp_id )) {
        $mp_id = session('user_auth.mp_id');
    }
    if (empty ( $mp_id )) {
        $map['uid'] = is_login();
        $map['public_id'] = get_token();
        $mp =  D('Mpbase/MemberPublic')->where($map)->find();  //所登陆会员帐号当前管理的公众号
        $mp_id = $mp['id'];
    }
    if (empty ( $mp_id )) {
        return - 1;
    }

    return $mp_id;
}


//根据uid获取粉丝用户信息
function get_uid_ucuser($uid = 0) {
  $model = D('Ucuser');
  $user = $model->find($uid);
  return $user;
}

// 获取当前粉丝用户uid,和 hook('init_ucuser',$params)作用基本相同。
function get_ucuser_uid($uid = 0) {
    $mp_id = get_mpid ();
    if ($uid !== NULL) {
        session ( 'uid_' . $mp_id, $uid );
    } elseif (! empty ( $_REQUEST ['uid'] )) {
        session ( 'uid_' . $mp_id, $_REQUEST ['uid'] );
    }                                                                    //以上是带uid参数调用函数时设置session中的uid
    $uid = session ( 'uid_' . $mp_id );

    $isWeixinBrowser = isWeixinBrowser ();
    //下面这段应该逻辑没问题，如果公众号配置信息错误或者没有snsapi_base作用域的获取信息权限可能会出现死循环，注释掉以下if可治愈
    if ( $uid <= 0 && $isWeixinBrowser) {
        $map['openid'] = get_openid();
        $map['mp_id'] = $mp_id;
        $ucuser = D('Ucuser');
        $data = $ucuser->where($map)->find();
        if(!$data){                                                 //公众号没有这个粉丝信息，就注册一个
                                                                 //先在Member表注册会员，使系统中uid统一，公众号粉丝在绑定手机后可登录网站
           
            //先在Member表注册会员，使系统中uid统一，公众号粉丝在绑定手机后可登录网站
            $aUsername = $aNickname = $map['openid'];           //以openid作为默认UcenterMember用户名和Member昵称
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
            session ( 'uid_' . $mp_id, $uid );

        }else{
            $uid =  $data['uid'];
            session ( 'uid_' . $mp_id, $uid );
        }
    }
    if (empty ( $uid )) {
        return - 1;
    }

    return $uid;
}

// 同步微信用户资料到本地存储。
function sync_wxuser($mp_id, $openid) {
    $model = D('Ucuser');
    $map['mp_id'] = $mp_id;
    $map['openid'] = $openid;
    $wxuser = session ( 'wxuser_' . $mp_id.$openid );
    if(!empty($wxuser['openid'])){         //通过oauth获取到过粉丝信息
        $user = $model->where($map)->find();
        if($user['status'] != 2){           //没有同步过粉丝信息
            $user = array_merge($user ,$wxuser);
            $user['status'] = 2;
            $model->save($user);
        }
        return $user;
    }

    return false;
}

//获取分享url的方法，解决controler在鉴权时二次回调jssdk获取分享url错误的问题
function get_shareurl(){
    $url = 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
    $findme   = 'https://open.weixin.qq.com/';
    $pos = strpos($url, $findme);
    // 使用 !== 操作符。使用 != 不能像我们期待的那样工作，
    // 因为 'a' 的位置是 0。语句 (0 != false) 的结果是 false。
    $share_url = '';
    if ($pos !== false) {             //url是微信的回调授权地址
        return '';
    } else {                           //url是本地的分享地址
        return $url;
    }
}