var ReviewJobAll = React.createClass({
  getInitialState: function() {
    return {
      time_after: '',
      time_before: '',
      job_type: '',
      hospital_name: '',
      job_name: '',
      status: '',
    }
  }
  ,handleRadio: function(e) {
    this.setState({
      status: e.target.value,
    })
  }
  ,handleSubmit: function(e){
    e.preventDefault()
    console.log(this.state.status)
    let time_before = this.refs.time_before.value,
        time_after = this.refs.time_after.value,
        job_type = this.refs.job_type.value,
        hospital_name = this.refs.hospital_name.value,
        job_name = this.refs.job_name.value,
        status = this.state.status

    $.ajax({
      url: '/admin/jobs',
      type: 'GET',
      data: {
        'search': true,
        'time_before': time_before,
        'time_after': time_after,
        'job_type': job_type,
        'hospital_name': hospital_name,
        'job_name': job_name,
        'status': status
      },
      success: function(data) {
        console.log(this)
        this.props.dad.setState({jobs : data.jobs})

      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },

    })
  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
          <div className="form-group col-sm-12">
            <RadioButtons ref="goodRadio" handleRadio={this.handleRadio} />
          </div>
          <div className='form-group col-sm-4'>
            <input type="date" className="form-control" placeholder='开始时间' name='time_after'
                   defaultValue={this.state.time_after} ref="time_after" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="date" className="form-control" placeholder='结束时间' name='time_before'
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
          <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})


var RadioButtons = React.createClass({
  render: function() {
    return (
      <span>
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="" />全部职位
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="release" />发布中职位
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="end" />已结束职位
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="fail" />审核失败职位
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="freeze" />冻结中职位
      </span>
    )
  }
});
