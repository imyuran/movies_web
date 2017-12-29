<?php
namespace app\index\controller;
use org\Http;
use think\Controller;
use think\Session;
use think\Db;
use think\Config;
use think\Model;
use think\Cache;
use think\captcha\Captcha;
use app\common\model\Upload as UploadModel;
use app\common\model\Forum as ForumModel;
use app\common\model\Comment as CommentModel;
use app\common\model\User as UserModel;
use app\common\model\Love as LoveModel;
use app\common\model\Connect as ConnectModel;
use app\common\model\Makecon as MakeconModel;
class Forum extends Controller{
    public function _initialize(){
    	parent::_initialize();
    	$this->assign('nav','forum'); 
    	 $user=new UserModel();
    	if(session('?userid')){
        $ud=session('userid');
    		$userone=$user->where('id',$ud)->find();
    	  $this->assign('userone',$userone);
       
    	}
    }    

    /*详情*/
     function detail(){
      $this->assign('nav','lists'); 
      //文章id
      $id=input('get.id');
      $forum = new ForumModel();
      $user=new UserModel();

      //获取发布文章信息
      $cone=$forum->find($id);
      
      $this->assign('cone',$cone);
      /*发布文章用户信息*/
      $userones=$user->find($cone['uid']);
    
      $this->assign('userones',$userones);
      
      $member = new CommentModel();
      if (request()->isPost()) { 
       $data = input('post.');
       if($data['tid']){
          $tid=$data['tid'];
       }else{
           $tid=0;
       }
       if(intval($data['mid'])){
          $mid=$data['mid'];
       }else{
           $mid=0;
       }
       if($data['cid']){
          $cid=$data['cid'];
       }else{
           $cid=0;
       }
       
       if(!$data['comments']){
        return json(array('code' => 0, 'msg' => '内容不能为空'));
       }
       $member->uid=session('userid');
       $member->tid=$tid;
       $member->fid=$cid;
       $member->mid=$mid;
       $member->content=$data['comments'];
       $member->reply=0;
       $member->praise=0;
        $member->time=time();   
       $member->save();
       if($member->id){
          return json(array('code' => 200, 'msg' => '评论成功'));
       }else{
          return json(array('code' => 0, 'msg' => '评论失败'));
       }
    }
    
      $page=input('get.page','');
        if($page=='all'){
          $commentval=$member->where('fid='.$id.' and tid=0')->order('time desc')->select();
        }else{
          $commentval=$member->where('fid='.$id.' and tid=0')->order('time desc')->limit(6)->select();
        }
    
    if($commentval){
      foreach($commentval as $key=>$val){
        $userval=$user->find($val['uid']);
        $val['uname']=$userval['username'];
        $val['uhead']=$userval['userhead'];
        $cnums=$member->where('tid='.$val['id'])->count();
        $val['cnums']=$cnums;
      }
    }
  
    $this->assign('commentval',$commentval);
    /*评论的数量*/
    $count=$member->where('fid='.$id)->count();
    $num=$member->where('fid='.$id.' and tid=0')->count();
    $this->assign('commentnum',$count);
    $this->assign('connum',$num);
    /*喜欢*/
    $love=new LoveModel();
    $lmap['cid']=$id;
    $lnums=$love->where($lmap)->count();
    $this->assign('lnums',$lnums);


    //判断用户是否关注
    if(session('?userid')){
      $lmap['uid']=session('userid');

      //获取登录用户id  
      $uids=session('userid');

      $res1=Db::name('connect')->where('userobj',$uids)->select(); 
      foreach($res1 as $k=>$v){
         if($userones['id'] ==  $v['usered']){
            $res=1;
            $this->assign('res',$res);
         }      
      }

      $lone=$love->where($lmap)->count(); 

      if($lone){
        $this->assign('lone',$lone);
      }
    }
      return view();
   }

   /*文章详情页 评论点开全部*/

