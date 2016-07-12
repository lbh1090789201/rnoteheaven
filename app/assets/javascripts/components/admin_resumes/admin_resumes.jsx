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


/*************查看简历详情组件****************/
var AdminResumeView = React.createClass({
  getInitialState: function() {
    return {
      resume_id: this.props.dad.state.resume_id,
      resume: '',
      re_display: false,
      close: this.props.dad.state.close,
      avatar: this.props.dad.state.avatar,
    }
  }
  ,componentWillMount: function() {
    $.ajax({
      url: "/admin/resumes",
      type: 'GET',
      data: {resume_id: this.state.resume_id},
      success: function(data) {
        this.setState({
          resume: data.resume,
          re_display: true
        })
      }.bind(this)
    })
  }
  ,handleClick: function() {
    this.props.dad.setState({
      view_display: false,
    })
  }
  ,render: function() {
    let resume = this.state.resume,
        resume_content = this.state.re_display ? <ResumeContent resume={resume} avatar={this.state.avatar} /> : ''

    return (
      <div className="mask-user">
        <div className="user-box">
          <img src={this.state.close} onClick={this.handleClick} className="img-close" />
          <div className="user-info">
            {resume_content}
          </div>
        </div>
      </div>
    )
  }
})

/******************简历详细信息***********************/
var ResumeContent = React.createClass({
  render: function() {
    let resume = this.props.resume,
        avatar = resume.avatar == 'avator.png' ? this.props.avatar : resume.avatar
    return (
      <div className="resume-content">
        <ul>
          <li>简历编号:{resume.id}</li>
          <li>投递职位数:{resume.apply_count}</li>
          <li>查看次数:{resume.viewed_count}</li>
        </ul>
        <div className="resume-content">
          <div className="show-img">
            <div className="avatar">
              <img src={avatar} />
            </div>
            <span>{resume.user.show_name}</span>
          </div>
        </div>

        <section className="resumes-preview-public">
          <h1>基本信息</h1>
          <div className="resumes-preview-bg  resumes-preview-base">
            <table className="resumes-base">
              <UserInfo key={resume.user.id} user={resume.user} />
            </table>
          </div>
        </section>


        <section className="resume-show resumes-preview-public preview-show" id="preview_resume">
          <h1>工作经历</h1>
          <div className="wrap resumes-preview-bg public-preview-style work-try">
            {
              resume.work_experiences.map(function(work_experience) {
                return (<WorkExperience key={work_experience.id} info={work_experience} />)
              })
            }
          </div>
        </section>


        <section className="resume-show resumes-preview-public" id="preview_resume">
          <h1>教育经历</h1>
          <div className="wrap resumes-preview-bg public-preview-style work-try">
            {
              resume.education_experiences.map(
                function(education_experience) {
                  return (
                    <EducationExperience key={education_experience.id} info={education_experience} />
                  )
                }
              )
            }
          </div>
        </section>

        <section className="resume-show resumes-preview-public">
            <h1>持有证书
            </h1>
            <div className="wrap resumes-preview-bg public-preview-style employer-style">
              {
                resume.certificates.map(
                  function(certificate) {
                    return (
                      <Certificate key={certificate.id} info={certificate} />
                    )
                  }
                )
              }
            </div>
        </section>


        <section className="resume-show resumes-preview-public employer-job">
          <h1>期望工作</h1>
          <div id="preview-expect" className="wrap expect-preview-style">
            <div className="box work-time expect-employer">
              <h3>{resume.name}</h3>
              <p className="expect-preview">
                {resume.job_type}/{resume.location}/{resume.expected_salary_range}
              </p>
              <p>{resume.job_desc}</p>
            </div>
          </div>
        </section>

      </div>
    )
  }
})

/******************用户的信息展示组件***********************/
var UserInfo = React.createClass({
  render: function() {
    let user = this.props.user
    return (
      <tbody>
        <tr>
          <td><span>姓</span>名：</td>
          <td>{user.show_name}</td>
        </tr>
        <tr>
          <td><span>性</span>别：</td>
          <td>{user.sex}</td>
        </tr>
        <tr>
          <td>最高学历：</td>
          <td>{user.highest_degree}</td>
        </tr>
        <tr>
            <td><span>职</span>称：</td>
            <td>{user.position}</td>
        </tr>
        <tr>
          <td>工作年限：</td>
          <td>{user.start_work_at}</td>
        </tr>
        <tr>
          <td>出生年限：</td>
          <td>{user.birthday}</td>
        </tr>
        <tr>
          <td>所在城市：</td>
          <td>{user.location}</td>
        </tr>
        <tr>
          <td>联系电话：</td>
          <td>{user.cellphone}</td>
        </tr>
        <tr>
          <td>联系邮箱：</td>
          <td>{user.user_email}</td>
        </tr>
        <tr>
          <td>当前状态：</td>
          <td>{user.seeking_job}</td>
        </tr>
      </tbody>
    )
  }
})

/*************工作经历展示组件******************/
var WorkExperience = React.createClass({
  render: function(){
    let resume = this.props.info
    return (
      <div className="box">
        <div className="green-point"></div>
        <time>{resume.started_at}-{resume.left_time}</time>
        <div className="time-line-box work-time">
          <h3>{resume.company}
          </h3>
          <p>
            {resume.job_desc}
          </p>
        </div>
      </div>
    )
  }
})

/**********教育经历展示组件*****************/
var EducationExperience = React.createClass({
  render: function() {
    let resume = this.props.info
    return (
      <div className="box">
        <div className="blue-left">
          <div className="blue-point"></div>
        </div>
        <div className="green-point"></div>
        <time>{resume.graduated_at}年毕业</time>
        <div className="time-line-box work-time">
          <h3>{resume.college}
          </h3>
          <p>
            <span>{resume.education_degree}</span>，<span>{resume.major}</span>
          </p>
        </div>
      </div>
    )
  }
})

/********持有证书展示组件**********/

var Certificate = React.createClass({
  render: function() {
    let resume = this.props.info
    return (
      <div className="box cer-employer">
          <p>{resume.title}</p>
      </div>
    )
  }
})
