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


        //判断进入用户个人中心是否存在
        if(session('?userid')){
            $uid=session('userid');
            $res=Db::name('user')->where('id',$uid)->find();
            $this->assign('res',$res);
        }
       
        //获取最新注册的用户名单    
        $new=new UserModel();
        $datas=$new->order('regtime desc')->limit(4)->select();
        //获取用户代表作 和 技能标签
        foreach($datas as $key =>$v){
           $uarr=explode('、',$datas[$key]['tech']);
           $datas[$key]['teachs']=$uarr; 
           
        }
    
        $this->assign('datas',$datas);

        //技术交流加载



       
        
        return view();
    }
}