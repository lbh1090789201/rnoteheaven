var AdminResume = React.createClass({
  getInitialState: function() {
    return {
      resumes: this.props.data,
      view_display: false,
      resume_id: '',
      close: this.props.close,
      avatar: this.props.avatar,
    }

  }
  ,render: function() {
    var see_resume = this.state.view_display ? <AdminResumeView dad={this} /> : ''
    return (
      <div>
        <AdminResumeForm dad={this}/>
        <AdminResumeTable dad={this} resumes={this.state.resumes}/>
        {see_resume}
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
        this.props.dad.setState({resumes : res.resumes})
        $('input:checkbox').removeAttr('checked');
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
          <div className='form-group col-sm-3'>
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
      ids: [],
    }
  }
  ,handleCheck: function(e) {
    var id = parseInt(e.target.value),
        new_ids = this.state.ids,
        index = new_ids.indexOf(id)

    if(index == -1) {
      new_ids.push(id)
    } else {
      new_ids.splice(index, 1)
    }

    this.setState({ids: new_ids})
  }
  ,handleSubmit: function(e) {
    $.ajax({
      url: '/admin/resumes/update',
      type: 'PATCH',
      data: {
        'ids': this.state.ids,
        'status': e.target.value,
      },
      success: function(data) {
        let resumes = this.props.dad.state.resumes,
            ids = this.state.ids,
            new_resumes = data.resumes

        res = resumes.map(function(resume) {
          let index = ids.indexOf(resume.id)
          if(index != -1) {
            let new_resume = new_resumes.filter((new_resume) =>   new_resume.id == resume.id )
            return new_resume[0]
          } else {
            return resume
          }
        })

        this.props.dad.setState({
          resumes: res,
        })

      }.bind(this),
      error: function(data) {
        alert(data.responseText)
      }
    })
  }
  ,render: function() {
    return (
      <div>
        <div className="handle-button">
          <button className="btn btn-info pull-right" onClick={this.handleSubmit} value="false">解冻</button>
          <button className="btn btn-danger pull-right" onClick={this.handleSubmit} value="true">冻结</button>
        </div>
        <table className="table table-bordered">
          <AdminResumeTableHead />
          <AdminResumeTableContent users={this.props.resumes} dad={this.props.dad} handleCheck={this.handleCheck} />
        </table>
      </div>
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
          <th>详情</th>
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
              return(<AdminResumeItem key={resume.id} resume={resume} index={index} handleCheck={this.props.handleCheck} dad={this.props.dad} />)
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var AdminResumeItem = React.createClass({
  handleClick: function(e) {
    this.props.dad.setState({
      view_display: true,
      resume_id: e.target.id,
    })
  }
  ,render: function() {
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
        <td><button onClick={this.handleClick} className="btn btn-default btn-form" id={resume.id}>查看</button></td>
        <td><input type="checkBox" value={resume.id} onChange={this.props.handleCheck} /></td>
      </tr>
    )
  }
})
