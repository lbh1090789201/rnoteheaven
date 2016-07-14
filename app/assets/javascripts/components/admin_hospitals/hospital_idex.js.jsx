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

    // console.log(this.state.hos_info.index)
    // console.log(this.state.hospitals)
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
    }
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    let vip_id = this.refs.vip_id.value,
        hospital_name = this.refs.hospital_name.value,
        property = thsi.refs.property.value,
        

    $.ajax({
      url: "/admin/hospitals",
      type: "GET",
      data: formData,
      processData: false,
      contentType: false,
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
    // console.log(this.props.data)
    var plans = this.props.data,
        vip_plan = {id: '', name: '全部'}
        plans.unshift(vip_plan)
        // console.log(plans)
        select_vip = plans.map(
          function(plan, index) {
            return <AdminPlanItem key={plan.id} data={plan} index={index} />
        })

    return (
      <form className='form-inline' encType="multipart/form-data" onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-12'>
          <AdminHospitalRadio />
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
  render: function() {
    return (
      <span>

        <label className="checkbox-inline">
        <input name="property" type="radio" ref="property" value="综合医院" />综合医院
        </label>

        <label className="checkbox-inline">
        <input name="property" type="radio" ref="property" value="专科医院" />专科医院
        </label>

        <label className="checkbox-inline">
        <input name="property" type="radio" ref="property" value="民营医院" />民营医院
        </label>

        <label className="checkbox-inline">
        <input name="property" type="radio" ref="property" value="公立诊所" />公立诊所
        </label>

        <label className="checkbox-inline">
        <input name="property" type="radio" ref="property" value="民营诊所" />民营诊所
        </label>

      </span>
    )
  }
});

/*************下拉框组件***************/
var AdminPlanItem = React.createClass({
  render: function() {
    console.log(this.props.data.id)
    return (
      <option value={this.props.data.id} name="vip_id" ref="vip_id">{this.props.data.name}</option>
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
