var AdminUser = React.createClass({
  getInitialState: function() {
    return {
      users: this.props.users,
      user_info: {
        show_name: '',
        role: 'copper',
        edit_diaplay: false,
      }
    }
  }
  ,render: function() {
    return (
      <div className="main">
        <AdminUserForm dad={this} />
        <AdminUserTable users={this.state.users} dad={this}/>
        <AdminUserEdit user_info={this.state.user_info}/>
      </div>
    )
  }
})


var AdminUserForm = React.createClass({
  getInitialState: function() {
    return {
      role: '',
      time_from: '',
      time_to: '',
      show_name: '',
    }
  }
  ,handleRadio: function(e) {
    this.setState({
      role: e.target.value,
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    $.ajax({
      url: '/admin/users',
      type: 'GET',
      data: {
        search: true,
        role: this.state.role,
        time_from: this.refs.time_from.value,
        time_to: this.refs.time_to.value,
        show_name: this.refs.show_name.value,
      },
      success: function(data){
                // console.log(data.users)
                console.log(this.props.dad)
        this.props.dad.setState({users: data.users})
      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },
    })

  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-12'>
          <AdminUserRadio handleRadio={this.handleRadio} />
        </div>
          <div className='form-group col-sm-3'>
            <input type="date" className="form-control" placeholder='开始时间' name='time_from'
                   defaultValue={this.state.time_from} ref="time_from" />
          </div>
          <div className='form-group col-sm-3'>
            <input type="date" className="form-control" placeholder='结束时间' name='time_to'
                   defaultValue={this.state.time_to} ref="time_to" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='用户名' name='show_name'
                   defaultValue={this.state.show_name} ref="show_name" />
          </div>
          <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})


var AdminUserRadio = React.createClass({
  render: function() {
    return (
      <span>
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="" />全部
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="copper" />医生
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="gold" />医院
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="admin" />管理员
      </span>
    )
  }
});


var AdminUserTable = React.createClass({
  render: function() {
    return (
      <table className="table table-bordered">
        <AdminUserTableHead />
        <AdminUserTableContent users={this.props.users} dad={this.props.dad} />
      </table>
    )
  }
})


var AdminUserTableHead = React.createClass({
  render: function() {
    return (
      <thead>
        <tr>
          <th>序号</th>
          <th>用户名称</th>
          <th>用户类型</th>
          <th>创建时间</th>
          <th>操作</th>
        </tr>
      </thead>
    )
  }
})


var AdminUserTableContent = React.createClass({
  render: function() {
      return(
        <tbody>
          {
            this.props.users.map(
              function(user, index) {
              return(<AdminUserItem key={user.id} data={user} index={index + 1} dad={this.props.dad}/>)
            }.bind(this)
          )
        }
        </tbody>
      )
  }
})


var AdminUserItem = React.createClass({
  getInitialState: function() {
    return {
      show_name: this.props.data.show_name,
      user_type: this.props.data.user_type,
    }
  }
  ,handleClick: function() {
    console.log(this.props.dad)
    this.props.dad.setState({
      user_info: this.state
    })
  }
  ,render: function() {
    return (
      <tr>
        <td>{this.props.index}</td>
        <td>{this.props.data.show_name}</td>
        <td>{transType(this.props.data.user_type)}</td>
        <td>{this.props.data.created_at.slice(0, 10)}</td>
        <td><button onClick={this.handleClick}>修改</button></td>
      </tr>
    )
  }
})

// 转译用户类型
function transType(e)  {
   if(e == "admin") {
     return "管理员"
   } else if (e == "gold") {
     return "医院"
   } else if (e == "copper") {
     return "求职者"
   } else {
     return "未知"
   }
 }


 var AdminUserEdit = React.createClass({
   getInitialState: function() {
     return {
       show_name: this.props.user_info.show_name,
       role: this.props.user_info.role,
       edit_diaplay: this.props.user_info.edit_diaplay,
     }
   }
   ,handleChange: function(e) {
     this.setState({
       role: e.target.value
     })
   }
   ,render: function() {
     return (
       <div className="mask-user">
         <div>
           <form>
             <div className="form-group">
                <label>用户名称</label>
                <input type="email" className="form-control" placeholder="用户名" defaultValue={this.state.show_name} ref="show_name" />
             </div>
             <div className="form-group">
                <label>配置角色</label>
                <select className="form-control" value={this.state.role} onChange={this.handleChange}>
                  <option value="copper">求职者</option>
                  <option value="gold">医院</option>
                  <option value="admin">管理员</option>
                </select>
             </div>
             <button type="button" className="btn btn-default">取消</button>
             <button type="submit" className="btn btn-success">提交</button>
           </form>
         </div>
       </div>
     )
   }
 })
