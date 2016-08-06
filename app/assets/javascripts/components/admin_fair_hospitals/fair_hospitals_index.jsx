var FairHospital = React.createClass({
  getInitialState: function() {
    return {
      fair_hospitals: this.props.fair_hospitals,
      fair_hospital: '',
      index: '',
      fair: this.props.fair,
      gold: '',
      new_display: false,
      edit_display: false,
      search_display: false,
      close: this.props.close,
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
          {fair_hospital_search}
          {fair_hospital_new}
          {fair_hospital_edit}
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
              return (<FairHospitalItem key={fair_hospital.id} fair_hospital={fair_hospital} index={index} dad={this.props.dad} />)
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var FairHospitalItem = React.createClass({
  getInitialState: function() {
    return {
      tdStyle: {
        maxWidth: '120px',
        overflow: 'hidden',
        whiteSpace: 'nowrap',
        textOverflow: 'ellipsis',
      }
    }
  }
  ,clickEdit: function() {
    this.props.dad.setState({
      fair_hospital: this.props.fair_hospital,
      index: this.props.index,
      edit_display: true
    })
  }
  ,ChangeStatus: function(e) {
    let fair_id = this.props.dad.state.fair.id,
        fair_hospital_id = this.props.fair_hospital.id,
        index = this.props.index,
        status_zh = trans_fair_hospital(e.target.value)

    $.ajax({
      url: '/admin/fairs/' + fair_id + '/fair_hospitals/' + fair_hospital_id,
      type: 'PATCH',
      data: {
        status: e.target.value,
      },
      success: function(data){
        let  fair_hospitals = this.props.dad.state.fair_hospitals

        fair_hospitals[index] = data.fair_hospital
        this.props.dad.setState({
           fair_hospitals: fair_hospitals
        })


        myInfo(`${status_zh}成功！`, 'success')
      }.bind(this),
      error: function(data){
        myInfo(`${status_zh}失败。`, 'fail')
      }
    })
  }
  ,render: function() {
    let fair_hospital = this.props.fair_hospital,
        index = this.props.index + 1

    return (
      <tr>
        <td>{index}</td>
        <td style={this.state.tdStyle}>{fair_hospital.hospital_name}</td>
        <td style={this.state.tdStyle}>{fair_hospital.intro}</td>
        <td>{fair_hospital.created_at.slice(0, 10)}</td>
        <td>{fair_hospital.jobs_count}</td>
        <td>{fair_hospital.resumes_count}</td>
        <td>{fair_hospital.banner == null  ? '未上传' : '已上传'}</td>
        <td>{trans_fair_hospital(fair_hospital.status)}</td>
        <td>
          <button className="btn btn-primary btn-form" value={fair_hospital.status == "pause" ? 'on' : 'pause'}
                  onClick={this.ChangeStatus}>{fair_hospital.status == "on" ? '暂停' : '参与'}</button>
                <button className="btn btn-danger btn-form" value="quit"
                  onClick={this.ChangeStatus}>退出</button>
          </td>
        <td><button onClick={this.clickEdit} className="btn btn-default btn-form">修改</button></td>
      </tr>
    )
  }
})

/********** 转译机构状态 ************/
function trans_fair_hospital(status) {
  switch (status) {
    case 'on':
      return '参与'
      break
    case 'pause':
      return '暂停'
      break
    case 'quit':
      return '退出'
      break
    default:
      return '未知'
  }
}


/********************** 专场医院验证 **********************/
 function formFairHospital(id) {
   $(id).validate({
     rules: {
       contact_person: {
         required: true,
         maxlength: 10,
         pattern: '^[\u4e00-\u9fa5_a-zA-Z0-9]+$'
       },
       contact_number: {
         pattern: '1[0-9]{10}'
       },
       intro: {
         rangelength: [6, 300]
       }
     },
     messages: {
       contact_person: {
         pattern: '请输入中文、英文或数字'
       },
       contact_number: {
         pattern: '号码不合法'
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

 function formFairHospitalSearch(id) {
   $(id).validate({
     rules: {
       id: {
         maxlength: 11,
         digits: true
       },
       name: {
         maxlength: 20,
       },
       contact_person: {
         maxlength: 10,
       }
     },
     messages: {}
   })
 }
