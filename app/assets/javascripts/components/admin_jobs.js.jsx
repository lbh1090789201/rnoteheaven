var AdminJob = React.createClass({
  getInitialState: function() {
    return {jobs: this.props.data}
  }
  ,render: function() {
    return (
      <div className="admin-jobs">
        <table className="table table-bordered">
          <thead>
            <tr>
              <th>序号</th>
              <th>职位名称</th>
              <th>职位类型</th>
              <th>行业</th>
              <th>发布机构</th>
              <th>提交时间</th>
              <th>审核时间</th>
              <th>状态</th>
              <th>详情</th>
              <th>选择</th>
            </tr>
          </thead>
          <tbody>
            {
              this.state.jobs.map(function(job) {
                // , {handleCheck: this.handleCheck}
                // return(React.createElement(Job, {key: job.id}, {data: job}))
                return(<Job key={job.id} data={job} />)
              })
            }
          </tbody>
        </table>
      </div>
    )
  }
})
