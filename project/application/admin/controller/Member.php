<?php 
namespace app\admin\controller;
use think\Controller;
use think\Session;
use think\Db;
use think\Model;
use think\Cache;
use think\Request;



//会员模块
class Member extends Controller
{
	public function index()
	{
		$data=Db::query('select * from wd_user');
		$this->assign('data',$data);
		return view();
	}


	public function add()
	{
		return view();
	}
}