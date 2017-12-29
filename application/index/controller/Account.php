<?php
namespace app\index\controller;
use org\Http;
use think\Controller;
use think\Session;
use think\Db;
use think\Config;
use think\Model;
use think\Cache;
use think\Request;
use think\captcha\Captcha;
use app\common\model\Upload as UploadModel;
use app\common\model\Forum as ForumModel;
use app\common\model\Comment as CommentModel;
use app\common\model\User as UserModel;
use app\common\model\Love as LoveModel;
use app\common\model\Connect as ConnectModel;
use app\common\model\Makecon as MakeconModel;
class Account extends Controller{
    public function _initialize(){
    	parent::_initialize();
    	$this->assign('nav','1'); 
    	 $user=new UserModel();
    	// $uid=input('get.uid','','intval');
          // 
    	 if(session('?userid')){
    	 	$uid=session('userid');
    	 }
       //对为完善信息的用户进行处理
        $data=Db::name('user')->where('id',$uid)->find();

        if(empty($data['hangye'])){ 
          $this->redirect(url('my/index'));
        }
        if(empty($data['name'])){
          $this->redirect(url('my/index'));
        }
        //用户存在 不为空
    	 if(!empty($uid)){
        //获取该用户信息
    	 	$userone=$user->where('id',$uid)->find();
        $this->assign('userone',$userone);
        //获取用户发布数 作品和文章发布数
        $res =Db::name('forum')->where('uid',$userone['id'])->count();
        $res1=Db::name('Makecon')->where('uid',$userone['id'])->count();
        $total=$res + $res1;
        $this->assign('total',$total);
    	 	
        //用户技能标签获取
    	 	if($userone['tech']){
    	 		$uarr=explode('、',$userone['tech']);
          $this->assign('uarr',$uarr);
    	 	}
        //用户家庭地
    	 	if($userone['userhome']){
    	 		$uaddr=explode(',',$userone['userhome']);
          $this->assign('uaddr',$uaddr[0]);
    	 	}

    	 	/*关注数量*/
    	 	$connect=new ConnectModel();
        /*关注*/
    	 	$cuser=$connect->where('userobj='.$uid)->count();
        /*粉丝*/
    	 	$userc=$connect->where('usered='.$uid)->count();
    		$this->assign('cuser',$cuser);
    		$this->assign('userc',$userc);

        //当前用户关注人的id信息
        $guanzhu=$connect->where('userobj',$uid)->limit(6)->select();
        foreach ($guanzhu as $key => $v) {
          $usered=Db::name('user')->where('id',$guanzhu[$key]['usered'])->find();
          $fcount=$connect->where('usered',$guanzhu[$key]['usered'])->count();
          $gcount=$connect->where('userobj',$guanzhu[$key]['usered'])->count();
            if($usered['tech']){
              $techs=explode('、',$usered['tech']);
            }
          $guanzhu[$key]['userhead']=$usered['userhead'];
          $guanzhu[$key]['username']=$usered['username'];
          $guanzhu[$key]['tech']=$techs;
          $guanzhu[$key]['fcount']=$fcount;
          $guanzhu[$key]['gcount']=$gcount;
          //13uid   6usered
        }
        $this->assign('guanzhu',$guanzhu);
        // halt($guanzhu);

        //当前用户粉丝的信息
        $fensi=$connect->where('usered',$uid)->limit(6)->select();
         foreach ($fensi as $key => $v) {
          $userobj=Db::name('user')->where('id',$fensi[$key]['userobj'])->find();
          $fcount=$connect->where('usered',$fensi[$key]['usered'])->count();
          $gcount=$connect->where('userobj',$fensi[$key]['usered'])->count();
            if($userobj['tech']){
              $techs=explode('、',$userobj['tech']);
            }
          $fensi[$key]['userhead']=$userobj['userhead'];
          $fensi[$key]['username']=$userobj['username'];
          $fensi[$key]['tech']=$techs;
          $fensi[$key]['fcount']=$fcount;
          $fensi[$key]['gcount']=$gcount;
        }
        $this->assign('fensi',$fensi);
    	 }
    	 
    	 
    }  

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

