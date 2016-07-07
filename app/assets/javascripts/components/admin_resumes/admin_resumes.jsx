var AdminResume = React.createClass({
  getInitialState: function() {
    return {
      resumes: this.props.data
    }
  }
  ,render: function() {
    return (
      <div>
        <AdminResumeForm dad={this}/>
        <AdminResumeTable resumes={this.state.resumes}/>
      </div>
    )
  }
})

/*********** form begin ***********/
var AdminResumeForm = React.createClass({
  getInitialState: function() {
    return {
      rid: '',
      show_name: '',
      location: '',
      public: '',
      resume_freeze: '',
    }
  }
  ,handleSubmit: function(e) {
    e.preventDefault()

    $.ajax({
      url: '/admin/resumes',
      type: 'GET',
      data: {
        'search': true,
        'rid': this.refs.rid.value,
        'show_name': this.refs.show_name.value,
        'location': this.refs.location.value,
        'public' : this.state.public,
        'resume_freeze': this.state.resume_freeze
      },
      success: function(res) {
        console.log(res)
        console.log(this)
        this.props.dad.setState({resumes : res.resumes})
      }.bind(this),
      error: function(res){
        alert(res.responseText)
      },
    })
  }
  ,handleCheck: function(e) {
    let name = e.target.name,
        val = e.target.checked

      if(val) {
        this.setState({[name] : 1})
      } else {
        this.setState({[name] : ''})
      }
  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-12'>
          <AdminResumeCheckbox handleCheck={this.handleCheck}/>
        </div>
          <div className='form-group col-sm-3'>
            <input type="text" className="form-control" placeholder='简历编号' name='rid'
                   defaultValue={this.state.rid} ref="rid" />
          </div>
          <div className='form-group col-sm-3'>
            <input type="text" className="form-control" placeholder='用户姓名' name='show_name'
                   defaultValue={this.state.show_name} ref="show_name" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='所在省市' name='location'
                   defaultValue={this.state.location} ref="location" />
          </div>
          <button type='submit' className='btn btn-primary'>查询</button>
      </form>
    )
  }
})

var AdminResumeCheckbox = React.createClass({
  render: function() {
    return (
      <div>
        <label className="checkbox-inline">
          <input type="checkbox" name="public" onChange={this.props.handleCheck} /> 公开简历
        </label>

        <label className="checkbox-inline">
          <input type="checkbox" name="resume_freeze" onChange={this.props.handleCheck} /> 冻结简历
        </label>
      </div>
    )
  }
})


/************ table begin ************/
var AdminResumeTable = React.createClass({
  getInitialState: function() {
    return {

    }
  }
  ,render: function() {
    return (
      <table className="table table-bordered">
        <AdminResumeTableHead />
        <AdminResumeTableContent users={this.props.resumes} dad={this.props.dad} />
      </table>
    )
  }
})

var AdminResumeTableHead = React.createClass({
  render: function() {
    return (
      <thead>
        <tr>
          <th>序号</th>
          <th>简历编号</th>
          <th>用户姓名</th>
          <th>所在省市</th>
          <th>是否公开</th>
          <th>状态</th>
          <th>投递数</th>
          <th>被查看数</th>
          <th>操作</th>
          <th>选择</th>
        </tr>
      </thead>
    )
  }
})

var AdminResumeTableContent = React.createClass({
  render: function() {
    return (
      <tbody>
        {
          this.props.users.map(
            function(resume, index) {
              return(<AdminResumeItem key={resume.id} resume={resume} index={index} />)
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var AdminResumeItem = React.createClass({
  render: function() {
    let resume = this.props.resume
    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td>{resume.id}</td>
        <td>{resume.show_name}</td>
        <td>{resume.location}</td>
        <td>{resume.public ? "公开" : "隐私"}</td>
        <td>{resume.resume_freeze ? "冻结" : "正常"}</td>
        <td>{resume.apply_count}</td>
        <td>{resume.viewed_count}</td>
        <td>查看</td>
        <td><input type="checkBox" /></td>
      </tr>
    )
  }
})
