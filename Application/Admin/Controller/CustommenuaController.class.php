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
use Admin\Builder\AdminTreeListBuilder;

/**
 * 微信自定义菜单配置控制器
 * @author patrick <contact@uctoo.com>
 */
class CustommenuController extends AdminController
{
    protected $model;

    function _initialize()
    {
        $this->model = D('Mpbase/CustomMenu');
        parent::_initialize();
    }

    public function index()
    {

        //显示页面
        $builder = new AdminTreeListBuilder();
        $attr['class'] = 'btn ajax-post';
        $attr['target-form'] = 'ids';

        $tree = D('Mpbase/CustomMenu')->getTree(get_token());
        //dump($tree);
        $builder->title('专辑管理')
            ->buttonNew(U('Custommenu/add'))->keyDoAction('del?id=###','删除')
            ->data($tree)
            ->display();
    }

    public function add($id = 0, $pid = 0)
    {
        if (IS_POST) {
            if ($id != 0) {
                $cm = $this->model->create();
                if ($this->model->save($cm)) {

                    $this->success('编辑成功。');
                } else {
                    $this->error('编辑失败。');
                }
            } else {
                $cm = $this->model->create();
                if ($this->model->add($cm)) {

                    $this->success('新增成功。');
                } else {
                    $this->error('新增失败。');
                }
            }


        } else {
            $builder = new AdminConfigBuilder();
            $cms = $this->model->select();
            $opt = array();
            foreach ($cms as $cm) {
                $opt[$cm['id']] = $cm['title'];
            }
            if ($id != 0) {
                $cm = $this->model->find($id);
            } else {
                $cm = array('pid' => $pid, 'status' => 1, 'token'=> get_token());
            }


            $builder->title('新增分类')->keyId()->keyText('title', '标题')->keySelect('pid', '父分类', '选择父级分类', array('0' => '顶级分类')+$opt)
                ->keyStatus()->keySelect('type','类型','请选择类型',$this->model->getCmType())->keyText('keyword', '关联关键词')->keyText('url', '关联url')
                ->keyHidden('token','公众号ID','所属公众号AppID')
                ->data($cm)
                ->buttonSubmit(U('Custommenu/add'))->buttonBack()->display();
        }

    }

    public function operate($type = 'move', $from = 0)
    {
        $builder = new AdminConfigBuilder();
        $from = D('Mpbase/CustomMenu')->find($from);

        $opt = array();
        $cms = $this->model->select();
        foreach ($cms as $cm) {
            $opt[$cm['id']] = $cm['title'];
        }
        if ($type === 'move') {

            $builder->title('移动分类')->keyId()->keySelect('pid', '父分类', '选择父分类', $opt)->buttonSubmit(U('Custommenu/add'))->buttonBack()->data($from)->display();
        } else {

            $builder->title('合并分类')->keyId()->keySelect('toid', '合并至的分类', '选择合并至的分类', $opt)->buttonSubmit(U('Custommenu/doMerge'))->buttonBack()->data($from)->display();
        }

    }

    public function doMerge($id, $toid)
    {
        $effect_count=D('Custommenu')->where(array('pid'=>$id))->setField('pid',$toid);
        $this->success('合并分类成功。共影响了'.$effect_count.'个内容。',U('index'));
        //TODO 实现合并功能
    }

}