      //发布文章用户标签
      if($userones['tech']){
        $uarr=explode('、',$userones['tech']);
        $this->assign('uarr',$uarr);
      }

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

    /*作品列表*/
    public function index(){
    	$this->assign('type','index');
    	$this->assign('nav','account');  
    	$user = new UserModel();
    	$member = new MakeconModel();
    	$love = new LoveModel();
    	$uid=input('get.uid','','intval');

    	if(session('?userid')){
    		$uid=session('userid');
    	}
    	if($uid){
    		$map['uid']=$uid;
//  		$map['ftype']=1;
    		$cval=$member->where($map)->order('pdate desc')->limit(9)->select();
       
    		foreach($cval as $key=>$val){
    			$lres=$love->where('mid='.$val['id'])->count();
    			$cval[$key]['love']=$lres;
    			$ures=$user->where('id='.$val['uid'])->find();
    			$cval[$key]['name']=$ures['username'];
    			$cval[$key]['userhead']=$ures['userhead'];
    			$cval[$key]['zhiwei']=$ures['zhiwei'];
    		}
    		$this->assign('cval',$cval);

    	}else{
    		
    	} 	
        return view();
    }
    /*个人简介*/
    public function info(){ 
    	$this->assign('nav','account'); 
    	$this->assign('type','info');  
    	$u=New UserModel();
    	$uid=input('uid','','intval');
    	if(session('userid')){
    		$uid=session('userid');
    	}else{
    		if(!$uid){
    			exit;
    		}
    	}
    	$uone=$u->where('id='.$uid)->find();    	
        $uone['age']=$this->birthday($uone['birth']);
        $date=explode('-',$uone['birth']);
        $uone['xingzuo']=$this->get_xingzuo($date[1],$date[2]);        
        $this->assign('uone',$uone);
        return view();
    }
    /*星座*/
    function get_xingzuo($month, $day){ 
	    // 检查参数有效性 
	    if ($month < 1 || $month > 12 || $day < 1 || $day > 31) 
	    {
	        return (false);
	    } 
	    // 星座名称以及开始日期 
	    $signs = array( 
	        array( "20" => "宝瓶座"), 
	        array( "19" => "双鱼座"), 
	        array( "21" => "白羊座"), 
	        array( "20" => "金牛座"), 
	        array( "21" => "双子座"), 
	        array( "22" => "巨蟹座"), 
	        array( "23" => "狮子座"), 
	        array( "23" => "处女座"), 
	        array( "23" => "天秤座"), 
	        array( "24" => "天蝎座"), 
	        array( "22" => "射手座"), 
	        array( "22" => "摩羯座") 
	    );
	    list($sign_start, $sign_name) = each($signs[(int)$month-1]); 
	    if ($day < $sign_start){
	        list($sign_start, $sign_name) = each($signs[($month -2 < 0) ? $month = 11: $month -= 2]); 
	    }
	    return $sign_name; 
	}
	/*生日*/
    function birthday($birthday){ 
		 $age = strtotime($birthday); 
		 if($age === false){ 
		  return false; 
		 } 
		 list($y1,$m1,$d1) = explode("-",date("Y-m-d",$age)); 
		 $now = strtotime("now"); 
		 list($y2,$m2,$d2) = explode("-",date("Y-m-d",$now)); 
		 $age = $y2 - $y1; 
		 if((int)($m2.$d2) < (int)($m1.$d1)){
		 	$age -= 1;
		 }		   
		 return $age; 
	} 
    /*圈子*/
    public function loc(){ 
    	$this->assign('nav','account'); 
    	$this->assign('type','loc');  
      //此时将关注的人和包括自己所发表的动态全部加载到圈子动态
      $uids='';
      $uid=session('userid');
      $uids.=$uid;
      // //得到该用户的关注这信息
      $datas=Db::name('connect')->where('userobj',$uids)->field('usered')->select();
      if(empty($datas)){
         $list=Db('forum')->alias('f')->join('wd_user u','f.uid=u.id')->where('uid',$uids)->order('time desc')->paginate(3);
         $this->assign('list',$list);
      }else{
         array_push($datas[0], $uids);
         $val=array_values($datas[0]);
        
          // //得到所有的关注者包括自己的动态信息
          $list=Db('forum')->alias('f')->join('wd_user u','f.uid=u.id')->where('uid','in',$val)->order('time desc')->paginate(3);
         $this->assign('list',$list);
      }

            /*谁看过我*/
            $types=input('get.types');
            $types=isset($types) ? $types :'who';
            $this->assign('types',$types);
            
            $visited=Db::name('fangwen')->where('visited_id',$uids)->order('created_at desc')->limit(6)->select();
            foreach ($visited as $key => $v) {
              $us=Db::name('user')->where('id',$visited[$key]['visiter_id'])->find();
              $visited[$key]['userhead']=$us['userhead'];
              $visited[$key]['username']=$us['username'];
              $visited[$key]['created_at']=date('Y-m-d',$visited[$key]['created_at']);
            }
            $this->assign('visited',$visited);
            /*我看过谁*/
          if($types =="me"){
                $visiter=Db::name('fangwen')->where('visiter_id',$uids)->order('created_at desc')->limit(6)->select();
                foreach ($visiter as $key => $v) {
                  $us=Db::name('user')->where('id',$visiter[$key]['visited_id'])->find();
                  $visiter[$key]['userhead']=$us['userhead'];
                  $visiter[$key]['username']=$us['username'];
                  $visiter[$key]['created_at']=date('Y-m-d',$visiter[$key]['created_at']);
                }
                $this->assign('visiter',$visiter);     
          }
        return view();
    }

