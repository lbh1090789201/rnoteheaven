 var AdminUserNew = React.createClass({
   getInitialState: function() {
     return {
       show_name: '',
       role: '',
       edit_diaplay: '',
       scopes: [],
     }
   }
   ,handleChange: function(e) {
     let name = e.target.name

     if(name == "show_name") {
       this.props.user_info.show_name = e.target.value
     } else if(name = "role") {
       this.props.user_info.role = e.target.value
     }

     this.setState({
       [name]: e.target.value
     })
   }
   ,handleClick: function() {
     this.props.dad.setState({
       user_info: {
         edit_diaplay: false,
       }
     })
   }
   ,handleCheck: function(e) {
     let scopes = this.state.scopes,
         index = scopes.indexOf(e.target.value)

     if(index == -1) {
       scopes.push(e.target.value)
     } else {
       scopes.splice(index, 1)
     }

     this.setState({scopes: scopes})
   }
   ,handleSubmit: function(e) {
     e.preventDefault()
     let show_name = this.refs.show_name.value,
         password = this.refs.password.value,
         password2 = this.refs.password2.value,
         scopes = this.state.scopes

     if(password != password2) {
       alert('两次输入密码不一致')
     } else if (scopes.length = 0) {
       alert('至少需要设置一项权限')
     } else {
       create_manager()
     }

     function create_manager() {
       $.ajax({
         url: '/admin/users',
         type: 'POST',
         data: {
           show_name: show_name,
           password: password,
           scopes: scopes
         },
         success: function(data){
           console.log(data)
          //  let index = this.props.dad.state.user_info.index,
          //      users = this.props.dad.state.users
           //
          //  users[index] = data.user
           //
          //  this.props.dad.setState({
          //     users: users,
          //     user_info: {
          //       edit_diaplay: false,
          //     }
          //  })
         }.bind(this),
         error: function(data){
           alert(data.responseText)
           this.props.dad.setState({
             user_info: {
               edit_diaplay: false,
             }
           })
         },
       })
     }

   }
   ,render: function() {
     return (
       <div className="mask-user" style={{"display": this.props.dad.state.user_info.new_display}}>
         <div className="user-box">
           <form onSubmit={this.handleSubmit}>
             <div className="form-group">
                <label>用户名称</label>
                  <input className="form-control" placeholder="用户名" name="show_name"
                              pattern=".{4,}" required title="用户名最少4个字符" defaultValue={this.state.show_name} ref="show_name" />
             </div>

             <div className="form-group">
                <label>设置密码</label>
                  <input type="password" className="form-control" placeholder="修改密码才需填写" name="password"
                                pattern=".{6,}" required title="密码最少6个字符" defaultValue={this.state.pwd}  ref="password" />
             </div>

             <div className="form-group">
                <label>重复密码</label>
                  <input type="password" className="form-control" placeholder="修改密码才需填写" name="password2"
                            pattern=".{6,}" required title="密码最少6个字符" defaultValue={this.state.pwd2} res="password2" />
             </div>

             <div className="form-group">
                <label>设置权限</label>
                <AdminRoleCheckbox handleCheck={this.handleCheck}/>
             </div>
             <button type="button" className="btn btn-secondary" onClick={this.handleClick}>取消</button>
             <button type="submit" className="btn btn-success">提交</button>
           </form>
         </div>
       </div>
     )
   }
 })

 var AdminRoleCheckbox = React.createClass({
   render: function() {
     return (
       <div>
         <label className="checkbox-inline">
           <input type="checkbox" value="jobs_manager" onChange={this.props.handleCheck} /> 职位管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" value="resumes_manager" onChange={this.props.handleCheck} /> 简历管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" value="hospitals_manager" onChange={this.props.handleCheck} /> 机构管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" value="fairs_manager" onChange={this.props.handleCheck} /> 专场管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" value="vips_manager" onChange={this.props.handleCheck} /> 套餐管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" value="acounts_manager" onChange={this.props.handleCheck} /> 帐号管理
         </label>
       </div>
     )
   }
 })
