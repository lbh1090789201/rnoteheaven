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
                {resume.job_type}
                {resume.job_type? '/' : ''}
                {resume.location}
                {resume.location? '/' : ''}
                {resume.expected_salary_range}
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
