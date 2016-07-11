var AdminJobSee = React.createClass({
  getInitialState: function() {
    return {
      job: '',
      jid: this.props.dad.state.jid,
    }
  }
  ,componentWillMount: function() {
    $.ajax({
      url: "/admin/jobs/" + this.state.jid,
      type: 'GET',
      success: function(data) {
        this.setState({
          job: data.job,
        })
      }.bind(this),
      error: function() {
        console.log("获取job数据失败")
      },
    })
  }
  ,handleClick: function() {
    this.props.dad.setState({
      view_display: false,
    })
  }
  ,render: function() {
    return (
      <div className="mask-user">
        <div className="user-box">
          <img src="../assets/close.png" />
          <div className="close-tab" onClick={this.handleClick}>关闭</div>
          <div className="job-content">
            <p>职位名称: <span>{this.state.job.name}</span></p>
            <p>职位类型: <span>{this.state.job.job_type}</span></p>
            <p>薪<span className="job-range">资</span>: <span>{this.state.job.salary_range}</span></p>
            <p>经验要求: <span>{this.state.job.experience}</span></p>
            <p>招聘人数: <span>{this.state.job.needed_number}</span></p>
            <p>详细地址: <span>{this.state.job.location}</span></p>
            <p>发布期限: <span>{this.state.job.duration}天</span></p>
            <p>职位描述:</p>
            <p>{this.state.job.job_desc}</p>
            <p>任职资格:</p>
            <p>{this.state.job.job_demand}</p>
          </div>
        </div>
      </div>
    )
  }
})