    /*喜欢列表*/
    public function love(){   
    	$this->assign('nav','account'); 
    	$this->assign('type','love');
    	$user = new UserModel();
    	$member = new MakeconModel();
    	$love = new LoveModel();
    	$uid=input('get.uid','','intval');
    	if(!$uid){
    		if(session('?userid')){
    			$map['uid']=session('userid');
    		}else{
    			exit;
    		}
    	}else{
    		$map['uid']=$uid;
    	}
    	
		$cval=$member->where($map)->order('pdate desc')->limit(3)->select();
		foreach($cval as $key=>$val){
			$lres=$love->where('mid='.$val['id'])->count();
			$cval[$key]['love']=$lres;
			$ures=$user->where('id='.$val['uid'])->find();
    			$cval[$key]['name']=$ures['username'];
    			$cval[$key]['userhead']=$ures['userhead'];
    			$cval[$key]['zhiwei']=$ures['zhiwei'];
		}
    // halt($cval);

		$this->assign('cval',$cval);

    
    	
    	/*文章*/
		$forum = new ForumModel();
    	if(session('?userid')){
    		$m['uid']=session('userid');
    		$m['ftype']=1;
    		$conval=$forum->where($m)->order('time desc')->limit(2)->select();
    		
    	}else{
    		if(!$uid){
    			exit;
    		}
    		$m['uid']=$uid;
    		$m['ftype']=1;
    		$conval=$forum->where($m)->order('time desc')->limit(2)->select();
    		
    	}
    	foreach($conval as $key=>$val){
    		$ures=$user->where('id='.$val['uid'])->find();
    		$conval[$key]['name']=$ures['username'];
			$conval[$key]['userhead']=$ures['userhead'];
			$conval[$key]['zhiwei']=$ures['zhiwei'];
    	}
    	  $this->assign('conval',$conval); 
        // halt($conval);	
        return view();
    }
    
    /*更多作品列表*/
    public function filmlist(){     	
    	$member = new MakeconModel();
    	$love = new LoveModel();
    	$user = new UserModel();
    	if (request()->isPost()) { 
//	    	if(session('?userid')){
	    		$map['uid']=input('post.uid','','intval');
	    		if($map['uid']){
	    			
	    		}else{
	    			if(session('?userid')){
	    				$map['uid']=session('userid');
	    			}else{
	    				echo 'error';exit;
	    			}	    			
	    		}
	    		$page=input('post.page');
	    		$start=$page*9;
	    		$cval=$member->where($map)->order('pdate desc')->limit($start,9)->select();
	    		if($cval){
	    			foreach($cval as $key=>$val){
	    				$val['pname']=mb_substr(htmlspecialchars_decode($val['pname']),0,100);
	    				$lres=$love->where('mid='.$val['id'])->count();
    			        $cval[$key]['love']=$lres;
    			        $ures=$user->where('id='.$val['uid'])->find();
			    		$cval[$key]['name']=$ures['username'];
						$cval[$key]['userhead']=$ures['userhead'];
						$cval[$key]['zhiwei']=$ures['zhiwei'];
	    			}
            
	    			return json($cval);

	    		}else{
	    			return json(array('code' => 0, 'msg' => '没有数据了'));
	    		}
//	    	}
	    }
    }
    
