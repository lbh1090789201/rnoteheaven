

/*搜索首页轮播开始*/
$('.flexslider').flexslider();

$('.flexslider').flexslider({
    slideshow: true
});
/*搜索首页轮播结束*/

/*屏幕自适应开始*/
screenWidth = window.screen.width;
if (screenWidth == 414){
    $('html').css('font-size','20px');
}else{
    $('html').css('font-size',screenWidth/414*20+'px');
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


function workExperience(obj,api,pclass) {
  var parentdiv = $('<div></div>');
  parentdiv.attr('class','before-mask div-hidden');;
  for (var i = 0; i < obj.length; i++) {
    var childBtn = $('<p>'+obj[i]+'</p>');
    childBtn.attr('value',obj[i]);
    childBtn.attr('onclick', 'change_val(this)');
    childBtn.attr('class', pclass)
    parentdiv.append(childBtn);
  }
  var workExperienceDiv = $('.edit_basic');
  parentdiv.appendTo(workExperienceDiv);
  edit_title =  $(".title").text();
  var h1 = $(api).siblings().text();
  $(".title").text(h1);
  $('.right').text('');
}

function change_val(obj) {
  $("#" + $(obj).attr("class")).attr('value', obj.value);
  $('.title').text(edit_title)
  $('.right').text('保存');
  $('.before-mask').animate({
    top: '1500px',
  },300);
  $('.before-mask').css("display","none");
};
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
    window.location.replace(window.location.href);
    // history.go(0);
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
  $("#popup").show();
}
function ClickDeleteBtn(obj){
  var text = $(obj).text();
  if(text == "取消"){
    $("#popup").hide();
  }
  if(text == "确定"){
    $('#delete_bottom_id')[0].click();
      $("#popup").hide();
  }
}
