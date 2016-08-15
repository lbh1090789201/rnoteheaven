var AdminVip = React.createClass({
  getInitialState: function() {
    return {
      vips: this.props.vips,
      vip_info: {
        vip_name: '',
        vip: '',
        edit_display: false,
        new_display: false,
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
    var edit_vip = this.state.vip_info.edit_display ? <AdminVipEdit dad={this} data={this.state.vip_info} /> : '',
        new_vip = this.state.vip_info.new_display ? <AdminVipNew dad={this} /> : ''

    return (
      <div className="main">
        <AdminVipForm dad={this} />
        <div className="handle-button">
          <button className="btn btn-info pull-right" onClick={this.handleClick} name="new_display" >新建套餐</button>
        </div>
        <AdminVipTable vips={this.state.vips} dad={this}/>
        {edit_vip}
        {new_vip}
      </div>
    )
  }
})

/********** form begin ************/
var AdminVipForm = React.createClass({
  getInitialState: function() {
    return {
      status: '',
      vip_name: '',
    }
  }
  ,componentDidMount: function() {
    formVipSearch('#form_vip_search')
  }
  ,handleRadio: function(e) {
    let val = e.target.value
    if(val == 'true') {
      this.setState({
        status: 1,
      })
    }else if(val == 'false') {
      this.setState({
        status: 0,
      })
    }else{
      this.setState({
        status: '',
      })
    }

  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_vip_search')) return // 不合法就返回

    $('.pagination').hide()
    $.ajax({
      url: '/admin/vips',
      type: 'GET',
      data: {
        status: this.state.status,
        vip_name: this.refs.vip_name.value,
        search: this.refs.hide_search.value,
      },
      success: function(data){
        this.props.dad.setState({
          vips: data.vip
        })
      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },
    })

  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit} id="form_vip_search">
        <div className='form-group vip-status'>
          <label>
            <span>状态:</span>
            <AdminVipRadio handleRadio={this.handleRadio} />
          </label>
        </div>

        <div className='form-group col-sm-6'>
          <input type="text" className="form-control" placeholder='套餐名称' name='vip_name'
                 defaultValue={this.state.vip_name} ref="vip_name" id="vip_name" />
        </div>

        <input type="hidden" ref="hide_search" value="search"/>
        <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})

/************单选框组件*************/
var AdminVipRadio = React.createClass({
  render: function() {
    return (
      <span>
        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="" />全部
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value={true} />启用
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value={false} />禁止
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
        <tbody id="mainContent" onLoad={this.handleload}>
          {
            this.props.vips.map(
              function(vip, index) {
              return(<AdminVipItem key={vip.id} data={vip} index={index} dad={this.props.dad}/>)
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
        index: this.props.index,
        vip: this.props.data,
        edit_display: true,
      }
    })
  }
  ,handleDel: function() {
    if(confirm('确定要删除套餐' + this.props.data.name + '?')) {
      let vip_id = this.props.data.id,
          index = this.props.index,
          vips = this.props.dad.state.vips

      $.ajax({
        url: '/admin/vips/' + vip_id,
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
          let info = JSON.parse(data.responseText)
          myInfo(info["info"], 'fail')
        }
      })
    }
  }
  ,render: function() {
    var Status = this.props.data.status

      vip_status = function() {
      if(Status == true) {
        return '启用'
      }else{
        return '禁止'
      }
    }
    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td className="limit-width">{this.props.data.name}</td>
        <td>{this.props.data.may_release}</td>
        <td>{this.props.data.may_set_top}</td>
        <td>{this.props.data.may_receive}</td>
        <td>{this.props.data.may_view}</td>
        <td>{this.props.data.may_join_fairs}</td>
        <td>{vip_status()}</td>
        <td>
          <button onClick={this.handleClick} className="btn btn-default btn-form btn-view hidden">修改</button>
          <button onClick={this.handleDel} className="btn btn-danger btn-form">删除</button>
        </td>
      </tr>
    )
  }
})


/********************** 表单验证 **********************/
function formVip(id) {
  $(id).validate({
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

function formVipSearch(id) {
  $(id).validate({
    rules: {
      vip_name: {
        maxlength: 10,
        pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
      },
    },
    messages: {
      vip_name: {
        maxlength: '最多十个字符',
        pattern: '请输入中文、英文或数字'
      }
    }
  })
}
