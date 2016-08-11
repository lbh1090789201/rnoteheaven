//= require slider

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
