var AdminJob = React.createClass({
  getInitialState: function() {
    return {
      jobs: this.props.data,
      checkValue: [],
    }
  }
  ,handleCheck: function(e) {
    var checkValues = this.state.checkValue.slice(),
        newVal = e.target.value,
        index = checkValues.indexOf(newVal)

    if(index == -1) {
      checkValues.push(newVal)
    } else {
      checkValues.splice(index, 1)
    }

    this.setState({
      checkValue: checkValues,
    })

    return e
  }
  ,handlClick: function(e) {
    e.preventDefault();
    var name = e.target.name,
        ids = this.state.checkValue.toString(),
        status= e.target.value

    console.log(ids)
    $.ajax({
      url: '/admin/jobs/update',
      type: 'PATCH',
      data: {'ids': ids, 'status': status},
      success: function(data) {

        this.setState({jobs : data.jobs})
      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },
    })
  }
  ,bandleSubmit: function(){
    console.log(this)
  }
  ,render: function() {
    var jobs_all = []

    this.state.jobs.forEach(
      function(job, index) {
        jobs_all.push(
          <Job key={index} data={job} handleCheck={this.handleCheck} />
        )
      }.bind(this)
    )

    return (
      <div className="admin-jobs">
        <ReviewJob dad={this} />

        <button className="btn btn-info pull-right" onClick={this.handleClick} name="passBtn" value="release">审核通过</button>
        <button className="btn btn-danger pull-right" onClick={this.handleClick} name="refuseBtn" value="fail">审核拒绝</button>
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
              // this.state.jobs.map(function(job) {
              //   // console.log(this.AdminJob.prototype.clickMe)
              //   return(<Job key={job.id} data={job} handleCheck={this.AdminJob.prototype.handleCheck} />)
              // })
              jobs_all
            }
          </tbody>
        </table>
      </div>
    )
  }
})
