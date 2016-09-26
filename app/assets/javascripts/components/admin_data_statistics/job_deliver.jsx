var AdminDataJobDeliver = React.createClass({
  getInitialState: function() {
    return {
      job_deliver_action: this.props.action,
    }
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#data_statistics')) return // 不合法就返回

    let time_from = this.refs.time_from.value,
        time_to = this.refs.time_to.value,
        hot_job_deliver = this.refs.hot_job_deliver.value

    $.ajax({
      url: "/admin/data_statistics/job_delivers",
      type: "GET",
      data: {
        time_from: time_from,
        time_to: time_to,
        hot_job_deliver: hot_job_deliver,
        search: true,
      },
      success: function(data) {
        // 趋势图函数
        // trendChart("#data_statistic", data.data_statistic)
      }.bind(this),
      error: function(data) {
        console.log('搜索失败')
      }.bind(this),
    })
  }
  ,render: function() {
    console.log(this.state.action)
    return (
      <div className="admin-statistics">
        <AdminDataStatisticForm dad={this} />


        <div id="data_statistic" style={{"minwidth":"310px","height":"400px","position":"relative","top":"30px"}}>
        </div>
      </div>
    )
  }
})
