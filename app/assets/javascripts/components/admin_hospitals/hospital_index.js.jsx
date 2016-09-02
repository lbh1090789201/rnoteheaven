  var AdminHospital = React.createClass({
  getInitialState: function() {
    return {
      hospitals: this.props.data,
      plans: this.props.plan,
      new_display: false,
      mass_display: false,
      hos_info: {
        index: 0,
        hospital: '',
        edit_display: false,
      },
    }
  }
  ,componentDidMount: function() {
    formHospitalSearch('#form_hospital_search')
  }
  ,handleClick: function() {
    this.setState({
      new_display: true
    })
  }
  ,handleClickMass: function() {
    this.setState({
      mass_display: true
    })
  }
  ,render: function() {
    var edit_hospital = this.state.hos_info.edit_display ? <AdminEditHospital plans={this.state.plans} data={this.state.hos_info.hospital} dad={this} /> : '',
        new_hospital = this.state.new_display ? <AdminHospitalNew plans={this.state.plans} dad={this} /> : '',
        mass_new_hospital = this.state.mass_display ? <AdminHospitalMassNew plans={this.state.plans} dad={this} /> : ''

    return (
      <div className="main">
        <AdminHospitalForm data={this.state.plans} dad={this} />
        <div className="handle-button">
          <button className="btn btn-info pull-right" onClick={this.handleClickMass} name="new_display" >批量创建</button>
          <button className="btn btn-info pull-right" onClick={this.handleClick} name="new_display" >新建</button>
        </div>
        <AdminHospitalTable hospitals={this.state.hospitals} dad={this}/>
        {edit_hospital}
        {new_hospital}
        {mass_new_hospital}
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
  ,handleFocus: function(e) {
    let id = e.target.id
    myDatePicker(id, 'time_before', 'time_after')
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
    if(invalid('#form_hospital_search')) return // 不合法就返回
    $(".pagination").hide()

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
      <form className='form-inline' encType="multipart/form-data" onSubmit={this.handleSubmit} id="form_hospital_search">
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

        <div className='form-group col-sm-2'>
          <input type="text" id="time_before" className="form-control" placeholder='开始时间' name='time_before'
                 onFocus={this.handleFocus} ref="time_before" />
        </div>

        <div className='form-group col-sm-2'>
          <input type="text" id="time_after" className="form-control" placeholder='结束时间' name='time_after'
                 onFocus={this.handleFocus} ref="time_after" />
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
            <th title="可发布职位限额">可发布</th>
            <th title="可置顶职位限额">可置顶</th>
            <th title="可接受简历限额">可接收</th>
            <th title="可查看简历限额">可查看</th>
            <th>级别</th>
            <th>状态</th>
            <th>入驻时间</th>
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
  ,handleDelete: function() {
    var hospital_id = this.props.data.id,
        index = this.props.index,
        hospitals = this.props.dad.state.hospitals

    if(confirm("确定删除"+this.props.data.name+"机构?")){
      $.ajax({
        url: "/admin/hospitals/"+hospital_id,
        type: "DELETE",
        data: {id: hospital_id},
        success: function(){
          hospitals.splice(index,1)
          this.props.dad.setState({
            hospitals: hospitals
          })
        }.bind(this),
        error: function(){
          alert("删除"+this.props.data.name+"机构失败")
        },
      })
    }

  }
  ,render: function() {
    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td>{this.props.data.contact_number}</td>
        <td className="limit-width">{this.props.data.name}</td>
        <td title="可发布职位限额">{this.props.data.may_release}</td>
        <td title="可置顶职位限额">{this.props.data.may_set_top}</td>
        <td title="可接受简历限额">{this.props.data.may_receive}</td>
        <td title="可查看简历限额">{this.props.data.may_view}</td>
        <td className="limit-width">{this.props.data.vip_name}</td>
        <td>{this.props.data.status}</td>
        <td>{this.props.data.created_at.slice(0, 10)}</td>
        <td>
          <button onClick={this.handleClick} className="btn btn-default btn-form">修改</button>
          <button onClick={this.handleDelete} className="btn btn-danger btn-form">删除</button>
        </td>
      </tr>
    )
  }
})

/********************** 入住机构表单验证 **********************/
 function formHospital(id) {
   $(id).validate({
     rules: {
       contact_number: {
         required: true,
         pattern: '^1[345678][0-9]{9}$'
       },
       hospital_name: {
         required: true,
         rangelength: [2, 20],
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
       },
       contact_person: {
         required: true,
         maxlength: 10,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
       },
       lng: {
         required: true,
         range: [73, 135],
       },
       lat: {
         required: true,
         range: [4, 53],
       },
       location: {
         required: true,
         rangelength: [2, 30],
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9-,， ]+$',
       },
       introduction: {
         required: true,
         rangelength: [6, 800],
       }
     },
     messages: {
       contact_number: {
         pattern: '手机号码不合法'
       },
       hospital_name: {
         pattern: '请输入中文、英文或数字'
       },
       contact_person: {
         pattern: '请输入中文、英文或数字'
       },
       location: {
         pattern: '请输入中文、英文、数字或逗号，-'
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

 function formHospitalSearch(id) {
   $(id).validate({
     rules: {
       hospital_name: {
         maxlength: 20,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
       },
       time_before: {
         date: true,
       },
       time_after: {
         date: true
       }
     },
     messages: {
       hospital_name: {
         maxlength: '最多20个字符',
         pattern: '请输入中文、英文或数字'
       }
     }
   })
 }
