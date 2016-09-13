 var AdminUserNew = React.createClass({
   getInitialState: function() {
     return {
       show_name: '',
       role: '',
       edit_display: '',
       scopes: [],
       checkValues: {"jobs_manager": false, "resumes_manager": false, "hospitals_manager": false,
                  "fairs_manager": false, "vips_manager": false, "acounts_manager": false},
     }
   }
   ,componentDidMount: function() {
     formUser('#form_user_new')
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
         edit_display: false,
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
     if(invalid('#form_user_new')) return // 不合法就返回

     let show_name = this.refs.show_name.value,
        　username = this.refs.username.value,
         password = this.refs.password.value,
         password2 = this.refs.password2.value,
         scopes = this.state.scopes.toString()

         console.log(scopes.toString())

     if(password != password2) {
       myInfo('两次输入密码不一致', 'fail')
     } else if (scopes.length == 0) {
       myInfo('至少需要设置一项权限', 'fail')
     } else {
       $.ajax({
         url: '/admin/users',
         type: 'POST',
         data: {
           username: username,
           show_name: show_name,
           password: password,
           scopes: scopes
         },
         success: function(data){
           let  users = this.props.dad.state.users
           myInfo('新建用户成功！', 'success')
           new_users = users.push(data.user)
           this.props.dad.setState({
              users: users,
              user_info: {
                new_display: false,
              }
           })
         }.bind(this),
         error: function(data){
           let info = JSON.parse(data.responseText)
           myInfo(info["info"], 'fail')
         },
       })
     }
   }
   ,render: function() {
     return (
       <div className="mask-user" style={{"display": this.props.dad.state.user_info.new_display}}>
         <div className="user-box">
           <form onSubmit={this.handleSubmit} id="form_user_new">
             <div className="form-group">
                <label>账号名称</label>
                  <input className="form-control" placeholder="账号名称，以英文开头" name="username" required
                              defaultValue={this.state.username} ref="username" autocomplete="off" />
             </div>

             <div className="form-group">
                <label>用户名称</label>
                  <input className="form-control" placeholder="用户名" name="show_name" required
                              pattern="^.{2,10}$" autocomplete="off" defaultValue={this.state.show_name} ref="show_name" />
             </div>

             <div className="form-group">
                <label>设置密码</label>
                  <input type="password" className="form-control" placeholder="修改密码才需填写" name="password"
                                pattern=".{6,}" required autocomplete="off" defaultValue={this.state.pwd}  ref="password" />
             </div>

             <div className="form-group">
                <label>重复密码</label>
                  <input type="password" className="form-control" placeholder="修改密码才需填写" name="password2"
                            pattern=".{6,}" required autocomplete="off" defaultValue={this.state.pwd2} ref="password2" />
             </div>

             <div className="form-group">
                <label>设置权限</label>
                <AdminRoleCheckbox handleCheck={this.handleCheck} checkValues={this.state.checkValues}/>
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
           <input type="checkbox" defaultValue="jobs_manager" onChange={this.props.handleCheck}
                  defaultChecked={this.props.checkValues["jobs_manager"]} /> 职位管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" defaultValue="resumes_manager" onChange={this.props.handleCheck}
                  defaultChecked={this.props.checkValues["resumes_manager"]} /> 简历管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" defaultValue="hospitals_manager" onChange={this.props.handleCheck}
                  defaultChecked={this.props.checkValues["hospitals_manager"]} /> 机构管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" defaultValue="fairs_manager" onChange={this.props.handleCheck}
                  defaultChecked={this.props.checkValues["fairs_manager"]} /> 专场管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" defaultValue="vips_manager" onChange={this.props.handleCheck}
                  defaultChecked={this.props.checkValues["vips_manager"]} /> 套餐管理
         </label>

         <label className="checkbox-inline">
           <input type="checkbox" defaultValue="acounts_manager" onChange={this.props.handleCheck}
                  defaultChecked={this.props.checkValues.acounts_manager} /> 帐号管理
         </label>
       </div>
     )
   }
 })