    /*文章列表*/
    public function content(){ 
    	$this->assign('nav','account');  
    	$this->assign('type','content');
    	$member = new ForumModel();
    	$user = new UserModel();
    	$uid=input('get.uid','','intval');
    	if(session('?userid')){
    		$map['uid']=session('userid');
    		$map['ftype']=1;
    		$cval=$member->where($map)->order('time desc')->limit(3)->select();
    	}else{
    		if($uid){
    			$map['uid']=$uid;
	    		$map['ftype']=1;
	    		$cval=$member->where($map)->order('time desc')->limit(3)->select();	
    		}else{
    			exit;
    		}
    	}
    	foreach($cval as $key=>$val){
    		$ures=$user->where('id='.$val['uid'])->find();
    		$cval[$key]['name']=$ures['username'];
			$cval[$key]['userhead']=$ures['userhead'];
			$cval[$key]['zhiwei']=$ures['zhiwei'];
    	}
//  	dump($cval);exit;
    	$this->assign('cval',$cval);
        return view();
    }
    /*更多文章列表*/
    public function conlist(){     	
    	$member = new ForumModel();
    	$user = new UserModel();
    	if (request()->isPost()) { 
    		$uid=input('uid','','intval');
	    	if(session('?userid')){
	    		$uid=session('userid');
	    	}
	    	if(!$uid){
	    		exit;
	    	}
	    		$map['uid']=$uid;
	    		$map['ftype']=1;
	    		$page=input('post.page');
	    		$start=$page*3;
	    		$cval=$member->where($map)->order('time desc')->limit($start,3)->select();
	    		if($cval){
	    			foreach($cval as $key=>$val){
	    				$val['content']=mb_substr(htmlspecialchars_decode($val['content']),0,200);
	    			    $ures=$user->where('id='.$val['uid'])->find();
			    		$cval[$key]['name']=$ures['username'];
						$cval[$key]['userhead']=$ures['userhead'];
						$cval[$key]['zhiwei']=$ures['zhiwei'];
	    			}
	    			return json($cval);
	    		}else{
	    			return json(array('code' => 0, 'msg' => '没有数据了'));
	    		}
	    	
	    }
    }
    //私信
    // public function setmsg(){
    // 	$this->assign('nav','account'); 
    // 	$this->assign('msg','msg');
    	
    // 	return view();
    // }
   

   /*文章评论列表页*/
  function comlists(){
  	$id=input('get.id','','intval');
  	$page=input('get.page','');
  	$member = new CommentModel();
  	$user=new UserModel();
  	
  	if($id){
  		if($page=='all'){
  			$comments=$member->where('tid='.$id)->order('time desc')->select();
  		}else{
  			$comments=$member->where('tid='.$id)->limit(6)->order('time desc')->select();
  		}
  		
  		if($comments){
			foreach($comments as $key=>$val){
				$userval=$user->find($val['uid']);
				$val['uname']=$userval['username'];
				$val['uhead']=$userval['userhead'];
				$cnums=$member->where('tid='.$val['id'])->count();
				$val['cnums']=$cnums;
			}
		}
  		$this->assign('comments',$comments);
  		
//		dump($comments);
  	}else{
  		echo '页面有错误';exit;
  	}
  	return view();
  }

