<?php
namespace Home\Model;
use Think\Model;
class IndexModel extends Model {
    // �����Զ���֤
    protected $_validate    =   array(
        array('title','require','�������'),
    );
    // �����Զ����
    protected $_auto    =   array(
        array('create_time','time',1,'function'),
    );
}