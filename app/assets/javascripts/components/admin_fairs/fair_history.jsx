var FairHistroy = React.createClass({
  getInitialState: function() {
    return {
      new_display: false,
      edit_display: false,
      fairs: this.props.fairs,
      fair: '',
    }
  }
  ,handleClick: function(e) {
    let key = e.target.name,
        val = JSON.parse(e.target.value);

    this.setState({
      [key]: val
    })
  }
  ,render: function() {
    let fair_new = this.state.new_display ? <FairNew dad={this} /> : '',
        fair_edit = this.state.edit_display ? <FairEdit dad={this} /> : ''

    return (
      <div className="main">
        <FairHistroyForm dad={this}/>
        <FairHistroyTable fairs={this.state.fairs} dad={this} />
        {fair_new}
        {fair_edit}
      </div>
    )
  }
})


/*********** 搜索表格 ************/
var FairHistroyForm = React.createClass({
  getInitialState: function() {
    return {
      status: '',

    }
  }
  ,handleRadio: function(e) {
    this.setState({
      status: e.target.value
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()

    $.ajax({
      url: '/admin/fairs',
      type: 'GET',
      data: {
        search: true,
        status: this.state.status,
        time_from: this.refs.time_from.value,
        time_to: this.refs.time_to.value,
        name: this.refs.name.value,
      },
      success: function(data) {
        this.props.dad.setState({
          fairs: data.fairs
        })
      }.bind(this),
      error: function(data) {
        alert('查询失败。')
      }
    })
  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
          <div className='form-group col-sm-3'>
            <input type="date" className="form-control" placeholder='开始时间' name='time_from'
                   defaultValue={this.state.time_from} ref="time_from" />
          </div>
          <div className='form-group col-sm-3'>
            <input type="date" className="form-control" placeholder='结束时间' name='time_to'
                   defaultValue={this.state.time_to} ref="time_to" />
          </div>
          <div className='form-group col-sm-3'>
            <input type="text" className="form-control" placeholder='专场名' name='name'
                   defaultValue={this.state.show_name} ref="name" />
          </div>
          <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})


/*********** 专场列表 ***********/
var FairHistroyTable = React.createClass({
  getInitialState: function() {
    return {

    }
  }
  ,render: function() {
    return (
      <table className="table table-bordered">
        <FairHistroyTableHead />
        <FairHistroyTableContent fairs={this.props.fairs} dad={this.props.dad} />
      </table>
    )
  }
})

var FairHistroyTableHead = React.createClass({
  render: function() {
    return (
      <thead>
        <tr>
          <th>序号</th>
          <th>专场名称</th>
          <th>开始时间</th>
          <th>结束时间</th>
          <th>参加机构数</th>
          <th>发布职位数</th>
          <th>收到简历数</th>
          <th>状态</th>
          <th>查看</th>
        </tr>
      </thead>
    )
  }
})

var FairHistroyTableContent = React.createClass({
  render: function() {
    return (
      <tbody>
        {
          this.props.fairs.map(
            function(fair, index) {
              return (<FairHistroyItem key={fair.id} fair={fair} index={index} dad={this.props.dad} />)
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var FairHistroyItem = React.createClass({
  handleClick: function() {

  }
  ,render: function() {
    let fair = this.props.fair,
        index = this.props.index + 1

    return (
      <tr>
        <td>{index}</td>
        <td>{fair.name}</td>
        <td>{fair.begain_at.slice(0, 10)}</td>
        <td>{fair.end_at.slice(0, 10)}</td>
        <td>参加机构数</td>
        <td>发布职位数</td>
        <td>收到简历数</td>
        <td>{trans_fair(fair.status)}</td>
        <td><button onClick={this.handleClick} className="btn btn-default btn-form">查看</button></td>
      </tr>
    )
  }
})

/********** 转译专场状态 ************/
// function trans_fair(status) {
//   switch (status) {
//     case 'processing':
//       return '进行中'
//       break
//     case 'pause':
//       return '已暂停'
//       break
//
//     default:
//       return '未知'
//   }
// }