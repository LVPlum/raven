<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;


/**
 * 前台首页控制器
 * 主要获取首页聚合数据
 */
class Index1Controller extends HomeController
{

    //系统首页
    public function index()
       {
           hook('homeIndex');
           $default_url = C('DEFUALT_HOME_URL');//获得配置，如果为空则显示聚合，否则跳转
           if ($default_url != '') {
               redirect(get_nav_url($default_url));
           }
           $id=session('temp_login_uid');
           $this->assign("id",$id);
           $this->assign("userinfo",cookie('OX_LOGGED_USER'));
           $this->display();
       }

    function help() {
        if (empty ( $_GET ['id'] )) {
            $this->error ( '公众号参数非法' );
        }
        $this->display ( );
    }

    //加入我们
    public function joinus()
    {

        $this->display();
    }
    //预约
    public function appointment()
    {

        $this->display();
    }

    public function tools()
    {

        $this->display();
    }

    public function office()
    {

        $this->display();
    }

    public function investor()
    {

        $this->display();
    }


    public function produce()
    {

        $this->display();
    }

    public function consult()
    {

        $this->display();
    }

    public function hasinvest()
    {

        $this->display();
    }
    //预约来访表单提交
    public function vistBookingInsert()
    {

        $VistBooking  =   D('vistbooking');
        if($VistBooking->create()) {
            $result =   $VistBooking->add();
            if($result) {
                $this->success('数据添加成功！');
            }else{
                $this->error('数据添加错误！');
            }
        }else{
            $this->error($VistBooking->getError());
        }
    }
    public function verify(){
        $Verify = new \Think\Verify();
        $Verify->imageW=250;
        $Verify->imageH=50;
        $Verify->entry(2);
    }
    function check_verify($code, $id = ''){
        $verify = new \Think\Verify();
        return $verify->check($code, $id);
    }
    public function route($url){
            $this->display($url);
        }
}