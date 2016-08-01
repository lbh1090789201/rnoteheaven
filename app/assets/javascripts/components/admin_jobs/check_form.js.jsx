// 搜索组件
var ReviewJob = React.createClass({
  //初始化搜索数据
  getInitialState: function() {
    return {
      time_after: '',
      time_before: '',
      job_type: '',
      hospital_name: '',
      job_name: '',
    }
  }
  ,handleFocus: function(e) {
      let id = e.target.id

      $("#"+id).datetimepicker({
        language: 'zh-CN',
        format: "yyyy-mm-dd",
        autoclose: true,
        minView: "month",
        todayBtn:  1,
        showMeridian: 1,
      });
    }
  //点击搜索提交按钮事件
  ,handleSubmit: function(e){
    e.preventDefault()
    //隐藏分页码
    $('.pagination').hide()
    // 获取真实dom节点
    let time_begin = this.refs.time_begin.value,
        time_end = this.refs.time_end.value,
        job_type = this.refs.job_type.value,
        hospital_name = this.refs.hospital_name.value,
        job_name = this.refs.job_name.value

    $.ajax({
      url: '/admin/jobs/check',
      type: 'GET',
      data: {
        'search': true,
        'time_after': time_begin,
        'time_before': time_end,
        'job_type': job_type,
        'hospital_name': hospital_name,
        'job_name': job_name
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
        <div className='form-group col-sm-4'>
            <input type="text" id="time_begin" className="form-control" placeholder='开始时间' name='time_end'
                   onFocus={this.handleFocus} defaultValue={this.state.time_after} ref="time_begin" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" id="time_end" className="form-control" placeholder='结束时间' name='time_begin'
                   onFocus={this.handleFocus} defaultValue={this.state.time_before} ref="time_end" />
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
          <button type='submit' className='btn btn-primary search'>查询</button>
     </form>
    )
  }
})
