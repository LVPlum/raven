<?php
/**
 * Ucenter模型   todo:这个model类成了proxy，有空了给它重构成模型分层的Service吧 uctoo 20150326
 * @author 缘境 <yvsm@vducn.com>
 * @date 2014-12-24
 */
namespace Common\Model;
class UcenterModel {
    public function test(){
        return time();
    }

    /**
     * 用户登录认证
     * @param  string  $username 用户名/邮箱/手机
     * @param  string  $password 用户密码
     * @return integer           登录成功-用户ID，登录失败-错误编号
     */
    public function uc_user_login($username, $password,$type=false){
        $uc = new \Ucenter\Client\Client();
        if($type==false){
            if(is_email($username)){
                $type=2;
            }elseif(is_phone($username)){
                $type=3;
            }else{
                $type=0;
            }
        }
        $re = $uc->__call('uc_user_login',array('username'=>$username,'password'=>$password,'isuid'=>$type));
        return $re;
    }

    /**
     * 用户注册
     */
    public function uc_user_register($username, $password, $email, $questionid = '', $answer = '', $regip = ''){
        $uc = new \Ucenter\Client\Client();
        $params['username'] = $username;
        $params['password'] = $password;
        $params['email'] = $email;
        $params['questionid'] = $questionid;
        $params['answer'] = $answer;
        $params['regip'] = $regip;
        $re = $uc->__call('uc_user_register',$params);
        return $re;
    }

    /* 获取用户数据 */
    public function uc_get_user($username,$isuid=0){
        $uc = new \Ucenter\Client\Client();
        $data = $uc->__call('uc_get_user',array('username'=>$username,'isuid'=>$isuid));
        return $data;
    }

    /* 更新用户资料 */
    public function uc_user_edit($username,$oldpw,$newpw,$email,$ignoreoldpw,$questionid,$answer){
        if(is_array($username))extract($username);
        $uc = new \Ucenter\Client\Client();
        $params['username'] = $username;
        $params['oldpw'] = $oldpw;
        $params['newpw'] = $newpw;
        $params['email'] = $email;
        $params['ignoreoldpw'] = $ignoreoldpw;
        $params['questionid'] = $questionid;
        $params['answer'] = $answer;
        $data = $uc->__call('uc_user_edit',$params);
        return $data;
    }


    //登陆错误代码
    function showLoginError($code = 0){
        switch ($code) {
            case -1:  $error = '用户不存在，或者被删除'; break;
            case -2:  $error = '密码错误'; break;
            default:  $error = $code;
        }
        return $error;
    }

    //注册错误代码
    function showRegError($code = 0){
        switch ($code) {
            case -1:  $error = '用户不存在，或者被删除'; break;
            case -2:  $error = '包含不允许注册的词语'; break;
            case -3:  $error = '用户名已经存在'; break;
            case -4:  $error = '该 Email 格式有误'; break;
            case -5:  $error = '该 Email 不允许注册'; break;
            case -6:  $error = '该 Email 已经被注册'; break;
            case -7:  $error = '手机号码格式错误'; break;
            case -8:  $error = '该手机号码已经被注册'; break;
            default:  $error = $code;
        }
        return $error;
    }

    //更新用户资料错误代码
    function showEditError($code = 0){
        switch ($code) {
            case 0:  $error = '没有做任何修改'; break;
            case -1:  $error = '旧密码不正确'; break;
            case -4:  $error = 'Email 格式有误'; break;
            case -5:  $error = 'Email 不允许注册'; break;
            case -6:  $error = '该 Email 已经被注册'; break;
            case -7:  $error = '没有做任何修改'; break;
            case -8:  $error = '该用户受保护无权限更改'; break;
            default:  $error = $code;
        }
        return $error;
    }

    //同步登录
    function uc_user_synlogin($uid){
        $uc = new \Ucenter\Client\Client();
        return $uc->__call('uc_user_synlogin',array('uid'=>$uid));
    }

    //同步退出
    function uc_user_synlogout(){
        $uc = new \Ucenter\Client\Client();
        return $uc->__call('uc_user_synlogout',array());
    }
}