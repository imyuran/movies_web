<?php
namespace app\admin\controller;
use think\Controller;
use think\Session;
use think\Db;
use think\Model;
use think\Cache;
use think\Request;


//后台管理员模块
class Admin extends controller
{
   
    public function index()
    {
    	$data=Db::query('select * from wd_admin_user');
        $count=Db::query('select count(id) from wd_admin_user');
        $this->assign('count',$count);
        $this->assign('data',$data); 	
        return view();
    }


    //添加        
    public function add(Request $request)
    {   
      if($request->isPost()){
        // return 111;
        $data=input('post.');
        $query=Db::table('wd_admin_user');
        $user=$query->where('username',$data['username'])->find();
        if($user){
            return json(array('msg'=>'管理员已存在','code'=>100));
        }
 
       $datas=[
            'username'=>$data['username'],
            'password'=>md5($data['password']),
            'create_time'=>$data['create_time'],
        ];
        
        $res=Db::name('admin_user')->insert($datas);   
        // return $res;
        if($res){
            return json(array('msg'=>'添加成功','code'=>200));
        }else{
            return json(array('msg'=>'添加失败','code'=>0));
        }
      }
        return view();
    }

    //测试
   public function test(){
        
      $data=[
        'lastword'=>'aaaa',
        'password'=>'qqqq',
        'password2'=>'qqqq',
        'user_id'=>62
      ];

      $count=Db::query('select count(id) from wd_admin_user');

   }

   //删除
   public function del(Request $request)
   {
        if($request->isPost()){
            $data=input('get.');
            $query=Db::table('wd_admin_user');
            $res=$query->where('id',$data['id'])->delete();   //真删除
            // $res=$query->update('status',0)->where('id',$data['id']);  //伪删除
            if($res){
                return json(array('msg'=>'删除成功','code'=>200));
            }else{
                return json(array('msg'=>'删除失败','code'=>0));
            }
        }
   }

   //修改
   public function edit(Request $request)
   {  
       if($request->isGet()){
            $id=input('get.id');
            $this->assign('id',$id);
       }    
       
        return view();
   }

   public function check(Request $request)
   {
        if($request->isPost()){
            $data=input('post.');

            $datas=Db::name('admin_user')->where('id',$data['user_id'])->find();

            if($datas['password']==md5($data['lastword'])){
                $res=Db::name('admin_user')->where('id',$data['user_id'])->update(['password'=>md5($data['password'])]);
                if($res){
                    return json(array('msg'=>'修改成功','code'=>200));
                }else{
                   return json(array('msg'=>'修改失败','code'=>0));
                }
            }else{
                return json(array('msg'=>'管理员密码错误','code'=>100));
            }

        }
   }


   //启用与禁用
   public function start(Request $request)
   {
        if($request->isPost()){
            $id=input('get.id');

            $status=Db::name('admin_user')->field('status')->where('id',$id)->find();
             
            if($status['status'] == 1){
                $res=Db::name('admin_user')->where('id',$id)->update(['status'=>0]);

                if($res){
                    return json(array('msg'=>'已停用','code'=>200));
                }else{
                    return json(array('msg'=>'停用失败，请联系超管！','code'=>0));
                }
            }else{
                $res=Db::name('admin_user')->where('id',$id)->update(['status'=>1]);
                if($res){
                    return json(array('msg'=>'已启用','code'=>200));
                }else{
                    return json(array('msg'=>'启用失败，请联系超管！','code'=>0));
                }
            }
        }
   }


}