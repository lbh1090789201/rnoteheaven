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
  var div = $(".top");
  div.prepend(span);
  $(document).scrollTop('0');
}

function change_val(obj) {
  var input = $("#" + $(obj).attr("class"));
  if(input.parent().attr('class') == 'job-endtime'){
    input.text(obj.value);
    var val = obj.value;
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
    input.attr('value', obj.value);
  }
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
