var AdminVipNew = React.createClass({
  getInitialState: function() {
    return {
      status: 'true',
      show_name: '',
      role: '',
      edit_display: '',
      vip_info: this.props.dad.state.vip_info,
    }
  }
  ,componentDidMount: function() {
    // 表单验证见底部
    formVipNew()
  }
  ,handleCheck: function(e) {
    this.setState({
      status: e.target.value
    })
  }
  ,handleClick: function() {
    this.props.dad.setState({
      vip_info: {
        new_display: false,
      }
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_vip_new')) return // 不合法就返回

    let vip_name = this.refs.vip_name.value,
        may_release = this.refs.may_release.value,
        may_set_top = this.refs.may_set_top.value,
        may_receive = this.refs.may_receive.value,
        may_view = this.refs.may_view.value,
        may_join_fairs = this.refs.may_join_fairs.value

      $.ajax({
        url: '/admin/vips',
        type: 'POST',
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
          let vips = this.props.dad.state.vips
          vips.push(data.vip)

          this.props.dad.setState({
             vips: vips,
             vip_info: {
               new_display: false,
             }
          })
        }.bind(this),
        error: function(data){
          myInfo('新建套餐失败，请检查表单。', 'fail')
        },
      })
  }
  ,render: function() {
    return (
      <div className="mask-user">
        <div className="user-box">
          <form onSubmit={this.handleSubmit} id="form_vip_new">
            <div className="form-group">
               <label>套餐名称</label>
                 <input className="form-control" type="text" placeholder="套餐名"
                    name="vip_name" required ref="vip_name"  />
            </div>

            <div className="form-group">
               <label>可发布职位数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_release"
                               required ref="may_release" />
            </div>

            <div className="form-group">
               <label>可置顶职位数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_set_top"
                           pattern="^\d+$" required title="请填整数" ref="may_set_top" />
            </div>

            <div className="form-group">
               <label>可接收简历数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_receive"
                           pattern="^\d+$" required title="请填整数" ref="may_receive" />
            </div>

            <div className="form-group">
               <label>可查看简历数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_view"
                           pattern="^\d+$" required title="请填整数" ref="may_view" />
            </div>

            <div className="form-group">
               <label>可参加专场数</label>
                 <input type="text" className="form-control" placeholder="请填整数" name="may_join_fairs"
                           pattern="^\d+$" required title="请填整数" ref="may_join_fairs" />
            </div>

            <div className="form-group">
               <label>套餐状态</label>
               <AdminVipCheckbox handleCheck={this.handleCheck} status={this.state.status}/>
            </div>

            <button type="button" className="btn btn-secondary" onClick={this.handleClick}>取消</button>
            <button type="submit" className="btn btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})


var AdminVipCheckbox = React.createClass({
  render: function() {
    console.log(this.props.status)
    return (
      <div>
        <label className="checkbox-inline">
          <input type="radio" name="status" checked={this.props.status == 'true'}
                 onChange={this.props.handleCheck} value={true}/>启用
        </label>

        <label className="checkbox-inline">
          <input type="radio" name="status" checked={this.props.status == 'false'}
                 onChange={this.props.handleCheck} value={false} />禁止
        </label>
      </div>
    )
  }
})


/********************** 表单验证 **********************/
function formVipNew() {
  $('#form_vip_new').validate({
    rules: {
      vip_name: {
        required: true,
        maxlength: 10,
        pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
      },
      may_release: {
        digits: true,
      },
      may_set_top: {
        required: true,
        digits: true,
      },
      may_receive: {
        digits: true,
      },
      may_view: {
        digits: true,
      },
      may_join_fairs: {
        digits: true,
      },
    },
    messages: {
      vip_name: {
        maxlength: '最多十个字符',
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
