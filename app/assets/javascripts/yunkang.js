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
var expectValue = {
  jobType: ['医院/医疗/护理','医院管理人员','综合门诊/全科医生','内科医生','外科医生','专科医生','牙科医生','护士','内科医生','内科医生','内科医生']
}
function workExperience(jobType) {
  var parentdiv = $('<div></div>');
  parentdiv.attr('class','before-mask');;
  for (var i = 0; i < expectValue.jobType.length; i++) {
    var childBtn = $('<button>'+expectValue.jobType[i]+'</button>');
    childBtn.attr('value',expectValue.jobType[i]);
    childBtn.attr('onclick', 'change_val(this)');
    parentdiv.append(childBtn);
  }
  var workExperienceDiv = $('.edit_basic');
  parentdiv.appendTo(workExperienceDiv);
}

function change_val(obj) {
  $('#name').attr('value', obj.value);
  $('.title').text('编辑期望工作')
  $('.right').text('保存');
  $('.before-mask').animate({
    top: '1500px',
  },300);
};
/* 蒙版 结束 */


/* 模拟点击右上按钮 开始 bobo */
function clickRignt(ojb) {
  $('#btn-submit-btn').bind('click', function() {
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
