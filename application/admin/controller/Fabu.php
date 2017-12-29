<?php
namespace app\admin\controller;
use think\Controller;
use think\Session;
use think\Db;
use think\Model;
use think\Cache;
use think\Request;


//后台发布模块
class Fabu extends controller
{
	public function index()
	{
		$data=Db::name('fabu')->order('add_ts desc')->select();

		$count=Db::name('fabu')->count();
		$this->assign('data',$data);
		$this->assign('count',$count);
		return view();
	}

	public function del()
	{
		$id=input('post.id');
		$res=Db::name('fabu')->where('id',$id)->delete();
		if($res){
			return json(array('code'=>200,'msg'=>'success'));
		}else{
			return json(array('code'=>400,'msg'=>'fail'));
		}
	}

	public function put()
	{
		$id=input('get.id');
		$is_open=Db::name('fabu')->where('id',$id)->find();
	
		if($is_open['status'] == 1){
			$open=Db::name('fabu')->where('id',$id)->update(['status'=>2]);
			if($open){
				return json(array('code'=>200,'msg'=>'success'));
			}else{
				return json(array('code'=>400,'msg'=>'fail'));
			}
		}else{
			$open=Db::name('fabu')->where('id',$id)->update(['status'=>1]);
			if($open){
				return json(array('code'=>200,'msg'=>'success'));
			}else{
				return json(array('code'=>400,'msg'=>'fail'));
			}
		}
		
	}

}