var FairHospital = React.createClass({
  getInitialState: function() {
    return {
      fair_hospitals: this.props.fair_hospitals,
      fair: this.props.fair,
      new_display: false,
      edit_display: false,
      search_display: false,
      search_show: 'show',
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
      let fair_hospital_new = this.state.new_display ? <FairHospitalNew dad={this} /> : '',
          fair_hospital_edit = this.state.edit_display ? <FairHospitalEdit dad={this} /> : '',
          fair_hospital_search = this.state.search_display ? <FairHospitalSearch dad={this} /> : ''

      return (
        <div className="main">
          <FairHospitalBtn handleClick={this.handleClick}/>
          <FairHospitalTable fair_hospitals={this.state.fair_hospitals} dad={this} />
          {fair_hospital_new}
          {fair_hospital_edit}
          {fair_hospital_search}
        </div>
      )
    }
})


/*********** 新建按钮 ************/
var FairHospitalBtn = React.createClass({
  render: function() {
    return (
      <div className="handle-button">
        <button className="btn btn-info pull-right" onClick={this.props.handleClick} name="search_display" value="true" >添加机构</button>
      </div>
    )
  }
})


/*********** 机构列表 ***********/
var FairHospitalTable = React.createClass({
  getInitialState: function() {
    return {

    }
  }
  ,render: function() {
    return (
      <table className="table table-bordered">
        <FairHospitalTableHead />
        <FairHospitalTableContent fair_hospitals={this.props.fair_hospitals} dad={this.props.dad} />
      </table>
    )
  }
})

var FairHospitalTableHead = React.createClass({
  render: function() {
    return (
      <thead>
        <tr>
          <th>序号</th>
          <th>机构名称</th>
          <th>相关介绍</th>
          <th>入驻时间</th>
          <th>发布职位数</th>
          <th>收到简历数</th>
          <th>机构图片</th>
          <th>状态</th>
          <th>操作</th>
          <th>修改</th>
        </tr>
      </thead>
    )
  }
})

var FairHospitalTableContent = React.createClass({
  render: function() {
    return (
      <tbody>
        {
          this.props.fair_hospitals.map(
            function(fair_hospital, index) {
              return (<FairHospitalItem key={fair_hospital.id} fair={fair_hospital} index={index} dad={this.props.dad} />)
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var FairHospitalItem = React.createClass({
  clickEdit: function() {
    this.props.dad.setState({
      fair_hospital: this.props.fair_hospital,
      index: this.props.index,
      edit_display: true
    })
  }
  ,render: function() {
    let fair_hospital = this.props.fair_hospital,
        index = this.props.index + 1

    return (
      <tr>
        <td>{index}</td>
        <td>{fair_hospital.name}</td>
        <td>{fair_hospital.create_at.slice(0, 10)}</td>
        <td>{fair_hospital.end_at.slice(0, 10)}</td>
        <td>参加机构数</td>
        <td>发布职位数</td>
        <td>收到简历数</td>
        <td>{trans_fair(fair_hospital.status)}</td>
        <td><a href={"/admin/fairs/" + fair.id + "/fair_hospitals"} className="btn btn-primary btn-form">管理</a></td>
        <td><button onClick={this.clickEdit} className="btn btn-default btn-form">修改</button></td>
      </tr>
    )
  }
})
