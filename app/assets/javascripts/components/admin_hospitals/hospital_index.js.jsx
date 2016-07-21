var AdminHospital = React.createClass({
  getInitialState: function() {
    return {
      hospitals: this.props.data,
      plans: this.props.plan,
      new_display: false,
      hos_info: {
        index: 0,
        hospital: '',
        edit_display: false,
      },
    }
  }
  ,handleClick: function() {
    this.setState({
      new_display: true
    })
  }
  ,render: function() {
    var edit_hospital = this.state.hos_info.edit_display ? <AdminEditHospital plans={this.state.plans} data={this.state.hos_info.hospital} dad={this} /> : '',
        new_hospital = this.state.new_display ? <AdminHospitalNew plans={this.state.plans} dad={this} /> : ''

    return (
      <div className="main">
        <AdminHospitalForm data={this.state.plans} dad={this} />
        <div className="handle-button">
          <button className="btn btn-info pull-right" onClick={this.handleClick} name="new_display" >新建</button>
        </div>
        <AdminHospitalTable hospitals={this.state.hospitals} dad={this}/>
        {edit_hospital}
        {new_hospital}
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
  ,handleChange: function(e) {
    this.setState({
      property: e.target.value,
    })
  }
  ,handleSelect: function(e) {
    this.setState({
      vip_id: e.target.value,
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()

    let hospital_name = this.refs.hospital_name.value,
        time_before = this.refs.time_before.value,
        time_after = this.refs.time_after.value,
        property = this.state.property,
        vip_id = this.state.vip_id,
        hide_search = this.refs.hide_search.value

    $.ajax({
      url: "/admin/hospitals",
      type: "GET",
      data: {
        hospital_name: hospital_name,
        time_before: time_before,
        time_after: time_after,
        property: property,
        vip_id: vip_id,
        hide_search: hide_search
      },
      success: function(data) {
        this.props.dad.setState({
          hospitals: data.hospital,
        })
      }.bind(this),
      error: function(data) {
        console.log(data.responseText)
      },
    })
  }
  ,render: function() {
    var plans = this.props.data,
        select_vip = plans.map(
          function(plan, index) {
            return (
              <AdminHosPlanItem key={plan.id} data={plan} dad={this} />
            )
          }.bind(this)
        )

    return (
      <form className='form-inline' encType="multipart/form-data" onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-12'>
          <AdminHospitalRadio handleChange={this.handleChange} />
        </div>

        <div className='form-group col-sm-3'>
          <input type="text" className="form-control" placeholder='机构名称' name='hospital_name'
                  ref="hospital_name" />
        </div>

        <div className='form-group col-sm-2'>
          <select onChange={this.handleSelect} className="form-control">
            <option value=''>套餐级别</option>
            {select_vip}
          </select>
        </div>

        <div className='form-group col-sm-2 form-margin-right'>
          <input type="date" className="form-control" placeholder='开始时间' name='time_before'
                 ref="time_before" />
        </div>

        <div className="underline" style={{'float':'left','paddingTop':'8px'}}>——</div>

        <div className='form-group col-sm-2 form-margin-left'>
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
        <input onChange={this.props.handleChange} name="goodRadio" type="radio" value="" />全部
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleChange} name="goodRadio" type="radio" value="综合医院" />综合医院
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleChange} name="goodRadio" type="radio" value="专科医院" />专科医院
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleChange} name="goodRadio" type="radio" value="民营医院" />民营医院
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleChange} name="goodRadio" type="radio" value="公立诊所" />公立诊所
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleChange} name="goodRadio" type="radio" value="民营诊所" />民营诊所
        </label>

      </span>
    )
  }
});

/*************下拉框组件***************/
var AdminHosPlanItem = React.createClass({
  handleChange: function(e) {
    this.props.dad.setState({
      vip_id: e.target.value,
    })
    console.log(333333)
  }
  ,render: function() {
    return (
      <option value={this.props.data.id} name="vip_id" ref="vip_id">{this.props.data.name}</option>
    )
  }
})


/*************Table组件*****************/
var AdminHospitalTable = React.createClass({
  render: function() {
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
        <AdminHospitalTableCt data={this.props.dad.state.hospitals} dad={this.props.dad} />
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
    let is_new
    this.props.data.may_release == undefined ? is_new = 'disabled' : is_new = ''
    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td>{this.props.data.contact_number}</td>
        <td>{this.props.data.name}</td>
        <td>{this.props.data.may_release}</td>
        <td>{this.props.data.may_set_top}</td>
        <td>{this.props.data.may_receive}</td>
        <td>{this.props.data.may_view}</td>
        <td>{this.props.data.vip_name}</td>
        <td>
          <button onClick={this.handleClick} className={"btn btn-default btn-form " + is_new} >修改</button>
        </td>
      </tr>
    )
  }
})
