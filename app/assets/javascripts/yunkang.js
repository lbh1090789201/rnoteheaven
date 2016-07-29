

/*请求失败弹窗,1.5秒后自动消失*/
// text: 弹窗展示的内容信息
// div_class: 弹窗插入的父节点id　或 class
function FailMask(div_class,text) {
  var div = $('<div class="mask-fail"></div>');
  var p = $('<p class="mask-middle"></p>');
  p.text(text);
  div.append(p);
  var parent_div = $(div_class);
  parent_div.append(div);
  var timer = setTimeout(function(){
    div.remove();
  },1000);
}

function ourNotice(div_class,text) {
  var div = $('<div class="mask-fail"></div>');
  var p = $('<p class="mask-middle"></p>');
  p.text(text);
  div.append(p);
  var parent_div = $(div_class);
  parent_div.append(div);
}

//页面小浮动脚本
// function Float_icon(div_class,text,url){
//   var a = $('<a class="float-color"></a>');
//   a.text(text);
//   a.attr('href',url)
//   var parent_div = $(div_class);
//   parent_div.append(a);
// }

/*返回顶部*/
$(document).scrollTop('0');

/*屏幕自适应开始*/
function getWidth()
  {
    xWidth = null;
    if(window.screen != null)
      xWidth = window.screen.availWidth;

    if(window.innerWidth != null)
      xWidth = window.innerWidth;

    if(document.body != null)
      xWidth = document.body.clientWidth;

    return xWidth;
  }

var realWidth = getWidth()

if (realWidth == 414){
    $('html').css('font-size','20px');
}else{
  var font_size = (realWidth/414*20).toFixed(2) + 'px';
  $('html').css('fontSize', font_size);
};

/*屏幕自适应结束*/

/* 取得屏幕高度并减去 head 开始 */
function fullScreen(dom) {
  $(dom).css('height', $(document.body).height() - 2.32*20);
}
/* 取得屏幕高度并减去 head 结束 */

/*
 * 超过一定字体变成省略号 开始
 * 传入jq选择dom,word值可不传
 */
function wordLimit(dom, word) {
  var content = $(dom).html();

  word ? word = word : word = 60;

  if (content.length > word) {
    $(dom).html(content.substr(0, word) + '……');
  } else {

  }
};
/* 超过一定字体变成省略号 结束 */

/* 蒙版 开始 */

// 进入页面即生成蒙版div

// function generate_mask() {
//   var parentdiv = $('<div></div>');
//   parentdiv.attr('class','before-mask div-hidden');;
//   for (var i = 0; i < obj.length; i++) {
//     var childBtn = $('<p>'+obj[i]+'</p>');
//     childBtn.attr('value',obj[i]);
//     childBtn.attr('onclick', 'change_val(this)');
//     childBtn.attr('class', pclass)
//     parentdiv.append(childBtn);
//   }
// }

function workExperience(obj,api,pclass) {
  // var now_url = window.location.href;
  // now_url+= "?index=1"
  // window.location.href = now_url
  var parentdiv = $('<div></div>');
  parentdiv.attr('class','before-mask div-hidden float-style');;
  for (var i = 0; i < obj.length; i++) {
    var childBtn = $('<p>'+obj[i]+'</p>');
    childBtn.attr('value',obj[i]);
    childBtn.attr('onclick', 'change_val(this)');
    childBtn.attr('class', pclass);
    parentdiv.append(childBtn);
  }
  var workExperienceDiv = $('.edit_basic');
  parentdiv.appendTo(workExperienceDiv);
  var delete_mask = $('<p></p>');
  delete_mask.text('返回');
  delete_mask.attr('onClick','delete_mask()');
  parentdiv.append(delete_mask);
  // edit_title =  $(".title").text();
  // var h1 = $(api).siblings().text();
  // $(".title").text(h1);
  // $('.right').text('');
  //生成返回按钮
  // var span = document.createElement("span");
  // span.setAttribute('class','title-over');
  // span.setAttribute('onclick','TitleOver(this)');
  // console.log(span);
  // var div = $(".top");
  // div.prepend(span);
  $(document).scrollTop('0');
}

function change_val(obj) {
  $("#" + $(obj).attr("class")).attr('value', obj.value);
  $('.before-mask').animate({
    top: '1500px',
  },300);
  $('.before-mask').css("display","none");
};

function delete_mask() {
  $('.before-mask').remove();
}
/* 蒙版 结束 */


/* 模拟点击右上按钮 开始 bobo */
function clickRignt(ojb) {
  $('#btn-submit-btn').bind('click', function() {
    $(ojb).trigger("click");
    console.log('ok');
  });

  $('.btm-save').bind('click', function() {
    $(ojb).trigger("click");
    console.log('ok');
  });
}
/* 模拟点击右上按钮 结束 bobo */

/* notice 自动消失 开始 bobo */
setTimeout(function() {
    $('.alert').fadeOut();
}, 1000);
/* notice 自动消失 结束 bobo */


/*
 * 单次刷新 开始 bobo
 * 调用方法,页面引入 $(refreshOnce());
 */
function refreshOnce() {
  if(getCookie('refresh') != null) {
    delCookie('refresh');
  } else {
    setCookie('refresh','true');
    refresh_cli()
  }
};

// 设置cookie
function setCookie(name,value)
{
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

// 读取cookie
function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");

    if(arr=document.cookie.match(reg))

        return unescape(arr[2]);
    else
        return null;
}

// 删除cookie
function delCookie(name)
{
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null)
        document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}
/* 单次刷新 结束 bobo */

