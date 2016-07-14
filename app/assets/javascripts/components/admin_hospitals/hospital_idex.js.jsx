var AdminHospital = React.createClass({
  getInitialState: function() {
    return {
      hospitals: this.props.data,
      plans: this.props.plan,
      hos_info: {
        index: 0,
        hospital: '',
        edit_display: false,
      },
    }
  }
  ,render: function() {

    var edit_hospital = this.state.hos_info.edit_display ? <AdminEditHospital data={this.state.hos_info.hospital} dad={this} /> : ''

    return (
      <div className="main">
        <AdminHospitalForm data={this.state.plans} dad={this} />
        <AdminHospitalTable hospitals={this.state.hospitals} dad={this}/>
        {edit_hospital}
      </div>
    )
  }
})


/********** form begin ************/
var AdminHospitalForm = React.createClass({
  getInitialState: function() {
    return {
      hos_name: '',
      property: '',
      vip_id: '',
    }
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    let hospital_name = this.refs.hospital_name.value,
        time_before = this.refs.time_before.value,
        time_after = this.refs.time_after.value,
        property = this.state.property,
        vip_id = this.state.vip_id

        console.log(property)

    $.ajax({
      url: "/admin/hospitals",
      type: "GET",
      data: {
        hospital_name: hospital_name,
        time_before: time_before,
        time_after: time_after,
        property: property,
        vip_id: vip_id,
      },
      seccess: function(data) {
        // console.log(data.hospital)
        this.props.dad.setState({
          hospitals: data.hospital,
        })
      }.bind(this),
      error: function(data) {
        // console.log(data.responseText)
      },
    })
  }
  ,render: function() {
    var plans = this.props.data,
        vip_plan = {id: '', name: '全部'}
        plans.unshift(vip_plan)
        select_vip = plans.map(
          function(plan, index) {
            return <AdminPlanItem key={plan.id} data={plan} dad={this} />
          }.bind(this)
        )


    return (
      <form className='form-inline' encType="multipart/form-data" onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-12'>
          <AdminHospitalRadio dad={this} />
        </div>

        <div className='form-group col-sm-3'>
          <input type="text" className="form-control" placeholder='机构名称' name='hospital_name'
                  ref="hospital_name" />
        </div>

        <div className='form-group col-sm-2'>
          <lebel>套餐级别</lebel>
          <select>
            {select_vip}
          </select>
        </div>

        <div className='form-group col-sm-3'>
          <input type="date" className="form-control" placeholder='开始时间' name='time_before'
                 ref="time_before" />
        </div>

        <div className='form-group col-sm-3'>
          <input type="date" className="form-control" placeholder='结束时间' name='time_after'
                 ref="time_after" />
        </div>

        <input type="hidden" ref="hide_search" value="search"/>
        <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})


/************单选框组件*************/
var AdminHospitalRadio = React.createClass({
  hanleChange: function(e) {
    this.props.dad.setState({
      property: e.target.value,
    })
  }
  ,render: function() {
    return (
      <span>

        <label className="checkbox-inline">
        <input onChange={this.handleChange} name="property" type="radio" value="综合医院" />综合医院
        </label>

        <label className="checkbox-inline">
        <input onChange={this.handleChange} name="property" type="radio" value="专科医院" />专科医院
        </label>

        <label className="checkbox-inline">
        <input onChange={this.handleChange} name="property" type="radio" value="民营医院" />民营医院
        </label>

        <label className="checkbox-inline">
        <input onChange={this.handleChange} name="property" type="radio" value="公立诊所" />公立诊所
        </label>

        <label className="checkbox-inline">
        <input onChange={this.handleChange} name="property" type="radio" value="民营诊所" />民营诊所
        </label>

      </span>
    )
  }
});

/*************下拉框组件***************/
var AdminPlanItem = React.createClass({
  hanleChange: function(e) {
    this.props.dad.setState({
      vip_id: e.target.value,
    })
  }
  ,render: function() {
    return (
      <option onChange={this.handleChange} value={this.props.data.id} name="vip_id" ref="vip_id">{this.props.data.name}</option>
    )
  }
})


/*************Table组件*****************/
var AdminHospitalTable = React.createClass({
  getInitialState: function() {
    return {
      hospitals: this.props.hospitals,
    }
  }
  ,render: function() {
    return (
      <table className="table table-bordered">
        <thead>
          <tr>
            <th>序号</th>
            <th>账号</th>
            <th>机构名称</th>
            <th>可发布职位数</th>
            <th>可置顶职位数</th>
            <th>可接收简历数</th>
            <th>可查看简历数</th>
            <th>级别</th>
            <th>操作</th>
          </tr>
        </thead>
        <AdminHospitalTableCt data={this.state.hospitals} dad={this.props.dad} />
      </table>
    )
  }
})


var AdminHospitalTableCt = React.createClass({
  render: function() {
    return (
      <tbody>
        {
          this.props.data.map(
            function(hospital, index) {
              return <AdminHospitalItem key={hospital.id} index={index} data={hospital} dad={this.props.dad} />
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var AdminHospitalItem =React.createClass({
  handleClick: function(e) {
    this.props.dad.setState({
      hos_info: {
        index: this.props.index,
        hospital: this.props.data,
        edit_display: true,
      }
    })
  }
  ,render: function() {
    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td>{this.props.data.id}</td>
        <td>{this.props.data.hospital_name}</td>
        <td>{this.props.data.may_release}</td>
        <td>{this.props.data.may_set_top}</td>
        <td>{this.props.data.may_receive}</td>
        <td>{this.props.data.may_view}</td>
        <td>{this.props.data.vip_name}</td>
        <td>
          <button onClick={this.handleClick} className="btn btn-default btn-form" >修改</button>
        </td>
      </tr>
    )
  }
})