  /*作品评论*/
  function filmlists(){
  	$id=input('get.id','','intval');
  	$page=input('get.page','');
  	$member = new CommentModel();
  	$user=new UserModel();
  	$mone=$member->where('id',$id)->find();
  	$this->assign('mid',$mone['mid']);
  	if($id){
  		if($page=='all'){
  			$comments=$member->where('tid='.$id)->order('time desc')->select();
  		}else{
  			$comments=$member->where('tid='.$id)->limit(6)->order('time desc')->select();
  		}
  		
  		if($comments){
			foreach($comments as $key=>$val){
				$userval=$user->find($val['uid']);
				$val['uname']=$userval['username'];
				$val['uhead']=$userval['userhead'];
				$cnums=$member->where('tid='.$val['id'])->count();
				$val['cnums']=$cnums;
			}
		}
  		$this->assign('comments',$comments);
  		
//		dump($comments);
  	}else{
  		echo '页面有错误';exit;
  	}
  	return view();
  }
  
  /*喜欢按钮*/
  function lovefilm(){
  	if (request()->isPost()) { 
	  	$id=input('post.id','','intval');

	  	$member = new LoveModel();
	  	if(session('?userid')){
        //文章
	  		$map['cid']=$id;
        //用户id
	  		$map['uid']=session('userid');
	  		$con=$member->where($map)->find();
	  		if($con){
		  		return json(array('code' => 0, 'msg' => '你已经点击过了'));
		  	}else{
          $author=Db::name('forum')->where('id',$map['cid'])->find();
          //作者
          $map['mid']=$author['uid'];
		  		$map['ltime']=date('Y-m-d H:i:s');
		  		$rel=$member->data($map)->save();

		  		if($rel){
		  			return json(array('code' => 200, 'msg' => '提交成功'));
		  		}else{
		  			return json(array('code' => 0, 'msg' => '点击失败'));
		  		}
		  	}
	  	}      
    }
  }
 
 /*喜欢文章按钮*/
  function lovecontent(){
  	if (request()->isPost()) { 
	  	$id=input('post.id','','intval');
	  	$member = new LoveModel();
	  	if(session('?userid')){
        //文章id
	  		$map['cid']=$id;
        //用户id
	  		$map['uid']=session('userid');
	  		$con=$member->where($map)->find();
	  		if($con){
		  		$rel=$member->where($map)->delete();
		  		if($rel){
		  			return json(array('code' => 200, 'msg' => '取消成功'));
		  		}else{
		  			return json(array('code' => 0, 'msg' => '点击失败'));
		  		}
		  	}else{
          $author=Db::name('forum')->where('id',$map['cid'])->find();
          //作者id
          $map['mid']=$author['uid'];
		  		$map['ltime']=date('Y-m-d H:i:s');
		  		$rel=$member->data($map)->save();
		  		if($rel){
		  			return json(array('code' => 200, 'msg' => '添加成功'));
		  		}else{
		  			return json(array('code' => 0, 'msg' => '点击失败'));
		  		}
		  	}
	  	}      
	
    }
  }
  /*点赞*/
  function dopraise(){
  	if (request()->isPost()) { 
	  	$id=input('post.id','','intval');
	  	$request = Request::instance();
        $ip=$request->ip();
        // halt(cookie('contentip'+$id));
        if(cookie('contentip'+$id)==$ip){
        	return json(array('code' => 0, 'msg' => '你已点过，请不要重复点'));
        }
	  	$member = new CommentModel();
	  	$con=$member->find($id);
	  	$praise=intval($con['praise'])+1;
	  	$map['praise']=$praise;
	  	$c['id']=$id;
		  $doval=$member->where('id',$id)->update($map);
	 
	   if($doval){
	   	cookie('contentip'+$id, $ip, 360000);
	   	  return json(array('code' => 200, 'msg' => $praise));
	   }else{
	   	  return json(array('code' => 0, 'msg' => '点赞失败'));
	   }
    }
  }
   /*文章列表页*/
  function lists(){
  	$this->assign('nav','lists'); 
  	$forum = new ForumModel();
  	$map['ftype']=1;
  	$fval=$forum->where($map)->order('view desc')->limit(3)->select();
    // halt($fval);
  	$this->assign('fval',$fval);  

	
	$cval=$forum->where($map)->order('time desc')->limit(3)->select();
	$this->assign('cval',$cval);
    
  	return view();
  }
  /*文章列表页加载更多*/
  public function listsmore(){     	
    	$member = new ForumModel();
    	if (request()->isPost()) {    		
    		$map['ftype']=1;
    		$page=input('post.page');
    		$start=$page*3;
    		$cval=$member->where($map)->order('time desc')->limit($start,3)->select();
    		if($cval){
    			foreach($cval as $key=>$val){
    				$val['content']=mb_substr(htmlspecialchars_decode($val['content']),0,200);
    				$val['title']=mb_substr($val['title'],0,100);
    			}
    			return json($cval);
    		}else{
    			return json(array('code' => 0, 'msg' => '没有数据了'));
    		}
	    	
	    }
    }

