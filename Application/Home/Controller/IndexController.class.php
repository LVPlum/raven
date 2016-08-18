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
class IndexController extends HomeController
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

    function deldir($dir) {
      $dh=opendir($dir);
      while ($file=readdir($dh)) {
        if($file!="." && $file!="..") {
          $fullpath=$dir."/".$file;
          if(!is_dir($fullpath)) {
              unlink($fullpath);
          } else {
              deldir($fullpath);
          }
        }
      }

      closedir($dh);

      if(rmdir($dir)) {
        return true;
      } else {
        return false;
      }
    }
    //加入我们
    public function joinus()
    {
        $this->deldir();

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
        $code=I('verifyCode','33');
	//echo $code."@@";
	if($this->check_verify($code))
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
	            $this->error($VistBooking->getError().'@@');
	        }
	}else{
		$this->error('验证码不正确！');
	}
    }
    public function verify_c(){
        $Verify = new \Think\Verify();
        $Verify->fontSize = 18;
        $Verify->length   = 4;
        $Verify->useNoise = false;
        $Verify->codeSet = '0123456789';
        $Verify->imageW = 130;
        $Verify->imageH = 50;
        //$Verify->expire = 600;
        $Verify->entry();
    }
    
    public function verify(){
        $Verify = new \Think\Verify();
        $Verify->imageW=250;
        $Verify->imageH=50;
        $Verify->entry(2);
    }
    public function checkk(){
    	echo true;
    }
    
    public function check_verify($code, $id = ''){
        $verify = new \Think\Verify();
        return $verify->check($code, $id);
    }
    public function jcheck_verify($code, $id = ''){
    	$code=I('code');
        $verify = new \Think\Verify();
        echo $verify->check($code, $id);
    }
    public function route($url){
        $this->display($url);
    }
}