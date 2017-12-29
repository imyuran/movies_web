<?php
namespace app\index\controller;
use think\Controller;
use think\Session;
use think\Db;
use think\Model;
use think\Cache;
use app\common\model\User as UserModel;
class Index extends controller{
    public function _initialize(){
    	parent::_initialize();
    	$this->assign('nav','index');
    	
    }
    /*首页*/
    public function index(){
    	$this->assign('index',2);  
        //获取最新注册的用户名单    
        $new=new UserModel();
        $datas=$new->order('regtime desc')->limit(3)->select();
        // halt($datas);
        $this->assign('newusers',$datas);
        return view();
    }
}