var AdminJobAll = React.createClass({
  getInitialState: function() {
    return {
      jobs: this.props.data,
      checkValue: [],
      close: this.props.close,
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
  ,handleClick: function(e) {
    e.preventDefault();
    var name = e.target.name,
        ids = this.state.checkValue.toString(),
        status= e.target.value

    $.ajax({
      url: '/admin/jobs/update',
      type: 'PATCH',
      data: {'ids': ids, 'status': status},
      success: function(data) {
        this.setState({jobs : data.jobs})
        $('input:checkbox').removeAttr('checked');
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
    var job_view = this.state.view_display ? <AdminJobSee dad={this} /> : ''
    return (
      <div className="admin-jobs">
        <ReviewJobAll dad={this} />
        <div className="handle-button">
          <button className="btn btn-info pull-right" onClick={this.handleClick} name="passBtn" value="saved">解冻职位</button>
          <button className="btn btn-default pull-right" onClick={this.handleClick} name="passBtn" value="freeze">冻结职位</button>
        </div>
        <table className="table table-bordered">
          <thead>
            <tr>
              <th>序号</th>
              <th>职位名称</th>
              <th>职位类型</th>
              <th>行业</th>
              <th>发布机构</th>
              <th>提交时间</th>
              <th>状态</th>
              <th>详情</th>
              <th>选择</th>
            </tr>
          </thead>
          <tbody>
            {this.state.jobs.map(
                function(job, index) {
                return(<Job key={job.id} data={job} handleCheck={this.handleCheck} index={index} dad={this} />)
              }.bind(this)
            )}
          </tbody>
        </table>
        {job_view}
      </div>
    )
  }
})
