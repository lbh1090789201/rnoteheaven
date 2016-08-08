var AdminJobSee = React.createClass({
  getInitialState: function() {
    return {
      job: '',
      jid: this.props.dad.state.jid,
      close: this.props.dad.state.close,
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
          <img src={this.state.close}  onClick={this.handleClick} className="img-close" />
          <div className="job-content">
            <table className="job-table table table-hover">
              <tbody>
                <tr>
                  <td>职位名称:</td>
                  <td>{this.state.job.name}</td>
                </tr>
                <tr>
                  <td>职位类型:</td>
                  <td>{this.state.job.job_type}</td>
                </tr>
                <tr>
                  <td>薪<span className="job-range">资</span>:</td>
                  <td>{this.state.job.salary_range}</td>
                </tr>
                <tr>
                  <td>经验要求:</td>
                  <td>{this.state.job.experience}</td>
                </tr>
                <tr>
                  <td>招聘人数:</td>
                  <td>{this.state.job.needed_number}</td>
                </tr>
                <tr>
                  <td>详细地址:</td>
                  <td>{this.state.job.location}</td>
                </tr>
                <tr>
                  <td>发布期限:</td>
                  <td>{this.state.job.duration}天</td>
                </tr>
                <tr>
                  <td>职位描述:</td>
                  <td>{this.state.job.job_desc}</td>
                </tr>
                <tr>
                  <td>任职资格:</td>
                  <td>{this.state.job.job_demand}</td>
                </tr>
              </tbody>
            </table>

          </div>
        </div>
      </div>
    )
  }
})
