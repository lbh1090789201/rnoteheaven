var FairNow = React.createClass({
  getInitialState: function() {
    return {
      new_display: false,
      fairs: this.props.fairs,
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
    let fair_new = this.state.new_display ? <FairNew dad={this} /> : ''

    return (
      <div className="main">
        <FairForm />
        <FairBtn handleClick={this.handleClick}/>
        <FairTable fairs={this.state.fairs} dad={this} />
        {fair_new}
      </div>
    )
  }
})

/*********** 发布按钮 ************/
var FairBtn = React.createClass({
  render: function() {
    return (
      <div className="handle-button">
        <button className="btn btn-info pull-right" onClick={this.props.handleClick} name="new_display" value="true" >发布专场</button>
      </div>
    )
  }
})

/*********** 搜索表格 ************/
var FairForm = React.createClass({
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
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-12'>
          <FairRadio handleRadio={this.handleRadio} />
        </div>
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
                   defaultValue={this.state.show_name} ref="show_name" />
          </div>
          <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})

var FairRadio = React.createClass({
  render: function() {
    return (
      <span>
        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="processing" />当前专场
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="pause" />暂停专场
        </label>
      </span>
    )
  }
});


/*********** 专场列表 ***********/
var FairTable = React.createClass({
  getInitialState: function() {
    return {

    }
  }
  ,render: function() {
    return (
      <table className="table table-bordered">
        <FairTableHead />
        <FairTableContent fairs={this.props.fairs} dad={this.props.dad} />
      </table>
    )
  }
})

var FairTableHead = React.createClass({
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
          <th>详情</th>
        </tr>
      </thead>
    )
  }
})

var FairTableContent = React.createClass({
  render: function() {
    return (
      <tbody>
        {
          this.props.fairs.map(
            function(fair, index) {
              return (<FairItem key={fair.id} fair={fair} index={index} dad={this.props.dad} />)
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var FairItem = React.createClass({
  render: function() {
    let fair = this.props.fair,
        index = this.props.index + 1

    return (
      <tr>
        <td>{index}</td>
        <td>{fair.name}</td>
        <td>{fair.begin_at.slice(0, 10)}</td>
        <td>{fair.end_at.slice(0, 10)}</td>
        <td>参加机构数</td>
        <td>发布职位数</td>
        <td>收到简历数</td>
        <td>{trans_fair(fair.status)}</td>
        <td>详情</td>
      </tr>
    )
  }
})

/********** 转译专场状态 ************/
function trans_fair(status) {
  switch (status) {
    case 'processing':
      return '进行中'
      break
    case 'pause':
      return '已暂停'
      break
    default:
      return '未知'
  }
}
