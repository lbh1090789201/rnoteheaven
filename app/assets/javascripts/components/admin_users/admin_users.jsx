var AdminUser = React.createClass({
  getInitialState: function() {
    return {
      users: this.props.users,
      user_info: {
        uid: '',
        show_name: '',
        role: '',
        edit_display: false,
        new_display: false,
        index: 0,
      }
    }
  }
  ,handleClick: function() {
    this.setState({
      user_info: {
        new_display: true
      }
    })
  }
  ,render: function() {
    var edit = this.state.user_info.edit_display ? <AdminUserEdit user_info={this.state.user_info} dad={this}/> : '',
        new_user = this.state.user_info.new_display ? <AdminUserNew dad={this} /> : ''

    return (
      <div className="main">
        <AdminUserForm dad={this} />
        <div className="handle-button">
          <button className="btn btn-info pull-right" onClick={this.handleClick} name="new_display" >新建</button>
        </div>
        <AdminUserTable users={this.state.users} dad={this}/>
        {edit}
        {new_user}
      </div>
    )
  }
})

/********** form begin ************/
var AdminUserForm = React.createClass({
  getInitialState: function() {
    return {
      manager: '',
      time_from: '',
      time_to: '',
      show_name: '',
    }
  }
  ,componentDidMount: function() {
    formUserSearch('#form_user_search')
  }
  ,handleRadio: function(e) {
    this.setState({
      manager: e.target.value,
    })
  }
  ,handleFocus: function(e) {
      let id = e.target.id

      myDatePicker(id, 'time_from', 'time_to')
    }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_user_search')) return // 不合法就返回

    $.ajax({
      url: '/admin/users',
      type: 'GET',
      data: {
        search: true,
        manager: this.state.manager,
        time_from: this.refs.time_from.value,
        time_to: this.refs.time_to.value,
        show_name: this.refs.show_name.value,
      },
      success: function(data){
        this.props.dad.setState({users: data.users})
      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },
    })

  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit} id="form_user_search">
        <div className='form-group col-sm-12'>
          <AdminUserRadio handleRadio={this.handleRadio} />
        </div>
          <div className='form-group col-sm-3'>
            <input type="text" id="time_from" className="form-control" placeholder='开始时间' name='time_from'
                  onFocus={this.handleFocus} defaultValue={this.state.time_from} ref="time_from" />
          </div>
          <div className='form-group col-sm-3'>
            <input type="text" id="time_to" className="form-control" placeholder='结束时间' name='time_to'
                   onFocus={this.handleFocus} defaultValue={this.state.time_to} ref="time_to" />
          </div>
          <div className='form-group col-sm-3'>
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
        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="" />全部
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="jobs_manager" />职位
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="resumes_manager" />简历
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="hospitals_manager" />机构
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="fairs_manager" />专场
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="vips_manager" />套餐
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="acounts_manager" />帐号
        </label>
      </span>
    )
  }
});


/********** table begin ************/
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
          <th>登录名</th>
          <th>用户名称</th>
          <th>用户类型</th>
          <th>创建时间</th>
          <th>操作</th>
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
  handleClick: function() {
    this.props.dad.setState({
      user_info: {
        show_name: this.props.data.show_name,
        role: this.props.data.user_type,
        uid: this.props.data.id,
        index: this.props.index - 1,
        edit_display: true,
      }
    })
  }
  ,handleDel: function() {
    if(confirm('确定要删除用户' + this.props.data.show_name + '?')) {
      let uid = this.props.data.id,
          index = this.props.index - 1,
          users = this.props.dad.state.users

      $.ajax({
        url: '/admin/users',
        type: 'DELETE',
        data: {
          id: uid
        },
        success: function(data){
          users.splice(index, 1)

          this.props.dad.setState({
             users: users
          })
        }.bind(this),
        error: function(data){
          alert('删除用户失败。')
        }
      })
    }
  }
  ,render: function() {
    return (
      <tr>
        <td>{this.props.index}</td>
        <td>{this.props.data.username}</td>
        <td className="limit-width">{this.props.data.show_name}</td>
        <td>{transType(this.props.data.user_type)}</td>
        <td>{this.props.data.created_at.slice(0, 10)}</td>
        <td><button onClick={this.handleClick} className="btn btn-default btn-form">修改</button></td>
        <td><button onClick={this.handleDel} className="btn btn-danger btn-form">删除</button></td>
      </tr>
    )
  }
})

/*********** 转译用户类型 ***********/
function transType(e)  {
   if(e == "admin") {
     return "超级管理员"
   } else if (e == "platinum") {
     return "管理员"
   } else {
     return "未知"
   }
 }



 /********************** 表单验证 **********************/
 function formUser(id) {
   $(id).validate({
     rules: {
       username: {
         required: true,
         rangelength: [5,20],
         pattern: '^[a-zA-Z][a-zA-Z0-9]{5,19}',
       },
       show_name: {
         required: true,
         rangelength: [2, 10],
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
       },
       password: {
         minlength: 6
       },
       password2: {
         minlength: 6
       }
     },
     messages: {
       username: {
         maxlength: '用户名为5~20字符',
         pattern: '请输入英文或数字，以英文开头'
       },
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
       username: {
         rangelength: [5,20],
         pattern: '^[a-zA-Z][a-zA-Z0-9]{5,19}',
       },
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
       username: {
         maxlength: '用户名为5~20字符',
         pattern: '请输入英文或数字，以英文开头'
       },
       show_name: {
         maxlength: '最多10个字符',
         pattern: '请输入中文、英文或数字'
       }
     }
   })
 }
