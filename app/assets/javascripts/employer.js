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
/*再次发布职位失败弹窗,1.5秒后自动消失*/

// text: 弹窗展示的内容信息
// div_class: 弹窗插入的父节点id　或 class
function againRelease(div_class,text) {
  var div = $('<div class="release-fail"></div>');
  var p = $('<p class="mask-release"></p>');
  p.text(text);
  div.append(p);
  var parent_div = $(div_class);
  parent_div.append(div);
  var timer = setTimeout(function(){
    div.remove();
  },1000);
}

/* new页面类型选择脚本 开始 */
function JobBasicNew(obj,api,pclass) {
  var parentdiv = $('<div></div>');
  parentdiv.attr('class','before-mask');
  for (var i = 0; i < obj.length; i++) {
    var childBtn = $('<p>'+obj[i]+'</p>');
    childBtn.attr('index',obj[i]);
    childBtn.attr('onclick', 'change_val(this)');
    childBtn.attr('class', pclass)
    parentdiv.append(childBtn);
  }
  var workExperienceDiv = $('#job_basic');
  parentdiv.appendTo(workExperienceDiv);
  var delete_mask = $('<p></p>');
  delete_mask.text('返回');
  delete_mask.attr('onClick','delete_mask()');
  parentdiv.append(delete_mask);
  $(document).scrollTop('0');
}

function change_val(obj) {
  var input = $("#" + $(obj).attr("class"));
  if(input.parent().attr('class') == 'job-endtime'){
    input.text($(obj).text());
    var val = $(obj).text();
    switch(val){
      case '１星期':
        val = 7;
        input.siblings().children('input').attr('value', val);
        break;
      case '２星期':
        val = 14;
        input.siblings().children('input').attr('value', val);
        break;
      case '半个月':
        val = 15;
        input.siblings().children('input').attr('value', val);
        break;
      case '１个月':
        val = 31;
        input.siblings().children('input').attr('value', val);
        break;
      case '２个月':
        val = 62;
        input.siblings().children('input').attr('value', val);
        break;
      case '３个月':
        val = 93;
        input.siblings().children('input').attr('value', val);
        break;
    }
  }else {
    input.attr('value', $(obj).text());
  }
  $('.before-mask').animate({
    top: '1500px',
  },300);
  $('.before-mask').css("display","none");
};

function delete_mask() {
  $('.before-mask').remove();
}
/* new页面类型选择脚本 结束 */


function ReplayImg(index,img_src){
  $('#footer_btm_nav>li').eq(index).children('a').children('span').css('color','#3f9e9d');
  $('#footer_btm_nav>li').eq(index).children('a').children('img').attr('src',img_src);
}

//清空input内容
function EmptyCont(input_id) {
	$("#"+input_id).val('');
}
