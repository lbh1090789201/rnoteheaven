var AdminResumeResumeDdeliver = React.createClass({
  getInitialState: function() {
    return {
      resume_delivers: this.props.data,
      ids: [],
      checked: '',
    }
  }
  ,handleClick: function() {
    let ids = this.state.ids
    
    if(ids.length == 0) {
      myInfo("请勾选需要导出的简历！", 'fail')
      return
    }
    $("#apply_record_id").val(ids)
    $("#form_deliver").trigger("click")
    myInfo("已成功导出简历列表！", 'success')
  }
  ,render: function() {
    return (
      <div className="admin-jobs">
        <AdminResumeResumeDdeliverForm dad={this} />

        <form action="/api/v1/admin_resumes" method="post" style={{"display":"none"}}>
          <input type="text" name="ids" id="apply_record_id" />
          <input type="submit" id="form_deliver" />
        </form>
        <div className="handle-button">
          <span>详细信息</span>
          <button className="btn btn-info pull-right" onClick={this.handleClick} name="passBtn" value="release">导出</button>
        </div>

        <AdminResumeResumeDdeliverTable dad={this} />
      </div>
    )
  }
})


/**********AdminResumeResumeDdeliverForm*********/
var AdminResumeResumeDdeliverForm = React.createClass({
  componentDidMount: function() {
    formJobCheck('#form_resume_deliver')
  }
  ,handleFocus: function(e) {
      let id = e.target.id
      myDatePicker(id, 'time_from', 'time_to')
    }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_resume_deliver')) return // 不合法就返回

    $.ajax({
      url: "/admin/resumes/resume_deliver",
      type: "GET",
      data: {
        time_from: this.refs.time_from.value,
        time_to: this.refs.time_to.value,
        name: this.refs.name.value,
        search: true
      },
      success: function(data) {
        resume_delivers = data.resume_delivers

        this.props.dad.setState({
          resume_delivers: resume_delivers
        })
      }.bind(this),
      error: function(data) {
        console.log(data)
        if(data) {
          data_info = JSON.parse(data.responseText)
          myInfo(data_info["info"], 'fail')
        }else{
          myInfo("查询失败", 'fail')
        }
      }.bind(this)
    })
  }
  ,render: function() {
    return (
      <form onSubmit={this.handleSubmit} id="form_resume_deliver">

        <div className="col-sm-1">
          <span>投递时间:</span>
        </div>

        <div className="col-sm-3">
          <input type="text" name="time_from" ref="time_from" id="time_from" className="form-control"
                        placeholder="从"  onFocus={this.handleFocus} />
        </div>

        <div className="col-sm-3">
          <input type="text" name="time_to" ref="time_to" id="time_to" className="form-control"
                        placeholder="至" onFocus={this.handleFocus} />
        </div>

        <div className="col-sm-4">
          <input type="text" name="name" ref="name" className="form-control" placeholder="机构名称" />
        </div>

        <button type='submit' className='btn btn-primary search'>查询</button>
      </form>
    )
  }
})


/************AdminResumeResumeDdeliverTable*****************/
var AdminResumeResumeDdeliverTable = React.createClass({
  handleClick: function(e) {
    let checked = e.target.checked,
        ids = [],
        resume_delivers = this.props.dad.state.resume_delivers

    if(checked){
      $("input[type='checkbox']").prop("checked", true);
      for(let i=0;i<resume_delivers.length;i++) {
        ids.push(resume_delivers[i].apply_record.id)
      }
    }else{
      $("input[type='checkbox']").prop("checked", false);
    }

    this.props.dad.setState({
      ids: ids
    })
  }
  ,render: function(){
    return (
      <table className="table table-bordered">
        <thead>
          <tr>
            <td>序号</td>
            <td>投递职位</td>
            <td>投递公司</td>
            <td>姓名</td>
            <td>年龄</td>
            <td>电话</td>
            <td>最高学历</td>
            <td>工作年限</td>
            <td>专业</td>
            <td>毕业院校</td>
            <td>投递时间</td>
            <td>
              <input type="checkbox" name="all" onClick={this.handleClick} />
            </td>
          </tr>
        </thead>
        <tbody>
          {
            this.props.dad.state.resume_delivers.map(function(resume_deliver, index) {
              return (
                <AdminResumeResumeDdeliverTableTbody key={resume_deliver.apply_record.id} data={resume_deliver} dad={this.props.dad} index={index} />
              )
            }.bind(this))
          }
        </tbody>
      </table>
    )
  }
})


var AdminResumeResumeDdeliverTableTbody = React.createClass({
  handleClick: function(e) {
    let id = e.target.id,
        checked = e.target.checked,
        ids = this.props.dad.state.ids

    if(checked){
      ids.push(id)
    }else{
      for(let i=0;i<ids.length;i++) {
        if(ids[i] == id) {
          ids.splice(i,1)
        }
      }
    }

    this.props.dad.setState({
      ids: ids
    })
  }
  ,render: function() {
    let data = this.props.data
    let major = function(){
          let majors
          data.major == null ? majors=[] : majors=data.major
          if(majors.length != 0) {
            let majorString = majors.join("/")
            return majorString
          }else{
            return ""
          }
        }
    let college =  function() {
      let colleges
      data.college == null ? colleges=[] : colleges=data.college
      if(colleges.length != 0) {
        let collegeString = colleges.join("/")
        return collegeString
      }else{
        return ""
      }
    }

    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td>{data.apply_record.job_name}</td>
        <td>{data.hospital_name}</td>
        <td>{data.apply_record.show_name}</td>
        <td>{data.apply_record.age}</td>
        <td>{data.cellphone}</td>
        <td>{data.apply_record.highest_degree}</td>
        <td>{data.apply_record.start_work_at}</td>
        <td>{major()}</td>
        <td>{college()}</td>
        <td>{data.apply_record.created_at.substring(0,10)}</td>
        <td>
            <input type="checkbox" name="checkedbox" id={data.apply_record.id} onClick={this.handleClick} />
        </td>
      </tr>
    )
  }
})
