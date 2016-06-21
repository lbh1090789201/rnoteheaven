/* new页面类型选择脚本 开始 */
function JobBasicNew(obj,api,pclass) {
  var parentdiv = $('<div></div>');
  parentdiv.attr('class','before-mask');
  for (var i = 0; i < obj.length; i++) {
    var childBtn = $('<p>'+obj[i]+'</p>');
    childBtn.attr('value',obj[i]);
    childBtn.attr('onclick', 'change_val(this)');
    childBtn.attr('class', pclass)
    parentdiv.append(childBtn);
  }
  var workExperienceDiv = $('#job_basic');
  parentdiv.appendTo(workExperienceDiv);
  edit_title =  $(".title").text();
  var h1 = $(api).siblings().text();
  $(".title").text(h1);
  // $('.right').text('');
  //生成返回按钮
  var span = document.createElement("span");
  span.setAttribute('class','title-over');
  span.setAttribute('onclick','TitleOver(this)');
  console.log(span);
  var div = $(".top");
  div.prepend(span);
}

function change_val(obj) {
  $("#" + $(obj).attr("class")).attr('value', obj.value);
  $('.title').text(edit_title);
  $('.before-mask').animate({
    top: '1500px',
  },300);
  $('.before-mask').css("display","none");
};

function TitleOver(obj) {
  $(".title-over").hide();
  $('.title').text(edit_title);
  // $('.right').text('保存');
  $('.before-mask').animate({
    top: '1500px',
  },300);
  $('.before-mask').css("display","none");
}
/* new页面类型选择脚本 结束 */
