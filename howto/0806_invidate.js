
  /********************** 组件 **********************/
  ,componentDidMount: function() {
    formUser('#form_user')
  }

  /********************** 提交 **********************/
  if(invalid('#form_user_search')) return // 不合法就返回



  // 不合法返回 ture， id 为表格id,"#form_id"，公用
  function invalid(id) {
    var isvalidate=$(id).valid();
    if(isvalidate) {
      return false
    } else {
      myInfo('内容不合法，提交失败。', 'fail')
      return true
    }
  }


  /********************** 表单验证 **********************/
   function formUser(id) {
     $(id).validate({
       rules: {
         show_name: {
           required: true,
           rangelength: [2, 10],
           pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
         },
       },
       messages: {
         show_name: {
           maxlength: '用户名为2~10字符',
           pattern: '请输入中文、英文或数字'
         }
       },
       highlight: function ( element, errorClass, validClass ) {
         $( element ).parents( ".form-group" ).addClass( "has-error" ).removeClass( "has-success" );
       },
       unhighlight: function ( element, errorClass, validClass ) {
         $( element ).parents( ".form-group" ).addClass( "has-success" ).removeClass( "has-error" );
       },
     })
   }

   function formUserSearch(id) {
     $(id).validate({
       rules: {
         show_name: {
           maxlength: 10,
           pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
         },
         time_from: {
           date: true,
         },
         time_to: {
           date: true
         }
       },
       messages: {
         show_name: {
           maxlength: '最多10个字符',
           pattern: '请输入中文、英文或数字'
         }
       }
     })
   }
