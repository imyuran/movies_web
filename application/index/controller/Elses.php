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

/*进入别人用户主页*/
class Elses extends Controller{
	public function _initialize(){
		parent::_initialize();
    	$this->assign('nav','1');
         $this->assign('type','index'); 
    
         //判断用户是否存在
    	 if(session('?userid')){
    	 	$uid=session('userid');
             //加载用户相关信息
             //头部加载    
    	 }

         
         $user=Db::name('user')->where('id',$uid)->find();
         $this->assign('user',$user);
           
         /*这是看其他人的页面个人中心*/
        //获取要访问的用户id 
        $id=input('get.id');

        //判断进入用户是否是自己
        if($id ==$uid){
            $this->redirect('account/index');
        }

        $userone=Db::name('user')->where('id',$id)->find();
        //判断是否关注了改用户
        $connect=Db::name('connect')->where('userobj',$uid)->where('usered',$id)->find();

        if($connect){
            $alie=1;
            $this->assign('alie',$alie);
        }else{
             $alie=2;
            $this->assign('alie',$alie);
        }



         //获取用户发布数 作品和文章发布数
        $res =Db::name('forum')->where('uid',$userone['id'])->count();
        $res1=Db::name('Makecon')->where('uid',$userone['id'])->count();
        $total=$res + $res1;
        $this->assign('total',$total);
      

         //用户技能标签获取
         if($userone['tech']){
            $uarr=explode('、',$userone['tech']);
            $userone['tech']=$uarr;
            }

        //用户家庭地
        if($userone['userhome']){
            $uaddr=explode(',',$userone['userhome']);
            $userone['userhome']=$uaddr[0];
        }

            $this->assign('userone',$userone);
            /*关注数量*/
            $connect=new ConnectModel();
            $cuser=$connect->where('userobj',$id)->count();
            $userc=$connect->where('usered',$id)->count();
            $this->assign('cuser',$cuser);
            $this->assign('userc',$userc);

	}


    /*他人个人中心主页  作品列表*/
    public function index(){
        $this->assign('type','index');
        $this->assign('nav','account');  
        $user = new UserModel();
        $member = new MakeconModel();
        $love = new LoveModel();
        $id=input('get.id');
        $this->assign('id',$id);

        if(session('?userid')){
            $uid=session('userid');
        } 

        /*访问信息入库*/
        $visit=[
            'visiter_id'=>$uid,
            'visited_id'=>$id,
            'created_at'=>time(),
        ];
        Db::name('fangwen')->insert($visit);

        if($id){
            $map['uid']=$id;
            $cval=$member->where($map)->order('pdate desc')->limit(9)->select();
       
            foreach($cval as $key=>$val){
                $lres=$love->where('mid='.$val['id'])->count();
                $cval[$key]['love']=$lres;
                $ures=$user->where('id='.$val['uid'])->find();
                $cval[$key]['name']=$ures['username'];
                $cval[$key]['userhead']=$ures['userhead'];
                $cval[$key]['zhiwei']=$ures['zhiwei'];
            }
            $this->assign('cvals',$cval);

        }
        return view();

    }

     /*更多作品列表*/
    public function filmlist(){         
        $member = new MakeconModel();
        $love = new LoveModel();
        $user = new UserModel();
        if (request()->isPost()) { 
//          if(session('?userid')){
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
//          }
        }
    }
    


    /*他人个人中心主页 文章*/
    public function content()
    {
        $this->assign('nav','account');  
        $this->assign('type','content');
        $member = new ForumModel();
        $user = new UserModel();

        $id=input('get.id');

        /*防止路由被篡改*/
        if($id){
            $cval=$member->where('uid',$id)
                ->where('ftype',1)
                ->order('time desc')
                ->limit(3)
                ->select(); 
        }else{
            //404NOT FOUND
        }

        foreach($cval as $key=>$val){
            $ures=$user->where('id='.$val['uid'])->find();
            $cval[$key]['name']=$ures['username'];
            $cval[$key]['userhead']=$ures['userhead'];
            $cval[$key]['zhiwei']=$ures['zhiwei'];
        }

        $this->assign('cval',$cval);
        return view();
    }

