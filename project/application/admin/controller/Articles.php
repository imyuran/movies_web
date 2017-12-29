<?php
namespace app\admin\controller;
use think\Controller;
use think\Session;
use think\Db;
use think\Model;
use think\Cache;
use think\Request;



class Articles extends controller
{

	/********************文章管理模块***************/
	public function index()
	{
		$list=Db::name('forum')->select();
		$lists=Db::name('forum')->count();
		foreach($list as $key =>$v){
			$user=Db::name('user')->where('id',$list[$key]['uid'])->find();
			$list[$key]['username']=$user['username'];
			$list[$key]['time']=date('Y-m-d H:i:s',$list[$key]['time']);			
		}
		$this->assign('list',$list);
		$this->assign('count',$lists);
		return view();
	}

	public function fabu()
	{
		$id=input('get.id');
		$is_open=Db::name('forum')->where('id',$id)->find();
	
		if($is_open['open'] == 1){
			$open=Db::name('forum')->where('id',$id)->update(['open'=>0]);
			if($open){
				return json(array('code'=>200,'msg'=>'success'));
			}else{
				return json(array('code'=>400,'msg'=>'fail'));
			}
		}else{
			$open=Db::name('forum')->where('id',$id)->update(['open'=>1]);
			if($open){
				return json(array('code'=>200,'msg'=>'success'));
			}else{
				return json(array('code'=>400,'msg'=>'fail'));
			}
		}
		
	}

	public function del()
	{
		$id=input('post.id');
		$res=Db::name('forum')->where('id',$id)->delete();
		if($res){
			return json(array('code'=>200,'msg'=>'success'));
		}else{
				return json(array('code'=>400,'msg'=>'fail'));
		}
	}


	public function detail()
	{
		$id=input('get.id');
		$res=Db::name('forum')->where('id',$id)->find();
		$user=Db::name('user')->where('id',$res['uid'])->find();
		$this->assign('user',$user);
		$this->assign('res',$res);
		return view();
	}

	/************************视频管理**************************/
	public function film()
	{
		$list=Db::name('makecon')->select();
		$lists=Db::name('makecon')->count();
		foreach($list as $key =>$v){
			$user=Db::name('user')->where('id',$list[$key]['uid'])->find();
			$list[$key]['username']=$user['username'];			
		}
		$this->assign('list',$list);
		$this->assign('count',$lists);
		return view();
	}


	public function film_fabu()
	{
		$id=input('get.id');
		$is_open=Db::name('makecon')->where('id',$id)->find();
	
		if($is_open['pstatus'] == 1){
			$open=Db::name('makecon')->where('id',$id)->update(['pstatus'=>2]);
			if($open){
				return json(array('code'=>200,'msg'=>'success'));
			}else{
				return json(array('code'=>400,'msg'=>'fail'));
			}
		}else{
			$open=Db::name('makecon')->where('id',$id)->update(['pstatus'=>1]);
			if($open){
				return json(array('code'=>200,'msg'=>'success'));
			}else{
				return json(array('code'=>400,'msg'=>'fail'));
			}
		}
		
	}

	public function film_del()
	{
		$id=input('post.id');
		$res=Db::name('makecon')->where('id',$id)->delete();
		if($res){
			return json(array('code'=>200,'msg'=>'success'));
		}else{
			return json(array('code'=>400,'msg'=>'fail'));
		}
	}

}