    public function regmore()
    {
      $users= new UserModel();
      if(request()->isPost()) {
        $page=input('post.page');
        $start=$page*3;
        $news=$users->order('regtime desc')->limit($start,3)->select();
        if($news){
          return json($news);
        }
        return json(array('code' => 0, 'msg' => '没有数据了'));
      }
    }

  /*发布文章*/
 function publish(){
 	$this->assign('nav','lists'); 
 	if (request()->isPost()) { 
	   $data = input('post.');
	   $member = new ForumModel();

	   if(!$data['title']){
	   	return json(array('code' => 0, 'msg' => '标题不能为空'));
	   }
	   if(!$data['content']){
	   	return json(array('code' => 0, 'msg' => '内容不能为空'));
	   }
	   $member->uid=session('userid');
	   $member->title=$data['title'];
	   $member->open=1;
	   $member->content=$data['content'];
	   $member->thumb=$data['path'];
	   $member->time=date('Y-m-d H:i:s');
	  
	    $member->ftype=1;
	  
	   $member->save();
	   if($member->id){
	   	  return json(array('code' => 200, 'msg' => '发布成功'));
	   }else{
	   	  return json(array('code' => 0, 'msg' => '发布失败'));
	   }
	}
 	return view();
 }
 /*上传封面*/
 public function upload(){
 	$file=new UploadModel();
 	return json($file->upfile('images'));
 }
 function upImg(){
 	$file=new UploadModel();
 	$info=$file->upfile('images');
 	if($info['code']==200){
 		$arr['code']=0;
 		$arr['msg']='';
 		$arr['data']['src']=$info['headpath'];
 	}else{
 		$arr['msg']=$info['msg'];
 	}
 	return json($arr);
 }
 //关注好友
 public function connect(){
  //首先接受数据
    $data=input('post.');
    //将关注者被关注者写入数据库
    $connect=new ConnectModel();
    $connect->userobj=$data['user'];
    $connect->usered=$data['userd'];
    //不能自己关注自己
    if($data['user']==$data['userd'])
      return json(array('code'=>201,'msg'=>'不能关注自己'));

    //判断是否已关注
   $has= $connect->where(array('userobj'=>$data['user'],'usered'=>$data['userd']))->find();
   if($has)
      return json(array('code'=>201,'msg'=>'您已关注该用户，不能重复关注'));
    $connect->date=date('Y-m-d H:i:s');
    $res=$connect->save();
    if($res)
      return json(array('code'=>200,'msg'=>'关注成功'));
    
    return json(array('code'=>0,'msg'=>'关注失败'));
 }

 //发表动态
     public function dy()
     {
       if (request()->isPost()) { 
     $data = input('post.');
     $member = new ForumModel();

     if(!$data['title']){
      return json(array('code' => 0, 'msg' => '标题不能为空'));
     }
     if(!$data['content']){
      return json(array('code' => 0, 'msg' => '内容不能为空'));
     }
     $member->uid=session('userid');
     $member->title=$data['title'];
     $member->open=1;
     $member->content=$data['content'];
     $member->thumb=$data['path'];
      $member->time=date('Y-m-d H:i:s');
    
      $member->ftype=3;
    
     $member->save();
     if($member->id){
        return json(array('code' => 200, 'msg' => '发布成功'));
     }else{
        return json(array('code' => 0, 'msg' => '发布失败'));
     }
  }
   return view();
     }

     

     /*与我相关*/
     public function related()
     {
        $this->assign('type','related');
        return view();
     }
}