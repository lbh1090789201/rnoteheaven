var AdminUser = React.createClass({
  getInitialState: function() {
    return {
      users: this.props.users
    }
  }
  ,render: function() {
    return (
      <div className="main">
        <AdminUserForm dad={this} />
        <AdminUserTable users={this.state.users} />
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
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="silver" />医生
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
        <AdminUserTableContent users={this.props.users} />
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
              return(<AdminUserItem key={user.id} data={user} index={index + 1} />)
            }.bind(this)
          )
        }
        </tbody>
      )
  }
})


var AdminUserItem = React.createClass({
  render: function() {
    return (
      <tr>
        <td>{this.props.index}</td>
        <td>{this.props.data.show_name}</td>
        <td>{this.props.data.position}</td>
        <td>{this.props.data.created_at.slice(0, 10)}</td>
        <td>查看</td>
      </tr>
    )
  }
})
