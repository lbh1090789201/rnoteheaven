var AdminVip = React.createClass({
  getInitialState: function() {
    return {
      vips: this.props.vips,
      vip_info: {
        vip_id: '',
        vip_name: '',
        role: '',
        edit_display: false,
        new_display: false,
        view_display: false,
        index: 0,
      }
    }
  }
  ,handleClick: function() {
    this.setState({
      vip_info: {
        new_display: true,
      }
    })
  }
  ,render: function() {

    var edit_vip = this.state.vip_info.edit_display ? <AdminVipEdit dad={this} /> : '',
        new_vip = this.state.vip_info.new_display ? <AdminVipNew dad={this} /> : '',
        view_vip = this.state.vip_info.view_display ? <AdminVipView dad={this} /> : ''

    return (
      <div className="main">
        <AdminVipForm dad={this} />
        <div className="handle-button">
          <button className="btn btn-info pull-right" onClick={this.handleClick} name="new_display" >新建套餐</button>
        </div>
        <AdminVipTable vips={this.state.vips} dad={this}/>
        {edit_vip}
        {view_vip}
        {new_vip}
      </div>
    )
  }
})

/********** form begin ************/
var AdminVipForm = React.createClass({
  getInitialState: function() {
    return {
      manager: '',
      vip_name: '',
    }
  }
  ,handleRadio: function(e) {
    this.setState({
      manager: e.target.value,
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    $.ajax({
      url: '/admin/vips',
      type: 'GET',
      data: {
        manager: this.state.manager,
        vip_name: this.refs.vip_name.value,
      },
      success: function(data){
        this.props.dad.setState({vips: data.vips})
      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },
    })

  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
        <div className='form-group vip-status'>
          <label>
            <span>状态:</span>
            <AdminUserRadio handleRadio={this.handleRadio} />
          </label>
        </div>

        <div className='form-group col-sm-6'>
          <input type="text" className="form-control" placeholder='套餐名称' name='vip_name'
                 defaultValue={this.state.vip_name} ref="vip_name" id="vip_name" />
        </div>
        <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})

/************单选框组件*************/
var AdminUserRadio = React.createClass({
  render: function() {
    return (
      <span>
        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="" />全部
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value={true} />已启用
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value={false} />已禁止
        </label>
      </span>
    )
  }
});



/********** table begin ************/
var AdminVipTable = React.createClass({
  render: function() {
    return (
      <table className="table table-bordered">
        <AdminVipTableHead />
        <AdminVipTableContent vips={this.props.vips} dad={this.props.dad} />
      </table>
    )
  }
})


var AdminVipTableHead = React.createClass({
  render: function() {
    return (
      <thead>
        <tr>
          <th>序号</th>
          <th>套餐名称</th>
          <th>可发布职位数</th>
          <th>可置顶职位数</th>
          <th>可接收简历数</th>
          <th>可查看简历数</th>
          <th>可参加专场数</th>
          <th>状态</th>
          <th>操作</th>
        </tr>
      </thead>
    )
  }
})


var AdminVipTableContent = React.createClass({

  render: function(){
      return(
        <tbody>
          {
            this.props.vips.map(
              function(vip, index) {
              return(<AdminVipItem key={vip.id} data={vip} index={index + 1} dad={this.props.dad}/>)
            }.bind(this)
          )
        }
        </tbody>
      )
  }
})


var AdminVipItem = React.createClass({
  handleClick: function() {
    this.props.dad.setState({
      vip_info: {
        // show_name: this.props.data.show_name,
        // role: this.props.data.user_type,
        vip_id: this.props.data.id,
        edit_display: true,
      }
    })
  }
  ,handleView: function() {
    this.props.dad.setState({
      vip_info: {
        vip_id: this.props.data.id,
        view_display: true,
      }
    })
  }
  ,handleDel: function() {
    if(confirm('确定要删除用户' + this.props.data.show_name + '?')) {
      let uid = this.props.data.id,
          index = this.props.index - 1,
          vips = this.props.dad.state.vips

      $.ajax({
        url: '/admin/vips',
        type: 'DELETE',
        data: {
          id: vip_id
        },
        success: function(data){
          vips.splice(index, 1)

          this.props.dad.setState({
             vips: vips
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
        <td>{this.props.data.name}</td>
        <td>{this.props.data.may_release}</td>
        <td>{this.props.data.may_set_top}</td>
        <td>{this.props.data.may_receive}</td>
        <td>{this.props.data.may_view}</td>
        <td>{this.props.data.may_join_fairs}</td>
        <td>
          <button onClick={this.handleClick} className="btn btn-default btn-form">修改</button>
          <button onClick={this.handleView} className="btn btn-default btn-form">查看</button>
          <button onClick={this.handleDel} className="btn btn-danger btn-form">删除</button>
        </td>
      </tr>
    )
  }
})