     /*更多文章列表*/
    public function conlist(){      
        $member = new ForumModel();
        $user = new UserModel();
        if (request()->isPost()) { 
            // $uid=input('uid','','intval');
            if(input('post.uid')){
                $uid=input('post.uid');
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

    /*喜欢列表*/
    public function love(){   
        $this->assign('nav','account'); 
        $this->assign('type','love');
        $user = new UserModel();
        $member = new MakeconModel();
        $love = new LoveModel();
        /*获取当前个人中心用户id*/
        $id=input('get.id');
        if($id){
            $map['uid']=$id;
        }else{
            //404           
        }
        //获取用户喜欢的
        // $loveid=$love->where('uid',$id)->field('cid,mid')->select();
        // foreach($loveid as $key=> $v){
        //     $author=Db::name('user')->where('id',$loveid[$key]['cid'])->find();
        //     $loveid[$key]['name']=$author['username'];
        //     $loveid[$key]['userhead']=$author['userhead'];
        //     $loveid[$key]['zhiwei']=$author['zhiwei'];

        // }
        // halt($loveid);

        /*视频*/
        $cval=$member->where($map)->order('pdate desc')->limit(3)->select();
        // halt($cval);
        foreach($cval as $key=>$val){
            $lres=$love->where('mid='.$val['id'])->count();
            $cval[$key]['love']=$lres;
            $ures=$user->where('id='.$val['uid'])->find();
                $cval[$key]['name']=$ures['username'];
                $cval[$key]['userhead']=$ures['userhead'];
                $cval[$key]['zhiwei']=$ures['zhiwei'];
        }

        $this->assign('cval',$cval);
      
        /*文章*/
        $forum = new ForumModel();
         $conval=$forum->where('ftype',1)
                ->where($map)
                ->order('time desc')
                ->limit(2)
                ->select();

        foreach($conval as $key=>$val){
            $ures=$user->where('id='.$val['uid'])->find();
            $conval[$key]['name']=$ures['username'];
            $conval[$key]['userhead']=$ures['userhead'];
            $conval[$key]['zhiwei']=$ures['zhiwei'];
        }
          $this->assign('conval',$conval); 
       
        return view();

        /*技术交流*/

    }

     /*个人简介*/
    public function info(){ 
        $this->assign('nav','account'); 
        $this->assign('type','info');  
        $u=New UserModel();
        $id=input('id');
  
        if($id){
            $uone=$u->where('id='.$id)->find();        
            $uone['age']=$this->birthday($uone['birth']);
            $date=explode('-',$uone['birth']);
            $uone['xingzuo']=$this->get_xingzuo($date[1],$date[2]);        
            $this->assign('uone',$uone);
            return view();
        }else{
            //404
        }
        
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

    /*私信*/
    public function setmsg()
    {
        //发送者id
        if(session('?userid')){
            $send_id=session('userid');
            $this->assign('s_userid',$send_id);     
        }

            //接收者id
            $acpt_id=input('get.accept_id');
         
            if(!empty($acpt_id)){
                session('accept_id',$acpt_id);
            }
            if(session('?accept_id')){
                $accept_id=session('accept_id');  
                $this->assign('a_userid',$accept_id);   
            }
            $accepter=Db::name('user')->where('id',$accept_id)->find();
            $this->assign('accepter',$accepter);

             //获取数据库中数据
       
            $content=Db::name('setmsg')->whereIn('accept_id',array($send_id,$accept_id))->whereIn('sender_id',array($send_id,$accept_id))->order('time asc')->select();
            foreach ($content as $key => $v) {
                $sender=Db::name('user')->where('id',$send_id)->find();
                $accepter=Db::name('user')->where('id',$accept_id)->find();
                $content[$key]['s_userhead']=$sender['userhead'];
                $content[$key]['s_username']=$sender['username'];
                $content[$key]['a_userhead']=$accepter['userhead'];
                $content[$key]['a_username']=$accepter['username'];
                $content[$key]['year']=date('Y',$content[$key]['time']);
                $content[$key]['month']=date('m',$content[$key]['time']);
                $content[$key]['day']=date('d',$content[$key]['time']);
                $content[$key]['hour']=date('h:i',$content[$key]['time']);
               
            }
            // halt($content);
            $this->assign('content',$content);



        if(request()->isPost()){
            $msg=input('post.');
            $data=[
                'sender_id'=>$msg['userid'],
                'accept_id'=>$accept_id,
                'content'=>$msg['msg'],
                'time'=>time(),
            ];
            $res=Db::name('setmsg')->insert($data);
            if($res){
                $this->redirect('elses/setmsg');
            }

        } 
        return view();
    }


     /*文章详情*/
   function detail(){
      $this->assign('nav','lists'); 
      $id=input('get.id');
      $forum = new ForumModel();
      $user=new UserModel();
      $cone=$forum->find($id);
      $this->assign('cone',$cone);
      /*用户信息*/
      $userone=$user->find($cone['uid']);
      // halt($userone);
      $this->assign('userone',$userone);
      
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
         if($userone['id'] ==  $v['usered']){
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

}