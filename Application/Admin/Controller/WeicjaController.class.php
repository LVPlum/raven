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


class WeicjaController extends AdminController
{
    public function config()
    {
        $this->display();
    }

    public function index($page=1,$r=20)
    {
        //读取数据
        $model = D('Weicj');
        $map['mp_id'] = get_mpid();
        $list = $model->where($map)->page($page, $r)->order('id asc')->select();
        foreach ($list as &$val) {

        }
        $url = $list['url'];
        $totalCount = $model->count();
        //显示页面
        $builder = new AdminListBuilder();
        $builder
            ->title('微场景列表')
            ->buttonNew(U('edit'))->button('删除',array('class' => 'btn ajax-post tox-confirm', 'data-confirm' => '您确实要删除关键词吗？', 'url' => U('del'), 'target-form' => 'ids'))
            ->keyId()->keyText('title', '标题')->keyText('intro', '简介')->keyText('cjurl', '跳转url')
            ->keyDoAction('preview?id=###', '预览')->keyDoActionEdit('edit?id=###')->keyDoAction('del?ids=###', '删除')
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();

    }

    /**
     * 删除微场景
     * @param null $ids
     * @author patrick<contact@uctoo.com>
     */
    public function del($ids = null){
        if (!$ids) {
            $this->error('请选择数据');
        }
        $model =  D('Weicj');
        $res = $model->delete($ids);
        if ($res) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 预览微场景
     * @param null $id
     * @author patrick<contact@uctoo.com>
     */
    public function preview($id = null){
        if (!$id) {
            $this->error('请选择数据');
        }
        $model =  D('Weicj');
        $res = $model->find($id);
        if ($res) {
            redirect($res['url']);
        } else {
            $this->error('预览失败');
        }
    }

    public function edit($id = null)
    {
        $model = D('Weicj');
        if (IS_POST) {   //提交表单
            $data['mp_id'] = I('post.mp_id', '', 'op_t');
            $data['url'] = I('post.url', '', 'op_t');
            $data['title'] = I('post.title', '', 'op_t');
            $data['intro'] = I('post.intro', '', 'op_t');
            $data['cover'] = I('post.cover', '', 'intval');   //不指定模块，默认用CustomReply模块
            $data['pic1'] = I('post.pic1', '', 'intval');
            $data['pic2'] = I('post.pic2', '', 'intval');
            $data['pic3'] = I('post.pic3', '', 'intval');
            $data['pic4'] = I('post.pic4', '', 'intval');
            $data['pic5'] = I('post.pic5', '', 'intval');
            $data['pic6'] = I('post.pic6', '', 'intval');
            $data['clickpic'] = I('post.clickpic', '', 'intval');
            $data['andio'] = I('post.andio', '', 'intval');
            $data['cjurl'] = I('post.cjurl', 1, 'op_t');
            $data['audio2'] = I('post.audio2', 1, 'op_t');

            if ($id != 0) {
                $data['id'] = $id;
                $data['url'] = "http://".$_SERVER ['HTTP_HOST'].addons_url ( 'Weicj://Weicj/index',array('id'=>$id,'mp_id'=> $data['mp_id']) ); //分享链接里一定加mp_id
                $data['url'] = str_replace("/admin/addon", "/home/addon", $data['url']);   //哎呀，管理类中生成的url得替换成前台的，好麻烦
                $res = $model->save($data);
            } else {
                $res = $model->add($data);
                if($res){             //新增成功，追加修改一下url字段数据
                    $data['id'] = $res;
                    $data['url'] = "http://".$_SERVER ['HTTP_HOST'].addons_url ( 'Weicj://Weicj/index',array('id'=>$res,'mp_id'=> $data['mp_id']) );  //分享链接里一定加mp_id
                    $data['url'] = str_replace("/admin/addon", "/home/addon", $data['url']);   //哎呀，管理类中生成的url得替换成前台的，好麻烦
                    $res = $model->save($data);
                }
            }
            $this->success(($id == 0 ? '添加' : '编辑') . '成功', $id == 0 ? U('', array('id' => $res)) : '');

        }else{   //显示表单
            //读取微场景信息
            if ($id != 0) {  //编辑
                $weicj = $model->where(array('id' => $id))->find();

            } else {  //新增初始化数据
                $weicj = array('mp_id' => get_mpid());  //
            }

            //显示页面
            $builder = new AdminConfigBuilder();

                $builder->title($id != 0 ? '编辑微场景' : '添加微场景')
                    ->keyId()->keyHidden('mp_id','')->keyHidden('url','')
                    ->keyText('title', '标题', '自定义回复的标题')->keyText('intro', '描述', '自定义回复的描述')
                    ->keySingleImage('cover', '封面图', '自定义回复的封面图片')
                    ->keySingleImage('pic1', '场景1', '微场景图片1')->keySingleImage('pic2', '场景2', '微场景图片2')
                    ->keySingleImage('pic3', '场景3', '微场景图片3')->keySingleImage('pic4', '场景4', '微场景图片4')
                    ->keySingleImage('pic5', '场景5', '微场景图片5')->keySingleImage('pic6', '场景6', '微场景图片6')
                    ->keySingleImage('clickpic', '跳转图片', '跳转场景图片或按钮')->keyText('cjurl', '跳转网址', '跳转网址必须以http://开头')
                    ->keyText('audio2', '背景音乐网址', '网址必须以http://开头，仅支持mp3格式')
                    ->data($weicj)
                    ->buttonSubmit(U('edit'))->buttonBack()
                    ->display();

        }

    }

}
