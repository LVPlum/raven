<?php
/**
 * Created by PhpStorm.
 * User: uctoo
 * Date: 15-5-5
 * Time: PM5:20
 */

namespace Admin\Controller;

use Admin\Builder\AdminConfigBuilder;
use Admin\Builder\AdminListBuilder;
use Admin\Builder\AdminTreeListBuilder;


class UcuserController extends AdminController
{

    public function index($page=1,$r=20)
    {
        //读取数据
        $model = D('Common/Ucuser');
        $map['status'] = array('EGT', 0);
        $map['mp_id'] = get_mpid();

        $list = $model->where($map)->page($page, $r)->order('uid asc')->select();
        int_to_string($list);  //设置status
        foreach ($list as &$val) {
            $val['sex'] = $model->getSex($val['sex']);
        }
        $totalCount = $model->count();
        //显示页面
        $builder = new AdminListBuilder();
        $builder
            ->title('用户列表')
            ->keyText('uid', 'uid')->keyText('openid', 'openid')->keyText('nickname', '昵称')->keyText('sex', '性别')->keyText('province','省份')->keyText('city','城市')->keyText('score1','积分')
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();

    }

}