    public function lists(){
    	return view();
    }
    /*评论*/
   public function comment(){
   	  return view();
   }
   /*首页*/
    public function index(){
    	$makecon=New MakeconModel();
    	$user=New UserModel();
    	$love=New LoveModel();
      //显示优秀创作人 
      


      /*技术交流加载*/
      $data=Db::name('forum')->field('id,title,thumb,time,content')->where('ftype',2)->limit(4)->select();
      $this->assign('data',$data);




      //获取观看次数最多的 为精品推荐
    	$mval=$makecon->where('pstatus=2')->order('count desc')->limit(7)->select();
    	if($mval){
    		foreach($mval as $key=>$val){
    			$ures=$user->where('id='.$val['uid'])->find();
    			$mval[$key]['name']=$ures['username'];
    			$mval[$key]['userhead']=$ures['userhead'];
    			$mval[$key]['zhiwei']=$ures['zhiwei'];
    			$lres=$love->where('mid='.$val['id'])->count();
    		    $mval[$key]['love']=$lres;
    		}
        // halt($mval);
	    	$this->assign('mval',$mval);
	    	$this->assign('mone',$mval[0]);
    	}
    	
    	/*其他影片*/
    	
    	return view();
    }
    public function publish(){
    	return view();
    }
    /*视频作品详情*/
   function film(){
   	  $film=New MakeconModel();
   	  $user=New UserModel();
   	  $love=New LoveModel();
   	  $id=input('get.id','','intval');
   	  if(!$id){
   	  	echo 'error';exit;
   	  }

   	  $filmval=$film->where('id='.$id)->find();
   	  $count['count']=$filmval['count']+1;
   	  
   	  $film->where('id='.$id)->update($count);
   	  $filmval['pdate']=strtotime($filmval['pdate']);
   	  $filmnums=$love->where('mid='.$filmval['id'])->count();

   	  $this->assign('filmval',$filmval);
   	  $this->assign('filmcount',$count['count']);
   	  $this->assign('filmnums',$filmnums);
   	  
   	  /*评论的数量*/
   	  $comment=New CommentModel();
   	  $comdata['mid']=$id;
// 	  $comdata['tid']=0;
   	  $commentnums=$comment->where($comdata)->count();
   	  $this->assign('commentnums',$commentnums);
   	  
   	  /*评论*/
   	  $page=input('get.page','');
        if($page=='all'){
        	$commentval=$comment->where('mid='.$id.' and tid=0')->order('time desc')->select();
        }else{
        	$commentval=$comment->where('mid='.$id.' and tid=0')->order('time desc')->limit(4)->select();
        }
        if($commentval){
    			foreach($commentval as $key=>$val){
    				$userval=$user->find($val['uid']);
    				$val['uname']=$userval['username'];
    				$val['uhead']=$userval['userhead'];
    				$cnums=$comment->where('tid='.$val['id'])->count();
    				$val['cnums']=$cnums;
    			}
		    }
   	 $this->assign('commentval',$commentval);
   	 /*发布人信息*/
   	 $f_one=$user->where('id',$filmval['uid'])->field('username,tech,userhead,id')->find();
      
   	  $this->assign('f_one',$f_one);
      /*获取当前登录用户  判断当前用户是否关注*/
        if(session('?userid')){
        $uid=session('userid'); 

        $res=Db::name('connect')->where('userobj',$uid)->select();

        foreach($res as $k){
          if($f_one['id'] == $k['usered']){
            $ress=1;
            $this->assign('ress',$ress);
          }
        }

      }

      /*评论更多ajax*/





   	  /*其它作品*/
      $other['id']=array('not in',$filmval['id']);
   	  $filmlists=$film->where('uid='.$filmval['uid'])
                      ->where($other)
                      ->order('count desc')
                      ->limit(2)
                      ->select();
   	  $this->assign('filmlists',$filmlists);
   	  return view();
   }
   /*作品评论*/
   function filmcomment()
   {
   	  $member = new CommentModel();
   	  if(!session('userid')){
   	  	echo 'error';exit;
   	  }
   	  if (request()->isPost()) { 
		   $data = input('post.');
		   if($data['tid']){
		   	  $tid=$data['tid'];
		   }else{
		   	   $tid=0;
		   }
		   if(!$data['commentfilm']){
		   	return json(array('code' => 0, 'msg' => '内容不能为空'));
		   }
		   $member->uid=session('userid');
		   $member->tid=$tid;
		   $member->mid=$data['mid'];
		   $member->content=$data['commentfilm'];
		   $member->reply=0;
		   $member->praise=0;
		    $member->time=time();	  
		   $member->save();
		   if($member->id){
		   	  return json(array('code' => 200, 'msg' => '评论成功'));
		   }else{
		   	  return json(array('code' => 0, 'msg' => '评论失败'));
		   }
		}
   	  
   }



   /*问答模块*/
   function interlocution()
   {
      return view();
   }


   /*问答发表模块*/
   function interpub()
   {
      $userid=input('get.id');
      $this->assign('userid',$userid);
      return view();
   }
    /*神吐槽*/
   function talk()
   {
      $userid=input('get.id');
      $this->assign('userid',$userid);
      return view();
   }

   /*问答处理*/
   function check()
   {
      if(request()->isPost()){
        $data=input('post.');
        

      }

   }

   /*技术交流发布模块*/
   function publist()
   {
      return view();
   }

  /*技术交流模块*/
   function jishulist()
   {    
      //加载5条技术文章
      $data=Db::field('user.userhead,user.username,a.time,a.title,a.content,a.thumb,a.id')
            ->table('wd_user user,wd_forum a')
            ->where("user.id = a.uid")
            ->where('ftype',2)
            ->limit(3)
            ->order('time desc')
            ->select();     
      $this->assign('data',$data);

      return view();
   }



   /*技术文章加载更多*/
   function jishumore()
   {
      if(request()->isPost()){
        $page=input('post.page');
        $start=$page*3;
        $data=Db::name('forum')->where('ftype',2)->limit($start,2)->order('time desc')->select();
       
        foreach($data as $key => $val){
          $uid=$data[$key]['uid'];
          $user=Db::name('user')->where('id',$uid)->find();
          $data[$key]['userhead']=$user['userhead'];
          $data[$key]['username']=$user['username'];
          $data[$key]['time']=date('Y-m-d',$data[$key]['time']);
        } 
        if($data){
          return json($data);
        }else{
          return json(array('code'=>0,'msg'=>'没有数据了'));
        }

      }
   }

   /*技术交流详情模块*/
   function jishu_details()
   {  
 
      //加载技术文章
      $id=input('get.id'); //文章id
      $datas=Db::name('forum')->where('id',$id)->find();
      $uid=$datas['uid'];
      $data=Db::field('user.userhead,user.username,a.time,a.title,a.content,a.thumb,a.id')
            ->table('wd_user user,wd_forum a')
            ->where("user.id =a.uid and a.id=$id")
            ->find();
      $this->assign('data',$data);

      return view();
   }



}