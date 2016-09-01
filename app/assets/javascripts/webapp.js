//= require slider
//= require mobiscroll.custom-3.0.0-beta4.min
//= require jedate.min

/********************** 表单验证 **********************/
 function formAll(id) {
   $(id).validate({
     rules: {
       // user验证
       show_name: {
         required: true,
         maxlength: 12,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
       },
       position: {
         required: true,
         maxlength: 15,
         pattern: '^[^ ]{0,15}$',
       },
       cellphone: {
         required: true,
         pattern: '^1[345678][0-9]{9}$',
       },
       user_email: {
         required: true,
         email: true,
       },
      // 工作经历验证
       company: {
         required: true,
         maxlength: 20,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
       },
       job_desc: {
         required: true,
         maxlength: 500,
       },
      // 教育经历验证
       college: {
         required: true,
         maxlength: 15,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
       },
       major: {
         required: true,
         maxlength: 10,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
       },
       title: {
         required: true,
         maxlength: 20,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
       },
      // 期盼工作
      name: {
        required: true,
        maxlength: 20,
        pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
      },
      job_type: {
        required: true,
      },
      location: {
        required: true,
      },
      expected_salary_range: {
        required: true,
      },
      // 培训经历
      certificate: {
        required: false,
        maxlength: 30,
        pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
      },
      desc: {
        required: false,
        maxlength: 500,
        pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
      },
     },
     errorPlacement: function(error, element) {
       return true
     },

     highlight: function ( element, errorClass, validClass ) {
       $( element ).addClass( "has-error" ).removeClass( "has-success" );
     },
     unhighlight: function ( element, errorClass, validClass ) {
       $( element ).addClass( "has-success" ).removeClass( "has-error" );
     },
   })
 }

 // 不合法返回 true, id 为表格id,"#form_id"，公用
 function valid(id) {
   var isvalidate=$(id).valid();
   if(isvalidate) {
     return false
   } else {
     return true
   }
 }

 // 城市插件再次点击删掉原来的
function againClick() {
   var input_city = $("#IIInsomnia_city_picker").length;
   if(input_city > 0){
     $("#IIInsomnia_city_picker").remove();
   }
 }


 // 判断开始时间是否大于结束时间
 function dataCompare() {
   var begin_time = $("#beginTime").val(),
       end_time = $("#endTime").val(),
       begin_time_day = parseInt(begin_time.substr(0,4))*365+parseInt(begin_time.substr(6,1))*30+parseInt(begin_time.substr(8,2)),
       end_time_day = parseInt(end_time.substr(0,4))*365+parseInt(end_time.substr(6,1))*30+parseInt(end_time.substr(8,2));

   if(begin_time_day > end_time_day) {
     FailMask("body", "开始时间不能大于结束时间");
     return true;
   }
 }




// 选择脚本插件
function addComponent(parent_class, options, input_id, boolean) {
  var parent_class = parent_class || '#wrap';
  var mask = $('<div id="pop_mask"></div>'),
      mask_pop = $('<div class="pop-mask"></div>'),
      box_1 = $('<div class="pop-box_1"></div>'),
      box_2 = $('<div class="pop-box_2"></div>'),
      button_div = $('<div class="pop-button"></div>')
      parent = $(parent_class);

  var title_text = $(input_id).siblings('label').text(),
      index = title_text.indexOf('*');
  if(index != -1) {
    title_text = title_text.substring(index+1,title_text.length);
  }

  parent.append(mask);
  mask.append(mask_pop);
  mask_pop.append(box_1);
  mask_pop.append(button_div);
  box_1.append(box_2);
  button_div.html('<button class="remove-btn" onClick="removePop()">取消</button><span class="input-title">'+title_text+'</span>');
  var button = $('<button class="success-btn">确定</button>');
  button.attr('onClick',"successPop("+"'"+input_id+"'"+")");
  button_div.append(button);
  for(var i=0;i<options.length;i++) {
    var p = $('<p class="pop-option" onclick="selectOption(this)"></p>');
    p.text(options[i]);
    box_2.append(p);
  }
  // 插入可填框
  if(title_text == '职        称'){
    title_text = '职称';
  }

  var boolean = boolean || false;
  if(boolean) {
    var p = $('<p class="pop-option"></p>');
    p.html('<span class="option-other">其他</span><input type="text" class="importability" placeholder="请输入'+title_text+'" onClick="enterInput()" />');
    box_2.append(p);
  }
}

function enterInput(e) {
  $('.success-btn').css({'pointer-events':'auto','color':'#fff'});
  $('.pop-option').removeClass('p-on');
}

// 点击选项事件
function selectOption(e) {
  $(e).addClass('p-on').siblings('p').removeClass('p-on');
  $('.success-btn').css({'pointer-events':'auto','color':'#fff'});
}

// 取消按钮
function removePop() {
  $('#pop_mask').remove();
}

// 确定按钮
function successPop(input_id) {
  var p = $('.pop-box_2 > .p-on'),
      p_text;
  if(p.length == 0){
     p_text = $('.importability').val();
  }else{
     p_text = $('.pop-box_2 > .p-on').text();
  }
  $(input_id).attr('value', p_text);
  $('#pop_mask').remove();
  $(input_id).blur();
}


// 判断时间插件 今天按钮是否需置灰
function preventClick(beginTime_id,endTime_id) {
  $("#beginTime").on('click', function(){
    var timer = setTimeout(function(){
      var end_time = $("#endTime").val(),
          begin_time = $("#beginTime").val(),
          toDate = new Date(),
          year = toDate.getFullYear(),
          month = toDate.getMonth()+1,
          day = toDate.getDate(),
          ToNumber = year*365+month*30+day;

      if(end_time != ''){
        end_time = parseInt(end_time.substring(0,4))*365 + parseInt(end_time.substring(5,7))*30 + parseInt(end_time.substring(8,10))
        if(end_time < ToNumber) {
          $('.jedatebtn > .jedatetodaymonth').css({'pointer-events':'none','background-color':'#c2c2c2'})
        }
      }
    },50)
  })
  $("#endTime").on('click', function(){
    var timer = setTimeout(function(){
      var end_time = $("#endTime").val(),
          begin_time = $("#beginTime").val(),
          toDate = new Date(),
          year = toDate.getFullYear(),
          month = toDate.getMonth()+1,
          day = toDate.getDate(),
          ToNumber = year*365+month*30+day;

      if(begin_time != ''){
        begin_time = parseInt(begin_time.substring(0,4))*365 + parseInt(begin_time.substring(5,7))*30 + parseInt(begin_time.substring(8,10))
        if(begin_time > ToNumber) {
          $('.jedatebtn > .jedatetodaymonth').css({'pointer-events':'none','background-color':'#c2c2c2'})
        }
      }
    },50)
  })
}
