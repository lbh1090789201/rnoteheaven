/*请求失败弹窗,1.5秒后自动消失*/
// text: 弹窗展示的内容信息
// div_class: 弹窗插入的父节点id　或 class
function myInfo(text, status='default') {
  var div = $('<div class="mask-fail"></div>');

  if(status == 'success') {
    var p = $('<p class="mask info-success"></p>');
  } else if(status == 'fail') {
    var p = $('<p class="mask info-fail"></p>');
  } else if(status == 'warning') {
    var p = $('<p class="mask info-warning"></p>');
  }else {
    var p = $('<p class="mask info-default"></p>');
  }

  p.text(text);
  div.append(p);
  var parent_div = $('body');
  parent_div.append(div);
  var timer = setTimeout(function(){
    div.remove();
  },1300);
}

/* 调用时间插件 传入绑定 input 标签id, 开始时间id，结束时间id */
function myDatePicker(id, begin_id, end_id) {
  $("#"+id).datetimepicker({
    language: 'zh-CN',
    format: "yyyy-mm-dd",
    autoclose: true,
    minView: "month",
    todayBtn:  1,
    showMeridian: 1,
  }).on('changeDate', function (e) {
    let time_begin = $('#' + begin_id).val(),
        time_end = $('#' + end_id).val()

    if(time_begin != '' && time_end != '') {
      if(time_begin > time_end) {
        myInfo('开始时间需小于结束时间哦。', 'warning')
      }
    }
  })
}
