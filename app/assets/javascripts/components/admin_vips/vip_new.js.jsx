var AdminVipNew = React.createClass({
  getInitialState: function() {
    return {
      status: '',
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
          alert(data.responseText)
          this.props.dad.setState({
            vip_info: {
              new_display: false,
            }

          })
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
               <AdminVipCheckbox handleCheck={this.handleCheck} />
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
    return (
      <div>
        <label className="checkbox-inline">
          <input type="radio" name="status" onChange={this.props.handleCheck} value={true}/>启用
        </label>

        <label className="checkbox-inline">
          <input type="radio" name="status" onChange={this.props.handleCheck} value={false} />禁止
        </label>
      </div>
    )
  }
})

/********************** 表单验证 **********************/
function formVipNew() {
  $('#form_vip_new').validate({
    rules: {
      may_set_top: {
        required: true,
        minlength: 10,
      }
    },
    messages: {
      may_set_top: {
        required: '不能为空',
        minlength: '太短了',
      }
    },
    errorPlacement: function ( error, element ) {
      // Add the `help-block` class to the error element
      error.addClass( "help-block" );

      // Add `has-feedback` class to the parent div.form-group
      // in order to add icons to inputs
      element.parents( ".form-group" ).addClass( "has-feedback" );

      if ( element.prop( "type" ) === "checkbox" ) {
        error.insertAfter( element.parent( "label" ) );
      } else {
        error.insertAfter( element );
      }

      // Add the span element, if doesn't exists, and apply the icon classes to it.
      if ( !element.next( "span" )[ 0 ] ) {
        $( "<span class='glyphicon glyphicon-remove form-control-feedback'></span>" ).insertAfter( element );
      }
    },
    success: function ( label, element ) {
      // Add the span element, if doesn't exists, and apply the icon classes to it.
      if ( !$( element ).next( "span" )[ 0 ] ) {
        $( "<span class='glyphicon glyphicon-ok form-control-feedback'></span>" ).insertAfter( $( element ) );
      }
    },
    highlight: function ( element, errorClass, validClass ) {
      $( element ).parents( ".form-group" ).addClass( "has-error" ).removeClass( "has-success" );
      $( element ).next( "span" ).addClass( "glyphicon-remove" ).removeClass( "glyphicon-ok" );
    },
    unhighlight: function ( element, errorClass, validClass ) {
      $( element ).parents( ".form-group" ).addClass( "has-success" ).removeClass( "has-error" );
      $( element ).next( "span" ).addClass( "glyphicon-ok" ).removeClass( "glyphicon-remove" );
    }
  })
}
