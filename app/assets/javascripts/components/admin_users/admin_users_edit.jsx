 var AdminUserEdit = React.createClass({
   getInitialState: function() {
     return {
       show_name: this.props.dad.state.user_info.show_name,
       edit_display: this.props.dad.state.user_info.edit_display,
       check_display: false,
       id: this.props.user_info.uid,
       scopes: [],
     }
   }
   ,componentWillMount: function() {
        $.ajax({
          url: '/admin/users/edit',
          type: 'GET',
          data: {
            id: this.state.id
          },
          success: function(data) {
            this.setState({
              checkValues: data.checkValues,
              check_display: true,
              scopes: data.scopes,
            })
          }.bind(this),
          error: function(data) {
            console.log(data)
          }
        })
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
     let show_name = this.props.dad.state.user_info.show_name,
         password = this.refs.password.value,
         password2 = this.refs.password2.value,
         scopes = this.state.scopes.toString(),
         id= this.refs.id.value

     console.log(scopes.toString())

     if(password != password2) {
       alert('两次输入密码不一致')
     } else if (scopes.length = 0) {
       alert('至少需要设置一项权限')
     } else {
       $.ajax({
         url: '/admin/users',
         type: 'PATCH',
         data: {
           show_name: show_name,
           password: password,
           scopes: scopes,
           id: id
         },
         success: function(data){
           let index = this.props.dad.state.user_info.index,
               users = this.props.dad.state.users

           users[index] = data.user

           this.props.dad.setState({
              users: users,
              user_info: {
                edit_display: false,
              }
           })
         }.bind(this),
         error: function(data){
           alert(data.responseText)
           this.props.dad.setState({
             user_info: {
               edit_display: false,
             }
           })
         }
       })
     }
   }
   ,render: function() {
     let check_box = this.state.check_display ? <AdminRoleCheckbox handleCheck={this.handleCheck} checkValues={this.state.checkValues}/> : ''

     return (
       <div className="mask-user" style={{"display": this.props.user_info.edit_display}}>
         <div className="user-box">
           <form onSubmit={this.handleSubmit}>
             <input onChange={this.handleChange} value={this.props.user_info.uid} name="id" ref="id" style={{"display": "none"}} />
             <div className="form-group">
                <label>用户名称</label>
                  <input className="form-control" placeholder="用户名" name="show_name" pattern="^.{2,10}$" title="用户名必须为2~10个字符"
                                      value={this.props.user_info.show_name} onChange={this.handleChange} />
             </div>

             <div className="form-group">
                <label>设置密码</label>
                  <input type="password" className="form-control" placeholder="修改密码才需填写" name="password"
                                defaultValue={this.state.pwd}  ref="password" />
             </div>

             <div className="form-group">
                <label>重复密码</label>
                  <input type="password" className="form-control" placeholder="修改密码才需填写" name="password2"
                             defaultValue={this.state.pwd2} ref="password2" />
             </div>

             <div className="form-group">
                <label>设置权限</label>
                {check_box}
             </div>

             <button type="button" className="btn btn-secondary" onClick={this.handleClick}>取消</button>
             <button type="submit" className="btn btn-success">修改</button>
           </form>
         </div>
       </div>
     )
   }
 })