// 编辑　删除弹窗
function ClickShowHide(){
  $("#popup_delete").show();
}
function ClickDeleteBtn(obj){
  var text = $(obj).text();
  if(text == "取消"){
    $("#popup_delete").hide();
  }
  if(text == "确定"){
    $('#delete_bottom_id')[0].click();
      $("#popup_delete").hide();
  }
}


// 切换 job & hospital
  function job_page() {
    $('#job-detail').show();
    $('#hospital_detail').hide();
    $('#job_page').attr('class', 'job-page');
    $('#hospital_page').attr('class', 'hospital-page');
  }

  function hospital_page() {
    $('#job-detail').hide();
    $('#hospital_detail').show();
    $('#job_page').attr('class', 'hospital-page');
    $('#hospital_page').attr('class', 'job-page');
  }

  //清空input内容
  function EmptyCont(input_id) {
  	$("#"+input_id).val('');
  }



/*********** 与APP交互 ***********/
  //设定返回链接，用在页面头部
  function set_back(my_url){
        var u = navigator.userAgent;
      	var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
      	var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端

        //IOS设置返回的链接中的独有包含字段
      	var iosUrl={};
      	iosUrl.faction="setBackUrl";
      	iosUrl.type="1";
      	var backUrl={};
      	backUrl.from_index = my_url == null ? "/pageJump/toDetectionReady.do" : my_url;
      	iosUrl.parameter=backUrl;

      	if(isiOS){
        	window.webkit.messageHandlers.interOp.postMessage(JSON.stringify(iosUrl));
          }
        if(isAndroid){
          if(my_url == null) {
            var messageBody={
              "faction": "setBackToLast",
              "parameter": '',
              "callback": ""
            }
          } else {
            var messageBody={
              "faction": "setBackToUrl",
              "parameter": {"url": my_url},
              "callback": ""
            }
          }

          window.js2MobInterface.postMessage(JSON.stringify(messageBody));
        }
  }


  //返回APP首页
  function go_home(){
		var u = navigator.userAgent;
		var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
		var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端

		//ios首页返回app
		var iosUrl={};
		iosUrl.faction="setBackUrl";
		iosUrl.type="1";
		var backUrl={};
		backUrl.setBackUrl="backHome";
		iosUrl.parameter=backUrl;

    //android 首页返回 app
    var androidUrl={
      "faction": "setBackCloseWeb",
      "parameter": "",
      "callback": ""
    }

		if(isiOS){
	    window.webkit.messageHandlers.interOp.postMessage(JSON.stringify(iosUrl));
	    }
	  if(isAndroid){
			window.js2MobInterface.postMessage(JSON.stringify(androidUrl));
		}
	}

  //安卓返回APP首页
  function go_home_android(){
    var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端

    //android 首页返回 app
    var androidUrl={
      "faction": "setBackCloseWeb",
      "parameter": "",
      "callback": ""
    }

    if(isAndroid){
      window.js2MobInterface.postMessage(JSON.stringify(androidUrl));
    }
  }

  //Android 刷新页面
  function set_back_reload(my_url) {
    var u = navigator.userAgent;
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端

    //IOS设置返回的链接中的独有包含字段
    var iosUrl={};
    iosUrl.faction="setBackUrl";
    iosUrl.type="1";
    var backUrl={};
    backUrl.from_index = my_url == null ? "/pageJump/toDetectionReady.do" : my_url;
    iosUrl.parameter=backUrl;

    if(isiOS){
      window.webkit.messageHandlers.interOp.postMessage(JSON.stringify(iosUrl));
      }
    if(isAndroid){
      if(my_url == null) {
        var messageBody={
          "faction": "setBackToLast",
          "parameter": '',
          "callback": ""
        }
      } else {
        var messageBody={
          "faction": "setBackToUrl",
          "parameter": {"url": my_url},
          "callback": "my_refresh()"
        }
      }

      window.js2MobInterface.postMessage(JSON.stringify(messageBody));
    }
  }


  function my_refresh() {
    var new_url = window.location.href + '?no_refresh=true'
    window.location.href = new_url
  }

function app_reload() {
  var u = navigator.userAgent;
  var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
  var messageBody={
    "faction": "registAutoReload",
    "parameter": '',
    "callback": ""
  }

  if(isAndroid){
    window.js2MobInterface.postMessage(JSON.stringify(messageBody));
  }
}

//医院端存在未填框时iOS会有弹窗提示
function submitMask(submit_id) {
  $(submit_id).on('click', function(){
  var u = navigator.userAgent;
  var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
  if(isiOS){
    var input_text = $(":text"),
        input_textarea = $("textarea");

    var empty_value = function(){
      for(var i=0;i<input_text.length;i++){
        var value = input_text.eq(i).val();
        if(value == ''){
          return "有空值"
        }
      }
    }

    var empty_text = function(){
      for(var i=0;i<input_textarea.length;i++){
        var value = input_textarea.eq(i).val();
        if(value == ''){
          return "有空值"
        }
      }
    }

    if(empty_value() == "有空值" || empty_text() == "有空值"){
      FailMask('.wrap',"请完善信息！")
    }
  }
  })
}

//医生端存在未填框时iOS会有弹窗提示
function doctorMask(submit_id) {
  $(submit_id).on('click', function(){
  var u = navigator.userAgent;
  var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
  if(isiOS){
    var input_text = $(":text"),
        input_textarea = $("textarea");

    var empty_value = function(){
      for(var i=0;i<input_text.length;i++){
        var value = input_text.eq(i).val();
        if(value == ''){
          return "有空值"
        }
      }
    }

    var empty_text = function(){
      var text = input_textarea.val();
      if(text == ""){
        return "有空值"
      }
    }

    if(empty_value() == "有空值" || empty_text() == "有空值"){
      FailMask('.wrap',"请完善信息！")
    }
  }
  })
}
