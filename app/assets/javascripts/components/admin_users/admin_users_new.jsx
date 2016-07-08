 var AdminUserNew = React.createClass({
   getInitialState: function() {
     return {
       show_name: this.props.dad.state.user_info.show_name,
       role: this.props.dad.state.user_info.role,
       edit_diaplay: this.props.dad.state.user_info.edit_diaplay,
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
   ,handleSubmit: function(e) {
     e.preventDefault()

     $.ajax({
       url: '/api/v1/admin_roles',
       type: 'PATCH',
       data: {
         show_name: this.props.user_info.show_name,
         role: this.props.user_info.role,
         id: this.refs.id.value
       },
       success: function(data){
         let index = this.props.dad.state.user_info.index,
             users = this.props.dad.state.users

         users[index] = data.user

         this.props.dad.setState({
            users: users,
            user_info: {
              edit_diaplay: false,
            }
         })
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
   ,render: function() {
     return (
       <div className="mask-user" style={{"display": this.props.user_info.edit_diaplay}}>
         <div className="user-box">
           <form onSubmit={this.handleSubmit}>
             <input onChange={this.handleChange} value={this.props.user_info.uid} name="id" ref="id" style={{"display": "none"}} />
             <div className="form-group">
                <label>用户名称</label>
                  <input className="form-control" placeholder="用户名" name="show_name"
                                      value={this.props.user_info.show_name} onChange={this.handleChange} />
             </div>
             <div className="form-group">
                <label>配置角色</label>
                <select className="form-control" value={this.props.user_info.role} onChange={this.handleChange} name="role">
                  <option value="copper">求职者</option>
                  <option value="gold">医院</option>
                  <option value="admin">管理员</option>
                </select>
             </div>
             <button type="button" className="btn btn-secondary" onClick={this.handleClick}>取消</button>
             <button type="submit" className="btn btn-success">提交</button>
           </form>
         </div>
       </div>
     )
   }
 })
