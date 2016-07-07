var AdminResume = React.createClass({
  getInitialState: function() {
    return {
      resumes: this.props.data
    }
  }
  ,render: function() {
    return (
      <div>
        <AdminResumeForm />
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
    }
  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-12'>

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
        <td>用户姓名</td>
        <td>所在省市</td>
        <td>{resume.public}</td>
        <td>{resume.resume_freeze}</td>
        <td>投递数</td>
        <td>被查看数</td>
        <td>操作</td>
        <td><input type="checkBox" /></td>
      </tr>
    )
  }
})
