//= require slider
//= require mobiscroll.custom-3.0.0-beta4.min

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
        required: true,
        maxlength: 30,
        pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$',
      },
      desc: {
        required: true,
        maxlength: 500,
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
