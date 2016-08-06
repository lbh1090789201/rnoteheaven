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
        this.setState({
          jobs : data.jobs,
          checkValue: [],
        })
        $('input:checkbox').removeAttr('checked');
        alert(alert_status(status) + '成功！')
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
    // console.log(this.state.checkValue.slice())
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
                return(<Job key={index} data={job} handleCheck={this.handleCheck} index={index} dad={this} />)
              }.bind(this)
            )}
          </tbody>
        </table>
        {job_view}
      </div>
    )
  }
})

/********************** 职位管理表单 **********************/
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
  ,componentDidMount: function() {
    formJobCheck('#form_job_index')
  }
  ,handleRadio: function(e) {
    this.setState({
      status: e.target.value,
    })
  }
  ,handleFocus: function(e) {
      let id = e.target.id
      myDatePicker(id, 'time_after', 'time_before')
    }
  ,handleSubmit: function(e){
    e.preventDefault()
    if(invalid('#form_job_index')) return // 不合法就返回

    //隐藏分页码
    $('.pagination').hide()

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
      <form className='form-inline' onSubmit={this.handleSubmit} id='form_job_index'>
          <div className="form-group col-sm-12">
            <RadioButtons ref="goodRadio" handleRadio={this.handleRadio} />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" id="time_after" className="form-control" placeholder='开始时间' name='time_after'
                   onFocus={this.handleFocus} defaultValue={this.state.time_after} ref="time_after" />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" id="time_before" className="form-control" placeholder='结束时间' name='time_before'
                   onFocus={this.handleFocus} defaultValue={this.state.time_before} ref="time_before" />
          </div>
          <div className='form-group col-sm-4'>
            <select name="job_type" ref="job_type" className="form-control">
              <option value="">工作类型</option>
              <option value="机构管理人员">机构管理人员</option>
              <option value="综合门诊/全科医生">综合门诊/全科医生</option>
              <option value="内科医生">内科医生</option>
              <option value="外科医生">外科医生</option>
              <option value="专科医生">专科医生</option>
              <option value="牙科医生">牙科医生</option>
              <option value="美容整形师">美容整形师</option>
              <option value="麻醉医生">麻醉医生</option>
              <option value="放射科医师">放射科医师</option>
              <option value="理疗师">理疗师</option>
              <option value="中医科医生">中医科医生</option>
              <option value="针灸/推拿">针灸/推拿</option>
              <option value="儿科医生">儿科医生</option>
              <option value="心理医生">心理医生</option>
              <option value="营养师">营养师</option>
              <option value="药库主任/药剂师">药库主任/药剂师</option>
              <option value="医药学检验">医药学检验</option>
              <option value="公共卫生/疾病控制">公共卫生/疾病控制</option>
              <option value="护理主任/护士长">护理主任/护士长</option>
              <option value="护士/护理人员">护士/护理人员</option>
              <option value="兽医">兽医</option>
              <option value="验光师">验光师</option>
              <option value="其他">工作类型</option>
            </select>
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


var RadioButtons = React.createClass({
  render: function() {
    return (
      <span>
        <label className="checkbox-inline">
          <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="" />全部
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="release" />发布中
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="pause" />暂停中
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="end" />已结束
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="fail" />审核失败
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="freeze" />冻结中
        </label>
      </span>
    )
  }
});

/********************** 审核弹窗提示汉化 **********************/
function alert_status(status){
  if(status == "saved"){
    return "解冻"
  }
  if(status == "reviewing"){
    return "审核"
  }
  if(status == "release"){
    return "发布"
  }
  if(status == "pause"){
    return "暂停"
  }
  if(status == "end"){
    return "结束发布"
  }
  if(status == "freeze"){
    return "冻结"
  }
  if(status == "fail"){
    return "审核拒绝"
  }
}
