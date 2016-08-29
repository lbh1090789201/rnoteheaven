//= require bootstrap-datetimepicker
//= require bootstrap-datetimepicker.fr
//= require bootstrap-datetimepicker.zh-CN


/* 请求失败弹窗,1.5秒后自动消失
 * text: 弹窗展示的内容信息
 * div_class: 弹窗插入的父节点id　或 class
 */

function myInfo(text, status) {
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
    var time_begin = $('#' + begin_id).val(),
        time_end = $('#' + end_id).val()

    if(time_begin != '' && time_end != '') {
      if(time_begin > time_end) {
        myInfo('开始时间需小于结束时间哦。', 'warning')
      }
    }
  })

  $("#"+id).blur()
}

// 不合法返回 ture， id 为表格id,"#form_id"
function invalid(id) {
  var isvalidate=$(id).valid();
  if(isvalidate) {
    return false
  } else {
    myInfo('内容不合法，提交失败。', 'fail')
    return true
  }
}

// 判断浏览器是否支持文件上传
function isAjaxUploadSupported(){
          var input = document.createElement("input");
          input.type = "file";

          return (
              "multiple" in input &&
                  typeof File != "undefined" &&
                  typeof FormData != "undefined" &&
                  typeof (new XMLHttpRequest()).upload != "undefined" );
  }


// 批量导入机构成功弹窗
function successNew(text) {
  var mask_user = $('<div class="mask-user" id="mask_user"></div>'),
      user_box = $('<div class="success-box"></div>'),
      parent = $('.admin_main');

  user_box.html('<span>'+text+'</span>'+'<p onClick="refressPage()">确定</p>');
  mask_user.append(user_box);
  parent.append(mask_user);
}

function refressPage() {
  $("#mask_user").remove();
  window.location.href = window.location.href;
}
