<?php
namespace app\admin\controller;
use think\Controller;
use think\Session;
use think\Db;
use think\Model;
use think\Cache;
use think\Request;
 class Login extends Controller{
        public function login(Request $request){
      		if($request->isPost()){
      			$data=input('post.');
      			$ip = $_SERVER["REMOTE_ADDR"];
				$res=Db::name('admin_user')->where('username',$data['username'])->find();

				if($res){
					if(md5($data['password']) == $res['password']){
						return json(array('msg'=>'登录成功','code'=>200));
					}else{
						return json(array('msg'=>'用户名或者密码错误','code'=>0));
					}
				}else{
					return json(array('msg'=>'用户名或者密码错误','code'=>0));
				}
      		
      		}else{
      			return view();
      		}
            
        }
    }
 
