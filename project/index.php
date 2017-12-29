<?php
// 定义URL
if (!defined('WEB_URL')) { 
$url = rtrim(dirname(rtrim($_SERVER['SCRIPT_NAME'], '/')), '/'); 
define('WEB_URL', (('/' == $url || '\\' == $url) ? '' : $url)); 
}

// 定义应用目录
define('APP_PATH', __DIR__ . '/application/');
define('EXTEND_PATH','/extend/');
define('BIND_MODULE','index');

// 加载框架引导文件
require __DIR__ . '/thinkphp/start.php';