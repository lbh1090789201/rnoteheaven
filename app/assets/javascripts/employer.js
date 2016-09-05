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
  $("#" + $(obj).attr("class")).blur();
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


/********************** 表单验证 **********************/
 function formAll(id) {
   $(id).validate({
     rules: {
       // job验证
        name: {
          required: true,
          maxlength: 15,
          pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
        },
        needed_number: {
          required: true,
          maxlength: 5,
          pattern: '^[0-9]*[1-9][0-9]*$',
        },
        location: {
          required: true,
          maxlength: 50,
        },
        job_demand: {
          required: true,
          maxlength: 500,
        },
        job_desc: {
          required: true,
          maxlength: 500,
        },
      // user 验证
      introduction: {
        required: true,
        maxlength: 500,
      },
     },
     messages: {
       // job验证
        name: {
          required: "不能为空",
          maxlength: "输入格式不对，请输入1~20位中文、英文或数字",
          pattern: "输入格式不对，请输入1~20位中文、英文或数字",
        },
        needed_number: {
          required: "不能为空",
          maxlength: "输入格式不对，请输入1~５位数字",
          pattern: "输入格式不对，请输入1~５位数字",
        },
        location: {
          required: "不能为空",
          maxlength: "输入格式不对，请输入1~50个字",
        },
        job_demand: {
          required: "不能为空",
          maxlength: "输入格式不对，最多只能输入500个字",
        },
        job_desc: {
          required: "不能为空",
          maxlength: "输入格式不对，最多只能输入500个字",
        },
        job_type: {
          required: "不能为空",
        },
        salary_range: {
          required: "不能为空",
        },
        experience: {
          required: "不能为空",
        },
        degree_demand: {
          required: "不能为空",
        },
        recruit_type: {
          required: "不能为空",
        },
        region: {
          required: "不能为空",
        },
      // user 验证
      introduction: {
        required: "不能为空",
        maxlength: "输入格式不对，最多只能输入500个字",
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
       $( element ).siblings( "label.error" ).remove();
     },
     errorPlacement: function(error, element) {
       error.appendTo(element.parent());
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

  // 表单验证提示语弹窗
  function unvalidAlert() {
    var form_div = $("#wrap") ? $("#wrap") : $(".wrap");
    form_div.css("padding-top","2rem");
    var lebelText = $('label.error').eq(0).siblings('label.control-label').text(),
         string = '';
     for(var i=0; i<lebelText.length; i++) {
       var character = lebelText.substr(i,1),
           pattern = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
       if(pattern.test(character)){
         string = string + character;
       }
     }

    if($('.error-alert')) {
      $('.error-alert').remove();
    }
    var alert_text = $('label.error').eq(0).text(),
        div = $('<div class="error-alert"></div>'),
        p = $('<p></p>'),
        parent = $('body');

    p.text(string+": "+alert_text);
    parent.append(div);
    div.append(p);
    var timer = setTimeout(function(){
      $('.error-alert').remove();
      form_div.css("padding-top","0");
    }, 2000)
  }


  // 职位名称不超过１０个字符
  function limitNumber(className) {
   var name_length = $(className).length;
   for(var i=0;i<name_length;i++) {
     var text = $(className).eq(i).text();
     if(text.length > 10) {
       $(className).eq(i).text(text.substr(0,10))
     }
   }
  }

  // 城市插件再次点击删掉原来的
 function againClick() {
    var input_city = $("#IIInsomnia_city_picker").length;
    if(input_city > 0){
      $("#IIInsomnia_city_picker").remove();
    }
  }


  // 选择脚本插件
  function addComponent(parent_class, options, input_id) {
    var parent_class = parent_class || '.wrap';
    var mask = $('<div id="pop_mask"></div>'),
        mask_pop = $('<div class="pop-mask"></div>'),
        box_1 = $('<div class="pop-box_1"></div>'),
        box_2 = $('<div class="pop-box_2"></div>'),
        button_div = $('<div class="pop-button"></div>')
        parent = $(parent_class);

    var title_text = $(input_id).siblings('label.control-label').text(),
        index = title_text.indexOf('*');
    if(index != -1) {
      title_text = title_text.substring(index+1,title_text.length);
    }

    parent.append(mask);
    mask.append(mask_pop);
    mask_pop.append(box_1);
    mask_pop.append(button_div);
    box_1.append(box_2);
    button_div.html('<button class="remove-btn" onClick="removePop()">取消</button><span>'+title_text+'</span>');
    var button = $('<button class="success-btn">确定</button>');
    button.attr('onClick',"successPop("+"'"+input_id+"'"+")");
    button_div.append(button);
    for(var i=0;i<options.length;i++) {
      var p = $('<p class="pop-option" onclick="selectOption(this)"></p>');
      p.text(options[i]);
      box_2.append(p);
    }
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
    var p_text = $('.pop-box_2 > .p-on').text();
    var input = $(input_id);
    if(input.parent().attr('class') == 'job-endtime') {
      $("#job_end").text(p_text);
      switch(p_text){
        case '１星期':
          $("#job_duration").attr('value', '7')
          break;
        case '２星期':
          $("#job_duration").attr('value', '14')
          break;
        case '半个月':
          $("#job_duration").attr('value', '15')
          break;
        case '１个月':
          $("#job_duration").attr('value', '31')
          break;
        case '２个月':
          $("#job_duration").attr('value', '62')
          break;
        case '３个月':
          $("#job_duration").attr('value', '93')
          break;
      }
    }else{
      input.attr('value', p_text)
    }
    $('#pop_mask').remove();
  }
