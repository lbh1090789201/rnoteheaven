var AdminDataStatistic = React.createClass({
  componentDidMount: function() {
    formDataStatistic('#data_statistics')
  }
  ,render: function() {
    return (
      <div className="admin-statistics">
        <AdminDataStatisticForm dad={this} />
        <h3 className="data-title">数据展示:</h3>
        <div id="data_statistic" style={{"minwidth":"310px","height":"400px","position":"relative","top":"30px"}}>
        </div>
      </div>
    )
  }
})


/*****************1**AdminDataStatisticForm********************/
var AdminDataStatisticForm = React.createClass({
  getInitialState: function() {
    return {
      resume_deliver: '',
      job_release: '',
    }
  }
  ,handleFocus: function(e) {
    let id = e.target.id
    myDatePicker(id, 'time_from', 'time_to')
  }
  ,handleChange: function(e) {
    let name = e.target.name,
        checked = e.target.checked

    if(checked) {
      this.setState({
        [name]: 1,
      })
    }else{
      this.setState({
        [name]: '',
      })
    }
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#data_statistics')) return // 不合法就返回

    let time_from = this.refs.time_from.value,
        time_to = this.refs.time_to.value,
        hot_job = this.refs.hot_job.value,
        hot_hospital_deliver = this.refs.hot_hospital_deliver.value,
        hot_job_collect = this.refs.hot_job_collect.value

    $.ajax({
      url: "/admin/data_statistics",
      type: "GET",
      data: {
        time_from: time_from,
        time_to: time_to,
        hot_job: hot_job,
        hot_hospital_deliver: hot_hospital_deliver,
        hot_job_collect: hot_job_collect,
        resume_deliver: this.state.resume_deliver,
        job_release: this.state.job_release,
        search: true,
      },
      success: function(data) {
        // 趋势图函数
        trendChart("#data_statistic", data.data_statistic)
      }.bind(this),
      error: function(data) {
        console.log('搜索失败')
      }.bind(this),
    })
  }
  ,render: function() {
    return (
      <form onSubmit={this.handleSubmit} id="data_statistics">
        <AdminDataStatisticRadio dad={this} />
        <div className="row">
          <label className="time-title">时间:</label>
          <div className="col-sm-4">
            <input type="text" id="time_from" name="time_from" ref="time_from" className=" form-control"
                    placeholder="从" onFocus={this.handleFocus} />
          </div>

          <div className="col-sm-4">
            <input type="text" id="time_to" name="time_to" ref="time_to" className=" form-control"
                    placeholder="至" onFocus={this.handleFocus} />
          </div>
        </div>

        <div className="row inquiry-input">
          <div className="col-sm-3">
            <label>职位投递数:</label>
            <input type="text" name="hot_job" ref="hot_job" className=" form-control" placeholder="请输入职位全称" />
          </div>

          <div className="col-sm-3">
            <label>机构投递数:</label>
            <input type="text" name="hot_hospital_deliver" ref="hot_hospital_deliver" className=" form-control" placeholder="请输入机构全称" />
          </div>

          <div className="col-sm-3">
            <label>机构收藏数:</label>
            <input type="text" name="hot_job_collect" ref="hot_job_collect" className=" form-control" placeholder="请输入机构全称" />
          </div>

          <button type="submit" id="submit">查询</button>
        </div>
      </form>
    )
  }
})


/***************AdminDataStatisticRadio*************/
var AdminDataStatisticRadio = React.createClass({
  render: function() {
    return (
      <div className="radio-box">
        <label className="checkbox">
          <input type="checkbox" name="resume_deliver" ref="resume_deliver" onChange={this.props.dad.handleChange} />
          简历投递数
        </label>

        <label className="checkbox">
          <input type="checkbox" name="job_release" ref="job_release" onChange={this.props.dad.handleChange} />
          职位发布数
        </label>
      </div>
    )
  }
})



/********************** 表单验证 **********************/
function formDataStatistic(id) {
  $(id).validate({
    rules: {
      time_from: {
        required: true,
        date: true,
      },
      time_to: {
        required: true,
        date: true,
      },
      hot_job: {
        rangelength: [0, 30],
      },
      hot_hospital_deliver: {
        rangelength: [0, 30],
      },
      hot_job_collect: {
        rangelength: [0, 30],
      }
    },
    messages: {
      hot_job: {
        maxlength: '职位名称为0~30字符',
      },
      hot_hospital_deliver: {
        maxlength: '职位名称为0~30字符',
      },
      hot_job_collect: {
        maxlength: '职位名称为0~30字符',
      },
    },

    highlight: function ( element, errorClass, validClass ) {
      $( element ).parents( ".form-group" ).addClass( "has-error" ).removeClass( "has-success" );
    },
    unhighlight: function ( element, errorClass, validClass ) {
      $( element ).parents( ".form-group" ).addClass( "has-success" ).removeClass( "has-error" );
    },
  })
}

function formDataStatisticSearch(id) {
  $(id).validate({
    rules: {
      hot_job: {
        rangelength: [0, 30],
      },
      hot_hospital_deliver: {
        rangelength: [0, 30],
      },
      hot_job_collect: {
        rangelength: [0, 30],
      },
      time_from: {
        date: true,
      },
      time_to: {
        date: true
      }
    },
    messages: {
      hot_job: {
        maxlength: '职位名称为0~30字符',
      },
      hot_hospital_deliver: {
        maxlength: '职位名称为0~30字符',
      },
      hot_job_collect: {
        maxlength: '职位名称为0~30字符',
      },
    }
  })
}
