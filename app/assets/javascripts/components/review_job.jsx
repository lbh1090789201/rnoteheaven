var ReviewJob = React.createClass({
  getInitialState: function() {
    return {
      time_after: '',
      time_before: '',
      job_type: '',
      hospital_name: '',
      job_name: '',
    }
  }
  ,componentDidMount: function() {
    // test: function(e) {
    //   e.preventDefault()
    //   console.log("")
    //   this.props.dad.setState({
    //     jobs: [1,2,3]
    //   })
    // }
    // TODO 下一步提交表单

      return( function valid() {
        return (
          this.refs.job_name.value &&
          this.refs.hospital_name.value &&
          this.refs.job_type.value &&
          this.refs.time_after.value &&
          this.refs.time_before.value
        )
      }
    )
  }
  ,handleSubmit: function(e){
    e.preventDefault()
    let time_before = this.refs.time_before.value,
        time_after = this.refs.time_after.value,
        job_type = this.refs.job_type.value,
        hospital_name = this.refs.hospital_name.value,
        job_name = this.refs.job_name.value

    $.ajax({
      url: '/admin/jobs/check',
      type: 'GET',
      data: {
        'search': true,
        'time_before': time_before,
        'time_after': time_after,
        'job_type': job_type,
        'hospital_name': hospital_name,
        'job_name': job_name
      },
      success: function(data) {
        // this.props.dad.setState({jobs : data.jobs})

      },
      error: function(data){
        alert(data.responseText)
      },

    })
  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='开始时间' name='time_after'
                   defaultValue={this.state.time_after} ref="time_after" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='结束时间' name='time_before'
                   defaultValue={this.state.time_before} ref="time_before" />
          </div>
          <div className='form-group col-sm-4'>
            <input type='text' className='form-control' placeholder='工作类型' name='job_type'
                   defaultValue={this.state.job_type} ref="job_type" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='机构名称' name='hospital_name'
                   defaultValue={this.state.hospital_name} ref="hospital_name" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='职位名称' name='job_name'
                   defaultValue={this.state.job_name} ref="job_name" />
          </div>
          <button type='submit' className='btn btn-primary' disabled={this.valid}>查询</button>
     </form>
    )
  }
})
