var AdminVipEdit = React.createClass({
  getInitialState: function() {
    return {
      vip_id: this.props.data.vip.id,
      status: this.props.data.vip.status,
      vip_info: this.props.data,
    }
  }
  ,handleCheck: function(e) {
    var val = e.target.value
    if(val == 'true') {
      this.setState({
        status: true
      })
    }else{
      this.setState({
        status: false
      })
    }
  }
  ,handleClick: function() {
    this.props.dad.setState({
      vip_info: {
        edit_diaplay: false,
      }
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    let vip_name = this.refs.vip_name.value,
        may_release = this.refs.may_release.value,
        may_set_top = this.refs.may_set_top.value,
        may_receive = this.refs.may_receive.value,
        may_view = this.refs.may_view.value,
        may_join_fairs = this.refs.may_join_fairs.value

      $.ajax({
        url: '/admin/vips/'+this.state.vip_id,
        type: 'PATCH',
        data: {
          name: vip_name,
          may_release: may_release,
          may_set_top: may_set_top,
          may_receive: may_receive,
          may_view: may_view,
          may_join_fairs: may_join_fairs,
          status: JSON.parse(this.state.status),
        },
        success: function(data){
          let index = this.state.vip_info.index,
              vips = this.props.dad.state.vips

          vips[index] = data.vip

          this.props.dad.setState({
             vips: vips,
             vip_info: {
               edit_display: false,
             }
          })
        }.bind(this),
        error: function(data){
          alert(data.responseText)
          this.props.dad.setState({
            vip_info: {
              edit_diaplay: false,
            }
          })
        },
      })
  }
  ,render: function() {
    return (
      <div className="mask-user">
        <div className="user-box">
          <form onSubmit={this.handleSubmit}>
            <div className="form-group">
               <label>套餐名称</label>
                 <input className="form-control" type="text" placeholder="用户名"
                    name="vip_name" required ref="vip_name" defaultValue={this.state.vip_info.vip.name}  />
            </div>

            <div className="form-group">
               <label>可发布职位数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_release"
                               required ref="may_release" defaultValue={this.state.vip_info.vip.may_release} />
            </div>

            <div className="form-group">
               <label>可置顶职位数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_set_top"
                           pattern="^\d+$" required title="请填整数" ref="may_set_top" defaultValue={this.state.vip_info.vip.may_set_top} />
            </div>

            <div className="form-group">
               <label>可接收简历数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_receive"
                           pattern="^\d+$" required title="请填整数" ref="may_receive" defaultValue={this.state.vip_info.vip.may_receive} />
            </div>

            <div className="form-group">
               <label>可查看简历数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_view"
                           pattern="^\d+$" required title="请填整数" ref="may_view" defaultValue={this.state.vip_info.vip.may_view} />
            </div>

            <div className="form-group">
               <label>可参加专场数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_join_fairs"
                           pattern="^\d+$" required title="请填整数" ref="may_join_fairs" defaultValue={this.state.vip_info.vip.may_join_fairs} />
            </div>

            <div className="form-group">
               <label>套餐状态</label>
               <AdminVipRadiobox handleCheck={this.handleCheck} data={this.state.status} />
            </div>

            <button type="button" className="btn btn-secondary" onClick={this.handleClick}>取消</button>
            <button type="submit" className="btn btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})


var AdminVipRadiobox = React.createClass({
  render: function() {
    var status = this.props.data,
         check_true = status ? "checked" : '',
         check_false = status ? '' : 'checked'

    return (
      <div>
        <label className="checkbox-inline">
          <input type="radio" name="status" onChange={this.props.handleCheck}
                             value={true} checked={check_true} ref="status_true" />启用
        </label>

        <label className="checkbox-inline">
          <input type="radio" name="status" onChange={this.props.handleCheck}
                            value={false} checked={check_false} ref="status_false" />禁止
        </label>
      </div>
    )
  }
})
