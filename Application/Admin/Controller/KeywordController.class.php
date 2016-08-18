<?php
/**
 * Created by PhpStorm.
 * User: uctoo
 * Date: 14-3-11
 * Time: PM5:41
 */

namespace Admin\Controller;

use Admin\Builder\AdminConfigBuilder;
use Admin\Builder\AdminListBuilder;


class KeywordController extends AdminController
{
    public function config()
    {
        $this->display();
    }

    public function index($page=1,$r=20)
    {
        //读取数据
        $model = D('Common/Keyword');
        $map['uid'] = UID;
        $map['public_id'] = get_token();
        $mp =  D('Mpbase/MemberPublic')->where($map)->find();  //所登陆会员帐号当前管理的公众号
        $kmap['mp_id'] = $mp['id'];
        $list = $model->where($kmap)->page($page, $r)->order('id asc')->select();
        foreach ($list as &$val) {
            $amap['name'] = $val['addon'];
            $val['addon_name'] = M('addons')->where($amap)->getField('title');
        }
        $totalCount = $model->count();
        //显示页面
        $builder = new AdminListBuilder();
        $builder
            ->title('关键词列表')
            ->buttonNew(U('edit'))->button('删除',array('class' => 'btn ajax-post tox-confirm', 'data-confirm' => '您确实要删除关键词吗？', 'url' => U('del'), 'target-form' => 'ids'))
            ->keyId()->keyText('keyword', '关键词')->keyText('addon', '所属插件')->keyText('model', '对应数据表')->keyText('aim_id','插件数据ID')
            ->keyImage('cover', '回复封面图片')->keyText('url', '跳转url', '以http://开头的完整url')->keyDoActionEdit('edit?id=###')->keyDoAction('del?ids=###', '删除')
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();

    }

    /**
     * 删除公众号
     * @param null $ids
     * @author patrick<contact@uctoo.com>
     */
    public function del($ids = null){
        if (!$ids) {
            $this->error('请选择公众号');
        }
        $model =  D('Common/Keyword');
        $res = $model->delete($ids);
        if ($res) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    public function edit($id = null)
    {
        $model = D('Common/Keyword');
        if (IS_POST) {   //提交表单
            $data['mp_id'] = I('post.mp_id', '', 'op_t');
            $data['keyword'] = I('post.keyword', '', 'op_t');
            $data['token'] = I('post.token', '', 'op_t');
            $data['addon'] = I('post.addon', 'CustomReply', 'op_t');   //不指定模块，默认用CustomReply模块
            $data['model'] = I('post.model', '', 'op_t');
            $data['aim_id'] = I('post.aim_id', 1, 'op_t');
            $data['cover'] = I('post.cover', '', 'intval');
            $data['url'] = I('post.url', '', 'op_t');

            if ($id != 0) {
                $data['id'] = $id;
                $res = $model->edit($data);
            } else {
                $res = $model->add($data);
            }
            $this->success(($id == 0 ? '添加' : '编辑') . '成功', $id == 0 ? U('', array('id' => $res)) : '');

        }else{   //显示表单
            //读取关键词信息
            if ($id != 0) {  //编辑
                $keyword = $model->where(array('id' => $id))->find();

            } else {  //新增
                $map['uid'] = UID;
                $map['public_id'] = get_token();
                $mp =  D('Mpbase/MemberPublic')->where($map)->find();
                $keyword = array('mp_id' => $mp['id'],'token' => $map['public_id']);  //
            }

            //显示页面
            $builder = new AdminConfigBuilder();

                $builder->title($id != 0 ? '关键词公众号' : '添加关键词')
                    ->keyId()->keyHidden('mp_id','')->keyText('keyword', '关键词', '关键词不可重复')->keyHidden('token','')
                    ->keyText('addon', '所属插件', '插件标识，一般是英文字符串')->keyText('model', '对应数据表', '关键词索引到的数据表，表名')
                    ->keySingleImage('cover', '封面图', '自定义回复的封面图片')->keyText('url', '跳转url', '以http://开头的完整url')->keyText('aim_id', '插件数据ID', '记录了回复信息的一条数据')->keyUpdateTime('cTime')
                    ->data($keyword)
                    ->buttonSubmit(U('edit'))->buttonBack()
                    ->display();

        }

    }

}
